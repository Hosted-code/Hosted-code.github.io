---
betitle: Vim 使用
date: 2020-07-04 09:02:52
categories:
  - Tool
  - CheatSheet
tags:
  - Tool
  - Linux
  - vim
  - CheatSheet
---

本文均不涉及插件, 常用操作一图总结
<img src="https://cdn.jsdelivr.net/gh/Hosted-code/CloudImg@master/Vim使用.jpg" alt="Vim使用" style="zoom: 80%;" />

四种模式
- **Normal**, 默认模式, 文本**操作**
- **Insert**, 正常编辑模式
- **Visual**, 用于文本**选定**
- **Command**, 文本**编辑命令**

vim按键的意义在于, 双手无需离开主键盘区域就可以进行绝大多数操作

# 移动

| 按键                                 | 备注                                                         |
| ------------------------------------ | ------------------------------------------------------------ |
| `h,j,k,l`<br>`gj, gk`                | `gj, gk`等同于`j,k`,不同的是前者将一行换行之后认作多行,后者仍认作一行 |
| `gg`, `G`                            | 首行,末行                                                    |
| `w/W`, `e/E`, `b/B`, `ge/gE`         | 移动单元是**单词**<br>**大写**按键为忽略**标点**<br>`w`, word; `e`, end; `b`, back<br>`w`,`e`均为向后, `w`为单词首, `e`尾单词尾<br>`b`,`ge`均为向前, `b`为单词首, `ge`为单词尾 |
| `0`,`^`, `$`<br>`g0, g_, g$`<br>`gm` | `0`,`^`均为行首, `0`为第一列, `^`为第一个非空字符处;`$`为行末<br>`g0,g_,g$`等同于`0,^,$`, 不同的是前者将一行自动换行后认作多行, 后者认作一行<br>`gm`为一行中间 |
| `%`                                  | 匹配符号之间跳转`()`,`{}`,`[]`,`/* */`, `#if, #ifdef, #else, #elif, #endif`<br>具体可参见vim帮助, `:help %`<br>即便不在匹配符号上, 按键后自动寻找到附近可匹配的符号 |
| `(/)`,`{/}`, `[[/[]`,`][,]]`         | `(/)`, 句首句尾;`{/}`, 段首段尾<br>句子以.**.,!,?**结尾并紧随换行,空格,制表符, 以此为边界; 段落以空行为边界<br>中括号类按键以`{`大括号为移动边界, 第一次的中括号决定向前向后移动, 第一次的中括号决定移动到左大括号还是右大括号 |
| `H, M, L`<br>`C-f, C-b, C-u, C-d`    | H: 屏幕第一行; M: 屏幕中间; L: 屏幕最后一行<br>`C-f`, 下翻一屏; `C-b`, 上翻一屏; `C-u`, 上翻半屏, `C-d`, 下翻半屏 |
| `f/F{char}`<br>`t/T{char}`           | `f{char}`, 向后移动到第一个char的位置, `F{char}`为反方向操作<br>`t{char}`类似于`f{char}`后在光标前移,  `T{char}`为反方向操作<br>`f`为目标位置, `t`为目标之前, `;`, 为重复该操作, `,`为反方向重复操作 |
| `:n`, `n|`,`nG`                      | `:n`, `nG`为到第n行, 个人而言, 一般使用`:n`<br>`n|`为到当前行的第n列 |
| `*`, `#`                             | 以当前光标所在单词为目标, `*`为向后搜索, `#`为向前搜索<br>`n`跳转到下一个目标位置, N跳转到上一个目标位置 |
| `/pattern`, `?pattern`               | `/`, 向下搜索, `?`, 向上搜索                                 |
| `C-o/i`                              | `o`, 回到上一次编辑的地方, `i`, 回到下一次编辑的地方         |

# 书签

标记, 即为**书签**，在某处打上标记后，可快速跳转。

三类标记

