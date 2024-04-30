# Use a lightweight Node.js image as the base
FROM node:lts-alpine AS builder

# Set the working directory for the build stage
WORKDIR /app

# Copy package.json and yarn.lock (recommended for reproducibility)
COPY package*.json ./
COPY yarn.lock ./

# Install dependencies using Yarn
RUN yarn install --production

# Copy the entire project directory
COPY . .

# Build the Next.js app for production (adjust if needed)
RUN yarn build

# Create a slimmer image for serving the production build
FROM nginx:alpine

# Copy the build output from the previous stage
COPY --from=builder /app/.next /usr/share/nginx/html

# Optional: Configure Nginx for serving Next.js (replace with your config if needed)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose the default port (80)
EXPOSE 80

# Start the Nginx server
CMD ["nginx", "-g", "daemon off;"]
