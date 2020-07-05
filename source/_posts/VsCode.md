---
title: VSCode
categories:
  - CheatSheet
  - Tool
tags:
  - Tool
  - CheatSheet
  - Snippet
abbrlink: 3804610536
date: 2019-11-29 16:43:03
---

# VsCode教程

<a href="https://geek-docs.com/vscode" class="LinkCard">VSCode|极客教程</a>

<!-- more -->

# VsCode基本设置

- 中文化：  <kbd>Ctrl</kbd>+<kbd>shift</kbd>+<kbd>P</kbd> => language(配置显示语言) => 安装其他语言 => 安装中文语言包，重启
- VsCode集成Cmder
  1. <kbd>Ctrl</kbd>+<kbd>shift</kbd>+<kbd>P</kbd> => 输入 **"设置"** => 选择 **打开设置(json)**
  2. settings.json添加如下代码

```json
// 这种设置方法 是通过cmd调用cmder的批处理文件， 窗口不独立
"terminal.integrated.shell.windows": "C:\\Windows\\System32\\cmd.exe",
"terminal.integrated.shellArgs.windows": ["/k", "D:\\Tool\\DevelopTool\\cmder\\vendor\\init.bat"]
// 这种设置方法cmder窗口独立
"terminal.integrated.shell.windows": "D:\\Tool\\DevelopTool\\cmder\\Cmder.exe"
// 设置集成cmder内带的git
"git.path": "D:\\Tool\\DevelopTool\\cmder\\vendor\\git-for-windows\\bin\\git.exe",
```

- 修改文件图标： 文件->首选项->文件图标主题->安装其他主题->安装喜欢的主题->选择文件图标主题

# VsCode快捷键

- 菜单里面就有各个操作的快捷键
- <kbd>Ctrl</kbd>+<kbd>K</kbd>;<kbd>Ctrl</kbd>+<kbd>M</kbd>可调出按键映射， 可安装对应键盘映射使用其他编辑器的按键映射
  - 会变为对应编辑器的快键键
- vscode欢迎使用处就有快捷键速查表
<a href="https://code.visualstudio.com/shortcuts/keyboard-shortcuts-windows.pdf" class="Linkcard">VsCode官方快捷键速查表</a>

<img src="D:%5CPictures%5CMarkdown_pic%5CVScode%E6%BC%94%E6%AD%A6%E5%9C%BA%5Cassets%5CVsCode%20CheetSheet.png" alt="VsCode CheetSheet" style="zoom:67%;" />

## 编辑

- 文件中查找/替换： <kbd>Ctrl</kbd>+<kbd>shift</kbd>+<kbd>F/H</kbd>
- 注释
  - 单行注释， 注释当前行，<kbd>Ctrl</kbd>+<kbd>/</kbd>
  - 块状注释， 多行注释， <kbd>Shift</kbd>+<kbd>Alt</kbd>+<kbd>A</kbd>
- 缩进： <kbd>Ctrl</kbd>+<kbd>[/]</kbd>
- 折叠/取消折叠： <kbd>Ctrl</kbd>+<kbd>shift</kbd>+<kbd>[/]</kbd>
- 删除当前行，<kbd>Ctrl</kbd>+<kbd>shift</kbd>+<kbd>K</kbd>
- 折叠：<kbd>Alt</kbd>+<kbd>Z</kbd>

## 导航

- 打开面板，打开文件：<kbd>Ctrl</kbd>+<kbd>P</kbd>
  - 默认列出最近打开的文件
  - 输入`?`得到提示
  - <kbd>Ctrl</kbd>+<kbd>P</kbd> & `>` => <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd>
  - <kbd>Ctrl</kbd>+<kbd>P</kbd> & `@` => <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>O</kbd>
  - <kbd>Ctrl</kbd>+<kbd>P</kbd> & `#` => <kbd>Ctrl</kbd>+<kbd>T</kbd>
  - 。。。
- 定位符号
  - 多文件：<kbd>Ctrl</kbd>+<kbd>T</kbd>
  - 当前文件：<kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>O</kbd>
- 错误定位：
  - 向下定位：<kbd>F8</kbd>
  - 向上定位：<kbd>Shift</kbd>+ <kbd>F8</kbd>
- 在几处编辑位置跳转：<kbd>Alt</kbd>+<kbd>←/→</kbd>
- 定位到括号处：<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>\\</kbd>

## 选择

