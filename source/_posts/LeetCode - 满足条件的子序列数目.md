---
title: LeetCode - 满足条件的子序列数目
categories:
  - Leetcode
tags:
  - LeetCode
  - 快速幂
  - 双指针
date: 2020-07-21 22:15:34
---

# 题目

链接：https://leetcode-cn.com/problems/number-of-subsequences-that-satisfy-the-given-sum-condition

给你一个整数数组 nums 和一个整数 target 。

请你统计并返回 nums 中能满足其最小元素与最大元素的 和 小于或等于 target 的 非空 子序列的数目。

由于答案可能很大，请将结果对 `10^9 + 7` 取余后返回。

 ```
示例 1：

输入：nums = [3,5,6,7], target = 9
输出：4
解释：有 4 个子序列满足该条件。
[3] -> 最小元素 + 最大元素 <= target (3 + 3 <= 9)
[3,5] -> (3 + 5 <= 9)
[3,5,6] -> (3 + 6 <= 9)
[3,6] -> (3 + 6 <= 9)
示例 2：

输入：nums = [3,3,6,8], target = 10
输出：6
解释：有 6 个子序列满足该条件。（nums 中可以有重复数字）
[3] , [3] , [3,3], [3,6] , [3,6] , [3,3,6]
示例 3：

输入：nums = [2,3,3,4,6,7], target = 12
输出：61
解释：共有 63 个非空子序列，其中 2 个不满足条件（[6,7], [7]）
有效序列总数为（63 - 2 = 61）
示例 4：

输入：nums = [5,2,4,1,7,6,8], target = 16
输出：127
解释：所有非空子序列都满足条件 (2^7 - 1) = 127
 ```


提示：

- `1 <= nums.length <= 10^5`
- `1 <= nums[i] <= 10^6`
- `1 <= target <= 10^6`



# 思路一

```c
//排序
int compare(const void *p1, const void *p2)
{
    return (*(int*)p1 - *(int*)p2);
}

long power(int num, unsigned times) {
    long res = 1;
    long base = num;
    while (times != 0) {
        if (times % 2) {
            res = (res * base) % (1000000000 + 7);
        }
        base = (base * base) % (1000000000 + 7);
        times /= 2;
    }

    return res % (1000000000 + 7);
}

int numSubseq(int* nums, int numsSize, int target){
    int left = 0;
    int right = numsSize - 1;
    int res = 0;
    int mod = power(10, 9) + 7;

    qsort(nums, numsSize, sizeof(int), compare);

    while (left <= right) {
        if (nums[left] + nums[right] > target) {
            right--;
        } else {
            res = (int)((res + power(2, (right-left))) % mod);
            left++;
        }
    }

    return res;
}
```

# 思路二

```c
//排序
int compare(const void *p1, const void *p2)
{
    return (*(int*)p1 - *(int*)p2);
}

int numSubseq(int* nums, int numsSize, int target){
    int mod = 1000000000 + 7;
    int *pow = (int*)malloc(sizeof(int)*numsSize);
    pow[0] = 1;  // 2^0 = 1

    for (int i = 1; i < numsSize; i++) {
        pow[i] = (pow[i-1] << 1) % mod;
    }
    qsort(nums, numsSize, sizeof(int), compare);

    int left = 0;
    int right = numsSize - 1;
    int res = 0;

    while (left <= right) {
        if (nums[left] + nums[right] > target) {
            right--;
        } else {
            res = (int)((res + pow[right-left]) % mod);
            left++;
        }
    }
    free(pow);
    return res;
}
```



# 目前耗时最短的思路

```c
#define MAX_VALUE  1000000007
int cmp(int *p1, int *p2) 
{
    return *p1 - *p2;
}

int numSubseq(int* nums, int numsSize, int target){
    int start, end;
    int loop;
    unsigned long long retCnt = 0;
    int mod[numsSize];
    qsort(nums, numsSize, sizeof(int), cmp);
    memset(mod, 0, sizeof(mod));
    mod[0] = 1;
    for (loop = 1; loop < numsSize; loop++) {
        mod[loop] = mod[loop - 1] * 2;
        mod[loop] %= MAX_VALUE;
    }
    start = 0;
    end = numsSize - 1;
    while(start <= end) {
        if (nums[start] + nums[end] > target) {
            end--;
            continue;
        }
        retCnt += mod[end - start];
        retCnt %= MAX_VALUE;
        start++;
    }

    return (int)retCnt;
}
```





# 总结

| 方法   | 运行时间 | 内存消耗 | 语言    |      |
| :----- | :------- | :------- | :------ | ---- |
| 思路一 | 通过     | 176 ms   | 13.5 MB | C    |
| 思路二 | 通过     | 168 ms   | 15.4 MB | C    |

