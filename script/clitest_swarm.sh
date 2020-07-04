export CLI_SWARM=$(docker ps -f name=test_cli | grep -o test_cli.*)

docker exec $CLI_SWARM peer channel create -c mychannel -o orderer.acornpub.com:7050 -f ./channel-artifacts/mychannel.tx --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/acornpub.com/orderers/orderer.acornpub.com/msp/tlscacerts/tlsca.acornpub.com-cert.pem
echo -------------------------------------------------------------
echo ----------------checking create channel----------------------
echo -------------------------------------------------------------
sleep 3
docker exec $CLI_SWARM peer channel join -b ./mychannel.block
echo -------------------------------------------------------------
echo ----------------checking join channel----------------------
echo -------------------------------------------------------------
sleep 3
docker exec $CLI_SWARM peer channel update -c mychannel -f ./channel-artifacts/Sales1MSPanchors.tx -o orderer.acornpub.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/acornpub.com/orderers/orderer.acornpub.com/msp/tlscacerts/tlsca.acornpub.com-cert.pem
echo -------------------------------------------------------------
echo ----------------checking update channel----------------------
echo -------------------------------------------------------------
sleep 3
docker exec $CLI_SWARM peer chaincode install -v 1.0 -n music -p github.com/chaincode/go
docker exec $CLI_SWARM peer chaincode list --installed
echo ------------------------------------------------------------------
echo ----------------checking installed chaincode----------------------
echo ------------------------------------------------------------------
sleep 5
docker exec $CLI_SWARM peer chaincode instantiate -C mychannel -n music -v 1.0 -o orderer.acornpub.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/acornpub.com/orderers/orderer.acornpub.com/msp/tlscacerts/tlsca.acornpub.com-cert.pem -c '{"Args":[""]}' -P "OR ('Sales1MSP.peer')"
echo --------------------waiting 5 seconds for instantiate chaincode----------------------
sleep 5
docker exec $CLI_SWARM peer chaincode list --instantiated -C mychannel
echo ------------------------------------------------------------------
echo ----------------checking instantiated chaincode----------------------
echo ------------------------------------------------------------------