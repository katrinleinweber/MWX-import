#' import_MWX_files
#'
#' Imports and cleans .MWX files created by the "Swift II Multi Wavelength Version 2.00" program (Biochrom Ltd). To obtain those files activate "Export Spreadsheet" under "Run > Medhod > Run Options".
#'
#' Please note: the .mwx files must have resulted from the same Swift II method. Otherwise, different numbers of header lines, variables, etc. might derail this function.
#'
#' @param skip_lines integer: the number of lines of the data file to skip before beginning to read data.
#' @param clean Determines whether the `X` column and rownames should be removed.
#' @param var_sep a character vector used to split untidily concatenated `Sample` names into their own columns, named according to `new_vars`.
#' @param new_vars a combination of strings to be used as variable names after splitting at `var_sep`.
#'
#' @export
#'
import_MWX_files <- function(skip_lines,
                             # parameter defaults
                             clean = TRUE,
                             var_sep = FALSE,
                             new_vars = FALSE
) {

  list.files(
                          # setwd(dirname(file.choose())) # alternative selection
                          # of working directory via file selection dialogue
                          pattern = "\\.MWX",
                          recursive = TRUE
  ) %>%
    purrr::map_df(.f = readr::read_tsv,
                  skip = skip_lines
                  ) ->
    MWX_df

  # remove default observations & variables
  if (clean) {
    MWX_df <- MWX_df[MWX_df$Sample != "Reference",]
    MWX_df$X <- NULL
    rownames(MWX_df) <- NULL
  }

  # split sample names into variables
  if (var_sep != FALSE) {
    MWX_df <- cbind(MWX_df,
                    reshape2::colsplit(string = MWX_df$Sample,
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
