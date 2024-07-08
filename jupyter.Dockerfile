FROM jupyter/base-notebook

# Copy Jupyter configuration file
COPY jupyter_notebook_config.py /home/jovyan/.jupyter/

# Set environment variable to enable Jupyter Lab
ENV JUPYTER_ENABLE_LAB=yes