- 块状选择
    - 纯键盘的：<kbd>Ctrl</kbd> + <kbd>Shift</kbd>+<kbd>Alt</kbd> + <kbd>↑/↓/←/→</kbd>
    - 纯鼠标的：**鼠标中键拖动**
    - 键鼠合作的： <kbd>Shift</kbd>+<kbd>Alt</kbd>+ **鼠标左键**
- 添加上一行或下一行光标，<kbd>Ctrl</kbd>+<kbd>Alt</kbd> + <kbd>↑/↓</kbd>
- 在行尾添加光标： <kbd>Ctrl</kbd>+<kbd>Shift</kbd> + <kbd>I</kbd>
- 选择所有匹配词： <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>L</kbd>
- 选择下一个匹配词， <kbd>Ctrl</kbd>+<kbd>D</kbd>
- 移动行位置，<kbd>alt</kbd>+<kbd>↑/↓</kbd>
- 复制当前行并粘贴到下一行，<kbd>Shift</kbd>+<kbd>Alt</kbd> + <kbd>↑/↓</kbd>

  

## 代码相关

- 重命名符号：<kbd>F2</kbd>
- 格式化代码:
    - 整体格式化： <kbd>shift</kbd>+<kbd>alt</kbd>+<kbd>K</kbd>
    - 选择格式化：<kbd>Ctrl</kbd>+<kbd>K</kbd>;<kbd>Ctrl</kbd>+<kbd>F</kbd>
- 代码提示
    - <kbd>Ctrl</kbd>+<kbd>Space</kbd>
    - 提示参数：<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>Space</kbd>
- 定义实现
    - 转到定义：<kbd>F12</kbd>
    - 查看定义：<kbd>Alt</kbd>+<kbd>F12</kbd>
    - 查看调用：<kbd>Shift</kbd>+<kbd>F12</kbd>
    - 跳转实现：<kbd>Ctrl</kbd>+<kbd>F12</kbd>
- 去掉行尾空格： <kbd>Ctrl</kbd>+<kbd>K</kbd>;<kbd>Ctrl</kbd>+<kbd>X</kbd>

# VsCode插件

- Code Runner
- Prettier, 代码格式化
- GitLens, git增强插件
  - Git History， 图形化 `git log`
-  Programming Languages
  - Python
  - C/C++
- Settings Sync， 同步vscode配置
  - 安装后欢迎界面，授权登陆Github
  - <kbd>Shift</kbd>+<kbd>Alt</kbd>+<kbd>U</kbd>
- Markdown All in One
- PicGo， 图床插件
- Polacode, 代码图片分享
- Path Autocomplete，文件路径自动补全。
- Document This，快速生成注释。
- Bracket Pair Colorizer，括号配对着色，方便查看多层嵌套的代码。

# Snippet规则

- Snippet， 代码片， 输入一小段字符串， 生成预定义代码模板， **辅助快速输入**
- vscode代码块配置
  - **纯鼠标：**
    - 文件->首选项->用户代码片段
    - 左下角齿轮->用户代码片段
  - **纯键盘：**<kbd>Ctrl</kbd>+<kbd>shift</kbd>+<kbd>P</kbd> -> `snippet`
- 可在Vscode应用商店安装对应的snippet
- snippet的自动补全
  - <kbd>Ctrl</kbd>+<kbd>Space</kbd>
  - <kbd>Tab</kbd>， 需启用， `"editor.tabCompletion": "on"`

## 语法结构（4部分）

- **prefix**：输入的一小段字符串，支持N:1
- scope：指定代码适用的语言模式，可选， **仅用于全局代码片使用**
- **body**: 预定义代码模板， **布局与控制**
- description： 可选， 描述， 代码片在IntelliSense 中的「介绍」

```json
//举个例子, in file 'Code/User/snippets/javascript.json'
{
  "For Loop": {
    "prefix": ["for", "for-const"],
    "body": ["for (const ${2:element} of ${1:array}) {", "\t$0", "}"],
    "description": "A for loop."
  }
}
```

- **prefix**, 支持N:1, 多个前缀对应同一个代码模板时， 定义为数组
  - `"prefix": [ "header", "stub", "copyright"],`
