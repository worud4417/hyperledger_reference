export CLI_SWARM=$(docker ps -f name=test_cli | grep -o test_cli.*)

docker exec \
  -e CORE_PEER_LOCALMSPID=CustomerMSP \
  -e CORE_PEER_ADDRESS=peer0.customer.acornpub.com:9051 \
  -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/customer.acornpub.com/users/Admin@customer.acornpub.com/msp/ \
  -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/customer.acornpub.com/peers/peer0.customer.acornpub.com/tls/ca.crt \
  $CLI_SWARM \
  peer channel create -c yourchannel -o orderer.acornpub.com:7050 -f ./channel-artifacts/yourchannel.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/acornpub.com/orderers/orderer.acornpub.com/msp/tlscacerts/tlsca.acornpub.com-cert.pem \

echo -------------------------------------------------------------
echo ----------------checking create channel----------------------
echo -------------------------------------------------------------
sleep 3

docker exec \
  -e CORE_PEER_LOCALMSPID=CustomerMSP \
  -e CORE_PEER_ADDRESS=peer0.customer.acornpub.com:9051 \
  -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/customer.acornpub.com/users/Admin@customer.acornpub.com/msp/ \
  -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/customer.acornpub.com/peers/peer0.customer.acornpub.com/tls/ca.crt \
  $CLI_SWARM \
  peer channel join -b ./yourchannel.block

echo -------------------------------------------------------------
echo ----------------checking join channel----------------------
echo -------------------------------------------------------------
sleep 3

docker exec \
  -e CORE_PEER_LOCALMSPID=CustomerMSP \
  -e CORE_PEER_ADDRESS=peer0.customer.acornpub.com:9051 \
  -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/customer.acornpub.com/users/Admin@customer.acornpub.com/msp/ \
  -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/customer.acornpub.com/peers/peer0.customer.acornpub.com/tls/ca.crt \
  $CLI_SWARM \
  peer channel update -c yourchannel -f ./channel-artifacts/CustomerMSPanchors_your.tx -o orderer.acornpub.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/acornpub.com/orderers/orderer.acornpub.com/msp/tlscacerts/tlsca.acornpub.com-cert.pem

echo -------------------------------------------------------------
echo ----------------checking update channel----------------------
echo -------------------------------------------------------------
sleep 3

docker exec \
  -e CORE_PEER_LOCALMSPID=CustomerMSP \
  -e CORE_PEER_ADDRESS=peer0.customer.acornpub.com:9051 \
  -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/customer.acornpub.com/users/Admin@customer.acornpub.com/msp/ \
  -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/customer.acornpub.com/peers/peer0.customer.acornpub.com/tls/ca.crt \
  $CLI_SWARM \
  peer chaincode install -v 1.0 -n fabcar -p github.com/chaincode/javascript

docker exec \
  -e CORE_PEER_LOCALMSPID=CustomerMSP \
  -e CORE_PEER_ADDRESS=peer0.customer.acornpub.com:9051 \
  -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/customer.acornpub.com/users/Admin@customer.acornpub.com/msp/ \
  -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/customer.acornpub.com/peers/peer0.customer.acornpub.com/tls/ca.crt \
  $CLI_SWARM \
  peer chaincode list --installed

echo ------------------------------------------------------------------
echo ----------------checking installed chaincode----------------------
echo ------------------------------------------------------------------
sleep 5

docker exec \
  -e CORE_PEER_LOCALMSPID=CustomerMSP \
  -e CORE_PEER_ADDRESS=peer0.customer.acornpub.com:9051 \
  -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/customer.acornpub.com/users/Admin@customer.acornpub.com/msp/ \
  -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/customer.acornpub.com/peers/peer0.customer.acornpub.com/tls/ca.crt \
  $CLI_SWARM \
  peer chaincode instantiate -C yourchannel -n fabcar -v 1.0 -o orderer.acornpub.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/acornpub.com/orderers/orderer.acornpub.com/msp/tlscacerts/tlsca.acornpub.com-cert.pem -c '{"Args":[""]}' -P "OR ('CustomerMSP.peer')"

echo --------------------waiting 5 seconds for instantiate chaincode----------------------
sleep 5

docker exec \
  -e CORE_PEER_LOCALMSPID=CustomerMSP \
  -e CORE_PEER_ADDRESS=peer0.customer.acornpub.com:9051 \
  -e CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/customer.acornpub.com/users/Admin@customer.acornpub.com/msp/ \
  -e CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/customer.acornpub.com/peers/peer0.customer.acornpub.com/tls/ca.crt \
  $CLI_SWARM \
  peer chaincode list --instantiated -C yourchannel

echo ------------------------------------------------------------------
echo ----------------checking instantiated chaincode----------------------
echo ------------------------------------------------------------------