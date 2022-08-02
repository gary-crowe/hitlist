FROM registry.redhat.io/ubi8/python-38
ENV MYSQL_USER=gary
ENV MYSQL_PASSWORD=redhat123
ENV MYSQL_DATABASE=offenders
ENV MYSQL_HOST=mysql
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
EXPOSE 5000
ENTRYPOINT [ "python" ]
CMD [ "offenders.py" ]
