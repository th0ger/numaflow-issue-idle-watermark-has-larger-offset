install:
	kind create cluster
	kubectl create ns numaflow-system
	kubectl apply -n numaflow-system -f https://raw.githubusercontent.com/numaproj/numaflow/v1.4.4/config/install.yaml
	kubectl apply -f https://raw.githubusercontent.com/numaproj/numaflow/v1.4.4/examples/0-isbsvc-jetstream.yaml
	kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
	kubectl patch -n kube-system deployment metrics-server --type=json -p '[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tls"}]'

ui:
	kubectl -n numaflow-system port-forward deployment/numaflow-server 8443:8443

pipeline:
	skaffold run

rm-pipeline:
	skaffold delete

clean:
	kind delete cluster
