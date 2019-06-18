FROM nginx

COPY default.conf /etc/nginx/conf.d/default.conf
COPY tekster /usr/share/nginx/json/tekster