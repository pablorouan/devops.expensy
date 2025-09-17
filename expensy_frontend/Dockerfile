# ---- Build stage: compile Next.js app ----
FROM node:20-alpine AS build
WORKDIR /app

# Accept build-time public env
ARG NEXT_PUBLIC_API_URL
ENV NEXT_PUBLIC_API_URL=${NEXT_PUBLIC_API_URL}

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# ---- Runtime stage stays as before ----
FROM node:20-alpine
WORKDIR /app
ENV NODE_ENV=production

COPY package*.json ./
RUN npm install --omit=dev

COPY --from=build /app/.next ./.next
COPY --from=build /app/public ./public

EXPOSE 3000
CMD ["npx", "next", "start", "-p", "3000"]
