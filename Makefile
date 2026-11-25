# Make commands for development
# 
# `make run` runs an express dev server, listening on port 3000.
# `make deploy` copies built files to s3.

PIP=pip
PYTHON=python
NPM=npm

default: deploy

deploy:
	aws s3 --profile echnet sync ./static s3://neiborli-site --exclude .DS_Store
	aws cloudfront create-invalidation --distribution-id=E1APZ3ZFRP9YGO --paths "/*"

package-lock.json: package.json
	$(NPM) install

run: package-lock.json
	node server.js

clean:
	rm -rf ./deploy
