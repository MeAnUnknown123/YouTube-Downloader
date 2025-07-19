FROM node:18-slim

WORKDIR /home/app

# Install required system dependencies for your app
RUN apt-get update \
 && apt-get install -y curl ffmpeg youtube-dl \
 && rm -rf /var/lib/apt/lists/*

COPY package.json package-lock.json ./
RUN npm ci

COPY . ./
RUN mkdir -p public/temp && npm run build

EXPOSE 8080
CMD ["npm", "start"]
