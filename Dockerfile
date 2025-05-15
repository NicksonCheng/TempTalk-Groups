# Use Node.js base image
FROM node:22.14.0 AS builder

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy project files
COPY . .

# Final stage: runtime container
FROM node:22.14.0

WORKDIR /app

# Copy built files from the builder stage
COPY --from=builder /app/ /app/

# Expose port for backend
EXPOSE 5000

# Start backend
CMD npm run dev