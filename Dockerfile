FROM quay.io/kubernetes-ingress-controller/nginx-ingress-controller:0.25.1

USER root

RUN luarocks install lua-resty-jwt
RUN luarocks install inspect

ADD lua/oauth2_group_access.lua /etc/nginx/lua/oauth2_group_access.lua
RUN chown www-data:www-data /etc/nginx/lua/oauth2_group_access.lua

USER www-data
