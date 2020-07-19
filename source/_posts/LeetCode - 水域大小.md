---
title: LeetCode - N X N 井字游戏
categories:
  - Leetcode
tags:
  - LeetCode
  - 编码
  - 树
date: 2020-07-19 09:05:14
---

# 题目

来源：https://leetcode-cn.com/problems/pond-sizes-lcci

你有一个用于表示一片土地的整数矩阵land，该矩阵中每个点的值代表对应地点的海拔高度。若值为0则表示水域。由垂直、水平或对角连接的水域为池塘。池塘的大小是指相连接的水域的个数。编写一个方法来计算矩阵中所有池塘的大小，返回值需要从小到大排序。

示例：

```
输入：
[
  [0,2,1,0],
  [0,1,0,1],
  [1,1,0,1],
  [0,1,0,1]
]
输出： [1,2,4]
```



提示：

- `0 < len(land) <= 1000`
- `0 < len(land[i]) <= 1000`



# 思路

```c
#define MAXSIZE  1000

int dfs(int** land, int landSize, int* landColSize, int x, int y)
{
    //八个方向
    int path[][2] = {{-1,-1}, {0,-1}, {1,-1}, {-1,0}, {1,0}, {-1,1}, {0,1},{1,1}};
    int dx, dy;
    if (x < 0 || x > landSize - 1 || y < 0 || y > landColSize[x] - 1 || land[x][y] != 0) {
        return 0;
    }

    land[x][y] = -1;	//标记访问
    int res = 1;  //初始大小为1

    for (int n = 0; n < 8; n++) {
        dx = x + path[n][0];
        dy = y + path[n][1];
        res += dfs(land, landSize, landColSize, dx, dy);
    }

    return res;
}

int compare(const void *p1, const void *p2)
{
    return (*(int*)p1 - *(int*)p2);
}

int* pondSizes(int** land, int landSize, int* landColSize, int* returnSize)
{
    int *pool = (int*)malloc(sizeof(int) * MAXSIZE * MAXSIZE);
    int cnt = 0;
    int size;
    
    for (int i = 0; i < landSize; i++) {
        for (int j = 0; j < landColSize[i]; j++) {
            if (land[i][j] != 0) {
                continue;
            }
            size = dfs(land, landSize, landColSize, i, j);
            if (size > 0) {
                pool[cnt] = size;
		        cnt++;
            }
        }
    }

    qsort(pool, cnt, sizeof(int), compare);
    *returnSize = cnt;

    return pool;
}
```



# 耗时最短的解法

```c
/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
#define MAX_NUM 10000
#define MAX_X 1001
#define MAX_Y 1001
#define MAX_RST_NUM 50000

typedef struct {
    int x;
    int y;
} Info;

Info g_queue[MAX_NUM];
int g_head;
int g_tail;
int g_rst[MAX_RST_NUM];
int g_rstNum;

void Init()
{
    g_head = 0;
    g_tail = 0;
    memset(g_rst, 0, sizeof(g_rst));
    g_rstNum = 0;
}

void ReInit()
{
    g_head = 0;
    g_tail = 0;
}

#define PARA_VALID(value, min, max) ((value >= min) && (value < max))
void Push(int** land, int i, int j, int iMax, int jMax)
{
    if (!PARA_VALID(i, 0, iMax)) {
        return;
    }

    if (!PARA_VALID(j, 0, jMax)) {
        return;
    }

    if (land[i][j] != 0) {
        return;
    }

    g_queue[g_tail].x = i;
    g_queue[g_tail].y = j;
    g_tail++;
    land[i][j] = 1;
    g_rst[g_rstNum]++;
    return;
}

int Pop(int *i, int *j)
{
    if (g_head == g_tail) {
        return -1;
    }

    *i = g_queue[g_head].x;
    *j = g_queue[g_head].y;
    g_head++;
    return 0;
}

void CalcRst(int** land, int iStart, int jStart, int iMax, int jMax)
{
    int i, j;

    Push(land, iStart, jStart, iMax, jMax);

    while (Pop(&i, &j) != -1) {
        Push(land, i - 1, j - 1, iMax, jMax);
        Push(land, i - 1, j, iMax, jMax);
        Push(land, i - 1, j + 1, iMax, jMax);
        Push(land, i + 1, j - 1, iMax, jMax);
        Push(land, i + 1, j, iMax, jMax);
        Push(land, i + 1, j + 1, iMax, jMax);
        Push(land, i, j - 1, iMax, jMax);        
        Push(land, i, j + 1, iMax, jMax);
    }

    g_rstNum++;
    return;
}

int cmpare(const void *x, const void *y)
{
    return ((*(int*)x) - (*(int*)y));
}

int* pondSizes(int** land, int landSize, int* landColSize, int* returnSize){
    int i, j;

    Init();
    for (i = 0; i < landSize; i++) {
        for (j = 0; j < landColSize[0]; j++) {
            if (land[i][j] != 0) {
                continue;
            }

            ReInit();
            CalcRst(land, i, j, landSize, landColSize[0]);
        }
    }

    qsort(g_rst, g_rstNum, sizeof(int), cmpare);

    int *rst;

    rst = malloc(g_rstNum * sizeof(int));
    memcpy(rst, g_rst, g_rstNum * sizeof(int));
    *returnSize = g_rstNum;
    return rst;
}
```





# 总结

| 方法     | 运行时间 | 内存消耗 | 语言 |
| -------- | :------- | :------- | ---- |
| 思路一   | 252 ms   | 20.8 MB  | C    |
| 耗时最短 | 200ms    |          | C    |

**朝8个方向探索, 访问过的进行标记**