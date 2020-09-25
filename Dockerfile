FROM fedora:latest

LABEL maintainer="Ralph Bean" \
      summary="A prometheus exporter for koji." \
      distribution-scope="public"

RUN pip3 install -r requirements.txt

# Allow a non-root user to install a custom root CA at run-time
RUN chmod g+w /etc/pki/tls/certs/ca-bundle.crt

COPY koji-prometheus-exporter.py /usr/local/bin/.
COPY docker/ /docker/

USER 1001
EXPOSE 8000
ENTRYPOINT ["/docker/entrypoint.sh", "/usr/local/bin/koji-prometheus-exporter.py"]
