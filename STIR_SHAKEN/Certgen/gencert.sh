#!/bin/sh

set -e
set -x

cat > TNAuthList.conf << EOF
asn1=SEQUENCE:tn_auth_list
[tn_auth_list]
field1=EXP:0,IA5:1234
EOF
openssl asn1parse -genconf TNAuthList.conf -out TNAuthList.der
cat > openssl.conf << EOF
[ req ]
distinguished_name = req_distinguished_name
req_extensions = v3_req
[ req_distinguished_name ]
commonName = "SHAKEN"
[ v3_req ]
EOF
od -An -t x1 TNAuthList.der | \
 sed -E -e 's/ +/:/g ; s/:$// ; s/^/1.3.6.1.5.5.7.1.26=DER/' >> openssl.conf
openssl ecparam -noout -name prime256v1 -genkey -out private_key.pem \
 -outform PEM
openssl req -new -nodes -key private_key.pem -keyform PEM \
 -out csr.pem -outform PEM \
 -subj '/C=US/ST=VA/L=Somewhere/O=AcmeTelecom, Inc./OU=VOIP/CN=SHAKEN' \
 -sha256 -config openssl.conf 

openssl ecparam -noout -name prime256v1 -genkey -out myCA.key -outform PEM
openssl req -x509 -new -nodes -key myCA.key -sha256 -days 1825 -out myCA.pem \
  -subj '/C=CA/ST=BC/L=Someplace/O=BigFatTelecom Corp./OU=VOIP/CN=SHAKEN' \
  -outform PEM
openssl x509 -req -in csr.pem -CA myCA.pem -CAkey myCA.key -CAcreateserial \
  -out cert.pem -days 825 -sha256 -outform PEM

