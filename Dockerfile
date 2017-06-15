FROM python:latest

ENV HOME /root
WORKDIR $HOME

RUN pip install ipython jupyter

ENV SMLROOT /usr/local/sml
WORKDIR $SMLROOT

# SML/NJ

## Install `multilib` for 32-bit support that SML/NJ requires.
RUN apt-get update && apt-get install -y gcc-multilib g++-multilib

RUN wget -O - http://smlnj.cs.uchicago.edu/dist/working/110.81/config.tgz | tar zxvf -
RUN config/install.sh

ENV PATH $SMLROOT/bin:$PATH

## Add Kernel

COPY . $HOME/sml
WORKDIR $HOME/sml

RUN jupyter kernelspec install kernels/smlnj

WORKDIR $HOME/notebook
CMD ["jupyter", "notebook", "--no-browser", "--allow-root", "--ip='*'"]
