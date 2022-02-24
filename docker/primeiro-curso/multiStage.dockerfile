FROM python:slim
WORKDIR /home/app
COPY requirements.txt .
COPY package.json .
RUN pip install -r requirements.txt
RUN apt-get update && apt-get install nodejs -y
RUN apt-get install npm -y
RUN npm install
COPY ./code .
ENTRYPOINT node server.js