\name{Molgenis-package}
\alias{Molgenis}
\alias{molgenis}
\docType{package}
\title{
	Interface between molgenis & r/qtl
}
\description{
	Interface between molgenis & r/qtl
}
\details{
	\tabular{ll}{
	Package: \tab Molgenis\cr
	Version: \tab 0.01\cr
	Date: \tab 25th May 2009\cr
	Depends: \tab R (>= 1.8.0), qtl\cr
	License: \tab GPL version 3 or later\cr
	LazyLoad: \tab yes\cr
	LazyData: \tab yes\cr
	}

	Index:
	\preformatted{
	CrossFromMolgenis       CrossFromMolgenis - Helperfunction to create a cross-object from a molgenis database
	ResultsFromMolgenis     ResultsFromMolgenis - Helperfunction to retrieve results from a molgenis database
	ResultsToMolgenis       ResultsToMolgenis - Helperfunction to store results into a molgenis database
	PipelineMolgenis		Automatic MQM-QTL analysis for Molgenis database systems	
	}
	The Molgenispipeline is comprised of two main parts:
	\itemize{
		\item 1A: Data retrieval from a molgenis database 
		\item 1B: Formatting into a \code{cross} object. See \code{\link[qtl]{read.cross}} for details. 
		\item 2A.1: MQM QTL Model selection, with specified cofactors
		\item 2A.2: MQM QTL mapping using the selected model
		\item 2B: Storage of QTLmap into the database
	}
}
\author{
Danny Arends \email{Danny.Arends@gmail.com} ; M.A. Swertz \email{m.a.swertz@rug.nl}

Maintainer: Danny Arends \email{Danny.Arends@gmail.com}
}
\references{
	\itemize{
		\item Swertz MA, Jansen RC. (2007), Beyond standardization: dynamic software infrastructures for systems biology. \emph{Nat Rev Genet.} \bold{3}, 235--243.
		\item Swertz MA, De Brock EO, Van Hijum SA, De Jong A, Buist G, Baerends RJ, Kok J, Kuipers OP, Jansen RC. (2004), Molecular Genetics Information System (MOLGENIS): alternatives in developing local experimental genomics databases. \emph{Bioinformatics},\bold{13}, 2075--2083.
	}
}
~~ Optionally other standard keywords, one per line, from file KEYWORDS in ~~
~~ the R documentation directory ~~
\keyword{ package }

\seealso{
	\itemize{
	\item \code{\link{PipelineMolgenis}} - Automatic MQM-QTL analysis for Molgenis database systems		
	}
}
\examples{
	library(Molgenis)
}
