FROM oven/bun

# "app" is always default workdir
WORKDIR /app

COPY package.json package.json
COPY bun.lockb bun.lockb

RUN bun install

COPY . .

ENV PORT=3000

EXPOSE 3000

CMD ["bun", "start"]
