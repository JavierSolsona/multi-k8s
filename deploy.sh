docker build -t javiersolsona/multi-client:latest -t javiersolsona/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t javiersolsona/multi-server:latest -t javiersolsona/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t javiersolsona/multi-worker:latest -t javiersolsona/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push javiersolsona/multi-client:latest
docker push javiersolsona/multi-server:latest
docker push javiersolsona/multi-worker:latest

docker push javiersolsona/multi-client:$SHA
docker push javiersolsona/multi-server:$SHA
docker push javiersolsona/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=javiersolsona/multi-server:$SHA
kubectl set image deployments/client-deployment client=javiersolsona/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=javiersolsona/multi-worker:$SHA