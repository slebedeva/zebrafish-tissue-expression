build:
	docker build -t shiny-zebrafish .

run_local:
	docker run --rm -it -p 3838:3838 shiny-zebrafish

deploy:
	docker run --env-file .Renviron shiny-zebrafish

R_console:
	docker run -it shiny-zebrafish R

clean_docker:
