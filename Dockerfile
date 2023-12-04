FROM node:20

WORKDIR /usr/app

COPY package*.json .

COPY src/ ./src/

COPY test/ ./test/

COPY  tsconfig.json .

COPY  tsconfig.build.json .

COPY  nest-cli.json .

RUN npm install

EXPOSE 3000

CMD ["npm", "run", "start"]
