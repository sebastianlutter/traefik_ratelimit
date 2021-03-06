# Traefik rate limit example

This is a test for the traefik rate limiter functionality like described here:
* https://docs.traefik.io/configuration/commons/#rate-limiting

Using the docker labels like described here:
* https://docs.traefik.io/configuration/backends/docker/#using-docker-compose

Benchmarks are done with apache benchmark: (part of apache2-utils)
* https://httpd.apache.org/docs/2.4/programs/ab.html

## Testing the rate limit

* add **foo.bar** as domain to /etc/hosts
```bash
127.0.0.1 foo.bar
```

* start stack with deploy.sh
```bash
./deploy.sh
```

* benchmark with rate limit from traefik
```bash
ab -c1 -n500 -l http://foo.bar/
```

* benchmark nginx directly
```bash
ab -c1 -n500 -l http://foo.bar:7080/
```

* inspect service labels of **webservice** service
```bash
docker service inspect gateway_webservice
```

* inspect container labels of **webservice** tasks
```bash
docker inspect $(docker ps |grep hello|cut -d" " -f1)
```

Discussion about this can be found here:
* https://github.com/containous/traefik/issues/4576

The right way to use the rateLimit for docker stack services is to use them as
deploy labels in the affected services and replacing **<name>** by some arbitrary 
name. You can stack multiple rateLimits for an service by using multiple names.
