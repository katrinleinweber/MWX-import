# Import function for .MWX files created by
# "Swift II Multi Wavelength Version 2.00" program (Biochrom Ltd)
# ensure MWX export by activating "Export Spreadsheet" under "Run > Medhod > Run Options"

library(reshape2) # needed for colsplit

import_MWXs <- function(skip,
                        # parameter defaults
                        clean = TRUE,
                        name_sep = FALSE,
                        new_names = FALSE) {

  # MWX files have to result from same method
  MWX_files <- list.files(getwd(), pattern = "\\.MWX")

  # concatenate data into data.frame
  MWX_data <- do.call("rbind",
                      lapply(X = MWX_files,
                             FUN = read.table,
                             stringsAsFactors = FALSE,
                             header = TRUE,
                             skip = skip,
                             sep = "\t",
                             dec = ","))

  # remove default observation & variable
  if (clean) {
    MWX_data <- MWX_data[MWX_data$Sample != "Reference",]
    MWX_data$X <- NULL
    rownames(MWX_data) <- NULL
  }

  # split ample names into variables
  if (name_sep != FALSE) {
    MWX_data <- cbind(MWX_data,
                      colsplit(string = MWX_data$Sample,
                               pattern = name_sep,
                               names = new_names))
  }

  return(MWX_data)}

# import demo with example files
# adjust parameters & observe MWX_data object in RStudio
MWX_data <- import_MWXs(skip = 13,
                        clean = FALSE,
                        name_sep = "_",
                        # Sample names like "150401aa_ax_manual_4" work-around
                        # in Swift II for encoding variables
                        new_names = c("Plate", "Achmi", "Pipette", "uL_MeOH"))
