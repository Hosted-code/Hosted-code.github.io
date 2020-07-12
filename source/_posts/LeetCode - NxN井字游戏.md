---
title: LeetCode - N X N 井字游戏
categories:
  - Leetcode
tags:
  - LeetCode
  - 编码
date: 2020-07-09 21:05:21
---

# 题目

来源：https://leetcode-cn.com/problems/valid-tic-tac-toe-state

用字符串数组作为井字游戏的游戏板 board。当且仅当在井字游戏过程中，玩家有可能将字符放置成游戏板所显示的状态时，才返回 true。

该游戏板是一个 3 x 3 数组，由字符 " "，"X" 和 "O" 组成。字符 " " 代表一个空位。

以下是井字游戏的规则：

玩家轮流将字符放入空位（" "）中。
第一个玩家总是放字符 “X”，且第二个玩家总是放字符 “O”。
“X” 和 “O” 只允许放置在空位中，不允许对已放有字符的位置进行填充。
当有 3 个相同（且非空）的字符填充任何行、列或对角线时，游戏结束。
当所有位置非空时，也算为游戏结束。

如果游戏结束，玩家不允许再放置字符。

```
示例 1:
输入: board = ["O  ", "   ", "   "]
输出: false
解释: 第一个玩家总是放置“X”。

示例 2:
输入: board = ["XOX", " X ", "   "]
输出: false
解释: 玩家应该是轮流放置的。

示例 3:
输入: board = ["XXX", "   ", "OOO"]
输出: false

示例 4:
输入: board = ["XOX", "O O", "XOX"]
输出: true
```

说明:

- 游戏板 board 是长度为 3 的字符串数组，其中每个字符串 board[i] 的长度为 3。
- `board[i][j] `是集合` {" ", "X", "O"} `中的一个字符。 

# 思路

```c
//判断谁赢了
char Check(char **board, int size)
{
    int i, j;
    int value, rearValue;
    //行列
    for (i = 0; i < size; i++) {
        value = 0;
        rearValue = 0;
        for (j = 0; j < size; j++) {
            if (board[i][j] == 'X') {
                value++;
            } else if (board[i][j] == 'O') {
                value--;
            }
            if (board[j][i] == 'X') {
                rearValue++;
            } else if (board[j][i] == 'O') {
                rearValue--;
            }
        }
        if ((value == size) || (rearValue == size)) {
            return 'X';
        } else if ((value == (0-size)) || (rearValue == (0-size))) {
            return 'O';
        }
    }
    //斜对角线
    value = 0;
    rearValue = 0;
    for (i = 0; i < size; i++) {
        if (board[i][i] == 'X') {
            value++;
        } else if(board[i][i] == 'O') {
            value--;
        }
        if (board[i][size-i-1] == 'X') {
            rearValue++;
        } else if (board[i][size-i-1] == 'O') {
            rearValue--;
        }
    }
    if ((value == size) || (rearValue == size)) {
        return 'X';
    } else if ((value == (0-size)) || (rearValue == (0-size))) {
        return 'O';
    } else {
        return 'C';
    }
}

bool validTicTacToe(char ** board, int boardSize)
{
    int countX = 0;
    int countO = 0;
    int i, j;
    
    if ((board == NULL) || (boardSize <= 0)) {
       return false;
    }

    for (i = 0; i < boardSize; i++) {
        for (j = 0; j < boardSize; j++) {
            if (board[i][j] == 'X') {
                countX++;
            } else if (board[i][j] == 'O') {
                countO++;
            } else if (board[i][j] == ' ') {
            } else {			//board中落下其他字符, 直接报错, 但这个也可以在外部判断
                return false;
            }
        }
    }
    // 正常情况: countO <= countX <= countO+1, int => countX == countO || countX == countO + 1
    if ((countX != countO) && (countX != countO + 1)) {
        return false;
    }
    // 不能有一方赢了另一方还继续下的情况, X赢, countX == countO+1; O赢, countX==countO
    c = Check(board, boardSize);
    if ((c == 'X') && (countX != countO + 1)) {         //X赢, X落子必多一
        return false;
    } else if ((c == 'O') && (countX != countO)) {      //O赢, XO落子数必一致
        return false;
    }

    return true;
}
```



# 思路二

- 此为该题耗时最短的推荐解法

```c
bool is_win_x(char **board, int boardSize, char x) {
    int j;
    for (int i = 0; i < boardSize; i++) {
        for (j = 0; j < boardSize; j++) {
            if (board[i][j] != x) {		//不符合预期结果的直接结束循环
                break;
            }
        }
        if (j == boardSize) {
            return true;
        }

        for (j = 0; j < boardSize; j++) {
            if (board[j][i] != x) {
                break;
            }
        }
        if (j == boardSize) {
            return true;
        }
    }

    for (j = 0; j < boardSize; j++) {
        if (board[j][j] != x) {
            break;
        }
    }
    if (j == boardSize) {
        return true;
    }

    for (j = 0; j < boardSize; j++) {
        if (board[boardSize - j - 1][j] != x) {
            break;
        }
    }
    if (j == boardSize) {
        return true;
    }

    return false;
}

bool validTicTacToe(char ** board, int boardSize){
    int x_num = 0;
    int o_num = 0;

    for (int i = 0; i < boardSize; i++) {
        for (int j = 0; j < boardSize; j++) {
            if (board[i][j] == 'O')
                o_num++;
            else if (board[i][j] == 'X')
                x_num++;
        }
    }

    if ((o_num != x_num) && (x_num != (o_num + 1)))
        return false;

    if (o_num == x_num) {
        if (is_win_x(board, boardSize, 'X') == true){
            return false;
        }
        return true;
    }else {
        if (is_win_x(board, boardSize, 'O') == true){
            return false;
        }
        return true;
    }
}
```

# 总结

| 提交时间 | 提交结果 | 运行时间 | 内存消耗 | 语言 |
| :------- | :------- | :------- | :------- | :--- |
| 几秒前   | 通过     | 0 ms     | 5.2 MB   | C    |

- 可能出问题了吧, 0ms 跑完
- 两种解法思路大体一致, 执行流程不同的是**胜负判断函数**
- 思路二判胜负函数中, 直接传入判断赢的对象, 在2N+2的情况里, **遇到与预期不符的情况直接跳出循环, 减少不必要的循环次数, 以及后续的判断也更简洁**

- 思路没什么好说的, 主要是异常判断和胜负判断
  - **异常判断**
    - 参数判断
    - X先行,  轮流落子, 则`countX=countO`, `countX = countO+1` 异常即为判断
    - 一方赢了之后另一方禁止继续落子
  - **胜负判断**, 目标均为同类落子
    - N横, `board[i][0], board[i][1],...,board[i][n]`
    - N竖, `board[0][i], board[1][i],...,board[n][i]`
    - 对角线, `board[i][i]`
    - 斜对角线, `board[i][n-i-1]`

