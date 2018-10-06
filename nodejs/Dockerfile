FROM node:boron

RUN mkdir -p /usr/src/app
ARG NODE=production
ENV NODE_ENV ${NODE}

WORKDIR /usr/src/app

COPY task-todo-app/ /usr/src/app/

RUN npm install

COPY . /usr/src/app

EXPOSE 3000

CMD [ "npm", "start", "guapo-api.js" ]
