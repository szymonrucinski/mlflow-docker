FROM python:3.7.4

ENV SERVER_PORT 5000
ENV FILE_STORE /home/mlflowuser/mlflow/fileStore
ENV MLFLOW_DB /home/mlflowuser/mlflow/mlruns.db
ENV ARTIFACT_STORE /home/mlflowuser/mlflow/artifact_store
ENV SCRIPTS /mlflow/scripts
ENV PYTHONPATH /mlflow/utils

RUN pip install --upgrade pip
RUN apt update
RUN adduser mlflowuser 
RUN usermod -u 1015 mlflowuser
RUN groupmod -g 1015 mlflowuser

RUN apt-get install net-tools
# RUN apt-get install fuser

USER mlflowuser:mlflowuser



WORKDIR /home/mlflowuser/

RUN mkdir -p ~/mlflow/scripts \
    && mkdir -p ~/mlflow/artifactStore \
    && mkdir -p ~/mlflow/fileStore

USER mlflowuser:mlflowuser
WORKDIR /home/mlflowuser/

RUN pip install --user pipenv
# COPY --chown=mlflowuser:mlflowuser Pipfile Pipfile
# COPY --chown=mlflowuser:mlflowuser . .
ENV PATH="/home/mlflowuser/.local/bin:${PATH}"

RUN pip install --user pandas \
    && pip install  --user scikit-learn \
    && pip install --user xgboost\
    && pip install --user mlflow

USER root
WORKDIR /home/mlflowuser
# RUN  apt-get update \
#     && apt-get install -y git
# RUN chmod 777 -R home/mlflowuser/
# RUN chown mlflowuser:mlflowuser -R ./mlflowuser/mlflow/
# COPY /data1/userspace/szymon/Galaxus/mlflow/run.sh ${SCRIPTS}

COPY run.sh /home/mlflowuser/mlflow/scripts/run.sh
RUN chmod +x /home/mlflowuser/mlflow/scripts/run.sh
# CMD ["python"]
# RUN chmod 777 -R home/user/mlflow
RUN echo ${SCRIPTS}
# /home/mlflowuser/home/mlflowuser/mlflow/scripts


# RUN chmod 777 -R /opt/mlflow

# Copy over artifact and code
# COPY model_format.py /opt/mlflow/utils/
# COPY /temp_artifacts/ ${ARTIFACT_STORE}/
# USER mlflowuser:mlflowuser
# WORKDIR /home/mlflowuser/
# ENTRYPOINT ["/home/mlflowuser/.local/bin/env"]
USER mlflowuser:mlflowuser
# CMD ["ls"]
CMD ["bash", "/home/mlflowuser/mlflow/run.sh"]
# CMD ['/bin/bash']