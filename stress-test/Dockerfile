FROM golang:1.19

RUN go install github.com/tsenart/vegeta@latest

COPY targets.txt targets.txt
COPY attack.sh attack.sh
COPY file_import_body.json file_import_body.json

CMD ./attack.sh
