# Use a smaller Node.js base image
FROM node:18-slim

# Set working directory
WORKDIR /home/node/app

# Install production dependencies only
COPY package.json yarn.lock ./
RUN yarn install --production

# Copy app source code
COPY . .

# Use Cloud Run’s dynamic PORT environment variable
ENV NODE_ENV=production
ENV PORT=8080

# Build the production app
RUN yarn run build

# Drop to non-root user
USER node

# Start the app
CMD ["yarn", "start"]
