---
title: LeetCode - 不相交的线
categories:
  - Leetcode
tags:
  - LeetCode
  - 编码
  - 动态规划
date: 2020-07-18 11:27:32
---

# 题目

来源: https://leetcode-cn.com/problems/uncrossed-lines/
我们在两条独立的水平线上按给定的顺序写下 `A` 和 `B` 中的整数。

现在，我们可以绘制一些连接两个数字 `A[i]` 和 `B[j]` 的直线，只要 `A[i] == B[j]`，且我们绘制的直线不与任何其他连线（非水平线）相交。

以这种方法绘制线条，并返回我们可以绘制的最大连线数。

 

**示例 1：**

**<img src="https://assets.leetcode-cn.com/aliyun-lc-upload/uploads/2019/04/28/142.png" alt="img" style="zoom: 25%;" />**

```
输入：A = [1,4,2], B = [1,2,4]
输出：2
解释：
我们可以画出两条不交叉的线，如上图所示。
我们无法画出第三条不相交的直线，因为从 A[1]=4 到 B[2]=4 的直线将与从 A[2]=2 到 B[1]=2 的直线相交。
```

**示例 2：**

```
输入：A = [2,5,1,2,5], B = [10,5,2,1,5,2]
输出：3
```

**示例 3：**

```
输入：A = [1,3,7,1,7,5], B = [1,9,2,5,1]
输出：2
```

 

**提示：**

1. `1 <= A.length <= 500`
2. `1 <= B.length <= 500`
3. `1 <= A[i], B[i] <= 2000`

 

# 思路

```c
#define MAX(a,b) ((a)>(b)?(a):(b))

int maxUncrossedLines(int* A, int ASize, int* B, int BSize){
    int i, j;
    int **dp = NULL;

    if ((A == NULL) || (B == NULL) || (ASize < 1) ||(ASize > 500) || (BSize < 1) || (BSize > 500)) {
        return -1;
    }

    dp = (int **)malloc(sizeof(int*) * (ASize+1));
    for (i = 0; i < ASize + 1; i++) {
        dp[i] = (int*)malloc(sizeof(int) * (BSize+1));
        memset(dp[i], 0, sizeof(int) * (BSize+1));
    }

    for (i = 1; i < ASize + 1; i++) {
        for (j = 1; j < BSize + 1; j++) {
            if (A[i-1] == B[j - 1]) {
                dp[i][j] = dp[i-1][j-1] + 1;
            } else {
                dp[i][j] = MAX(dp[i-1][j], dp[i][j-1]);
            }
        }
    }

    for (i = 0; i < ASize+1; i++) {
        free(dp[i]);
        dp[i] = NULL;
    }
    free(dp);
    dp = NULL;

    return dp[i][j];
}
```





# 耗时最短的思路



```c
/* 本质上就是求最长公共子序列 动态规划
 * dp[i][j]表示A的前i个数到B的前j个数的最大连线数，最后要求的是dp[ASize][BSize]
 * dp[0][j]与dp[i][0]则分别表示空集与另一个数集的最大连线数，应都赋0
 * 状态转移方程为 A[i] == B[j]时 dp[i + 1][j + 1] = dp[i][j] + 1
 * 不相等时dp[i + 1][j + 1] = max(dp[i][j + 1], dp[i + 1][j])
*/
int maxUncrossedLines(int* A, int ASize, int* B, int BSize){
    int **dp = (int**)malloc(sizeof(int*) * (ASize + 1));
    int i, j;
    for(i = 0; i < ASize + 1; i++)
        dp[i] = (int*)malloc(sizeof(int) * (BSize + 1));
    for(i = 0; i < ASize + 1; i++)
        dp[i][0] = 0;
    for(j = 1; j < BSize + 1; j++)
        dp[0][j] = 0;
    for(i = 0; i < ASize; i++)
        for(j = 0; j < BSize; j++)
        {
            if(A[i] == B[j])
                dp[i + 1][j + 1] = dp[i][j] + 1;
            else
                dp[i + 1][j + 1] = max(dp[i][j + 1], dp[i + 1][j]);
        }
    return dp[ASize][BSize];
}
int max(int a, int b){
    return a > b ? a : b;
}
```



# 总结

| 提交结果 | 运行时间 | 内存消耗 | 语言 |
| :------- | :------- | :------- | :--- |
| 通过     | 8 ms     | 8.6 MB   | C    |

思路总结

- 设函数 `f(x,y)` 标识 `A` 的前 `x`个数字和 `B` 的前 `y`个数字，能绘制出的**最大连接数**。假设 `A、B` 都是从下标1开始。
- `f(0,0) = 0, f(0,y) = 0, f(x,0) = 0`
- 线不想交**, 顺序相对一致**
  - 两条不想交的线, $A[x_1], B[y_1]$ 和 $A[x_2], B[y_2]$
  - $x_1 < x_2 且 y_1 < y_2$ 或 $x_1 > x_2 且 y_1 > y_2$
- `A[x], B[y]`, 状态转移方程
  - `A[x] == B[y]`,  `f(x, y) = f(x-1, y-1)+1`, 相等, 新增加一条, 最大连接数+1
  - `A[x]!= B[y]`,  `max(f(x-1,y), f(x,y-1))`,  
    - `A[x], B[y]`不等, 必然不可能都参与连线, 若都与其他点相连, 一定会出现直线相交(与`A(x)相交的点必然小于B(y), 与B(y)相交的点必然小于A(x)`)
- `dp` 为记忆数组, 记忆之前子问题的结果

