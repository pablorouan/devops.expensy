# ---- Build stage: compile Next.js app ----
FROM node:20-alpine AS build
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy sources and build Next.js app
COPY . .
RUN npm run build

# ---- Runtime stage: lightweight Next.js production image ----
FROM node:20-alpine
WORKDIR /app
ENV NODE_ENV=production

# Install only production dependencies
COPY package*.json ./
RUN npm install --omit=dev

# Copy build output and public assets
COPY --from=build /app/.next ./.next
COPY --from=build /app/public ./public

# Expose frontend port
EXPOSE 3000

# Run Next.js directly (no need for package.json "start" script)
CMD ["npx", "next", "start", "-p", "3000"]
