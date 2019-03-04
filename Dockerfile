
# Base image
FROM ubuntu:16.04
MAINTAINER Paul Murrell <paul@stat.auckland.ac.nz>

# Install additional software
# R stuff
RUN apt-get update && apt-get install -y \
    xsltproc \
    libxml2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    bibtex2html \
    subversion 

# Get R commit r76141
# (use r76141 to include bug fix in set.gpar())
RUN svn co -r76141 https://svn.r-project.org/R/trunk/ R
# Building R from source
RUN apt-get update && apt-get install -y r-base-dev texlive-full libcairo2-dev
RUN apt-get install -y rsync
RUN cd R; tools/rsync-recommended
RUN cd R; ./configure --with-x=no 
RUN cd R; make
RUN cd R; make install

# For building the report
RUN Rscript -e 'install.packages(c("knitr", "devtools"), repos="https://cran.rstudio.com/")'
RUN Rscript -e 'library(devtools); install_version("xml2", "1.1.1", repos="https://cran.rstudio.com/")'

# Packages used in the report
RUN Rscript -e 'library(devtools); install_version("jpeg", "0.1-8", repos="https://cran.rstudio.com/")'
RUN Rscript -e 'library(devtools); install_github("pmur002/gridbezier@v1.0-0")'
RUN Rscript -e 'library(devtools); install_github("pmur002/vwline/pkg@v0.2-1")'
RUN Rscript -e 'library(devtools); install_version("ggplot2movies", "0.0.1", repos="https://cran.rstudio.com/")'

# Using COPY will update (invalidate cache) if the tar ball has been modified!
# COPY gridGeometry_0.1-0.tar.gz /tmp/
# RUN R CMD INSTALL /tmp/gridGeometry_0.1-0.tar.gz
# To be replace with things like ...
RUN Rscript -e 'library(devtools); install_github("pmur002/gridgeometry@v0.1-0")'
RUN Rscript -e 'library(devtools); install_github("pmur002/polyclip@v1.91-0")'


