#In AWS the as nuilder must be eliminate
FROM node:16-alpine

USER node

RUN mkdir -p /home/node/app
WORKDIR /home/node/app

COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node . .
 
RUN npm run build


#the builder must be replaced with 0 in AWS
FROM nginx
EXPOSE 3000
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=0 /home/node/app/build /usr/share/nginx/html