FROM jupyter/base-notebook

# Copy Jupyter configuration file
COPY jupyter_notebook_config.py /home/jovyan/.jupyter/
WORKDIR /home/jovyan/work/

COPY Pipfile .
COPY Pipfile.lock .

RUN pip install pipenv
RUN pipenv install --system --deploy --ignore-pipfile --no-cache-dir
# Set environment variable to enable Jupyter Lab
ENV JUPYTER_ENABLE_LAB=yes
