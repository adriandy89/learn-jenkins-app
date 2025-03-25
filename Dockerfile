#stage 1
FROM node:20 as dev
RUN mkdir -p /app
WORKDIR /app
COPY --chown=node:node package*.json ./
RUN npm install --verbose
COPY --chown=node:node . .
RUN npm run build
#stage 2
FROM nginx
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=dev /app/build /usr/share/nginx/html
# Expose port 80
EXPOSE 80
