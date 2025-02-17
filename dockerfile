FROM node:lts as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY ./ ./
RUN npm run build

# Stage 2: Nginx zum Ausführen der App
FROM nginx:alpine as production-stage
COPY - from=build-stage /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]