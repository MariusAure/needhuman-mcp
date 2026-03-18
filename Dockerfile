FROM node:18-slim

WORKDIR /app

COPY package.json package-lock.json* ./
RUN npm ci
COPY tsconfig.json mcp-server.ts ./
RUN npx tsc && npm prune --omit=dev

ENTRYPOINT ["node", "dist/mcp-server.js"]