- `a-z` 用户设置，仅对当前的一个文件生效，也就意味着只可以在当前文件中跳转
- `A-Z` 用户设置，全局标记，可以作用于不同文件。大写标注也称为「文件标注」。跳转时有可能会切换到另一个缓冲区
- `0-9` 由 **viminfo** 记录，0 代表 viminfo **最后一次**被写入的位置, 
  - 0 代表 Vim 进程最后一次结束的位置
  - 1 代表 Vim 进程**倒数第二次**结束的位置

 `m` 定义一个标记，如 `ma` 标记当前问题为 a 标记。

标记间跳转用 `'` / `g'`  或者反引号

- **单引号**会跳转回被标记行的第一个**非空字符**
- **反引号**会跳转回被标记行的**被标记列**。

其他的跳转,  反引号命令相同

- `'['`,  上次修改或复制的第一行或第一个字符
- `']'`, 上次修改或复制的最后一行或最后一个字符
- `'<`, 上一次在可视模式下选取的第一行或第一个字符
- `'>`,  上一次在可视模式下选取的最后一行或最后一个字符
- `''`, 上一次跳转之前的光标位置
- `'"`, 上一次关闭当前缓冲区时的光标位置
- `'^`,  上一次插入字符后的光标位置
- `'.`, 上一次修改文本后的光标位置
- `'(`, 当前句子的开头; `')`, 当前句子的结尾
- `'{`, 当前段落的开头; `'}`, 当前段落的结尾

标记也可以搭配 **范围** 一起使用。如果在可视模式下选取一些文本，然后按下 `:`，这时命令行会被填充为 `:'<,'>`，这即表示在可视模式下选取的范围。

使用 `:marks` 可以查看当前所有的标记，使用 `:h mark-motions` 更多关于标记的帮助信息。

# 选择

选择处于visual模式
- `v`, 按字符选定
- `V`, 按行选定
- `C-v`, 列选择

`a{x}`, `i{x}`,  `a` 选择的范围要比`i`要大, **a: around; i: inner**

- `x`可以是`w, s, p`, 分别表示word, sentence, paragraph
- `x`可以是block,  `ax`, 包括外边符号, `ix`, 不包括外边符号
  - `[/]`, `(/)`, `</>`, `{/}`分别对应`[]`, `()`,  `<>`, `{}`包含的block
  - `"`, `'`, `反引号`, 分别对应其包起来的block



# 编辑

`r`, replace, 替换单个字符; `R`, 连续替换

`x`, 删除光标所在字符, `X`, 删除光标前一个字符

命令格式: **`motion` + `num` + `range`**

`motion`, 动作

- 替换
  - `c`, change, 改写, 删了重写, `c`需要配合运动(如`w`, `b`, `j`等), 将删除从当前光标位置一直到运动结束的字符进入insert模式
  - `s`, substitute, 替换, 删除当前字符, 并进入insert模式
  - `r`, replace, 替代, 不进入insert模式, 需要另一个字符替换当前字符
- `d`, delete, 删除
- `y`, yank, 复制
- `v`, visual, 选择

- `range`, 均为上文提到的**选择命令**
  - **单词**, `w/W`, `b/B`, `e/E`
  - **行**, `j, k, 0, ^, $`
  - **句子**, `(/)`; 段落: `{/}`
- command模式
  - `:set paste`, 粘贴不自动缩进
  - `:a, b co p`,  a-b行的内容 **copy** 到 p行, a < b 时会提示范围输错了, 是否交换a,b, 确认的话会交换a,b 正常粘贴
  - `:a, b m p`, a-b行的内容 **move** 到 p
  - `:a, bd`, a-b行的内容 delete掉

编辑模式, <kbd>Ctrl</kbd>+<kbd>U</kbd>, 删除光标所在位置至行首的字符

**特殊字符/符号**

- command 模式:  **输入回车**: `C-v` + 回车
- **insert** + **command**: `:dig`获取特殊字符对应`digraph`, 然后 `C-k`,  输入对应`digraph`

