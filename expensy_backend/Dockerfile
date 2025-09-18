# Dockerfile.frontend
FROM node:20-alpine AS builder
WORKDIR /app

# Copy package files and install
COPY expensy_frontend/package*.json ./
RUN npm ci

# Copy source
COPY expensy_frontend/ ./

# Build Next.js app (inject API URL at build time)
ARG NEXT_PUBLIC_API_URL
ENV NEXT_PUBLIC_API_URL=$NEXT_PUBLIC_API_URL
RUN npm run build

# Production image
FROM node:20-alpine
WORKDIR /app

# Copy only what is needed
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public

EXPOSE 3000
CMD ["npm", "start"]
