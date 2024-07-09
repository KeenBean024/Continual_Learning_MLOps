FROM ghcr.io/mlflow/mlflow:v2.0.1

# Install psycopg2
RUN pip install psycopg2-binary
RUN apt-get update && apt-get install -y postgresql-client

ARG MLFLOW_TRACKING_URI=postgresql+psycopg2://user:password@db:5432/mlflow
ARG MLFLOW_ARTIFACT_ROOT=/mlflow/artifacts

# Set environment variables
ENV MLFLOW_TRACKING_URI=${MLFLOW_TRACKING_URI}
ENV MLFLOW_ARTIFACT_ROOT=${MLFLOW_ARTIFACT_ROOT}

RUN mkdir -p ${MLFLOW_ARTIFACT_ROOT}

# Set the entrypoint to run the MLflow server
# ENTRYPOINT ["sh", "-c", "mlflow server --backend-store-uri ${MLFLOW_TRACKING_URI} --default-artifact-root ${MLFLOW_ARTIFACT_ROOT} --host 0.0.0.0 --port 5000"]
RUN pip install gevent
COPY wait-for-db.sh /wait-for-db.sh
RUN chmod +x /wait-for-db.sh

# Create a script to run the db upgrade and then start the server
RUN echo '#!/bin/sh\n\
/wait-for-db.sh db\n\
mlflow db upgrade ${MLFLOW_TRACKING_URI}\n\ # RUN upgrade only when new postgres server is used
mlflow server --backend-store-uri ${MLFLOW_TRACKING_URI} --serve-artifacts --default-artifact-root ${MLFLOW_ARTIFACT_ROOT} --host 0.0.0.0 --port 5000 --gunicorn-opts "--worker-class gevent --threads 3 --workers 3 --timeout 300 --keep-alive 300 --log-level INFO"' > /start.sh

RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]