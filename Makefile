up: cluster namespace strizmi-operator kafka-cluster
cluster:
	k3d cluster create labs \
	    -p 80:80@loadbalancer \
	    -p 443:443@loadbalancer \
	    -p 30000-32767:30000-32767@server[0] \
	    -v /etc/machine-id:/etc/machine-id:ro \
	    -v /var/log/journal:/var/log/journal:ro \
	    -v /var/run/docker.sock:/var/run/docker.sock \
		--k3s-server-arg '--no-deploy=traefik' \
	    --agents 3
namespace:
	kubectl apply -f namespace.yaml
strizmi-operator:
	kubectl apply -f 'https://strimzi.io/install/latest?namespace=kafka' -n kafka
kafka-cluster:
	kubectl apply -f https://strimzi.io/examples/latest/kafka/kafka-persistent-single.yaml -n kafka
kafka-topic:
	kubectl apply -f kafkatopic.yaml -n kafka
