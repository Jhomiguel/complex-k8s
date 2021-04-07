docker build -t jhomiguel/complex-client:lastest -t jhomiguel/complex-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t jhomiguel/complex-server:lastest -t jhomiguel/complex-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t jhomiguel/complex-worker:lastest -t jhomiguel/complex-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push jhomiguel/complex-client:lastest
docker push jhomiguel/complex-server:lastest
docker push jhomiguel/complex-worker:lastest

docker push jhomiguel/complex-client:$GIT_SHA
docker push jhomiguel/complex-server:$GIT_SHA
docker push jhomiguel/complex-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=jhomiguel/complex-client:$GIT_SHA
kubectl set image deployments/server-deployment server=jhomiguel/complex-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=jhomiguel/complex-worker:$GIT_SHA