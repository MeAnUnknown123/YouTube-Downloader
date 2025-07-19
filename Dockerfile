FROM node:18-slim

WORKDIR /home/app

# Install required system dependencies, Python, and build tools
RUN apt-get update \
 && apt-get install -y curl ffmpeg youtube-dl python3 make g++ \
 && ln -sf /usr/bin/python3 /usr/bin/python \
 && rm -rf /var/lib/apt/lists/*

# Copy dependency files
COPY package.json package-lock.json ./

# Install Node.js dependencies
RUN npm ci

# Copy the rest of the app
COPY . ./

# Build frontend (if needed)
RUN mkdir -p public/temp && npm run build || true

EXPOSE 8080
CMD ["npm", "start"]
