php craft db/backup
php craft off

git reset HEAD --hard
git pull origin main

composer install --no-dev --no-interaction --prefer-dist --optimize-autoloader

php craft migrate/all --no-content --interactive=0
php craft project-config/apply
php craft migrate --track=content --interactive=0

npm install
npm run build

php craft on
