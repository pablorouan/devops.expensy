# ---- Build stage: compile TypeScript to JS ----
FROM node:20-alpine AS build
WORKDIR /app

# Install all deps (incl. devDeps for tsc)
COPY package*.json ./
RUN npm ci

# Copy source and build (expects "build": "tsc" in package.json)
COPY . .
RUN npm run build

# ---- Runtime stage: slim image with prod deps only ----
FROM node:20-alpine
WORKDIR /app
ENV NODE_ENV=production

# Install only production deps
COPY package*.json ./
RUN npm ci --omit=dev

# Copy compiled JS only
COPY --from=build /app/dist ./dist

# App listens on 8706
EXPOSE 8706

# Run compiled server
CMD ["node", "dist/server.js"]
