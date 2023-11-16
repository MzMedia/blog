#!/usr/bin/env sh
# 确保脚本抛出遇到的错误
set -e
npm run build # 生成静态文件
cd docs/.vuepress/dist # 进入生成的文件夹

# deploy to github
git config --global user.name "MzMedia"
git config --global user.email "mzmedia2023@126.com"

#echo 'blog.xugaoyi.com' > CNAME
if [ -z "$GITHUB_TOKEN" ]; then
  msg='deploy'
  githubUrl=git@github.com:Mzmedia/Mzmedia.github.io.git
else
  msg='来自github action的自动部署'
  #githubUrl=https://Mzmedia:${GITHUB_TOKEN}@git@github.com:Mzmedia/Mzmedia.github.io.git
  githubUrl=https://${GITHUB_TOKEN}@github.com/Mzmedia/Mzmedia.github.io.git
fi

git init
git add -A
git commit -m "${msg}"
git push -f $githubUrl master:gh-pages # 推送到github

cd -
rm -rf docs/.vuepress/dist
