# 1. Install the Ruby bundle
bundle install

# 2. Install yarn dependencies
yarn

# Then either:
# 3a. Run the 'dev' task to start a local server for development
# yarn run dev

# or:
# 3b: Run the 'build' task to generate the static site for deployment
yarn run build

cd ./build
mv accessibility.html.zh_Hant accessibility/index.html
mv cookies.html.zh_Hant cookies/index.html
mv features.html.zh_Hant features/index.html
mv index.html.zh_Hant index.html
mv privacy.html.zh_Hant privacy/index.html
mv support.html.zh_Hant support/index.html