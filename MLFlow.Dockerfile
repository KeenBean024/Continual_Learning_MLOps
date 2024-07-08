FROM ghcr.io/mlflow/mlflow:v2.0.1

# Install psycopg2
RUN pip install psycopg2-binary

ARG MLFLOW_TRACKING_URI=postgresql+psycopg2://user:password@db:5432/mlflow
ARG MLFLOW_ARTIFACT_ROOT=/mlflow/artifacts

# Set environment variables
ENV MLFLOW_TRACKING_URI=${MLFLOW_TRACKING_URI}
ENV MLFLOW_ARTIFACT_ROOT=${MLFLOW_ARTIFACT_ROOT}

RUN mkdir -p ${MLFLOW_ARTIFACT_ROOT}
# Set the entrypoint to run the MLflow server
ENTRYPOINT ["mlflow", "server", "--backend-store-uri", "${$MLFLOW_TRACKING_URI}", "--default-artifact-root", "${MLFLOW_ARTIFACT_ROOT}", "--host", "0.0.0.0", "--port", "5000"]
