---
title: LeetCode - 满足条件的子序列数目
categories:
  - Leetcode
tags:
  - LeetCode
  - 动态规划
date: 2020-07-24 23:09:34
---

# 题目

链接：https://leetcode-cn.com/problems/coin-change

给定不同面额的硬币 coins 和一个总金额 amount。编写一个函数来计算可以凑成总金额所需的最少的硬币个数。如果没有任何一种硬币组合能组成总金额，返回 -1。

```
示例 1:

输入: coins = [1, 2, 5], amount = 11
输出: 3 
解释: 11 = 5 + 5 + 1
示例 2:

输入: coins = [2], amount = 3
输出: -1
```

 

说明:
你可以认为每种硬币的数量是无限的。



# 思路一

```c
int compare(const void *p1, const void *p2) 
{
    return *(int *)p1 - *(int *)p2;
}

int coinChange(int* coins, int coinsSize, int amount){
    if ((coins == NULL) || (coinsSize < 1) || (amount < 0)) {
        return -1;
    }
    if (amount == 0) {
        return 0;
    }

    int i, j;
    int res = -1;
    
    qsort(coins, coinsSize, sizeof(int), compare);
    
    int *dp = (int *)malloc(sizeof(int) * (amount + 1));
    dp[0] = 0; //base
    for (i = 1; i < amount + 1; i++) {
        dp[i] = amount + 1;    //数组赋值为amount+1, 是无法取到的值
        for (j = 0; j < coinsSize; j++) {
            if (i < coins[j]) { //问题无解, amount小于该面值
                continue;
            }
            if (dp[i - coins[j]] + 1 < dp[i]) {
                dp[i] = dp[i - coins[j]] + 1;
            }
        }
    }

    if (dp[amount] != amount + 1) {
        res = dp[amount];
    }
    free(dp);
    return res;
}
```



# 耗时最短的思路

```c
int cmp(const void *a, const void *b) 
{
    return *(int *)b - *(int *)a;
}

void searchCoin(int *coins, int coinsSize, int i_coin, int sum, int amount, int *result)
{
    int num = amount / coins[i_coin];

    if ((sum + num) >= *result ) {	
        return;
    }

    if (amount % coins[i_coin] == 0) {	//目标金额能整除最大面值的, 最小硬币数必为此种情况
        *result = sum + num;
        return;
    } 
    
    if (i_coin + 1 < coinsSize) {
        for (int i = num; i >= 0; i--) { //减少了循环次数
            if (sum + i >= *result - 1) {
                break;
            }
            searchCoin(coins, coinsSize, i_coin+1, sum + i, amount - i*coins[i_coin], result);
        }
    }
    return;
}

int coinChange(int* coins, int coinsSize, int amount){
    if (coins == NULL || coinsSize <  1) {
        return -1;
    }

    qsort(coins, coinsSize, sizeof(int), cmp);

    int result = amount + 1;
    
    searchCoin(coins, coinsSize, 0, 0, amount, &result);
    
    if (result == amount + 1) {
        return -1;
    }

    return result;
}
```





# 总结

| 提交时间 | 运行时间 | 内存消耗 | 语言 |
| :------- | :------- | :------- | :--- |
| 思路一   | 40 ms    | 9.4 MB   | C    |
| 思路二   | 0 ms     |          | C    |

- 思路一, 思路二核心思路都是动规

- 思路二的拦截条件极其 nice

  