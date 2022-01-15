FROM python:3.8

RUN mkdir /app
COPY  . /app
WORKDIR  /app


RUN pip install -r requirements.txt

ENV ENVIRONMENT  DEV
ENV HOST localhost
ENV PORT 8000
ENV REDIS_HOST redis
ENV REDIS_PORT 6379
ENV REDIS_DB 0

EXPOSE 8080
CMD ["python" , "hello.py"]

