build_local:
	docker build -t shiny-zebrafish .

run_local:
	docker run --rm -it -p 3838:3838 shiny-zebrafish

build_remote:
	docker build -t shinyapps-io-zebrafish .

deploy:
	docker run --env-file .Renviron shinyapps-io-zebrafish

R_console:
	docker run -it shiny-zebrafish R

clean_docker_containers:
	docker container prune

clean_docker_images:
	docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
