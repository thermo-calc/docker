FROM ubuntu:18.04 as base

FROM base as builder
RUN apt-get update -qq 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
        build-essential \
        fp-compiler
# copy in termocalc from local
COPY thermocalc /tmp/thermocalc  
WORKDIR /tmp/thermocalc
RUN fpc -O3 thermo.pas

FROM base
COPY --from=builder /tmp/thermocalc/thermo /bin/thermo