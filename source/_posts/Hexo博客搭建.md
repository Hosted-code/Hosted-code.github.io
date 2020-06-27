---
title: Hexo 博客搭建
categories: 
  - Blog
tags:
  - Blog
abbrlink: 426584999
date: 2019-11-29 12:25:03
---

# 安装hexo

- 安装前提
    - [Node.js](http://nodejs.org/) (安装时确保 **add to path**)
    - [Git](https://git-scm.com/)

```bash
npm install -g hexo-cli         # 安装 Hexo
hexo init                       # 在站点目录里执行， 初始化站点

git clone https://github.com/theme-next/hexo-theme-next themes/next  #下载主题
theme: next           # _config.yml, 启用next主题

scheme: Pisces        # theme/next/_config.yml, 启用 Pisces 的样式
```
<!-- more -->

# 插件

- 查看本地有哪些包
```diff
# 站点根目录的package.json也记录着
λ npm ls --depth 0                  
hexo-site@0.0.0 D:\Blog 
hexo@4.1.0
+ hexo-abbrlink@2.0.5
+ hexo-deployer-git@2.1.0
hexo-generator-archive@1.0.0
hexo-generator-category@1.0.0
hexo-generator-index@1.0.0
+ hexo-generator-searchdb@1.2.0
hexo-generator-tag@1.0.0
+ hexo-related-popular-posts@3.0.6
hexo-renderer-ejs@1.0.0
hexo-renderer-marked@2.0.0
hexo-renderer-stylus@1.1.0
hexo-server@1.0.0
+ hexo-symbols-count-time@0.7.0
```

```bash
npm install hexo-deployer-git --save                    # 部署插件
npm install hexo-symbols-count-time --save              # 文章字数统计
npm install hexo-related-popular-posts --save           # 相关文章推荐
npm install hexo-generator-searchdb --save              # 本地博客搜索
npm install hexo-abbrlink --save                        # 生成唯一文章链接
npm install hexo-neat --save                            # 静态资源压缩
npm install hexo-generator-feed --save                  # rss
```

- 装完有可能出现如下提示, 按照提示输入命令执行下
- **是否一定要照着 npm 或 GitHub 的建议來更新 package 似乎是不一定，而且得要靠个人判断，目前认为有效的判断方法是：透过在 GitHub 上的 issue 讨论来获得资讯。**
- 修复步骤
    1. `npm audit fix`
    2. `npm audit`
    3. `open More info`
    4. `cd Path && npm -i --save package@version`

```bash
#found 1 low severity vulnerability
# run `npm audit fix` to fix them, or `npm audit` for details、
npm audit fix       #尝试修复下
npm audit           #查看细节
  Low             Regular Expression Denial of Service
  Package         braces
  Patched in      >=2.3.1
  Dependency of   hexo-abbrlink
  Path            hexo-abbrlink > hexo-fs > chokidar > anymatch > micromatch > braces
  More info       https://npmjs.com/advisories/786
# 查看More info, 然后进入到路径后更新包
# 指定更新包到那个版本， 也可以是最新版(lastest), --save, 省掉你手动修改package.json文件的步骤
npm i --save braces@2.3.1        
```

# 新建页面

```bash
hexo new page tags                      # 新建标签
hexo new page categories            # 新建分类
hexo new page links                     # 新建友链
```

```bash
# 标签页面, source/tags/index.md
title: 标签
type: "tags"

# 分类页面, source/categories/index.md
title: 分类
type: "categories"

# 友链页面, source/links/index.md
title: 友情链接
type: "links"

# 站点启用评论，需要在上述页面禁用评论的
comments: false
```


# 站点配置

- 站点配置文件： **_config.yml**
- 下列展示代码均为 **需要修改** 的部分

```yml
# _config.yml
# site 
title: Hosted's Blog
subtitle: ''
description: ''
keywords:
author: Hosted
language: zh-CN
timezone: ''

# permalink config
permalink: posts/:abbrlink.html         #改变年月日标题的链接方式， 生成唯一链接(纯数字的)， 避免中文链接导致权重降低
abbrlink:
  alg: crc32  #support crc16(default) and crc32
  rep: dec    #support dec(default) and hex

theme: next           # 启用next主题, 开始已经改过了

deploy:
  type: git
  repo:
    github: https://github.com/username/username.github.io.git, master
```

# 主题配置

- 主题配置文件：**theme/next/_config.yml**

```yml
footer:
  since:          # 博客开始时间

# 关闭hexo和next的强力驱动("广告")
powered:
    # Hexo link (Powered by Hexo).
    enable: false
    # Version info of Hexo after Hexo link (vX.X.X).
    version: false
  theme:
    # Theme & scheme info link (Theme - NexT.scheme).
    enable: false
    # Version info of NexT after scheme info (vX.X.X).
    version: false

# 知识共享， 或者说版权说明吧
creative_commons:
  license: by-nc-sa
  sidebar: false
  post: true
  language: zh-CN

scheme: Pisces        # 启用 Pisces 的样式,  前面已经启用

# 菜单， 这里只启用了首页， 归档和友链
menu:
  home: / || home
  #about: /about/ || user
  #tags: /tags/ || tags
  #categories: /categories/ || th
  archives: /archives/ || archive
  #schedule: /schedule/ || calendar
  #sitemap: /sitemap.xml || sitemap
  #commonweal: /404/ || heartbeat
  links: /links/ || user-plus       # 友链， 需在languages/zh-CN.yml中， 新增对应翻译

# 侧边栏头像
avatar:
  # Replace the default image and set the url here.
  url: /images/avatar.gif
  # If true, the avatar will be dispalyed in circle.
  rounded: true
  # If true, the avatar will be rotated with the cursor.
  rotated: true

# 社交链接
social:
  GitHub: https://github.com/yourname || github
  E-Mail: mailto:whcycle493@gmail.com || envelope
  RSS: /atom.xml || rss

# 友链
links:
  #Title: http://yoursite.com
  浅墨的游戏编程Blog: https://blog.csdn.net/poem_qianmo
  HelloGitHub: https://hellogithub.com/
  说好不能打脸: https://blog.csdn.net/yinwenjie
  OverAPI: http://overapi.com/
  即时通信网: http://www.52im.net/
  Sanarous(Hexo): https://bestzuo.cn/

# 关闭这个， 封面通过 <!-- more --> 来控制
excerpt_description: false

# 文章参数
post_meta:
  item_text: false    # 关闭文字描述
  created_at: true
  updated_at:
    enable: true     # 关闭更新日期
    another_day: true
  categories: true

# 打赏设置
reward_settings:
  # If true, reward will be displayed in every article by default.
  enable: true
  animation: false
  comment: 如果这篇文章对您很有帮助，不妨

reward:
  wechatpay: /images/wechatpay.png
  alipay: /images/alipay.png

# 相关文章推荐
# 依赖项: hexo-related-popular-posts
related_posts:
  enable: true
  title: 📚  相关文章推荐 # Custom header, leave empty to use the default one
  display_in_home: false
  params:
    maxCount: 5
    #PPMixingRate: 0.0
    #isDate: false
    #isImage: false
    #isExcerpt: false

# 设置代码高亮主题及复制按钮
codeblock:
  # Code Highlight theme
  # Available values: normal | night | night eighties | night blue | night bright | solarized | solarized dark | galactic
  # See: https://github.com/chriskempson/tomorrow-theme
  highlight_theme: galactic
  # Add copy button on codeblock
  copy_button:
    enable: true
    # Show text copy result.
    show_result: true
    # Available values: default | flat | mac
    style:

# 返回顶部处显示百分比
scrollpercent: true

# 连续看图
fancybox: true

# Valine
# For more information: https://valine.js.org, https://github.com/xCss/Valine
valine:
  enable: true
  appid:  # Your leancloud application appid
  appkey: # Your leancloud application appkey
  notify: false # Mail notifier
  verify: false # Verification code
  placeholder:  # Comment box placeholder
  avatar: wavatar # Gravatar style
  guest_info: nick,mail #,link # Custom comment header
  pageSize: 10 # Pagination size
  language: zh-cn # Language, available values: en, zh-cn
  visitor: false # Article reading statistic
  comment_count: true # If false, comment count will only be displayed in post page, not in home page
  recordIP: false # Whether to record the commenter IP
  serverURLs: # When the custom domain name is enabled, fill it in here (it will be detected automatically by default, no need to fill in)
  #post_meta_order: 0

# 启用本地搜索
# 依赖项：hexo-generator-searchdb
local_search:
  enable: true
```

# 自定义修改

- next V7 不使用之前版本的 _custom.styl, 所有的自定义文件都在 **source/_data/** 下
```yml
custom_file_path:
  #head: source/_data/head.swig
  #header: source/_data/header.swig
  sidebar: source/_data/sidebar.swig    # 侧边栏布局自定义， 用于后面侧边栏添加一言
  #postMeta: source/_data/post-meta.swig
  #postBodyEnd: source/_data/post-body-end.swig
  #footer: source/_data/footer.swig
  #bodyEnd: source/_data/body-end.swig
  #variable: source/_data/variables.styl
  #mixin: source/_data/mixins.styl
  style: source/_data/styles.styl       # 自定义样式文件
```

## 自定义优化之前

- 自定义优化之前可以了解一下包括hexo目录结构， next主题目录结构， swig语法等相关知识， 具体内容在**另一个篇文章**中

## valine评论框美化

- 先 [下载](https://site-1258928558.cos.ap-guangzhou.myqcloud.com/js/Valine.min.js) 作者给出的Valine.min.js文件，放到 **hexo/themes/next/source/js/src** 下
- 修改 **layout/_third-party/comments/valine.swig**

```swig
{% if theme.valine.enable and theme.valine.appid and theme.valine.appkey %}
  <script src="//cdn1.lncld.net/static/js/3.0.4/av-min.js"></script>
  <script src="/js/src/Valine.min.js"></script>

  <script type="text/javascript">
    new Valine({
        lang: 'zh-cn',
        admin_email: 'whcycle493@gmai.com',
        el: '#comments' ,
        appId: '{{ theme.valine.appid }}',
        appKey: '{{ theme.valine.appkey }}',
        emoticon_url: 'https://cloud.panjunwen.com/alu',
        emoticon_list: ["狂汗.png","不说话.png","汗.png","坐等.png","献花.png","不高兴.png","中刀.png","害羞.png","皱眉.png","小眼睛.png","暗地观察.png"],
        placeholder: '{{ theme.valine.placeholder }}',
  });
  </script>
{% endif %}
```

## 文章结束标志


- 优化步骤
  1. 新增样式文件， **passage-end-tag.swig**
  2. post.swig中添加对上述样式的引用
  3. 主题配置文件启用该功能项

- 新建 **next\layout\_macro\passage-end-tag.swig**， 设定样式

```html
<!-- next\layout\_macro\passage-end-tag.swig -->
<div style="text-align:center;color: #ccc;font-size:14px;">-------------　　　　本文结束　<i class="fa fa-heart"></i>　感谢您的阅读　　　　-------------</div>
```
- post.swig添加上述引用
```html
{% if theme.passage_end_tag and not is_index %}
    {% include 'passage-end-tag.swig' %}
{% endif %}
```
- 启用该功能项
```yml
# 主题配置文件 theme/next/_config.yml
# 启用文章结束标志
passage_end_tag: false
```

## 标题奔溃欺骗 & 点击特效 & 网站背景

- 优化步骤
  1. 新增对应效果js文件
  2. layout.swig 添加引用
  3. 主题配置文件启用该功能项

- 添加效果js文件

```javascript
//next\source\js\src\clicklove.js,  网页鼠标点击特效（爱心)
!function (e, t, a) {function r() {for (var e = 0; e < s.length; e++) s[e].alpha <= 0 ? (t.body.removeChild(s[e].el), s.splice(e, 1)) : (s[e].y--, s[e].scale += .004, s[e].alpha -= .013, s[e].el.style.cssText = "left:" + s[e].x + "px;top:" + s[e].y + "px;opacity:" + s[e].alpha + ";transform:scale(" + s[e].scale + "," + s[e].scale + ") rotate(45deg);background:" + s[e].color + ";z-index:99999");requestAnimationFrame(r)}function n() {var t = "function" == typeof e.onclick && e.onclick;e.onclick = function (e) {t && t(), o(e)}}function o(e) {var a = t.createElement("div");a.className = "heart", s.push({el: a,x: e.clientX - 5,y: e.clientY - 5,scale: 1,alpha: 1,color: c()}), t.body.appendChild(a)}function i(e) {var a = t.createElement("style");a.type = "text/css";try {a.appendChild(t.createTextNode(e))} catch (t) {a.styleSheet.cssText = e}t.getElementsByTagName("head")[0].appendChild(a)}function c() {return "rgb(" + ~~(255 * Math.random()) + "," + ~~(255 * Math.random()) + "," + ~~(255 * Math.random()) + ")"}var s = [];e.requestAnimationFrame = e.requestAnimationFrame || e.webkitRequestAnimationFrame || e.mozRequestAnimationFrame || e.oRequestAnimationFrame || e.msRequestAnimationFrame || function (e) {setTimeout(e, 1e3 / 60)}, i(".heart{width: 10px;height: 10px;position: fixed;background: #f00;transform: rotate(45deg);-webkit-transform: rotate(45deg);-moz-transform: rotate(45deg);}.heart:after,.heart:before{content: '';width: inherit;height: inherit;background: inherit;border-radius: 50%;-webkit-border-radius: 50%;-moz-border-radius: 50%;position: fixed;}.heart:after{top: -5px;}.heart:before{left: -5px;}"), n(), r()}(window, document);

//next\source\js\src\crash_cheat.js, 崩溃欺骗
var OriginTitle = document.title;
var titleTime;
document.addEventListener('visibilitychange', function () {
    if (document.hidden) {
        $('[rel="shortcut icon"]').attr('href', "/images/sao-16x16.png");
        document.title = '😰 w(ﾟДﾟ)w 页面崩溃啦！ ';
        clearTimeout(titleTime);
    }
    else {
        $('[rel="shortcut icon"]').attr('href', "/images/sao-16x16.png");
        document.title = '😏 ♪(^∇^*) 噫？又好了！';
        titleTime = setTimeout(function () {
            document.title = '🤔 啊来来！原标题是啥来着？ ';
        }, 2000);

        titleTime = setTimeout(function () {
            document.title = '😮哦~！想起来了！ ';
        }, 4000);

        titleTime = setTimeout(function () {
            document.title = OriginTitle;
        }, 6000);
    }
});


// next\source\js\src\particle.js, 背景特效
!function(){function n(n,e,t){return n.getAttribute(e)||t}function e(n){return document.getElementsByTagName(n)}function t(){i=a.width=window.innerWidth||document.documentElement.clientWidth||document.body.clientWidth,c=a.height=window.innerHeight||document.documentElement.clientHeight||document.body.clientHeight}function o(){d.clearRect(0,0,i,c);var n,e,t,a,m,r,y=[x].concat(w);w.forEach(function(o){for(o.x+=o.xa,o.y+=o.ya,o.xa*=o.x>i||o.x<0?-1:1,o.ya*=o.y>c||o.y<0?-1:1,d.fillRect(o.x-.5,o.y-.5,1,1),e=0;e<y.length;e++)n=y[e],o!==n&&null!==n.x&&null!==n.y&&(a=o.x-n.x,m=o.y-n.y,r=a*a+m*m,r<n.max&&(n===x&&r>=n.max/2&&(o.x-=.03*a,o.y-=.03*m),t=(n.max-r)/n.max,d.beginPath(),d.lineWidth=t/2,d.strokeStyle="rgba("+u.c+","+(t+.2)+")",d.moveTo(o.x,o.y),d.lineTo(n.x,n.y),d.stroke()));y.splice(y.indexOf(o),1)}),l(o)}var i,c,a=document.createElement("canvas"),u=function(){var t=e("script"),o=t.length,i=t[o-1];return{l:o,z:n(i,"zIndex",-1),o:n(i,"opacity",.5),c:n(i,"color","0,0,0"),n:n(i,"count",99)}}(),m="c_n"+u.l,d=a.getContext("2d"),l=window.requestAnimationFrame||window.webkitRequestAnimationFrame||window.mozRequestAnimationFrame||window.oRequestAnimationFrame||window.msRequestAnimationFrame||function(n){window.setTimeout(n,1e3/45)},r=Math.random,x={x:null,y:null,max:2e4};a.id=m,a.style.cssText="position:fixed;top:0;left:0;z-index:"+u.z+";opacity:"+u.o,e("body")[0].appendChild(a),t(),window.onresize=t,window.onmousemove=function(n){n=n||window.event,x.x=n.clientX,x.y=n.clientY},window.onmouseout=function(){x.x=null,x.y=null};for(var w=[],y=0;u.n>y;y++){var s=r()*i,f=r()*c,h=2*r()-1,g=2*r()-1;w.push({x:s,y:f,xa:h,ya:g,max:6e3})}setTimeout(function(){o()},100)}();
```

- layout.swig 添加引用

```html
  <!--崩溃欺骗-->
  {% if theme.crashcheat %}
    <script type="text/javascript" src="/js/crash_cheat.js"></script>
  {% endif %}
  <!-- 点击爱心 -->
  {% if theme.clicklove %}
    <script type="text/javascript" src="/js/clicklove.js"></script>
  {% endif %}
  <!-- 背景特效 -->
  {% if theme.particle %}
  <script type="text/javascript" src="/js/particle.js"></script>
  {% endif %}
```


## 添加分享

- 优化步骤
  1. 在这个 [Share.js](https://github.com/overtrue/share.js) 中拷贝dist目录到本地的 **hexo/themes/next/source** 下。
  2. **_layout.swig** 添加引用

```html
<!-- next/layout/_layout.swig -->
<head>
    <link rel="stylesheet" href="/dist/css/share.min.css">
</head>
<body>
  <!-- 分享功能 -->
  <script src="/dist/js/social-share.min.js"></script>
</body>

<!-- next/layout/post.swig -->
<div class="post-spread">
<!-- 引入share.js -->
{% if theme.share_js%}
<center><div data-weibo-title="分享到微博" data-qq-title="分享到QQ" data-douban-title="分享到豆瓣" class="social-share" class="share-component" data-disabled="twitter,facebook" data-description="Share.js - 一键分享到微博，QQ空间，腾讯微博，人人，豆瓣">分享到：</div></center>
{% endif %}
</div>
```

## 友链页面优化


- 优化步骤
  1. 设置友链布局， 新建 **links.swig**
  2. 针对 **/links** 引用友链布局 **links.swig**
  3. 主题配置模板里添加数据项

- 设置友链页面布局， 新建 **links.swig**

```html
<!-- next\layout\links.swig -->
{% block content %}
  {######################}
  {### LINKS BLOCK ###}
  {######################}

<div id="links">
    <style>
        .links-content{
            margin-top:1rem;
        }

        .link-navigation::after {
            content: " ";
            display: block;
            clear: both;
        }

        .card {
            width: 45%;
            font-size: 1rem;
            padding: 10px 20px;
            border-radius: 4px;
            transition-duration: 0.15s;
            margin-bottom: 1rem;
            display:flex;
        }
        .card:nth-child(odd) {
            float: left;
        }
        .card:nth-child(even) {
            float: right;
        }
        .card:hover {
            transform: scale(1.1);
            box-shadow: 0 2px 6px 0 rgba(0, 0, 0, 0.12), 0 0 6px 0 rgba(0, 0, 0, 0.04);
            background-image: radial-gradient(circle at 65% 10%, rgb(230, 196, 141), rgb(71, 254, 185));
        }
        .card a {
            border:none;
        }
        .card .ava {
            width: 3rem!important;
            height: 3rem!important;
            margin:0!important;
            margin-right: 1em!important;
            border-radius:4px;

        }
        .card .card-header {
            font-style: italic;
            overflow: hidden;
            /*width: 236px;*/
        }
        .card .card-header a {
            font-style: normal;
            color: #2bbc8a;
            font-weight: bold;
            text-decoration: none;
        }
        .card .card-header a:hover {
            color: #d480aa;
            text-decoration: none;
        }
        .card .card-header .info {
            font-style:normal;
            color:#a3a3a3;
            font-size:14px;
            min-width: 0;
            text-overflow: ellipsis;
            overflow: hidden;
            white-space: nowrap;
        }

        span.focus-links {
            font-style: normal;
            margin-left: 10px;
            position: unset;
            left: 0;
            padding: 0 7px 0 5px;
            font-size: 11px;
            border-color: #42c02e;
            border-radius: 40px;
            line-height: 24px;
            height: 22px;
            color: #fff !important;
            background-color: #42c02e;
            display: inline-block;
        }

        .friends-btn{
            text-align: center;
            color: #555!important;
            background-color: #fff;
            border-radius: 3px;
            font-size: 15px;
            box-shadow: inset 0 0 10px 0 rgba(0,0,0,.35);
            border: none!important;
            transition-property: unset;
            padding: 0 15px;
            margin: inherit;
        }

        .friends-btn:hover{
            color: rgb(255, 255, 255) !important;
            border-radius: 3px;
            font-size: 15px;
            box-shadow: inset 0px 0px 10px 0px rgba(0, 0, 0, 0.35);
            background-image: linear-gradient(90deg, #a166ab 0%, #ef4e7b 25%, #f37055 50%, #ef4e7b 75%, #a166ab 100%);
            margin: inherit;
            }
        }
    </style>
    <div class="links-content">
        <div class="no-icon note warning" style="background-color: #fdf8ea">
            <div class="link-info">👨‍🎓 大佬 —— 没有不劳而获的工作，更没有坐享其成的收获</div>
        </div>
        <div class="link-navigation">
            {% for link in theme.mylinks_expert %}
                <div class="card">
                    <img class="ava" src="{{ link.avatar }}"/>
                    <div class="card-header">
                    <div><a href="{{ link.site }}" target="_blank"> {{ link.nickname }}</a> <a href="{{ link.site }}"><span class="focus-links">关注</span></a></div>
                    <div class="info">{{ link.info }}</div>
                    </div>
                </div>
            {% endfor %}
        </div>
        <div class="no-icon note primary" style="background-color: #f5f0fa">
            <div class="link-info">🌤️ 工具 —— 你的春日好运正在派件，请保持心情舒畅</div>
        </div>
        <div class="link-navigation">
            {% for link in theme.mylinks_tool %}
                <div class="card">
                    <img class="ava" src="{{ link.avatar }}"/>
                    <div class="card-header">
                    <div><a href="{{ link.site }}" target="_blank"> {{ link.nickname }}</a> <a href="{{ link.site }}"><span class="focus-links">关注</span></a></div>
                    <div class="info">{{ link.info }}</div>
                    </div>
                </div>
            {% endfor %}
        </div>
        <div class="no-icon note info" style="background-color: #eef7fa">
            <div class="link-info">🍀 论坛 —— 我欲穿花寻路，直入白云深处，浩气展虹霓</div>
        </div>
        <div class="link-navigation">
            {% for link in theme.mylinks_forum %}
                <div class="card">
                    <img class="ava" src="{{ link.avatar }}"/>
                    <div class="card-header">
                    <div><a href="{{ link.site }}" target="_blank"> {{ link.nickname }}</a> <a href="{{ link.site }}"><span class="focus-links">关注</span></a></div>
                    <div class="info">{{ link.info }}</div>
                    </div>
                </div>
            {% endfor %}
        </div>
        {{ page.content }}
    </div>
</div>

  {##########################}
  {### END LINKS BLOCK ###}
  {##########################}
{% endblock %}
```
- 添加友链页面引用

```html
{% block title %}
  {%- elif page.type === 'links' and not page.title %}
    {{- __('title.links') + page_title_suffix }}
{% endblock %}
{% block content %}
  {% elif page.type === 'links' %}
    {% include 'links.swig' %}
{% endblock %}
```

- 主题配置文件配置友链项

```yml
# next/_config.yml
# 友情链接
mylinks_expert:   #大佬的链接
  - nickname: 浅墨的游戏编程Blog
    avatar: https://tva1.sinaimg.cn/crop.0.0.237.237.180/66b543f2gw1eh6yry9b7aj206m06mjro.jpg?KID=imgbed,tva&Expires=1576171998&ssig=0LPaIXuqrA
    site: https://blog.csdn.net/poem_qianmo
    info:  浅墨， CSDN博客专家， 微软MVP,  游戏，图形方面

  - nickname: 骆昊的技术专栏
    avatar: https://avatar.csdnimg.cn/C/8/3/3_jackfrued.jpg
    site: https://blog.csdn.net/jackfrued
    info: 传道、授业、解惑，分享知识带来的快乐！

  - nickname: 廖雪峰的官方网站
    avatar: https://tva2.sinaimg.cn/crop.0.1.635.635.50/62d8efadgw1ej30downrsj20hs0hq0ws.jpg?KID=imgbed,tva&Expires=1576170465&ssig=Rasza%2FYFwm
    site: https://www.liaoxuefeng.com/
    info: 技术作家，著有《Spring 2.0核心技术与最佳实践》 头条文章作者

  - nickname: 酷 壳 – CoolShell
    avatar: https://coolshell.cn/coolshell_logo.png
    site: https://coolshell.cn/
    info: 享受编程和技术所带来的快乐 – Coding Your Ambition

  - nickname: 说好不能打脸
    avatar: https://avatar.csdnimg.cn/1/E/F/3_yinwenjie.jpg
    site: https://blog.csdn.net/yinwenjie
    info: CSDN博客专家, 著有《高性能服务系统构建与实战》

  - nickname: Sanarous
    avatar: https://bestzuo.cn/images/touxiang.jpg
    site: https://bestzuo.cn/
    info: Hexo博客美化

mylinks_tool:   #工具链接
  - nickname: OverAPI
    avatar: http://overapi.com/static/images/overapi-logo.png
    site: http://overapi.com/
    info: Collecting All Cheat Sheets

  - nickname: Temp Mail - 临时性 - 匿名电子邮件
    avatar: https://temp-mail.org/images/favicon.ico
    site: https://temp-mail.org/zh/
    info: Temp Mail提供临时、安全、匿名、免费的一次性电子邮件地址。

  - nickname: tldr | bash用法帮助
    avatar:
    site: https://tldr.ostera.io/
    info: 免费分享各种学习视频，资源收集于网络！

  - nickname: tool.lu | 程序员工具箱
    avatar: https://qn11.tool.lu/201710/15/103320SbM84Ql4tETjg49a_28x28.png
    site: https://tool.lu/nav/
    info: 在线工具,开发人员工具,代码格式化、压缩、加密、解密,下载链接转换,ico图标制作

mylinks_forum:    #论坛链接
  - nickname: 即时通信网 | IM 开发者社区
    avatar: https://www.uo33.cn/favicon.ico
    site: http://www.52im.net/
    info: 既然爱可以做 那还谈它干嘛

  - nickname: HELLOGITHUB
    avatar: https://hellogithub.com/favicon.ico
    site: https://hellogithub.com/
    info: 分享 GitHub 上有趣、入门级的开源项目

  - nickname: CTOLib码库
    avatar: https://www.ctolib.com/static/favicon.ico
    site: https://www.ctolib.com/
    info: 分类收集GitHub上的开源项目

  - nickname: 一起开源网
    avatar: http://static.17ky.net/themes/default/images/fav.ico
    site: http://www.17ky.net/
    info: 做最好的开源项目分享平台

  - nickname: 今日热榜
    avatar: https://file.ipadown.com/tophub/assets/images/favicon/favicon-32x32.png
    site: https://tophub.today/
    info: 今日热榜提供各站热榜聚合，追踪全网热点、简单高效阅读。
```

## 归档页面美化

- 将归档页面布局 **post-collapse.swig** 中class属性改名(前面加个 **my-**， 避免CSS影响到其他页面

```diff
- <article itemscope itemtype="http://schema.org/Article">
+ <article class="my-post post-type-{{ post.type | default('normal') }}" itemscope itemtype="http://schema.org/Article">

- <div class="post-meta">
-   <time itemprop="dateCreated"
+ div class="my-post-meta">
+   <time class="my-post-time" itemprop="dateCreated"

- <{%- if theme.seo %}h3{% else %}h2{%- endif %} class="post-title">
+ <{%- if theme.seo %}h3{% else %}h2{%- endif %} class="my-post-title">

- {{ next_url(post.link, postText + postTitleIcon, {class: 'post-title-link post-title-link-external', itemprop: 'url'}) }}
+ {{ next_url(post.link, postText + postTitleIcon, {class: 'my-post-title-link post-title-link-external', itemprop: 'url'}) }}

- <a class="post-title-link" href="{{ url_for(post.path) }}" itemprop="url">
+ <a class="my-post-title-link" href="{{ url_for(post.path) }}" itemprop="url">
```

- 样式美化需要在自定义样式文件里
  1. 主题配置文件取消注释
  2. 新建自定义样式文件, 
    - 自定义样式文件位置为站点目录下 **source/_data**
    - ~~非主题下source~~
    - [custom_file_path用法](https://github.com/theme-next/hexo-theme-next/issues/1217)

```diff
-  #style: source/_data/styles.styl
+  style: source/_data/styles.styl
```

```css
/* next/source/_data/styles.styl */
/*归档页样式优化*/
.my-post-time{
  position: absolute;
    color: #fff;
    background-color: #49b1f5;
    border-radius: 5px;
    padding-left: 5px;
    padding-right: 5px;
    margin-left: 15px;
}

.mypost{
    position: relative;
    margin-bottom: 1rem;
    -webkit-transition: all .2s ease-in-out;
    -moz-transition: all .2s ease-in-out;
    -o-transition: all .2s ease-in-out;
    -ms-transition: all .2s ease-in-out;
    transition: all .2s ease-in-out;
}

a.my-post-title-link:before{
    top: 10px;
    width: 18px;
    height: 18px;
    content: "📚";
    font: normal normal normal 14px/1 FontAwesome;
    font-size: 18px;
    line-height: 18px;
}

a.my-post-title-link{
  text-decoration: none;
  font-size: 18px;
  font-weight: 400;
}

.my-post-title{
      display: block;
    margin-left: 5rem;
    color: #4c4948;
    text-decoration: none;
    font-size: .8rem;
    cursor: pointer;
}

.my-post-header{
    position: top;
    margin-bottom: 1rem;
    -webkit-transition: all .2s ease-in-out;
    -moz-transition: all .2s ease-in-out;
    -o-transition: all .2s ease-in-out;
    -ms-transition: all .2s ease-in-out;
    transition: all .2s ease-in-out;

}
.my-post-title-link{
    font-size: 16px;
    font-weight: 500;

}

.my-post-meta{
  position: absolute;
    color: #99a9bf;
    width: 80px;
    color: #114142;
}
```

## 彩色标签云

- 标签页面添加脚本， js随机生成背景颜色

```javascript
 <script type="text/javascript">
   var alltags=document.getElementsByClassName("tag-cloud-tags").item(0);
   var tags=alltags.getElementsByTagName("a");

   for (var i = tags.length - 1; i >= 0; i--) {
     var r=Math.floor(Math.random()*75+130);
     var g=Math.floor(Math.random()*75+100);
     var b=Math.floor(Math.random()*75+80);
     tags[i].style.background = "rgb("+r+","+g+","+b+")";
   }
</script>
```

- 主题配置文件里面设置标签文字颜色范围
```yml
start: "#fff" # Start color (hex, rgba, hsla or color keywords)
end: "#fff" # End color (hex, rgba, hsla or color keywords)
```

- 自定义样式设置标签云样式， **source/_data/styles.styl**

```css
/*标签云设置*/
.tag-cloud-tags{
  text-align: left;
  counter-reset: tags;
}

div#posts.posts-expand .tag-cloud a{
  border-radius: 6px;
  padding-left: 10px;
  padding-right: 10px;
  margin-top: 18px;
}

.tag-cloud a{
  -webkit-box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
  -moz-box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
  box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
  transition: 0.2s ease-out;
  background: #f5f5f5;
  border-radius: 4px;
  padding-right: 5px;
  padding-left: 5px;
  margin-right: 5px;
  margin-left: 0px;
  margin-top: 8px;
  margin-bottom: 0px;

  &:hover {
  text-decoration: none;
  background: rgba(100,154,182,0.902);
  color: #fff !important;
  -webkit-box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
  -moz-box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
  box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
  }
  &:before {
      content: "📜";
  }
}
```

## 修复代码高亮

- 修改高亮格式， **next\source\css\\_common\scaffolding\highlight\highlight.styl**

```css
/* 在.highlight中添加 */
tbody tr {
  background: $highlight-background;
}

/* diff 高亮， 背景色改为字体颜色 */
.deletion {
  color: #ff511a;
}

.addition {
  color: #4ca340;
}
```

## 添加首页轮播图

- 添加步骤
  1. **next/layout/_macro/carousel.swig**, 添加轮播图布局
  2. **next/layout/index.swig**, 添加对轮播图的引用
  3.  **next/_config.yml**, 启用轮播图


- 添加轮播图布局
```html
{% if theme.carousel.enable %}
<script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<style>
.glyphicon-chevron-left:before{
	content: "《"
}
.glyphicon-chevron-right:before{
	content: "》"
}

.carousel{
	width: 65%;
	height: 100%;
	position: relative;
}

.carousel-inner {
  position: relative;
  overflow: hidden;
  width: 100%;
}
.carousel-inner > .item {
  display: none;
  position: relative;
  -webkit-transition: 0.6s ease-in-out left;
  -o-transition: 0.6s ease-in-out left;
  transition: 0.6s ease-in-out left;
}
.carousel-inner > .item > img,
.carousel-inner > .item > a > img {
  line-height: 1;
}
@media all and (transform-3d), (-webkit-transform-3d) {
  .carousel-inner > .item {
    -webkit-transition: -webkit-transform 0.6s ease-in-out;
    -moz-transition: -moz-transform 0.6s ease-in-out;
    -o-transition: -o-transform 0.6s ease-in-out;
    transition: transform 0.6s ease-in-out;
    -webkit-backface-visibility: hidden;
    -moz-backface-visibility: hidden;
    backface-visibility: hidden;
    -webkit-perspective: 1000px;
    -moz-perspective: 1000px;
    perspective: 1000px;
  }
  .carousel-inner > .item.next,
  .carousel-inner > .item.active.right {
    -webkit-transform: translate3d(100%, 0, 0);
    transform: translate3d(100%, 0, 0);
    left: 0;
  }
  .carousel-inner > .item.prev,
  .carousel-inner > .item.active.left {
    -webkit-transform: translate3d(-100%, 0, 0);
    transform: translate3d(-100%, 0, 0);
    left: 0;
  }
  .carousel-inner > .item.next.left,
  .carousel-inner > .item.prev.right,
  .carousel-inner > .item.active {
    -webkit-transform: translate3d(0, 0, 0);
    transform: translate3d(0, 0, 0);
    left: 0;
  }
}
.carousel-inner > .active,
.carousel-inner > .next,
.carousel-inner > .prev {
  display: block;
}
.carousel-inner > .active {
  left: 0;
}
.carousel-inner > .next,
.carousel-inner > .prev {
  position: absolute;
  top: 0;
  width: 100%;
}
.carousel-inner > .next {
  left: 100%;
}
.carousel-inner > .prev {
  left: -100%;
}
.carousel-inner > .next.left,
.carousel-inner > .prev.right {
  left: 0;
}
.carousel-inner > .active.left {
  left: -100%;
}
.carousel-inner > .active.right {
  left: 100%;
}
.carousel-control {
  position: absolute;
  top: 0;
  left: 0;
  bottom: 0;
  width: 15%;
  opacity: 0.5;
  filter: alpha(opacity=50);
  font-size: 20px;
  color: #fff;
  text-align: center;
  text-shadow: 0 1px 2px rgba(0, 0, 0, 0.6);
  background-color: rgba(0, 0, 0, 0);
}
.carousel-control.left {
  background-image: -webkit-linear-gradient(left, rgba(0, 0, 0, 0.5) 0%, rgba(0, 0, 0, 0.0001) 100%);
  background-image: -o-linear-gradient(left, rgba(0, 0, 0, 0.5) 0%, rgba(0, 0, 0, 0.0001) 100%);
  background-image: linear-gradient(to right, rgba(0, 0, 0, 0.5) 0%, rgba(0, 0, 0, 0.0001) 100%);
  background-repeat: repeat-x;
  filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=#80000000, endColorstr=#00000000, GradientType=1);
}
.carousel-control.right {
  left: auto;
  right: 0;
  background-image: -webkit-linear-gradient(left, rgba(0, 0, 0, 0.0001) 0%, rgba(0, 0, 0, 0.5) 100%);
  background-image: -o-linear-gradient(left, rgba(0, 0, 0, 0.0001) 0%, rgba(0, 0, 0, 0.5) 100%);
  background-image: linear-gradient(to right, rgba(0, 0, 0, 0.0001) 0%, rgba(0, 0, 0, 0.5) 100%);
  background-repeat: repeat-x;
  filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=#00000000, endColorstr=#80000000, GradientType=1);
}
.carousel-control:hover,
.carousel-control:focus {
  outline: 0;
  color: #fff;
  text-decoration: none;
  opacity: 0.9;
  filter: alpha(opacity=90);
}
.carousel-control .icon-prev,
.carousel-control .icon-next,
.carousel-control .glyphicon-chevron-left,
.carousel-control .glyphicon-chevron-right {
  position: absolute;
  top: 50%;
  margin-top: -10px;
  z-index: 5;
  display: inline-block;
}
.carousel-control .icon-prev,
.carousel-control .glyphicon-chevron-left {
  left: 50%;
  margin-left: -10px;
}
.carousel-control .icon-next,
.carousel-control .glyphicon-chevron-right {
  right: 50%;
  margin-right: -10px;
}
.carousel-control .icon-prev,
.carousel-control .icon-next {
  width: 20px;
  height: 20px;
  line-height: 1;
  font-family: serif;
}
.carousel-control .icon-prev:before {
  content: 2039;
}
.carousel-control .icon-next:before {
  content: 203a;
}
.carousel-indicators {
  position: absolute;
  bottom: 10px;
  left: 50%;
  z-index: 15;
  width: 60%;
  margin-left: -30%;
  padding-left: 0;
  list-style: none;
  text-align: center;
}
.carousel-indicators li {
  display: inline-block;
  width: 10px;
  height: 10px;
  margin: 1px;
  text-indent: -999px;
  border: 1px solid #fff;
  border-radius: 10px;
  cursor: pointer;
  background-color: #000 9;
  background-color: rgba(0, 0, 0, 0);
}
.carousel-indicators .active {
  margin: 0;
  width: 12px;
  height: 12px;
  background-color: #fff;
}
.carousel-caption {
  position: absolute;
  left: 15%;
  right: 15%;
  bottom: 20px;
  z-index: 10;
  padding-top: 20px;
  padding-bottom: 20px;
  color: #fff;
  text-align: center;
  text-shadow: 0 1px 2px rgba(0, 0, 0, 0.6);
}
.carousel-caption .btn {
  text-shadow: none;
}
@media screen and (min-width: 768px) {
  .carousel-control .glyphicon-chevron-left,
  .carousel-control .glyphicon-chevron-right,
  .carousel-control .icon-prev,
  .carousel-control .icon-next {
    width: 30px;
    height: 30px;
    margin-top: -10px;
    font-size: 30px;
  }
  .carousel-control .glyphicon-chevron-left,
  .carousel-control .icon-prev {
    margin-left: -10px;
  }
  .carousel-control .glyphicon-chevron-right,
  .carousel-control .icon-next {
    margin-right: -10px;
  }
  .carousel-caption {
    left: 20%;
    right: 20%;
    padding-bottom: 30px;
  }
  .carousel-indicators {
    bottom: 20px;
  }
}
</style>
<div width="100%" height="320px" style="border: 0px; overflow: hidden; border-radius: 10px;" scrolling="no">
			
	<div id="myCarousel" class="carousel slide" data-ride="carousel" data-interval="3500" style="float:left">
		<!-- 轮播（Carousel）指标 -->
		<ol class="carousel-indicators">
		{% set index = 0 %}
		{% for item in theme.carousel.item %}

			<li data-target="#myCarousel" data-slide-to="{{index}}"></li>
			{% set index = index+1 %}

		{% endfor %}
		</ol>
		<!-- 轮播（Carousel）项目 -->
		<div class="carousel-inner" style="height: 280px; border-radius: 10px; width: 100%;">

		{% set act = 0 %}
    {% set month = date(null, 'MM') %}
		 {% for item in theme.carousel.item %}
		
	    	{% if act===0 %}
				<a class="item active" href="{{ url_for(item.link) }}" target="_blank" style="height: 100%;">
					<img src="./images/{{month}}月.png"   style="width: 100%; height: 100%" >
				</a>
				{% set act = 1 %}
				{% elseif act===1 %}
					<a class="item" href="{{ url_for(item.link) }}" target="_blank" style="height: 100%;">
						<img src="{{item.img}}"  style="width: 100%; height: 100%;" >
					</a>
			{% endif %}

		{% endfor %}

	 
		</div>
		<!-- 轮播（Carousel）导航 -->
		<a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
		    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
		    
		</a>
		<a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
		    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
		   
		</a>
	</div> 
  <div  class="rights" style="width: 30%; height: 290px; margin-right: 0px;margin-left: 20px;float: left;">
    <!-- 天气插件 -->
    <iframe scrolling="no" height="50px" frameborder="0" allowtransparency="true" src="http://i.tianqi.com/index.php?c=code&id=12&color=%23&bdc=%23&icon=1&py=taiyuan&num=2"></iframe>
    <!-- 速查表 -->
    <div class="my-carousel">
      <a href="/categories/速查表/" target="_blank">
        <img class="right-siders nofancybox" src="/images/cheatsheet.png" width="100%"/>
      </a>
    </div>
    <!-- 学习笔记 -->
    <div class="my-carousel">
      <a href="/categories/学习笔记/" target="_blank">
        <img class="right-siders nofancybox" src="/images/learn.png"/>
      </a>
    </div>
    <!-- 资源分享 -->
    <div class="my-carousel">
      <a href="/categories/资源分享/" target="_blank">
        <img class="right-siders nofancybox" src="/images/share.png"/>
      </a>
    </div>
    <!-- 随笔 -->
    <div class="my-carousel">
        <a href="/categories/随笔/" target="_blank">
          <img class="right-siders nofancybox" src="/images/essay.png"/>
        </a>
    </div>
  </div>
  <div class="tag-cloud">
  <div class="tag-cloud-tags" id="tags">
    {{ tagcloud({min_font: 14, max_font: 14, amount: 20, color: true, start_color: '#fff', end_color: '#fff'}) }}
  </div>
  </div>
</div>


<br>
<script type="text/javascript">
   var alltags=document.getElementById('tags');
   var tags=alltags.getElementsByTagName('a');
   for (var i = tags.length - 1; i >= 0; i--) {
     var r=Math.floor(Math.random()*75+130);
     var g=Math.floor(Math.random()*75+100);
     var b=Math.floor(Math.random()*75+80);
     tags[i].style.background = "rgb("+r+","+g+","+b+")";
   }
</script>

{% endif %}
```

- 添加轮播图引用

```html
<!-- blog content 里添加 -->
{% include '_macro/carousel.swig' %}
```
- 启用轮播图， 添加轮播图

```yml
carousel:
  enable: true
  item: [
    {
      'link': '/',
    },
    {
      'link': 'https://mailchi.mp/e92415d27722/leaf',
      'img': 'https://s2.ax1x.com/2019/10/24/KNHdCq.jpg'
    }
  ]
```

## 仿知乎卡片链接

- 步骤
  1. 卡片链接脚本
  2. **_layout.swig** 引用脚本
  3. 需要使用卡片链接样式时， class为 **LinkCard**

- 卡片链接脚本
```javascript
//next/source/js/src/linkcard.js
window.onload=function(){
  var LinkCards=document.getElementsByClassName('LinkCard');
  if(LinkCards.length != 0){
    var LinkCard=LinkCards[0];
    var link=LinkCard.href;
    var title=LinkCard.innerText;
    LinkCard.innerHTML="<style type=text/css>.LinkCard,.LinkCard:hover{text-decoration:none;border:none!important;color:inherit!important}.LinkCard{position:relative;display:block;margin:5px auto;width:330px;box-sizing:border-box;border-radius:12px;max-width:100%;overflow:hidden;color:inherit;text-decoration:none}.ztext{word-break:break-word;line-height:1.6}.LinkCard-backdrop{position:absolute;top:0;left:0;right:0;bottom:0;background-repeat:no-repeat;-webkit-filter:blur(20px);filter:blur(20px);background-size:cover;background-position:center}.LinkCard,.LinkCard:hover{text-decoration:none;border:none!important;color:inherit!important}.LinkCard-content{position:relative;display:flex;align-items:center;justify-content:space-between;padding:12px;border-radius:inherit;background-color:rgba(246,246,246,0.88)}.LinkCard-text{overflow:hidden;width:260px;}.LinkCard-title{white-space: nowrap;display:-webkit-box;-webkit-line-clamp:2;overflow:hidden;text-overflow:ellipsis;max-height:calc(16px * 1.25 * 2);font-size:16px;font-weight:500;line-height:1.25;color:#1a1a1a}@media(max-width: 767px){.LinkCard-title{font-size:13px;}}.LinkCard-meta{display:flex;margin-top:4px;font-size:14px;line-height:20px;color:#999;white-space:nowrap}.LinkCard-imageCell{margin-left:28px;border-radius:30px;width:70px;}.LinkCard-image{display:block;width:60px;height:auto;border-radius:inherit}</style><span class=LinkCard-backdrop style=background-image:url(https://zhstatic.zhihu.com/assets/zhihu/editor/zhihu-card-default.svg)></span><span class=LinkCard-content><span class=LinkCard-text><span class=LinkCard-title>"+title+"</span><span class=LinkCard-meta><span style=display:inline-flex;align-items:center><svg class="+"'Zi Zi--InsertLink'"+" fill=currentColor viewBox="+"'0 0 24 24'"+" width=17 height=17><path d="+"'M6.77 17.23c-.905-.904-.94-2.333-.08-3.193l3.059-3.06-1.192-1.19-3.059 3.058c-1.489 1.489-1.427 3.954.138 5.519s4.03 1.627 5.519.138l3.059-3.059-1.192-1.192-3.059 3.06c-.86.86-2.289.824-3.193-.08zm3.016-8.673l1.192 1.192 3.059-3.06c.86-.86 2.289-.824 3.193.08.905.905.94 2.334.08 3.194l-3.059 3.06 1.192 1.19 3.059-3.058c1.489-1.489 1.427-3.954-.138-5.519s-4.03-1.627-5.519-.138L9.786 8.557zm-1.023 6.68c.33.33.863.343 1.177.029l5.34-5.34c.314-.314.3-.846-.03-1.176-.33-.33-.862-.344-1.176-.03l-5.34 5.34c-.314.314-.3.846.03 1.177z'"+" fill-rule=evenodd></path></svg></span>"+link+"</span></span><span class=LinkCard-imageCell><img class=LinkCard-image alt=图标 src=/images/linkcard.png></span></span>";

    for (var i = LinkCards.length - 1; i >= 1; i--) {
      LinkCard=LinkCards[i];
      title=LinkCard.innerText;
      link=LinkCard.href;
      LinkCard.innerHTML="<span class=LinkCard-backdrop style=background-image:url(https://zhstatic.zhihu.com/assets/zhihu/editor/zhihu-card-default.svg)></span><span class=LinkCard-content><span class=LinkCard-text><span class=LinkCard-title>"+title+"</span><span class=LinkCard-meta><span style=display:inline-flex;align-items:center><svg class="+"'Zi Zi--InsertLink'"+" fill=currentColor viewBox="+"'0 0 24 24'"+" width=17 height=17><path d="+"'M6.77 17.23c-.905-.904-.94-2.333-.08-3.193l3.059-3.06-1.192-1.19-3.059 3.058c-1.489 1.489-1.427 3.954.138 5.519s4.03 1.627 5.519.138l3.059-3.059-1.192-1.192-3.059 3.06c-.86.86-2.289.824-3.193-.08zm3.016-8.673l1.192 1.192 3.059-3.06c.86-.86 2.289-.824 3.193.08.905.905.94 2.334.08 3.194l-3.059 3.06 1.192 1.19 3.059-3.058c1.489-1.489 1.427-3.954-.138-5.519s-4.03-1.627-5.519-.138L9.786 8.557zm-1.023 6.68c.33.33.863.343 1.177.029l5.34-5.34c.314-.314.3-.846-.03-1.176-.33-.33-.862-.344-1.176-.03l-5.34 5.34c-.314.314-.3.846.03 1.177z'"+" fill-rule=evenodd></path></svg></span>"+link+"</span></span><span class=LinkCard-imageCell><img class=LinkCard-image alt=图标 src=/images/linkcard.png></span></span>";
    }
  }
}
```
- 布局中引用脚本
```html
<script type="text/javascript" src="/js/src/linkcard.js"></script>
```
- 使用方法
```html
<a href="/links/" class="LinkCard">友情链接</a>
```

## 启用加载进度

- 依赖项：[pace](https://github.com/theme-next/theme-next-pace)
- 主题： [选择进度主题](https://github.hubspot.com/pace/docs/welcome/)
- 下载依赖

```bash
cd themes/next
git clone https://github.com/theme-next/theme-next-pace source/lib/pace
```
- 启用加载进度

```yml
# Progress bar in the top during page loading.
# 依赖项参考链接: https://github.com/theme-next/theme-next-pace
# For more information: https://github.com/HubSpot/pace
pace:
  enable: true
  # Themes list:
  # big-counter | bounce | barber-shop | center-atom | center-circle | center-radar | center-simple
  # corner-indicator | fill-left | flat-top | flash | loading-bar | mac-osx | material | minimal
  theme: bounce
```

## 版权说明

- 优化步骤
  1. 修改布局，优化样式
  2. 启用版权

- 修改布局， **layout/_partials/post/post-copyright.swig**

```html
{%- set ccIcon = '<i class="fa fa-fw fa-creative-commons"></i>' %}
{%- set ccText = theme.creative_commons.license | upper %}
<!-- 转载还是原创链接 -->
{%- set ccLink =  page.link or page.permalink %}
<script src="//cdn.bootcss.com/clipboard.js/1.5.10/clipboard.min.js"></script>
<div>
<ul class="my-post-copyright">
    <li class="post-copyright-title">
    <strong>{{ __('本文标题') + __('symbol.colon') }} </strong>
    {{- page.title or title }}
    </li>
  <li class="post-copyright-author">
    <strong>{{ __('post.copyright.author') + __('symbol.colon') }} </strong>
    {{- page.author or author }}
  </li>
  <li class="post-copyright-date">
    <strong>{{ __('发布时间') + __('symbol.colon') }} </strong>
     {{-page.date.format("YYYY年MM月DD日 - HH:mm:ss")}} 
  </li>
  <li class="post-copyright-update">
    <strong>{{ __('最后更新') + __('symbol.colon') }} </strong>
    {{- page.updated.format("YYYY年MM月DD日 - HH:mm:ss") or page.date.format("YYYY年MM月DD日 - HH:mm:ss") }}
  </li>
  <li class="post-copyright-link">
    <strong>{{ __('post.copyright.link') + __('symbol.colon') }}</strong>
    {{ next_url(ccLink, ccLink, {title: page.title}) }}
    <span class="copy-path"  title="点击复制文章链接"><i class="fa fa-clipboard" data-clipboard-text="{{ ccLink }}"  aria-label="复制成功！"></i></span>
  </li>
  <li class="post-copyright-license">
    <strong>{{ __('post.copyright.license_title') + __('symbol.colon') }} </strong>
    {{- __('post.copyright.license_content', next_url(ccURL, ccIcon + ccText)) }}
  </li>
</ul>
</div>
<style>
.my-post-copyright {
    width: 85%;
    max-width: 45em;
    margin: 2.8em auto 0;
    padding: .5em 1em;
    border: 1px solid #d3d3d3;
    font-size: .93rem;
    line-height: 1.6em;
    word-break: break-all;
    background: rgba(255,255,255,.4);
    box-shadow: 0 0 10px rgba(0,0,0,.12);
    color: #555;
}
</style>
<script> 
    var clipboard = new Clipboard('.fa-clipboard');
    clipboard.on('success', function(){
      $(".fa-clipboard").click(function(){
        swal({   
          title: "",   
          text: '复制成功',   
          html: false,
          timer: 500,   
          showConfirmButton: false
        });
      });
    });  
</script>
```
- 启用版权说明， 上述主题配置里已配置好
- 涉及转载的版权说明， 需要在 **front-matter** 增添几个字段

```yml
author: # 只有转载才添加该字段， 在此加入原作者名字
link:   # 同上， 在此加入原文链接
```

## 侧边栏添加一言

- 操作步骤
  1. 主题配置文件取消注释，添加侧边栏自定义文件, **source/_data/sidebar.swig**
  2. 添加自定义样式

- 一言API: https://hitokoto.cn/api
```html
<!-- source/_data/sidebar.swig -->
<!-- none-select-br -->

<p></p>

<!-- hitokoto -->

<div class="hitokoto-title">
	<i class="fa fa-paragraph"></i>
	<b>一言</b>
</div>

<div id="hitokoto">:D 获取中...</div>
<i id="hitofrom">:D 获取中...</i>

<script src="https://cdn.jsdelivr.net/npm/bluebird@3/js/browser/bluebird.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/whatwg-fetch@2.0.3/fetch.min.js"></script>
<script>
  fetch('https://v1.hitokoto.cn')
    .then(function (res){
      return res.json();
    })
    .then(function (data) {
      var hitokoto = document.getElementById('hitokoto');
      hitokoto.innerText = '\xa0\xa0\xa0\xa0\xa0\xa0\xa0' + data.hitokoto;
      var hitofrom = document.getElementById('hitofrom');
      hitofrom.innerText = "——" + data.from + '\xa0'; 
    })
    .catch(function (err) {
      console.error(err);
    })
</script>
```

## 自定义样式

- 如下代码中展示自定义样式， 包括上述存放于自定义样式文件的CSS代码

```css
/*归档页样式优化*/
.my-post-time{
  position: absolute;
    color: #fff;
    background-color: #49b1f5;
    border-radius: 5px;
    padding-left: 5px;
    padding-right: 5px;
    margin-left: 15px;
}

.mypost{
    position: relative;
    margin-bottom: 1rem;
    -webkit-transition: all .2s ease-in-out;
    -moz-transition: all .2s ease-in-out;
    -o-transition: all .2s ease-in-out;
    -ms-transition: all .2s ease-in-out;
    transition: all .2s ease-in-out;
}

a.my-post-title-link:before{
    top: 10px;
    width: 18px;
    height: 18px;
    content: "📚";
    font: normal normal normal 14px/1 FontAwesome;
    font-size: 18px;
    line-height: 18px;
}

a.my-post-title-link{
  text-decoration: none;
  font-size: 18px;
  font-weight: 400;
}

.my-post-title{
      display: block;
    margin-left: 5rem;
    color: #4c4948;
    text-decoration: none;
    font-size: .8rem;
    cursor: pointer;
}

.my-post-header{
    position: top;
    margin-bottom: 1rem;
    -webkit-transition: all .2s ease-in-out;
    -moz-transition: all .2s ease-in-out;
    -o-transition: all .2s ease-in-out;
    -ms-transition: all .2s ease-in-out;
    transition: all .2s ease-in-out;

}
.my-post-title-link{
    font-size: 16px;
    font-weight: 500;

}

.my-post-meta{
  position: absolute;
    color: #99a9bf;
    width: 80px;
    color: #114142;
}

*修改推荐文章标题前面图标*/
.popular-posts-title:before{
    top: 10px;
    width: 18px;
    height: 18px;

    content: "🏷️";
    font-size: 14px;
    line-height: 18px;
    margin-right: 8px;
}

/*标签云设置*/
.tag-cloud-tags{
  text-align: left;
  counter-reset: tags;
}

div#posts.posts-expand .tag-cloud a{
  border-radius: 6px;
  padding-left: 10px;
  padding-right: 10px;
  margin-top: 18px;
}

.tag-cloud a{
  -webkit-box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
  -moz-box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
  box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
  transition: 0.2s ease-out;
  background: #f5f5f5;
  border-radius: 4px;
  padding-right: 5px;
  padding-left: 5px;
  margin-right: 5px;
  margin-left: 0px;
  margin-top: 8px;
  margin-bottom: 0px;

  &:hover {
  text-decoration: none;
  background: rgba(100,154,182,0.902);
  color: #fff !important;
  -webkit-box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
  -moz-box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
  box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
  }
  &:before {
      content: "📜";
  }
}

/* 以上均为上述优化步骤中加入的CSS样式， 加下来为自定义样式*/

/*更好的侧边滚动条*/
::-webkit-scrollbar {
  width: 10px;
  height: 10px;
}
::-webkit-scrollbar-button {
  width: 0;
  height: 0;
}
::-webkit-scrollbar-button:start:increment,::-webkit-scrollbar-button:end:decrement {
  display: none;
}
::-webkit-scrollbar-corner {
  display: block;
}
::-webkit-scrollbar-thumb {
  border-radius: 8px;
  background-color: rgba(0,0,0,.2);
}
::-webkit-scrollbar-thumb:hover {
  border-radius: 8px;
  background-color: rgba(0,0,0,.5);
}
::-webkit-scrollbar-track,::-webkit-scrollbar-thumb {
  border-right: 1px solid transparent;
  border-left: 1px solid transparent;
}
::-webkit-scrollbar-track:hover {
  background-color: rgba(0,0,0,.15);
}
::-webkit-scrollbar-button:start {
  width: 10px;
  height: 10px;
  /*background: url(../images/scrollbar_arrow.png) no-repeat 0 0;*/  /*可以添加滚动条样式*/
}

/* 分享按钮样式 */
.post-spread {
    margin-bottom: 20px;
    margin-top: 20px;
    text-align: center;
}

/* 站点头部信息 */
.site-meta .site-title {
    font-size: 28px;
    font-family: 'Comic Sans MS', sans-serif;
    color: #fff;
}
/*设置文章字体排版合理*/
.post-body{
  text-align: justify;
}

/* 设置内容背景与背景特效颜色一致 */
.content-wrap {
  padding-top: 5px;
  background: #f5f7f9;
}

.posts-expand {
  padding-top: 0px;
}

sidebar-inner {
 background: #f5f7f9;
}


/*修改post文章样式*/
.posts-expand .post {
  margin-top: 20px;
}

/*文章元数据样式*/
.posts-expand .post-meta{
  text-align: center;
}

/*文章标题样式*/
.posts-expand .post-title{
  text-align: center;
}

/*文章页文章主体*/
div#posts.posts-expand{
  padding-left: 25px;
  padding-right: 25px;
  margin-bottom: 10px;
}

/* 文章页面 */
h2.post-title{
  font-weight: 600;
  border: 0px solid #fff;
  padding-left: 0px;
}
h1.post-title{
  font-weight: 600;
  border: 0px solid #fff;
  padding-left: 0px;
}

/*文章标题字体*/
.posts-expand .post-title {
    font-size: 26px;
    font-weight: 700;
}

/*文章标题动态效果*/
.posts-expand .post-title-link::before {
    background-image: linear-gradient(90deg, #a166ab 0%, #ef4e7b 25%, #f37055 50%, #ef4e7b 75%, #a166ab 100%);
}

/*修改h1前面图标*/
.posts-expand .post-body h1:before{
    top: 10px;
    width: 18px;
    height: 18px;

    content: "🌈";
    font-size: 18px;
    line-height: 18px;
    margin-right: 16px;

}

/*修改h2前面图标*/
.posts-expand .post-body h2:before{
    top: 10px;
    width: 18px;
    height: 18px;
    content: "🌞";
    font: normal normal normal 14px/1 FontAwesome;
    font-size: 18px;
    line-height: 18px;
    margin-right: 16px
}

/*修改h3前面图标*/
.posts-expand .post-body h3:before{
  display: none;
    top: 10px;
    width: 18px;
    height: 18px;
    content: "🔍";
    font: normal normal normal 14px/1 FontAwesome;
    font-size: 18px;
    line-height: 18px;
    margin-right: 16px;
}

/* 4~6级标题前置设置 */
.posts-expand .post-body h4:before,
.posts-expand .post-body h5:before
.posts-expand .post-body h6:before{
    top: 10px;
    width: 18px;
    height: 18px;
    font-size: 18px;
    line-height: 18px;
    margin-right: 18px;
}

div.post-block.tag .collection-title h2{
    border-width: 1px;
    border-style: solid;
    border-color: #3f3f3f;
    border-radius: 20px;
    font-size: 26px;
    background-color: #b4e8fa;
    padding: 2px 15px;
    letter-spacing:1.5px;
    box-sizing: border-box;
    color:#3f3f3f;
    display: inline-block;
    margin:10px 0% 10px;
    text-align: center;

}

/* 有序和无序图标设置 */
ol{
    margin-top: .4rem;
    padding: 0 0 0 .8rem;
    list-style: none;
    counter-reset: ol-li;

}
ul{
    margin-top: .4rem;
    padding: 0 0 0 .8rem;
    list-style: none;
    counter-reset: ul-li;
    color: #000;
}

.posts-expand .post-body ul li{
    margin-bottom: 2px;
    list-style: none;
    color: #000;

}

.posts-expand .post-body ul li p{
    margin-bottom: 10px;
    border-radius: 6px;
}

/*设置无序标签内文本样式*/
.posts-expand .post-body ol li{
  text-align: left
    color: #000;
}

.posts-expand .post-body ul li:before{
    display: block;
    float: left;
    width: 12px;
    height: 12px;
    line-height: 28px;
    margin: .60rem 12px 0 0;
    color: #fff;
    font-size: 15px;
    font-weight: 700;
    font-style: normal;
    background-color: #49b1f5;
    border-radius: 50%;
    text-align: center;
    content: "";
}

.posts-expand .post-body ol li:before{
    display: block;
    float: left;
    width: 19px;
    height: 19px;
    line-height: 18px;
    margin: 0.4rem 12px 0 0;
    color: #fff;
    font-size: 15px;
    font-weight: 700;
    font-style: normal;
    background-color: #49b1f5;
    border-radius: 50%;
    text-align: center;
    content: counter(ol-li);
    counter-increment: ol-li;
}

/*valine 评论系统样式*/
div#comments.comments.v{
  margin-top: 0px !important;
  margin-left: 0px;
  margin-right: 0px;
}

div.vheader.item2{
  border-bottom: 1px solid #5f5f5f;
  height: 35px !important;
}

.v .vwrap .vheader.item2 .vinput{
  height: 30px !important;
  border: 0px !important;
  width: 25% !important;
  margin: 0px !important;
}

input.vnick.vinput{
  border-right: 2px solid #a4d8fa !important;
}

div.vcontrol{
  padding-top: 0px !important;
}

div#comments.comments.v{
  border: 0px;
}

.v .vlist .vcard .vquote{
  border-left: none !important;
}

.v .vlist .vcard .vh{
  border-bottom: none !important;
}

.v .vwrap{
  border: 2px solid black !important;
  height: 250px !important;
  width: 98%;
  left: 1%;
  border-radius: 6px !important;
  overflow: visible !important;
  counter-reset: avater;
}

.v .vwrap .vedit .vemojis{
  width: 600px !important;
  background-color: #fff !important;
  border-radius: 5px !important;
}

.v .vwrap .vedit .vpreview {
  width: 600px !important;
  background-color: #fff !important;
  border-radius: 5px !important;
}

.v .vbtn{
  background-color: #971212 !important;
  color: #fff !important;
}

.v .vwrap .vedit .vctrl{
  text-align: left !important;
}

.v .vwrap .vedit .vctrl span{
  background-color: #7f7f7f !important;
  color: #fff !important;
  border-radius: 3px !important;
  padding: 3px !important;
}

.v .vwrap .vedit .vctrl{
  padding: 0px !important;
  margin: 0px !important;
}

.v .vlist .vcard .vquote .vcontent {
  font-size: 15px;
  font-weight: 200;
}

div.vedit{
  height: 120px;
}
div.vcontrol{
  margin-top: 30px;
}

.v .veditor{
  min-height: 70px !important;
  height: 100px !important;
}

.v .vlist .vcard {
  border: 1px solid #ccc !important;
  width: 98%;
  left: 1%;
  padding-left: 14px !important;
  padding-right: 14px !important;
  margin-bottom: 20px !important;
  border-radius: 10px !important;
}
.v .vlist  .vquote .vcard{
  border: 0px !important;
  margin-bottom: 0px !important;
  border-radius: 0px !important;
  padding: 0px !important;
}

.v .vlist .vcard .vhead .vsys{
  display:none !important;
  background-color: #fff !important;
}
.v .vlist .vcard .vh .vmeta .vat{
  background-color: #177714 !important;
  color: #fff !important;
  border-radius: 3px !important;
  padding-left: 10px !important;
  padding-right: 10px !important;
}

.v .vlist .vcard .vimg{
  margin: 0 12px 0 0;
  counter-increment: avater;
}

/*设置评论头像旋转*/
.v .vlist .vcard .vimg:hover {
    -webkit-transform: rotate(360deg);
    -moz-transform: rotate(360deg);
    -ms-transform: rotate(360deg);
    -transform: rotate(360deg);
}

.v .vlist .vcard .vquote{
  margin-left: 40px;
}

.v .vlist .vcard .vquote{
  counter-reset: avaters;
}

.v .vlist .vcard .vquote .vimg{
  display: avaters !important;
}

.v .vlist .vcard .vquote  .vhead:before{
    display: block;
    float: left;
    width: 38px;
    height: 38px;
    line-height: 38px;
    margin: 0 12px 0 0;
    color: #fff;
    font-size: 15px;
    font-weight: bold;
    font-style: normal;
    background-color: #2d4e41;
    border: 3px solid #60a1e5;
    border-radius: 50%;
    text-align: center;

    /*content: counter(avater)'.'counter(avaters);
    counter-increment: avaters;*/
}

.v .vlist .vcard p {
  top: -1.5em;
  position: relative;
  z-index: 1;
  margin: unset;
  text-align: left;
}

.v .vlist .vcard .vquote a.at {
  font-size: 13px;
  color: #bea124;
  text-decoration: none;
  border: unset;
  position: relative;
  top: -40px;
}
.v .vlist .vcard .vquote .vcontent{
  font-size: 15px;
  font-weight: 200;
}

.v .vlist .vcard .vcontent {
  margin-top: 58px !important;
  font-size: 15px !important;
  font-weight: 500 !important;
  padding-top: 0 !important;
  margin-bottom: unset !important;
}

.v .vlist .vcard .vquote .vhead .vnick {
  color: #5af !important;
  font-weight: 300 !important;
  font-size: 15px !important;
}
.v .vlist .vcard .vhead .vnick {
  font-size: 18px !important;
  font-weight: 500 !important;
  color: #5b6b68 !important;
}

.v .vlist .vcard{
  padding-top: 8px !important;
}

.v .vlist .vcard .vh{
  border-bottom: none;
}

.v .vlist .vcard .vhead{
  float: left !important;
}

.v .vlist .vcard .vh .vmeta{
  float: right !important;
}

.v .vlist .vcard .vcontent.expand:after{
    content: "👆 展开留言"!important;
    font-weight: 400!important;
    font-size: 14px;
    border: 2px solid #666;
    display: block;
    text-align: center;
    color: #276c95;
    position: absolute;
    width: 35%;
    height: 15%;
    line-height: 29px;
    padding: 0px;
    left: 30%;
    bottom: 1px;
    pointer-events: none;
    background: #bbb;
    z-index: 7;
}

.site-author-name{
  color: #555 !important;
}

/*文章页内标签样式*/
.posts-expand .post-tags {
  margin: 40px 10px 0 10px;
  text-align: right;
}

.posts-expand .post-tags a {
  -webkit-box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
  -moz-box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
  box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
  font-family: 'Comic Sans MS', sans-serif;
  transition: 0.2s ease-out;
  padding: 3px 5px;
  margin: 5px;
  background: #f5f5f5;
  border-bottom: none;
  border-radius: 15px;

  &:hover {
  background: rgba(100,154,182,0.902);
  color: #fff;
  -webkit-box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
  -moz-box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
  box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0,0,0,0.19);
  }
}

/*相关文章推荐样式设置*/
.popular-posts-header {
  margin-top: 45px;
  font-size: 20px;
  font-family: "PT Serif", "Songti SC", STZhongsong, "PingFang SC", "Microsoft YaHei", Georgia, sans;
  font-weight: 900;
}

ul.popular-posts .popular-posts-item .popular-posts-title a {
  border-bottom: 1px solid #999;
  &:hover{
    border-bottom: none;
  }
}

article.post-block.home {
    border-radius: 5px;
    padding: 10px 30px 20px 30px;
    box-shadow: 0 0 40px rgba(0,0,0,.12);
}
article.post-block {
    border-radius: 5px;
    padding: 10px 30px 20px 30px;
    box-shadow: 0 0 40px rgba(0,0,0,.12);
    margin-bottom: 30px;
}

/* 添加博客背景 */
body {
  background-image:url(../images/background.png);
  height:100%;
  width:100%;
  background-repeat:repeat-x;
  background-attachment:fixed;
  background-size:cover;
}

/* 博客内容透明化 */
.content-wrap {
  opacity: 0.85;
}

.sidebar {
  opacity: 0.85;
}

.header-inner {
  background: rgba(255,255,255,0.85);
}

.popup {
  opacity: 0.9;
}

//hitokoto一言

.hitokoto-title {
  text-align: center;
  font-size: 12px;
}

#hitokoto {
  text-align: left;
  font-family: "Microsoft YaHei";
  font-size: 11px;
}

#hitofrom {
  float: right;
  font-family: "Microsoft YaHei";
  font-size: 10px;
}
```

# 参考链接

- [Hexo官方文档](https://hexo.io/zh-cn/docs/)
- [Hexo-abbrlink生成唯一文章链接](https://www.liaofuzhan.com/posts/4084686398.html)
- [Hexo博客+Next主题深度优化与定制 - Sanarous的博客](https://bestzuo.cn/posts/blog-establish.html)
- [Hexo NexT主题美化2.0 | Leaface](https://www.liaofuzhan.com/posts/2114475547.html)
- [【极客日常】hexo+NexT博客自定义代码高亮主题配色CSS](https://www.okcode.net/article/58394)
- [Hexo NexT 主题 LeanCloud 插件安装教程](https://yunhao.space/2018/06/27/hexo-leancloud-plugin-installation-tutor/)
- [Hexo-NexT主题自定义配置高阶教程](https://blog.bill.moe/hexo-theme-next-config-optimization/)
- [Hexo 博客静态资源压缩优化](https://www.playpi.org/2018112101.html)
- [Fixing NPM Dependencies Vulnerabilities](https://dev.to/bbenefield89/fixing-npm-dependencies-vulnerabilities-6p8)
- [如何解決 “VULNERABILITIES REQUIRED MANUAL REVIEW AND COULD NOT BE UPDATED”｜CODING NOTES](https://chenclaire.wordpress.com/2019/06/20/%E5%A6%82%E4%BD%95%E8%A7%A3%E6%B1%BA-vulnerabilities-required-manual-review-and-could-not-be-updated%EF%BD%9Ccoding-notes/)
- [为您的Hexo博客添加Hitokoto一言功能](https://blog.bill.moe/add-hitokoto/)

