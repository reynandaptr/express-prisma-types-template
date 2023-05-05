all: migration

migration:
	mkdir -p migration/prisma
	cd migration && \
		git init && \
		git remote add origin "git@${GIT_REPOSITORY_HOST}:${PROJECT_GROUP}/${PROJECT_NAME}-migration.git" && \
		git pull origin main && \
		cp ../prisma/schema.prisma prisma/schema.prisma && \
		git checkout -b migration-${TAG_VERSION} && \
		pnpm install && \
		pnpm migrate:prepare:test && \
		git config user.name github-actions && \
		git config user.email 41898282+github-actions[bot]@users.noreply.github.com && \
		git add . && \
		git commit -m "feat: migration ${TAG_VERSION}" && \
		git push origin migration-${TAG_VERSION} && \
		echo ${PAT} | docker login ghcr.io --username ${PROJECT_GROUP} --password-stdin && \
		docker buildx create --name multi-arch --bootstrap --use && \
		docker buildx build --push --platform linux/arm64,linux/amd64 --tag ghcr.io/${PROJECT_GROUP}/${PROJECT_NAME}-migration:${TAG_VERSION} . && \
		docker buildx build --push --platform linux/arm64,linux/amd64 --tag ghcr.io/${PROJECT_GROUP}/${PROJECT_NAME}-migration:latest .
