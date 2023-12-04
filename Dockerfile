FROM node:20

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY /src .

COPY  tsconfig.json .

COPY  tsconfig.build.json .

COPY  nest-cli.json .

EXPOSE 3000

CMD ["npm", "run", "start"]
