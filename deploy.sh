docker build -t hyu6/multi-client:latest -t hyu6/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hyu6/multi-server:latest -t hyu6/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hyu6/multi-worker:latest -t hyu6/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hyu6/multi-client:latest
docker push hyu6/multi-server:latest
docker push hyu6/multi-worker:latest

docker push hyu6/multi-client:$SHA
docker push hyu6/multi-server:$SHA
docker push hyu6/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=hyu6/multi-client:$SHA
kubectl set image deployments/server-deployment server=hyu6/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=hyu6/multi-worker:$SHA
