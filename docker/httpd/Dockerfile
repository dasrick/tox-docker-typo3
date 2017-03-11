FROM httpd:2.4.25-alpine

COPY ./ssl/server.crt /usr/local/apache2/conf/
COPY ./ssl/server.key /usr/local/apache2/conf/
COPY ./ssl/ca.crt /usr/local/apache2/conf/

RUN sed -i 's@#Include conf/extra/httpd-ssl.conf@Include conf/extra/httpd-ssl.conf@' /usr/local/apache2/conf/httpd.conf
RUN sed -i 's@#Include conf/extra/httpd-vhosts.conf@Include conf/extra/httpd-vhosts.conf@' /usr/local/apache2/conf/httpd.conf
RUN sed -i 's@#LoadModule ssl_module modules/mod_ssl.so@LoadModule ssl_module modules/mod_ssl.so@' /usr/local/apache2/conf/httpd.conf
RUN sed -i 's@#LoadModule socache_shmcb_module modules/mod_socache_shmcb.so@LoadModule socache_shmcb_module modules/mod_socache_shmcb.so@' /usr/local/apache2/conf/httpd.conf
RUN sed -i 's@#LoadModule expires_module modules/mod_expires.so@LoadModule expires_module modules/mod_expires.so@' /usr/local/apache2/conf/httpd.conf
RUN sed -i 's@#LoadModule rewrite_module modules/mod_rewrite.so@LoadModule rewrite_module modules/mod_rewrite.so@' /usr/local/apache2/conf/httpd.conf
RUN sed -i 's@#LoadModule deflate_module modules/mod_deflate.so@LoadModule deflate_module modules/mod_deflate.so@' /usr/local/apache2/conf/httpd.conf
RUN sed -i 's@#LoadModule proxy_fcgi_module modules/mod_proxy_fcgi.so@LoadModule proxy_fcgi_module modules/mod_proxy_fcgi.so@' /usr/local/apache2/conf/httpd.conf
RUN sed -i 's@#LoadModule proxy_module modules/mod_proxy.so@LoadModule proxy_module modules/mod_proxy.so@' /usr/local/apache2/conf/httpd.conf
RUN sed -i 's@#LoadModule headers_module modules/mod_headers.so@LoadModule headers_module modules/mod_headers.so@' /usr/local/apache2/conf/httpd.conf
RUN echo 'SSLCACertificateFile "/usr/local/apache2/conf/ca.crt"' >> /usr/local/apache2/conf/extra/httpd-ssl.conf



