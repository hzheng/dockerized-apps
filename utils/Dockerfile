FROM ubuntu:20.04

RUN apt-get update

ARG DEBIAN_FRONTEND=noninteractive

# install essential tools
RUN apt-get install -y g++ unzip zip openjdk-11-jdk wget build-essential

# install bazel
ARG BAZEL_VERSION=5.3.1
ARG BAZEL_INSTALL_SH=bazel-installer.sh
RUN wget -c https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh -O ${BAZEL_INSTALL_SH}
RUN chmod +x ${BAZEL_INSTALL_SH}
RUN ./${BAZEL_INSTALL_SH} && rm -f ${BAZEL_INSTALL_SH}

# install other utilities
# RUN apt-get install -y rsyslog

# run forever
CMD tail -f /dev/null
