ARG NODE_VERSION
ARG NODE_IMAGE=node:$NODE_VERSION

ARG REACH_VERSION
ARG JS_DEPS_IMAGE=reachsh/js-deps:$REACH_VERSION

# hadolint ignore=DL3006
FROM $JS_DEPS_IMAGE as js-deps

# hadolint ignore=DL3006
FROM $NODE_IMAGE

WORKDIR /stdlib
COPY --from=js-deps /js-deps/node_modules /stdlib/node_modules
COPY package.json package-lock.json /stdlib/
# The above should cover all `npm install` needs
# RUN npm install

COPY ts/* /stdlib/ts/
COPY *.mjs /stdlib/
COPY types/* /stdlib/types/
# We need .gitignore for eslint, weirdly
COPY tsconfig.json \
     .eslintrc.yaml .eslintignore .gitignore \
     /stdlib/
COPY sbin/* /stdlib/sbin/

RUN npm run tsc
RUN ./sbin/fix.sh
RUN rm ./sbin/fix.sh

# TODO: remove this runner stuff, probably
ENV REACH_RUNNER_MOUNT_DIR /app
ENTRYPOINT ["npm", "run", "--"]
CMD ["runner", "FAKE", "index.mjs"]

ARG REACH_GIT_HASH
ENV REACH_GIT_HASH="${REACH_GIT_HASH}"
