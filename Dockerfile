FROM node:18-slim

WORKDIR /home/app

# Install system dependencies (curl, ffmpeg, youtube-dl, python3, build tools)
RUN apt-get update \
 && apt-get install -y curl ffmpeg youtube-dl python3 make g++ \
 && ln -sf /usr/bin/python3 /usr/bin/python \
 && rm -rf /var/lib/apt/lists/*

COPY package.json package-lock.json ./
RUN npm ci

COPY . ./
RUN mkdir -p public/temp && npm run build

EXPOSE 8080
CMD ["npm", "start"]
