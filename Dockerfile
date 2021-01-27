#Stage 1
FROM registry.access.redhat.com/ubi8/nodejs-12 as build-stage
USER root
WORKDIR /ims-frontend
COPY . .
RUN npm install && npm run build --prod
#Stage 2
#FROM registry.redhat.io/ubi7/nginx-118
FROM registry.access.redhat.com/ubi7/nginx-118
#####NEW########
#WORKDIR /ims-frontend
#COPY /dist/ims-core /opt/app-root/src
EXPOSE 4200 8080 80 8443 6443
#USER root
COPY --from=build-stage /ims-frontend/dist/ims-core /opt/app-root/src
CMD ["nginx", "-g", "daemon off;"]
