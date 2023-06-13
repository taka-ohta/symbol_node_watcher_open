FROM node:14.16.1

WORKDIR /usr/src/app
COPY . .
RUN npm install --production

CMD [ "npx", "ts-node", "./src/index.ts" ]
