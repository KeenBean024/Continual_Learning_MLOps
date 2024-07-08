FROM ghcr.io/mlflow/mlflow:v2.0.1

# Install psycopg2
RUN pip install psycopg2-binary

# Set environment variables
ENV MLFLOW_TRACKING_URI=postgresql+psycopg2://user:password@db:5432/mlflow

# Set the entrypoint to run the MLflow server
ENTRYPOINT ["mlflow", "server", "--backend-store-uri", "postgresql+psycopg2://user:password@db:5432/mlflow", "--default-artifact-root", "/mlflow", "--host", "0.0.0.0", "--port", "5000"]
