# Build stage
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install --only=production

# Production stage
FROM node:20-alpine

ENV NODE_ENV production

WORKDIR /app

COPY --from=build /app/node_modules ./node_modules
COPY app.js ./

USER node

EXPOSE 3000

CMD ["node", "app.js"] 