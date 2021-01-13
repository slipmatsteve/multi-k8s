docker build -t slipmatsteve/multi-client:latest -t slipmatsteve/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t slipmatsteve/multi-server:latest -t slipmatsteve/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t slipmatsteve/multi-worker:latest -t slipmatsteve/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push slipmatsteve/multi-client:latest
docker push slipmatsteve/multi-server:latest
docker push slipmatsteve/multi-worker:latest

docker push slipmatsteve/multi-client:$SHA
docker push slipmatsteve/multi-server:$SHA
docker push slipmatsteve/multi-worker:$SHA
 
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=slipmatsteve/multi-server:$SHA 
kubectl set image deployments/client-deployment client=slipmatsteve/multi-client:$SHA 
kubectl set image deployments/worker-deployment worker=slipmatsteve/multi-worker:$SHA 