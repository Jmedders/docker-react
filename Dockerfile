# as keyword can tag with the subsequent name
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
# no need for volumes as prod code doesn't change
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
# want to copy from a different phase
# taking everything from the app/build folder and serving it where nginx likes
COPY --from=builder /app/build /usr/share/nginx/html
# nginx starts up by default
