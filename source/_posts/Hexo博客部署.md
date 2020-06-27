---
title: Hexo博客部署
categories:
  - Blog
tags:
  - Blog
abbrlink: 37349663
date: 2019-11-29 16:43:03
---

# Github Page部署

1. [New repository](https://github.com/new)
2. 必填的只有Repository name
   1. 格式为：**{user_name}.github.io**
   2. user_name必须与github用户名一致


# 配置ssh与git

- 生成SSH key, 邮箱改为对应的邮箱名， 然后一路回车

```bash
ssh-keygen -t rsa -C your_email@youremail.com
```

- 上述命令会在主目录下生成`.ssh`文件夹, 复制文件夹下`id_rsa.pub`内容
- [添加SSH key](https://github.com/settings/ssh/new): 右上角头像->settings->SSH and GPG keys->new SSH Key
  - 将上述操作复制的内容添加到key中
  - 填好title，然后add SSH key, 添加key

- 验证github, `ssh -T git@github.com`
  - 第一次会出现 **Are you sure you want to continue connecting (yes/no)?** 
  - 这时应该输入yes
  - 当出现：**You've successfully authenticated, but GitHub does not provide shell access.**，说明成功了
- 配置用户名和邮箱, 用于每次提交时的个人信息记录

```bash
git config --global user.name your name
git config --global user.email your_email@youremail.com
```
<!-- more -->

# Hexo 持续集成


- 项目配置
  - 备份博客源文件, 在本地仓库创建 hexo 分支
  - 密钥配置
    - `ssh-keygen`
    - 项目页.Settings.Deploy keys.Add deploy key
    - 将deploy_key.pub公钥内容复制上去，**勾选：Allow write access**
  - 添加加密环境变量, 用于后续配置文件使用
    - 项目页.Settings.Secrets.Add a new secret
|  环境变量  | 说明                                   |
| :--------: | :------------------------------------- |
| DEPLOY_KEY | 发布key 私钥，`deploy_key`私钥文件内容 |
|   EMAIL    | 发布用户邮箱账号                       |
|    NAME    | 发布用户名                             |
```bash
# 克隆项目到本地
git clone https://github.com/xxx/xxx.github.io.git
# 创建并切换到 hexo 分支
git checkout -b hexo
# 提交本地 hexo 分支到远程仓库的 hexo 分支
git push origin hexo:hexo
```

- 修改`_config.xml`
  - repo链接必须为ssh格式

```xml
deploy:
  type: 'git'
  repo: git@github.com:Hosted-code/Hosted-code.github.io.git
  branch: master
  message: "Github CI Auto Builder at {{ now('YYYY-MM-DD HH:mm:ss Z') }}"
```

- 添加Action
  - 创建action文件, `.github/workflows/hexo.yml`
  - 根目录下.gitignore中需要移除package-lock.json

```xml
name: Hexo CICD

on: # 监视 `hexo`分支
  push:
      branches:
      - hexo

jobs:
  build:
    runs-on: ubuntu-latest
    if: "!contains(github.event.head_commit.message, '[ci skip]')"
    steps:
      - name: Checkout
        uses: actions/checkout@v1
        with:
          submodules: true
      - name: Cache node modules
        uses: actions/cache@v1
        with:
          path: node_modules
          key: ${{runner.OS}}-${{hashFiles('**/package-lock.json')}}
      - uses: yrpang/github-actions-hexo@master
        with:
          deploykey: ${{secrets.DEPLOY_KEY}}
          username: ${{secrets.NAME}}
          email: ${{secrets.EMAIL}}
```
- 之后发布博客的命令
```bash
# 切换到 hexo 分支
git checkout hexo

# 提交新博文
git add .
git commit -m "Publish new post."

# 推送到远程仓库
git push
```
# 参考链接

- [基于Hexo+Github+Coding搭建个人博客——基础篇(从菜鸟到放弃)](https://yangbingdong.com/2017/build-blog-hexo-base/)
- [持续集成CI](https://easyhexo.com/1-Hexo-install-and-config/1-5-continuous-integration.html#%E4%BB%80%E4%B9%88%E6%98%AF%E6%8C%81%E7%BB%AD%E9%9B%86%E6%88%90%EF%BC%9F)
- [GitHub Actions自动部署Hexo博客](https://blog.motreen.ml/posts/35722/)