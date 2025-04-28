# Stage 1: Compile and Build angular codebase
FROM node AS build
WORKDIR /app
COPY package*.json /app/
RUN npm install
COPY . /app
RUN npm run build 

# Stage 2, use the compiled app, ready for production with Nginx
FROM nginx:alpine
COPY --from=build /app/dist/sample-angular-app/browser /usr/share/nginx/html
#Changing default config 
COPY ./nginx/default.conf  /etc/nginx/conf.d/default.conf
# Port configured on nginx/default.conf is 8080
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]