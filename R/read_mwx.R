# Import function for .MWX files created by the
# "Swift II Multi Wavelength Version 2.00" program (Biochrom Ltd)
# Important: Ensure MWX export by activating "Export Spreadsheet" under
# "Run > Medhod > Run Options"

library(reshape2) # needed for colsplit

import_MWX_files <- function(skip_lines,
                             # parameter defaults
                             clean = TRUE,
                             var_sep = FALSE,
                             new_vars = FALSE
) {
  
  # Please note: MWX files should be present in R's working directory, and
  # should have resulted from same method. Otherwise, different numbers of
  # header lines, variables, etc. may cause this script to run into errors.
  MWX_files <- list.files(getwd(),
                          # setwd(dirname(file.choose())) # alternative selection
                          # of working directory via file selection dialogue
                          pattern = "\\.MWX"
  )
  
  # merge data tables from MWX file into R dataframe
  MWX_df <- do.call("rbind",
                    lapply(X = MWX_files,
                           FUN = read.table,
                           stringsAsFactors = FALSE,
                           header = TRUE,
                           skip = skip_lines,
                           sep = "\t",
                           dec = ","
                    )
  )
  
  # remove default observations & variables
  if (clean) {
    MWX_df <- MWX_df[MWX_df$Sample != "Reference",]
    MWX_df$X <- NULL
    rownames(MWX_df) <- NULL
  }
  
  # split sample names into variables
  if (var_sep != FALSE) {
    MWX_df <- cbind(MWX_df,
                    colsplit(string = MWX_df$Sample,
                             pattern = var_sep,
                             names = new_vars
                    )
    )
  }
  return(MWX_df)
}

# import demo with example files
# adjust parameters & observe MWX_df object in RStudio
MWX_demo <- import_MWX_files(skip_lines = 13,
                             clean = FALSE,
                             var_sep = "_",
                             # Use this as a work-around for encoding variables names
                             # in Swift II, e.g. "150401aa_ax_manual_4" turns into:
                             new_vars = c("plate_ID",
                                          "cell_culture",
                                          "treatment",
                                          "mL_solvent"
                             )
)