- **body**： 代码模板主题， 每个字符串代表一行
  - **tabstops**, 制表符， 使用tab可以让光标在snippet内跳转
    - `${n}`, 如`$1, $2` 指定光标位置, 数字大小表示先后顺序
        - `$0`, 为光标最终位置
    - 相同序号会同步更新
  - **placeholders**, 占位符， 带有默认值的tabstops
    - `${1:foo}`, 默认值为foo, 跳转到时自动全选， 方便修改
    - 利于提供默认值或作为输入提示
    - 结构体的snippets: `struct ${1:name_t} {\n\t$2\n};`
  - **choice**, 可选项， 多个默认值， 选择其中一个
    - `${1|one,two,three|}`
  - **variables**, **变量**
    - `$name`或`${name:default}`可以插入变量的值

## 变量

- 内置变量
  - `TM_SELECTED_TEXT`：当前选定的文本或空字符串；
    - 注：**选定后**通过在命令窗口点选「插入代码片段」插入。
  - `TM_CURRENT_LINE`：当前行的内容；
  - `TM_CURRENT_WORD`：光标所处单词或空字符串
    - 注：所谓光标一般为文本输入处那条闪来闪去的竖线，该项可定制。单词使用 VSCode 选词（Word Wrap）器选择。
    - 只可选择英文单词，没有针对宽字符优化过，它甚至无法识别宽字符的标点符号。
  - 行号
    - `TM_LINE_INDEX`：zero-index based
    - `TM_LINE_NUMBER`：one-index based
  - 文件相关
    - `TM_FILENAME`：当前文档的文件名；
    - `TM_FILENAME_BASE`：当前文档的文件名（不含后缀名）；
    - `TM_DIRECTORY`：当前文档所在目录；
    - `TM_FILEPATH`：当前文档的全路径；
    - `WORKSPACE_NAME`：打开的工作区或目录的名称（而非完整路径）；
  - `CLIPBOARD`：当前剪贴板中内容。
  - **当前时间日期**
    - 当年
      - `CURRENT_YEAR`，四位年份
      - `CURRENT_YEAR_SHORT`, 年份后两位
    - 当月
      - `CURRENT_MONTH`， 数字月份
      - `CURRENT_MONTH_NAME` 当前月份的全称，如 July；
      - `CURRENT_MONTH_NAME_SHORT`: 当前月份的简称，如 Jul；
    - 当日
      - `CURRENT_DATE`: 当天月份第几天；
      - `CURRENT_DAY_NAME`: 当天周几，如 Monday；
      - `CURRENT_DAY_NAME_SHORT`: 当天周几的简称，如 Mon；
    - 时：`CURRENT_HOUR`， 24小时制
    - 分：`CURRENT_MINUTE`
    - 秒：`CURRENT_SECOND`
    - unix时间戳：`CURRENT_SECONDS_UNIX`：Unix 时间戳。
  - 注释
    - `BLOCK_COMMENT_START` 块注释上半段
    - `BLOCK_COMMENT_END`, 块注释下半段
    - `LINE_COMMENT`, 行注释

  

## 变量转换

- 变量转换：将变量的值格式化后插入预定位置
- 语句：`${var_name/regular_expression/format_string/options}`
- regulare_expression, options 为正则表达式和匹配选项
  - `(?i)`：忽略大小写(CASE_INSENSITIVE)
  - `(?x)`：忽略空格字符(COMMENTS)
  - `(?s)`：`.`匹配任意字符，包括换行符（DOTALL）
  - `(?m)`：多行模式（MULTILINE）
  - `(?u)`：对Unicode符大小写不敏感（UNICODE_CASE），必须启用**CASE_INSENSITIVE**
  - `(?d)`：只有'\n'才被认作一行的中止（UNIX_LINES）
