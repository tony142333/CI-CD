# 1. Use an official Node.js runtime as a parent image
FROM node:18-alpine

# 2. Set the working directory inside the container
WORKDIR /app

# 3. Copy package.json and install dependencies first (for caching)
COPY package.json ./
RUN npm install

# 4. Copy the rest of the application code
COPY . .

# 5. Expose the port the app runs on
EXPOSE 3000

# 6. Define the command to run the app
CMD ["node", "server.js"]