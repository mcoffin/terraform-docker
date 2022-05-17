FROM alpine:latest

RUN apk update && apk add ca-certificates
RUN apk add bash make gnupg

# Download the hashicorp PGP key
COPY hashicorp-*.asc ./
RUN bash -c 'find . -mindepth 1 -maxdepth 1 -type f -name "hashicorp-*.asc" | xargs -n 1 gpg2 --import'

ARG TF_VERSION

WORKDIR /
ADD https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip /terraform_${TF_VERSION}_linux_amd64.zip
ADD https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_SHA256SUMS /terraform_${TF_VERSION}_SHA256SUMS
ADD https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_SHA256SUMS.sig /terraform_${TF_VERSION}_SHA256SUMS.sig
RUN gpg2 --verify-files terraform_${TF_VERSION}_SHA256SUMS.sig \
	&& bash -c 'sha256sum -c <(find . -mindepth 1 -maxdepth 1 -type f -name "terraform_*_SHA256SUMS" | xargs cat | grep -F linux_amd64)' \
	&& TF_VERSION=${TF_VERSION} bash -c 'rm terraform_${TF_VERSION}_SHA256SUMS{,.sig}' \
	&& mv terraform_${TF_VERSION}_linux_amd64.zip terraform.zip
RUN unzip terraform.zip \
	&& rm terraform.zip \
	&& install -Dm755 -t /usr/local/bin terraform \
	&& rm terraform
