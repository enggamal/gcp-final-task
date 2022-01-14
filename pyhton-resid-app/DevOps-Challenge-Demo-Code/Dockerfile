FROM python:3.8-slim

COPY requirements.txt /
RUN pip install -r /requirements.txt
#RUN pip install redis==3.0.1
#FROM redis
#COPY redis.conf /usr/local/etc/redis/redis.conf
#RUN ["redis-server"]
# Expose ports.
#EXPOSE 6379
#RUN pip install tornado==5.1.1
COPY . /app
WORKDIR /app
RUN  [ "python","tests/test.py" ]
RUN export $(cat .env | xargs)
EXPOSE 8181
CMD ["python" , "hello.py"]

