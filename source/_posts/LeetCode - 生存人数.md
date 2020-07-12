---
title: LeetCode - 生存人数
categories:
  - Leetcode
tags:
  - LeetCode
  - 编码
date: 2020-07-08 21:36:51
---



# 题目

来源: https://leetcode-cn.com/problems/living-people-lcci/

给定N个人的出生年份和死亡年份，第`i`个人的出生年份为`birth[i]`，死亡年份为`death[i]`，实现一个方法以计算生存人数最多的年份。

你可以假设所有人都出生于1900年至2000年（含1900和2000）之间。如果一个人在某一年的任意时期都处于生存状态，那么他们应该被纳入那一年的统计中。例如，**生于1908年、死于1909年的人应当被列入1908年和1909年的计数。**

如果有多个年份生存人数相同且均为最大值，输出其中最小的年份。

示例：



```c
输入：
birth = {1900, 1901, 1950}
death = {1948, 1951, 2000}
输出： 1901
```


提示：

- `0 < birth.length == death.length <= 10000`

leetcode上的一条用例

- `[1972,1908,1915,1957,1960,1948,1912,1903,1949,1977,1900,1957,1934,1929,1913,1902,1903,1901]`
- `[1997,1932,1963,1997,1983,2000,1926,1962,1955,1997,1998,1989,1992,1975,1940,1903,1983,1969]`

前期的异常判断有耗费多余时间, **一个for循环**, 提交是去除异常判断

# 思路1

leetcode消耗

- 执行用时：**104 ms**

- 内存消耗：**7 MB**

```c
int maxAliveYear1(int *birth, int birthSize, int *death, int deathSize) {
    int i;
    int j;
    int year;
    int count;      //记录当年生存人数
    int max = 0;    //记录最大生存人数
    
    if ((birth == NULL) || (death == NULL) || (birthSize < 0) || (birthSize > 10000)) {
        printf("参数无效\n");
        return -1;
    }
    if (birthSize != deathSize) {
        printf("出生年份人数与死亡年份人数不一致, 数据有误\n");
        return -1;
    }
    for (i = 0; i < birthSize; i++) {
        if (birth[i] > death[i]) {
            printf("生的的比死的迟, 数据有误\n");
            return -1;
        }
    }

    for (i = START_YEAR; i <= END_YEAR; i++) {
        count = 0;
        for (j = 0; j < birthSize; j++) {
            if ((i >= birth[j]) && (i <= death[j])) {
                count++;
            } else {
                continue;
            }
        }

        if (max < count) {
            max = count;
            year = i;
        }
    }

    return year;
}
```



# 思路2

```c
int maxAliveYear(int* birth, int birthSize, int* death, int deathSize){
    int year[SIZE] = {0};
    int i, birthIdx, deathIdx;
    int tmp = 0;
    int max = 0;
    int result =0;

    if ((birth == NULL) || (death == NULL) || (birthSize < 0) || (birthSize > 10000)) {
        printf("参数无效\n");
        return -1;
    }
    if (birthSize != deathSize) {
        printf("出生年份人数与死亡年份人数不一致, 数据有误\n");
        return -1;
    }
    for (i = 0; i < birthSize; i++) {
        if (birth[i] > death[i]) {
            printf("生的的比死的迟, 数据有误\n");
            return -1;
        }
    }

    for (i = 0; i < birthSize; i++) {
        birthIdx = birth[i] - START_YEAR;
        deathIdx = death[i] - START_YEAR + 1;		//死亡第二年
        year[birthIdx]++;
        //避免数组越界, 如果death[i]为2000, 则deathIdx为101, year[101]为数组越界
        if (deathIdx < SIZE) {
            year[deathIdx]--;
        }
    }
    for (i = 0; i < SIZE; i++) {
        tmp += year[i];
        if (max < tmp) {
            max = tmp;
            result = i;
        }
    }

    return result + START_YEAR;
}
```



# 目前耗时最短的写法

- 耗时为**32ms**

```c
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <math.h>
#include <limits.h>

#define MMAX(a, b)        ((a) > (b)? (a) : (b))
#define MMIN(a, b)        ((a) < (b)? (a) : (b))

#define BASE_YEAR   1900
#define MAX_LEN     102

//【算法思路】差分问题。注意死亡年份减人，在第二年。
int maxAliveYear(int* birth, int birthSize, int* death, int deathSize){
    int *years = (int *)calloc(MAX_LEN, sizeof(int));

    for(int i = 0; i < birthSize; i++) {
        years[birth[i] - BASE_YEAR]++;
        years[death[i] - BASE_YEAR + 1]--;
    }

    int sum = 0;
    int max = 0;
    int max_year;
    for(int i = 0; i < MAX_LEN; i++) {
        sum += years[i];

        if(sum > max) {
            max = sum;
            max_year  = i + BASE_YEAR;
        }
    }

    return max_year;
}
```



# 前缀和, 差分, 二维前缀和

前缀和是一种重要的**预处理**，能大大降低查询的时间复杂度(以**空间换时间**)。我们可以简单理解为“数列的前 n 项的和”。

简单的说, **前缀和: 数组B中每一项`B[i]` 保存 A 中 `[0…i]` 的和；**

类似的概念还有

-  **后缀和: 数组B中每一项`B[i]` 保存 A 中 `[i…n-1]` 的和；**
-  **前缀积: 数组B中每一项`B[i]` 保存 A 中 `[0…i]` 的和；**
-  **后缀积: 数组B中每一项`B[i]` 保存 A 中 `[i…n-1]` 的和；**
-  **差分: $d(n) = a[n] - a[n-1]$, 可存储每一步的操作**

**差分 + 前缀和**, 可直接查询每一个节点的状态

# 总结

| 方法      | 提交结果 | 运行时间 | 内存消耗 | 语言 |
| :-------- | :------- | :------- | :------- | :--- |
| 思路一    | 通过     | 104 ms   | 7 MB     | C    |
| 13 分钟前 | 通过     | 48 ms    | 6.8 MB   | C    |

- 根据上述 leetcode 的结果来看, 思路二明显优于思路一
- 思路一便是无脑双重循环, 代码复杂度为$O(n^2)$
- 思路二采用的是 **差分+前缀和** 的方法
- 最少耗时代码的思路同样是这种思路,  耗时为 **32ms**
- 两种方法产生耗时差可能的原因是, 思路二中, 为避免出现2000年死亡这种边界条件导致数组越界, **每次都要进行一次判断**,  **最少耗时思路则记录了2001年的数据, 确保不会数组越界, 少了每一次的判断耗时**



# 参考资料

[前缀和 & 差分](https://oi-wiki.org/basic/prefix-sum/)

[前缀和+差分](https://www.jianshu.com/p/fc2c30576e92)

[前缀和、二维前缀和与差分的小总结](https://blog.csdn.net/k_r_forever/article/details/81775899)

[实用算法解析 - 前缀和](https://segmentfault.com/a/1190000022853798)