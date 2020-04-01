FROM quay.io/kubernetes-ingress-controller/nginx-ingress-controller:0.29.0

USER root
RUN RUN apk --update add --no-cache unzip && rm -rf /var/cache/apk/*
RUN luarocks install lua-resty-jwt
RUN luarocks install inspect

ADD lua/oauth2_group_access.lua /etc/nginx/lua/oauth2_group_access.lua
RUN chown www-data:www-data /etc/nginx/lua/oauth2_group_access.lua

USER www-data
