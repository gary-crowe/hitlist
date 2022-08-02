FROM registry.redhat.io/ubi8/python-38
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
EXPOSE 5000
ENTRYPOINT [ "python" ]
CMD [ "offenders.py" ]
