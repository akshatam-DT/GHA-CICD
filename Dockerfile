
FROM node:20-alpine AS builder
WORKDIR /app

COPY package*.json ./

# RUN --mount=type=cache,target=/root/.npm \
RUN   npm ci --legacy-peer-deps

COPY . .

RUN npm run build

FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
