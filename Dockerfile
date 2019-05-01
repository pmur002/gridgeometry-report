
# Base image
FROM ubuntu:16.04
MAINTAINER Paul Murrell <paul@stat.auckland.ac.nz>

# add CRAN PPA
RUN apt-get update && apt-get install -y apt-transport-https
RUN echo 'deb https://cloud.r-project.org/bin/linux/ubuntu xenial-cran35/' > /etc/apt/sources.list.d/cran.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

# Install additional software
# R stuff
RUN apt-get update && apt-get install -y \
    xsltproc \
    r-base=3.6* \ 
    libxml2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    bibtex2html \
    subversion 

# For building the report
RUN Rscript -e 'install.packages(c("knitr", "devtools"), repos="https://cran.rstudio.com/")'
RUN Rscript -e 'library(devtools); install_version("xml2", "1.1.1", repos="https://cran.rstudio.com/")'

# Packages used in the report
RUN Rscript -e 'library(devtools); install_version("jpeg", "0.1-8", repos="https://cran.rstudio.com/")'
RUN Rscript -e 'library(devtools); install_version("polyclip", "1.10-0", repos="https://cran.rstudio.com/")'
RUN Rscript -e 'library(devtools); install_github("pmur002/gridbezier@v1.0-0")'
RUN Rscript -e 'library(devtools); install_github("pmur002/vwline/pkg@v0.2-1")'
RUN Rscript -e 'library(devtools); install_version("ggplot2movies", "0.0.1", repos="https://cran.rstudio.com/")'

# Using COPY will update (invalidate cache) if the tar ball has been modified!
## COPY gridGeometry_0.2-0.tar.gz /tmp/
## RUN R CMD INSTALL /tmp/gridGeometry_0.2-0.tar.gz
# To be replace with things like ...
RUN Rscript -e 'library(devtools); install_github("pmur002/gridgeometry@v0.2-0")'


