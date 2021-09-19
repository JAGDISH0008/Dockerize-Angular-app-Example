FROM node:12 as node

# Setting up the working directory
WORKDIR /usr/local/app

# Coping the package.json to app
COPY package*.json /usr/local/app/

# Install all the dependencies
RUN npm install

# Coping the source code to app
COPY . /usr/local/app/

# Generate the build of the application
RUN npm run build


# Serving the  app with nginx
FROM nginx:latest

# Copy the build output to replace the default nginx contents.
COPY --from=node /usr/local/app/dist/sample-app /usr/share/nginx/html

# Expose port 80
EXPOSE 80