FROM quay.io/jupyter/minimal-notebook:afe30f0c9ad8

# Install conda-lock and build the pinned environment from the repo lockfile.
USER root
COPY conda-linux-64.lock /tmp/conda-linux-64.lock
RUN mamba install -y -n base -c conda-forge conda-lock && \
    mamba create -y -n dsci522 --file /tmp/conda-linux-64.lock && \
    mamba clean -afy && \
    rm -f /tmp/conda-linux-64.lock
USER ${NB_UID}

# Use the dsci522 environment by default and start JupyterLab when the container runs.
ENV CONDA_DEFAULT_ENV=dsci522
ENV PATH=/opt/conda/envs/dsci522/bin:$PATH
EXPOSE 8888
CMD ["start-notebook.py"]
