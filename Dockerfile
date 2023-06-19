FROM node:18.16.0 as build
ARG REACT_APP_TG_API_ID=${REACT_APP_TG_API_ID}
ENV REACT_APP_TG_API_ID=${REACT_APP_TG_API_ID}
ARG REACT_APP_TG_API_HASH=${REACT_APP_TG_API_HASH}
ENV REACT_APP_TG_API_HASH=${REACT_APP_TG_API_HASH}
ARG ADMIN_USERNAME=${ADMIN_USERNAME}
ENV ADMIN_USERNAME=${ADMIN_USERNAME}
ARG DATABASE_URL=${DATABASE_URL}
ENV DATABASE_URL=${DATABASE_URL}

WORKDIR /app

COPY package.json .
COPY api/package.json api/package.json
COPY web/package.json web/package.json
RUN yarn cache clean
RUN yarn install --network-timeout 1000000
COPY . .
RUN yarn workspaces run build
CMD ["yarn", "start"]