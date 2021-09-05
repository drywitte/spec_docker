FROM ubuntu:18.04

WORKDIR /opt/pytorch

RUN apt -y update && apt -y install wget curl vim libgcrypt20 coreutils libgl1-mesa-glx

RUN wget https://repo.continuum.io/miniconda/Miniconda3-3.7.0-Linux-x86_64.sh -O ./miniconda.sh

RUN chmod ouga+xw ./miniconda.sh
RUN bash ./miniconda.sh -b -p ./miniconda

ENV PATH /opt/pytorch/miniconda/bin:$PATH

RUN conda update conda
RUN conda create -n conda3.6 python=3.8

RUN /bin/bash -c "source activate conda3.6 && conda install mkl numpy pandas jupyter ipython scikit-learn plotly"
RUN /bin/bash -c "source activate conda3.6 && conda install pytorch torchvision cudatoolkit=10.2 -c pytorch"
RUN /bin/bash -c "source activate conda3.6 && conda install -c conda-forge matplotlib seaborn"
RUN /bin/bash -c "source activate conda3.6 && conda install -c anaconda -c conda-forge -c comet_ml comet_ml"
RUN /bin/bash -c "source activate conda3.6 && conda install pyyaml yaml"
RUN /bin/bash -c "conda install -c menpo opencv3"
RUN /bin/bash -c "pip install netifaces"



CMD /bin/bash -c "source activate conda3.6"

ENTRYPOINT [ "executable", "python", "conda" ]
