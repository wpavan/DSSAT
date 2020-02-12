#' Writes soil parameters to a single DSSAT soil parameter file (*.SOL)
#'
#' @export
#'
#' @inheritParams read_dssat
#' @param sol a tibble of soil profiles that have been read in by read_sol()
#' @param append TRUE or FALSE indicating whether soil profile should
#' be appended to file_name. If FALSE, the soil profile will be written
#' to a new file and will overwrite file_name (if it exists).
#' @param title a length-one character vector that contains the title of the soil file
#'
#' @return Invisibly returns NULL
#'
#' @examples
#'
#' sample_sol <- c(
#' "*SOILS: General DSSAT Soil Input File",
#' "! DSSAT v4.7; 09/01/2017",
#' "*IB00000001  IBSNAT      SIC     210 DEFAULT - DEEP SILTY CLAY",
#' "@SITE        COUNTRY          LAT     LONG SCS FAMILY",
#' " Generic     Generic          -99      -99 Generic",
#' "@ SCOM  SALB  SLU1  SLDR  SLRO  SLNF  SLPF  SMHB  SMPX  SMKE",
#' "   -99  0.11   6.0  0.30  85.0  1.00  1.00 IB001 IB001 IB001",
#' "@  SLB  SLMH  SLLL  SDUL  SSAT  SRGF  SSKS  SBDM  SLOC  SLCL  SLSI  SLCF  SLNI  SLHW  SLHB  SCEC  SADC",
#' "     5   -99 0.228 0.385 0.481 1.000   -99  1.30  1.75  50.0  45.0   0.0 0.170   6.5   -99   -99   -99",
#' "    15   -99 0.228 0.385 0.481 1.000   -99  1.30  1.75  50.0  45.0   0.0 0.170   6.5   -99   -99   -99",
#' "    30   -99 0.249 0.406 0.482 0.638   -99  1.30  1.60  50.0  45.0   0.0 0.170   6.5   -99   -99   -99",
#' "    45   -99 0.249 0.406 0.465 0.472   -99  1.35  1.45  50.0  45.0   0.0 0.140   6.5   -99   -99   -99",
#' "    60   -99 0.249 0.406 0.465 0.350   -99  1.35  1.45  50.0  45.0   0.0 0.140   6.5   -99   -99   -99",
#' "    90   -99 0.308 0.456 0.468 0.223   -99  1.35  1.10  50.0  45.0   0.0 0.110   6.5   -99   -99   -99",
#' "   120   -99 0.207 0.341 0.452 0.122   -99  1.40  0.65  50.0  45.0   0.0 0.060   6.5   -99   -99   -99",
#' "   150   -99 0.243 0.365 0.455 0.067   -99  1.40  0.30  50.0  45.0   0.0 0.030   6.5   -99   -99   -99",
#' "   180   -99 0.259 0.361 0.457 0.037   -99  1.40  0.10  50.0  45.0   0.0 0.010   6.5   -99   -99   -99",
#' "   210   -99 0.259 0.361 0.457 0.020   -99  1.40  0.01  50.0  45.0   0.0 0.000   6.5   -99   -99   -99")
#'
#' write(sample_sol,'SOIL.SOL')
#'
#' sol <- read_sol('SOIL.SOL')
#'
#' write_sol(sol,'EXAMPLE.SOL')

write_sol <- function(sol,file_name,title=NULL,append=TRUE){

  if(is.null(title))  title <- attr(sol,'title')
  if(is.null(title))  title <- 'General DSSAT Soil Input File'

  comments <- attr(sol,'comments')

  sol_out <- 1:nrow(sol) %>%
    map(~{sol[.,]}) %>%
    map(write_soil_profile) %>%
    unlist()

  if(!append){
    sol_out <- title %>%
      str_c('*SOILS: ',.) %>%
      c(.,comments,sol_out)
  }

  write(sol_out,file_name,append = append)

  return(invisible())
}