# ============================
# Prepare lint Environment
FROM node:22-alpine AS lint-env
WORKDIR /app
COPY . .
RUN npm install --loglevel verbose
# RUN npm run build
# RUN npm run lint

# ============================
# Prepare Build Environment
FROM python:3.11 AS python-env
WORKDIR /app
COPY --from=lint-env /app .
RUN apt-get update && apt-get install -y weasyprint fonts-noto-cjk wget unzip
RUN rm node_modules -rf && pip install -r requirements.txt
RUN mkdir -p site && mkdocs build

# ============================
# Prepare Runtime Environment
FROM nginx:1-alpine
COPY --from=python-env /app/site /usr/share/nginx/html

# Ensure nginx serves the site directory
COPY nginx.conf /etc/nginx/conf.d/default.conf

LABEL org.opencontainers.image.source="https://github.com/xmg2024/cook-in-home"
