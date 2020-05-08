rm -rf public
hugo --theme=hello-friend-ng --baseUrl="https://min-zou.github.io/record.github.io"
cd public
git init
git add .
git config user.email "xxiao_l@163.com"
git commit -m "build site"
git push -f git@github.com:min-zou/record.github.io.git master
