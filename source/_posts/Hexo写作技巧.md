---
title: Hexo写作技巧
categories:
  - Blog
tags:
  - Blog
  - Snippet
abbrlink: 3662325414
date: 2019-11-30 13:21:05
updated: 2019-12-05 17:44:56
---

# vscode辅助插件

- Markdown All in One, 主要是快捷输入
- vscode-hexo-utils, 便于在vscode进行hexo的管理
- PicGo, 图床插件

# Markdown语法

| 元素     | Markdown 语法                       |
| :------- | :---------------------------------- |
| 标题     | `# 标题1` `## h2` `### h3`          |
| 加粗     | `**文字加粗**`                      |
| 引用     | `> 引用文字`                        |
| 有序列表 | `1. 第一项` `2. 第二项` `3. 第三项` |
| 无序列表 | `- 第一项` `- 第二项` `- 第三项`    |
| 链接     | `[链接](url)`                       |
| 图片     | `![图片](image.jpg)`                |
| 水平线   | `---`                               |
| 代码     | \`code`                            |
| 代码块   | \```code snippet```                |

 [Markdown Cheat Sheet](https://www.markdownguide.org/cheat-sheet/)
 
<!-- more -->

# Hexo 标签

## 文本居中

{% cq %}bla bla bla{% endcq %}

- 使用方法： 
{% raw %}
{% cq %}blah blah blah{% endcq %}`
{% endraw %}

## 代码块标签

```js "hello world" http://www.google.com 谷歌
console.log("hello world")
```

- 代码块标签
	- `language`：语言名称
	- `title`：代码块标题，将会显示在左上角, 若不设定title则三个空格以上
	- `url`：链接地址
		- 如果没有指定 link text 则会在右上角显示 link
		- 以url为分界， 左侧第一个单词为langauge, 其余均为title
		- 右侧识别为link_text
	- `link text`：链接名称，指定 url 后有效，将会显示在右上角
```swig
{% codeblock [title] [lang:language] [url] [link text] [additional options] %}
code snippet
{% endcodeblock %}
```
- 反斜杠代码块
```` 
``` [language] [title] [url] [link text]
code snippet
```
````

## note标签

{% note primary %}
primary note tag
{% endnote %}`
{% note success  %}
success  note tag
{% endnote %}
{% note info %}
info note tag
{% endnote %}
{% note warning  %}
warning  note tag
{% endnote %}
{% note danger %}
danger note tag
{% endnote %}
{% note undefined  %}
undefined note tag
{% endnote %}


- note标签: 类名包含`default`, `primary`, `success`, `info`, `warning`, `danger`
```swig
{% note [class] %}
文本内容 (支持行内标签)
{% endnote %}
```

## label标签

I heard the echo, {% label default@from the valleys and the heart %} Open to the lonely soul of {% label info@sickle harvesting %}
Repeat outrightly, but also repeat the well-being of
Eventually {% label warning@swaying in the desert oasis %}
{% label success@I believe %} I am
{% label primary@Born as the bright summer flowers %}
Do not withered undefeated fiery demon rule
Heart rate and breathing to bear {% label danger@the load of the cumbersome %}
Bored

- lable标签 同note标签, `{% label [class]@text  %}`

## button按钮

{% btn #, 文本 & 大图标 (固定宽度), home fa-fw fa-lg %}

- button, **{% raw %}{% btn /path/to/url/, text, icon [class], title %}{% endraw %}**
  - 图标 ID 来源于 [FontAwesome](https://fontawesome.com/v4.7.0/icons/)

## tab标签页

{% tabs Tab标签列表 %}
  <!-- tab 标签页1 -->
    标签页1文本内容
  <!-- endtab -->
  <!-- tab 标签页2 -->
    标签页2文本内容
  <!-- endtab -->
  <!-- tab 标签页3 -->
    标签页3文本内容
  <!-- endtab -->
{% endtabs %}

- tab标签， 快速创建标签卡
  - Unique name: 全局唯一的 Tab 名称，将作为各个标签页的 id 属性前缀
  - index: 当前激活的标签页索引，如果未定义则默认选中显示第一个标签页，如果设为 - 1 则默认隐藏所有标签页
  - Tab caption: 当前标签页的标题，如果不指定则会以 Unique name 加上索引作为标题
  - icon: 在标签页标题中添加 Font awesome 图标
```swig
{% tabs [Unique name], [index] %}
  <!-- tab [Tab caption]@[icon] -->
  标签页内容（支持行内标签）
  <!-- endtab -->
{% endtabs %}
```

## 引用站内链接

{% post_link VsCode %}

- 使用语法
  - 渲染为**文章地址**：{% raw %}{% post_path slug %}{% endraw %}
  - 渲染为**跳转链接**：{% raw %}{% post_link slug [title] %}{% endraw %}
  - slug指**Markdown 文件名**

## 插入swig

- 为防止swig语法被渲染， 使用`raw`标签
```swig
{% raw %}
content
{% endraw %}
```

# Snippet

{% note info  %}
snippet相关语法参见 {% post_link VsCode %}
{% endnote %}

- 一些设置
```json
//markdown启用自动补全
"[markdown]": {
  "editor.quickSuggestions": true //预设 false
},
"editor.snippetSuggestions": "top"    //优先显示snippet
```

```json
	//For Hexo
	"centerquote": {
		"prefix": "cq",
		"body": "{% cq %} $1 {% endcq %}\n",
		"description": "文本居中"
	},
	"note tag": {
		"prefix": "note",
		"body": [
			"{% note ${1|primary, success, info, warning, danger|} %}",
			"$2",
			"{% endnote %}\n"
		],
		"description": "note 标签"
	},
	"label tag": {
		"prefix": "label",
		"body": "{% label ${1|primary, success, info, warning, danger|}@$2 %}\n",
		"description": "label 标签"
	},
	"button tag": {
		"prefix": ["button", "btn"],
		"body": "{% btn ${1:/path/to/url/}, ${2:text}, ${3:icon [class]} %}",
		"description": "按钮标签"
	},
	"tab tag": {
		"prefix": "tab",
		"body": [
			"{% tabs ${1:标签列表名} %}",
			"<!-- tab ${2:标签页1} -->",
			"$3",
			"<!-- endtab -->",
			"<!-- tab ${4:标签页2} -->",
			"$5",
			"<!-- endtab -->",
			"<!-- tab ${6:标签页3} -->",
			"$7",
			"<!-- endtab -->",
			"{% endtabs %}"
		],
		"description": "按钮标签"
	},
	"post link": {
		"prefix": "link",
		"body": "{% post_link ${1:markdown文件名} ${2:$1} %}",
		"description": "站内链接"
	},
	"linkcard": {
		"prefix": "link",
		"body": "<a href=\"${1:#}\" class=\"LinkCard\">$2</a>",
		"description": "卡片链接"
	}
```


# 参考文档

- [标签插件](https://hexo.io/zh-cn/docs/tag-plugins)
- [Hexo 搭建个人博客系列：写作技巧篇](http://yearito.cn/posts/hexo-writing-skills.html)