- format_string为格式化字符串, 
  - 普通文本 + 格式化控制符
  - 格式化控制符(7种)
    - `$n`, `${n}`, 捕捉项， 正则涉及括号分组时， 每个括号内为一个匹配项，未分组则无捕捉项
    - 根据格式化控制符进行捕捉项的替换， 形成新的字符串， **替换匹配到的字符串**
      - 形成的新字符串格式与format_string格式一致
      - 匹配成功， 新字符串替换匹配项
        - 捕获成功， 捕获项为捕获分组内容
        - 捕获失败， 捕获项为空
      - 匹配失败， 新字符串替换变量
    - `${n:/upcase}`，`${n:/downcase}`， `${n:/capitalize}`：匹配后**捕捉项变更大小写**
    - `${n:+if}`,  只处理成功的捕获项
      - 匹配成功捕获成功， 将`if`所述语句完全替换正则表达式匹配项捕获分组。
      - 匹配成功捕获失败，捕获项为空
      - 匹配失败， 不变
    - `${n:?if:else}`, 类似于三目运算符的操作, 成功和失败均处理
      - 匹配成功且捕捉成功， 将`if`所述语句完全**替换捕获项**；
      - 匹配成功捕捉失败，将`else`所述语句完全**替换捕获项位置**；
      - 匹配失败，`else`所述语句即为处理后的变量
    - `${n:-else}`, `${n:else}`， 只处理失败的
      - 匹配成功捕捉成功，捕捉项不变
      - 匹配成功捕捉失败，将`else`所述语句**完全替换正则表达式匹配项**；
      - 匹配失败，`else`所述语句即为处理后的变量

  ```bash
  ${TM_FILENAME/(.*)\\..+$/$1/}
    |           |         |  |
    |           |         |  |-> 没有选项
    |           |         |
    |           |         |-> 第一个捕捉项
    |           |             
    |           |
    |           |-> 正则表达式，捕获文件名， 不包含后缀名
    |               就是浪催的， 不如变量直接用 TM_FILENAME_BASE
    |
    |-> 变量名， 当前文档的文件名
  ```

  ```bash
  # 示例， 文件名为global-js.json
  # 则 $TM_FILENAME_BASE: global-js
  # ${var_name/regular_expression/$1/options}
  ${TM_FILENAME_BASE/(global).*/$1/}				#匹配成功，捕获成功，global
  
  # ${var_name/regular_expression/${1:/upcase}/options}
  ${TM_FILENAME_BASE/(global).*/${1:/upcase}/}	#匹配成功捕获成功，变更为大写， GLOBAL
  
  # ${var_name/regular_expression/${1:+if}/options}
  ${TM_FILENAME_BASE/(glo)(bal)/${1:+if}&${2:+if}/}			#匹配成功，捕获成功，if&if-js
  ${TM_FILENAME_BASE/global/${1:+if}&${2:+if}/}				#匹配成功，捕获失败，&&-js
  ${TM_FILENAME_BASE/(globald)/${1:+if}&${2:+if}/}			#匹配失败，不变，global-js
  
  # ${var_name/regular_expression/${1:?if:else}/options}
  ${TM_FILENAME_BASE/(glo)(bal)/${1:?if:else}&${2:?if:else}/}	#匹配成功，捕获成功, if&if-js
  ${TM_FILENAME_BASE/global/${1:?if:else}&${2:?if:else}/}		#匹配成功，捕获失败， else&else-js
  ${TM_FILENAME_BASE/globald/${1:?if:else}&${2:?if:else}/}	#匹配失败，else&else
  
  # ${var_name/regular_expression/${1:else}/options}
  ${TM_FILENAME_BASE/(glo)(bal)/${1:else}&${2:else}/}			#匹配成功，捕获成功, glo&bal-js
  ${TM_FILENAME_BASE/global/${1:else}&${2:else}/}				#匹配成功，捕获失败， else&else-js
  ${TM_FILENAME_BASE/globald/${1:else}&${2:else}/}			#匹配失败，else&else
  
  # ${var_name/regular_expression/text/options}
  ${TM_FILENAME_BASE/(global)/text/}				#匹配成功， 替换匹配项, text-js
  
  # 匹配成功与否与整个正则有关， 捕获成功与否与某个分组有关
  ${TM_FILENAME_BASE/(glo)(bal)/${1:+if}&${2:+if}&${3:+if}/}  #匹配成功，第一分组匹配成功第二分组匹配成功，第三分组捕获失败if&if&-js
  ```

  

- **`Placeholder Transform`** 本质与`Variable Transform`的第8条一致，只是**正则表达式变为占位符常量**

```json
//代码片段
"transform": {
    "prefix": "tr",
    "body": "$1 -> ${1/placeholder/text/}",   //输入: placeholder 输出: placeholder -> text
}
```

# 参考链接

- [在 vscode 中写 Markdown ](https://juejin.im/post/5c45b92751882525487c5c66)
- [在 VSCode 下用 Markdown Preview Enhanced 愉快地写文档](https://zhuanlan.zhihu.com/p/56699805)
- [snippet官方文档](https://code.visualstudio.com/docs/editor/userdefinedsnippets)
- [【VSC】Snippets不完全指南](https://juejin.im/post/5caab98af265da24e238d9d2)