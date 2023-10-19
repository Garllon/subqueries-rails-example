setup:
	docker-compose build
	docker-compose run --rm development bundle exec rake db:create
	docker-compose run --rm development bundle exec rake db:migrate
	docker-compose run --rm test bundle exec rake db:create
	docker-compose run --rm test bundle exec rake db:migrate
	echo 'Successfully finished setup.'

console:
	docker-compose run development rails c

terminal:
	docker-compose run development bash

devserver:
	docker-compose up development

clean:
	docker-compose run --rm development bundle exec rake db:drop
	docker-compose run --rm test bundle exec rake db:drop
	docker-compose down --rmi local
	yes | docker system prune
	echo 'Successfully finished cleanup.'