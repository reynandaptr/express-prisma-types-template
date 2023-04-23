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
		git push origin migration-${TAG_VERSION}
