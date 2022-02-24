FROM python:slim as dependency
WORKDIR /regs
COPY requirements.txt /reqs
RUN pip install -r requirements.txt

FROM node:lts as package
WORKDIR /packages
COPY package.json .
RUN npm install

FROM python:slim
RUN apt-get update && apt-get install nodejs -y
WORKDIR /home/app
COPY ./code/ .
COPY --From=dependency /usr/local/lib/python3.7/site-packages /usr/local/lib/python3.7/site-packages/
COPY --From=packages /packages/node_modules /home/app/node_modules
ENTRYPOINT node server.js