FROM node:16

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# Create a user with a known UID/GID within range 10000-20000.
# This is required by Choreo to run the container as a non-root user.
RUN adduser \
    --disabled-password \
    --gecos "" \
    --uid 10014 \
    "choreo"

# RUN chown -R choreo:choreo /app

# Use the above created unprivileged user
USER 10014

EXPOSE 4600

CMD [ "node", "app.js" ]
