docker build -t imranoneem/multi-client:latest -t imranoneem/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t imranoneem/multi-server:latest -t imranoneem/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t imranoneem/multi-worker:latest -t imranoneem/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push imranoneem/multi-client:latest
docker push imranoneem/multi-server:latest
docker push imranoneem/multi-worker:latest

docker push imranoneem/multi-client:$SHA
docker push imranoneem/multi-server:$SHA
docker push imranoneem/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=imranoneem/multi-server:$SHA
kubectl set image deployments/client-deployment client=imranoneem/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=imranoneem/multi-worker:$SHA