大小写转换, `:help ~`
- `~`,  改变大小写
- `g~~`, 改变当前行大小写
- `guu`, 当前行字母全小写
- `gUU`, 当前行字母全小写

**列编辑,** `C-v`

- 修改, `r`, 光标所选均会被 **Replace**
- 光标插入, `I`, 所选列光标前会被 **Insert**
- 光标后追加, `A`, 所选列光标后会 **Append**
- 删除, `d`, 光标所选会被 **delete**

**替换**, **substitute**,  `:[range]s/pattern/string/flags`

- **flag**, 只列出常用的
  - `c`, confirm, 每个替换都需要验证
  - `g`, global, 范围内全部替换
  - `i`, ignore case for the pattern, 忽略大小写
    - `I`, don't ignore case
  - `n`, number, 不做替换, 只显示匹配数目
- `string`相关规则
  - `\0, ... \9`, pattern 匹配到的第i个子串
  - `&`, 表示为整个pattern
  - 大小写变换
    - `~`, 替换, 大小写转换
    - `\u`, `\l`, 下个字符为大写, 小写
    - `\U`, `\L`, 接下来的字符为大写, 小写, 直到遇到`\e`
- 替换示例: `:s/\([abc]\)\([efg]\)/\L\u\2\u\1/g   modifies "AF Fa bG" to "Fa Fa Gb"`

