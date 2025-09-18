# Step 1: Use an official Node.js image as the base image
FROM node:18-alpine

# Step 2: Set the working directory in the container
WORKDIR /app

# Step 3: Copy all application code
COPY . .

# Step 4: Install the dependencies
RUN npm install

# Step 5: Set the API URL that will be embedded into the frontend

# Define build arg
ARG NEXT_PUBLIC_API_URL

# Make it available as an environment variable . This ensures NEXT_PUBLIC_API_URL is injected at build time and available during npm run build
ENV NEXT_PUBLIC_API_URL=$NEXT_PUBLIC_API_URL

# Step 6: Build the Next.js app (production build)
RUN npm run build

# Step 7: Expose the port that Next.js will run on
EXPOSE 3000

# Step 8: Start the Next.js app
CMD ["npm", "start"]