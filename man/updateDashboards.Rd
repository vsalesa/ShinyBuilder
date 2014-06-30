\name{updateDashboards}
\alias{updateDashboards}
\title{Update All Dashboards}
\usage{
updateDashboards(dashboards = NULL)
}
\arguments{
  \item{dashboards}{a vector of dashboard names.  By
  default, all dashboards in the dashboards directory are
  updated}
}
\description{
Update All Dashboards
}
\examples{
\dontrun{
#All Dashboards
updateDashboards()
#Selected dashboards
updeateDashboards(c('dashboard_1', 'dashboard_2'))
}
}

