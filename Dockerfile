FROM node:16-alpine as builder

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . . 
#since we are not changing code anymore
#we dont need docker volumes

RUN npm run build
# we will get all results form build in /app/build

#just put second phase directly under, no need terminology
FROM nginx
EXPOSE 80
# needs to get a port map to 80
# beanstalk will look at expose instructiion
COPY --from=builder /app/build /usr/share/nginx/html
#copy something from other phase