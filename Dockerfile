FROM ubuntu:14.04

ENV AWS_DEFAULT_REGION us-east-1

RUN apt-get update -q
RUN DEBIAN_FRONTEND=noninteractive apt-get install -qy python-pip groff-base
RUN pip install awscli

ENTRYPOINT ["/usr/local/bin/aws"]
