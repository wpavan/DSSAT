% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/write_sol.R
\name{write_sol}
\alias{write_sol}
\title{Writes soil parameters to a single DSSAT soil parameter file (*.SOL)}
\usage{
write_sol(sol, file_name, title = NULL, append = TRUE,
  force_std_fmt = TRUE)
}
\arguments{
\item{sol}{a tibble of soil profiles that have been read in by read_sol()}

\item{file_name}{a character vector of length one that contains the name
of a single DSSAT output file}

\item{title}{a length-one character vector that contains the title of the soil file}

\item{append}{TRUE or FALSE indicating whether soil profile should
be appended to file_name. If FALSE, the soil profile will be written
to a new file and will overwrite file_name (if it exists).}

\item{force_std_fmt}{a logical value indicating whether to override the
variable format stored within the FileX object with standard DSSAT formatting}
}
\value{
Invisibly returns NULL
}
\description{
Writes soil parameters to a single DSSAT soil parameter file (*.SOL)
}
\examples{

# Extract file path for sample soil file
sample_sol <- system.file('extdata','SAMPLE.SOL',package='DSSAT')

# Read sample soil file
sol <- read_sol(sample_sol)

# Create example soil file path
sample_sol2 <- paste0(tempdir(),'/SAMPLE.SOL')

# Write example soil file
write_sol(sol,sample_sol2)

}
