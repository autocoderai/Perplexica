# Build stage
FROM node:22-slim AS build

ARG USER=node

WORKDIR /app

COPY src /app/src
COPY tsconfig.json /app/
COPY drizzle.config.ts /app/
COPY package.json /app/
COPY yarn.lock /app/

RUN mkdir /app/data

RUN yarn install --frozen-lockfile --network-timeout 600000
RUN yarn build

# Runtime stage
FROM node:22-slim

ARG USER=node

WORKDIR /app

COPY --from=build /app /app

RUN chown -R $USER:$USER /app
USER $USER

CMD ["yarn", "start"]
