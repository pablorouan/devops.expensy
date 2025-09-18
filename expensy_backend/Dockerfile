# Dockerfile.frontend
FROM node:20-alpine
WORKDIR /app

# Copy source and package files
COPY . .

RUN npm install

# Build because this is TypeScript
RUN npm run build

# Expose port and run server
EXPOSE 8706
CMD ["npm", "start"]
