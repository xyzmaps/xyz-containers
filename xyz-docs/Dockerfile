FROM python:latest as builder

RUN pip install mkdocs-material 
RUN git clone https://github.com/xyzmaps/xyz-documentation.git
RUN cd xyz-documentation && mkdocs build


# FROM httpd:2.4
# COPY --from=builder ./build/ /usr/local/apache2/htdocs/
