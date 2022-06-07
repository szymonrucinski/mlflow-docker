export ARTIFACT_STORE=/home/mlflowuser/mlflow/artifact_store/
export MLFLOW_DB=/home/mlflowuser/mlflow/mlruns.db
mlflow server --default-artifact-root ${ARTIFACT_STORE} --backend-store-uri sqlite:///${MLFLOW_DB} --host 0.0.0.0 --port 5000 --gunicorn-opts "--log-level debug"