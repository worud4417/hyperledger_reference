mkdir channel-artifacts
cd bin
./configtxgen -configPath ../ -profile TwoOrgsOrdererGenesis -channelID test-mychannel -outputBlock ../channel-artifacts/genesis.block
./configtxgen -configPath ../ -profile TwoOrgsChannel -channelID mychannel -outputCreateChannelTx ../channel-artifacts/mychannel.tx
./configtxgen -configPath ../ -profile TwoOrgsChannel -channelID mychannel -outputAnchorPeersUpdate ../channel-artifacts/Sales1MSPanchors.tx -asOrg Sales1
./configtxgen -configPath ../ -profile TwoOrgsChannel -channelID mychannel -outputAnchorPeersUpdate ../channel-artifacts/CustomerMSPanchors.tx -asOrg Customer