vim 与 shell
- `:shell`, vim 进入shell, `exit`后会回到vim
- `:!command`, 临时进入shell, 完成后返回vim
- 与shell交互, ``:r !command`, 读取命令输出, 写入到vim中

二进制文件
- `vim -b filename`,  `-b`, 二进制, 否则文件末尾会被加上0x0a
- `:%!xxd`, 以16进制方式查看
- `:%!xxd -r`, 取消上一步操作, 
- 为调用`xxd`转换, `-g`, 指定输出每组的8位字节数, 默认为2

# 退出

- `:w`, save, 保存
- `:q`, quit, 退出, 修改未保存进行退出会失败
- `:wq`, :`x`, save and exit, 保存退出
- `:quit`, force quit, 强制退出, 忽略未保存



# 折叠

- 6种折叠模式, `:help fdm`
  - **manual**, 手动管理
  - **indent**, 缩进表示折叠
  - **expr**, 表达式表示折叠, `foldexpr`
  - **marker**, 对特定标示, 如括号(`(), {}, []`) 折叠
  - **syntax**, 语法高亮折叠
  - **diff**, 没变更的会被折叠
- 折叠命令
  - `zf`, 选中文本折叠
    - `zf10j`, 折叠当前行后10行; `5zf`, 折叠5行
    - `zf7G`, 当前行至全文第7行折叠起来
    - `zfa(`, 折叠 `()`包围区域
  - `zo`,  open 当前的折叠; `zc`, close 当前的折叠; `za`,  打开关闭折叠切换
  - `zd`, 删除当前的折叠, **delete**;  `zE`, 删掉所有的折叠, **erase**
  - `zj`, `zk`,  移动到下/上一个折叠
  - `zn`, `zN`, 禁用/启用折叠
  - `zM`, 关闭所有及嵌套的折叠; `zr`, 打开所有折叠; `zR`, 打开所有及嵌套的折叠
- 保存折叠状态, `:mkview`, 此命令会在 **.vim** 下生成view文件夹
- 可通过 `:loadview` 加载折叠状态

# 文本比较

- `vimdiff file1 file2`
- ``vim -d file1 file2`
- 已打开一个文件file1
  - 上下,  `:diffsplit file2`
  - **左右: `:vert diffsplit file2`**
    - 左右文件交换: `C-w` + `H/L`
- 已经打开两个文件, 分屏后分别在两个窗口输入 `:diffthis`
- 比较命令
  - `:diffupdate`, 修改文件后变更比较结果
  - `[c`, 上一个diff点; `]c`下一个diff点
  - `dp`, diff put, 将diff点的当前文档应用到另一个文档
  - `do`, diff obtain, diff点的当前文档应用另一个文档的内容



# 多屏 & session

- vim支持多窗口分屏, 可同时打开多个文件编辑
- 三种概念,  查看帮助`:help window`
  - **buffer**, A buffer is the **in-memory** text of a file., 保存前修改只在内存中, 未写入磁盘
  - **window**, A window is a viewport on a buffer. **sql中的视图**, **用来显示buffer,** 一个buffer可有多个窗口, 一个窗口只对应一个buffer
  - **tab**, A tab page is a collection of windows. tab是窗口的集合
- vim是终端软件, 非图形软件(gvim不包括在内)
  - vim默认打开一个window, 根据打开的文件数量, 可以有多个buffer
  - `:e filename`, 新打开一个文件, buffer+1
  - `:ls`, 查看当前buffer
    - 最开始是buffer编号, 用于buffer切换时指定编号
      - `:bp`, 切换到 **previous** buffer
      - `:bn`, 切换到 **next** buffer
      - `:bf`, 切换到 **first** buffer
      - `:bl` 切换到 **last** buffer
      - `:b{n}`, 切换到第n个buffer, 如`:b2`
    - `:bd`, delete buffer, 关闭当前文件
    - **flag**,  标示文件状态
      - `%`, 当前, 当前窗口正显示的文件
      - `#`, 交换, 上次打开的文件
      - `=`, 只读, 该buffer打开的是一个只读文件
      - `+`, 文件已修改
      - `a`, 当前被激活, **activation**
      - `h`, 隐藏的缓冲区
    - `1 %a + "test.c"   line 9`
- 多窗口, 一个窗口 **split** 成多个窗口
  - `:sp`, 水平分屏, 分为上下; `:vsp`, 垂直分屏, 分为左右, 后可跟文件名
  - 窗口命令, `C-w`
    - **光标移动**, `C-w` + `hjkl`
    - **分屏移动**, `C-w` + `HJKL`
    - **调整尺寸**
      - `C-w` + `-/+`, 增加或减少窗口高度
      - `C-w` + `</>`, 增加或减少窗口宽度
      - `C-w` + `=`, 均分窗口
- 分屏同步滚动, **scrollbind**
    - 设置, `:set scb`
    - 取消, `:set scb!`
- 标签页, **tab**
  - `:tabnew + filename`, 新建一个tab页
  - `tabc i`, close掉tab页, 指定数字就关闭指定页, 否则关闭当前页
  - `:tabo`, close掉 other 页
  - `:tabs`, 查看所有tab页
  - 查看上一个, 下一个tab
    - `:tabn`, `:tabp`
    - `gt`, `gT`
  - `Ngt`, 查看第N个标签页
  - `vim -p file1 file2 file3`, 使用tab打开多个文件
- **目录**, `:E`
  - 也可直接vim一个目录
  - `j, k`上下移动, 回车进入目录或打开文件, 上面有显示一堆命令
  - `:cd path`, 切换目录, `:pwd`, 查看当前路径
  -  目录分屏
    - 上下分屏, `:He`,  `He!`为目录在上
    - 左右分屏, `Ve`, 左边是目录
    - `:Te`, tab页浏览目录

- 会话, **session**
  - 保存会话:  `:mksession ~/.mysession.vim`
  - 加载会话, `vim -S ~/.mysession.vim`

# 其他

- **字符编码:**, `ga`, 查看光标处字符的ascii码, `g8`, 查看光标处字符的utf-8编码

- `gf`, 打开光标处所指的文件, 例如`#include`

- **缩进**

  - `>>`, 右缩进, `<<`, 左缩进, `=`, 缩进当前行, **对齐缩进**, 与上下文对齐
  - `=%`, **对齐缩进整个语句块**, `%`是括号匹配, **光标需要在语句块括号上**
  - `gg=G`, 对整个文件进行排版

- **自动补全**

  - `C-n`, `C-p`

  - 智能补全, 进入补全模式: `C-x`
    - 整行补全, line `C-L`
    - **根据当前文件里关键字补全**`C-n`
    - **根据字典补全**`C-n`
    - 根据同义词字典补全 `C-t`
    - **根据头文件内关键字补全**`C-i`
    - 根据标签补全 `C-]`
    - **补全文件名**`C-f`
    - 补全宏定义, **define** , `C-d`
    - 补全vim命令 `C-v`
    - 用户自定义补全方式 `C-u`

- **插入计算结果:** 输入 `ctrl-r =`，然后输入表达式，就能在光标处得到计算结果。



# vimrc

```vimrc
filetype on             "检测文件类型
filetype indent on      "针对不同文件类型采用不同的缩进格式
syntax enable           "开启语法高亮
syntax on

"通用项
set number              "显示行号
set nowrap              "取消换行
set cursorline          "突出显示当前行
set colorcolumn=121		"121列高亮, 代码规范要求一行不超过120字符, 压线则超
set paste               "粘贴时保持格式
set scrolloff=3         "光标的上方或下方至少会保留显示的行数, 意即上移或下移距屏幕边缘还有n行便开始滚动
set autowrite           "自动保存
set autoread			"自动加载, 外部修改文件, 自动更新
set confirm             "处理未保存文件或只读文件弹出确认
set report=0            "通过使用: commands命令，告诉我们文件的哪一行被改变过"
set iskeyword+=_,$,@,%,#,-  "带有这些字符的不要被换行分割
"colorscheme desert		"颜色主题


"命令模式模糊匹配
set wildmenu
set wildmode=longest:list,full

"取消备份
set nobackup
set noswapfile

"查找
set ignorecase          "搜索忽略大小写
set hlsearch            "高亮搜索结果
set incsearch           "随着键入即时搜索
set smartcase           "有一个或以上大写字母时仍大小写敏感
set magic               "支持正则

"缩进
set tabstop=4           "设置tab键的宽度
set expandtab           "将tab自动转为空格
set smarttab
set shiftwidth=4        "自动缩进的宽度
set softtabstop=4       "退格键删除的空格数, 只影响tab插入的空格
set smartindent         "智能缩进
set autoindent          "自动缩进
set cintent
autocmd FileType make set noexpandtab  "不将makefile中的tab转换为空格

"折叠
set foldenable
" 折叠方法
" manual    手工折叠
" indent    使用缩进表示折叠
" expr      使用表达式定义折叠
" syntax    使用语法定义折叠
" diff      对没有更改的文本进行折叠
" marker    使用标记进行折叠, 默认标记是 {{{ 和 }}}
set foldmethod=syntax
"set foldcolumn=4 "设置最大折叠层次

"编码设置
set encoding=gbk
set fileencodings=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936

"状态栏
set ruler               "显示当前行号列号
set showcmd             "在状态栏显示正在输入的命令

set statusline=%F%m%r%h%w
set statusline+=[%{&fileformat}]
set statusline+=[%{&fileencoding}]
set statusline+=[%{strftime(\"%Y/%m/%d\ %H:%M:%S\",getftime(expand(\"%:p\")))}]
set statusline+=%=%l,%c%V\ %P
set laststatus=2

"其他
set lz	"在执行宏命令时，不进行显示重绘；在宏命令执行完成后，一次性重绘，以便提高性能"
set noerrorbells		"关闭错误信息响铃

```



# 参考文档

- `:help`
- [无插件Vim编程技巧|](https://coolshell.cn/articles/11312.html)
- [vi / vim中的s，c和r命令有什么区别？](https://www.thinbug.com/q/16416758)
- [Vim 使用技巧整理](https://blog.konghy.cn/2019/11/23/vim-skill/)