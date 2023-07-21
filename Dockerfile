FROM node:15.14.0-alpine3.13

ENV CHROME_BIN="/usr/bin/chromium-browser" \
    PUPPETEER_SKIP_CHROMIUM_DOWNLOAD="true" \
    PUPPETEER_EXECUTABLE_PATH="/usr/bin/chromium-browser"
#RUN apt-get update -y && apt-get upgrade -y && apt-get install -y gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget net-tools git
RUN apk update && apk upgrade && apk add --no-cache udev ttf-freefont chromium git
ENV NODE_ENV ${NODE_ENV:-production}

RUN git clone https://github.com/pa11y/dashboard.git && cd dashboard && npm install --loglevel=error

EXPOSE 4000

COPY production.json /dashboard/config/production.json

# Start the web server
WORKDIR /dashboard
CMD node .
