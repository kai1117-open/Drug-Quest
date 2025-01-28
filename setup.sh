echo "Running bundle install..."
bundle install

echo "Running yarn install..."
yarn install

echo "Running rails db:migrate..."
rails db:migrate

echo "Running rails db:seed..."
rails db:seed

echo "All tasks completed!"
