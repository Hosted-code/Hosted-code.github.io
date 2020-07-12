---
title: 定义未使用的变量
date: 2020-07-09 21:39:52
categories:
  - 编码
tags:
  - Linux
  - 编码
  - 随笔
---



同事在搞特性开发时引入一个问题,  报错是存在未使用的定义变量, 其本质是宏开关控制条件不一致, 导致某一产品不支持该特性, 但执行了变量的定义, 赋值, 和 `log` 输出, 作为参数使用的代码被正确的宏控制着未执行

按正常来说log输出一般也就是 `printf` 的封装, 但 log 本身也是使用宏控制着的, 一般正式产品不启用这种 log 的宏, 这种场景下, log 输出没有使用变量, 赋值不算使用变量, 因此出现了这种报错, 下面是小例子

```c
#include <stdio.h>
#ifdef DEBUG
	#define LOG(arg) printf("i = %d\n", arg)
#else
	#define LOG(arg)
#endif

int main() 
{
	int i;
    
    i = 30;
    LOG(i);
    
    return 0;
}
```

```bash
hosted@Desktop:~/train$ gcc 01.c -Werror=unused-but-set-variable -o 01
01.c: In function ‘main’:
01.c:10:6: error: variable ‘i’ set but not used [-Werror=unused-but-set-variable]
  int i;
      ^
cc1: some warnings being treated as errors
hosted@Desktop:~/train$ gcc 01.c -Werror=unused-but-set-variable -DDEBUG -o 01
hosted@Desktop:~/train$ ./01
i = 30
```

