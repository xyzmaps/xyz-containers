FROM docker.io/python:latest AS builder

RUN pip install mkdocs-material 
RUN git clone https://github.com/xyzmaps/xyz-documentation.git
RUN cd xyz-documentation && mkdocs build -d ./build


FROM docker.io/nginx:latest
COPY --from=builder /xyz-documentation/build/ /usr/share/nginx/html