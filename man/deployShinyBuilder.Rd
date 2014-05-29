\name{deployShinyBuilder}
\alias{deployShinyBuilder}
\title{Deploy ShinyBuilder to a specified directory}
\usage{
deployShinyBuilder(dir)
}
\arguments{
  \item{dir}{directory to which ShinyBuilder app is
  deployed}
}
\description{
Deploy ShinyBuilder app (ui.R, server.R, global.R) to a
specified directory. Useful for copying ShinyBuilder to a
Shiny Server directory from which it will be served. Note
that regardless of its deploy location, the app will use
the ShinyBuilder library location for saving/loading
dashboards, databases, and config files.
}
\examples{
debployShinyBuilder(dir = '/srv/shiny-server/ShinyBuilder')
}

