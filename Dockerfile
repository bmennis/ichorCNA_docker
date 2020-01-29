FROM ubuntu:18.04
LABEL maintainer="Brian Ennis (ennisb@email.chop.edu)"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y build-essential software-properties-common libcurl4-openssl-dev libssl-dev libxml2-dev \
&& apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 \
&&  add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/' \
&& apt update && apt install -y r-base

RUN git clone git@github.com:broadinstitute/ichorCNA.git 
RUN Rscript -e 'install.packages("plyr")'
RUN Rscript -e 'source("https://bioconductor.org/biocLite.R")'
RUN Rscript -e 'BiocManager::install("HMMcopy")'  
RUN Rscript -e 'BiocManager::install("GenomeInfoDb")'  
RUN Rscript -e 'BiocManager::install("GenomicRanges")'
RUN R CMD INSTALL ichorCNA 

RUN apt autoclean -y && apt autoremove -y
