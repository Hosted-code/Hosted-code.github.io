---
title: Linux权限相关
categories:
  - Linux
tags:
  - Linux
  - Capabilities
abbrlink: 4220703012
date: 2020-06-25 09:36:51
updated: 2020-06-27 19:47:56
---

# setuid

## 从passwd说起

```bash
hosted@Desktop:~$ l /etc/passwd /etc/shadow /usr/bin/passwd
-rw-r--r-- 1 root root 1.6K Mar  9 11:09 /etc/passwd
-rw-r----- 1 root shadow 1026 Mar  9 11:13 /etc/shadow
-rwsr-xr-x 1 root root  59K Mar 23  2019 /usr/bin/passwd
```

- 要修改, 需通过 `passwd` 命令修改 `/etc/passwd`, `/etc/shadow`
  - `/etc/passwd`, 只有属组root有w权限
  - `passwd` 命令root和普通用户都可以执行
  - `passwd` 命令权限为rws, **设置了setuid**, **使其以命令属主的名义执行**
  - 普通用户执行 `passwd` 命令时, euid变为passwd的属主root, 去修改 `/etc/passwd`
- `setuid`, 让执行该命令的用户以该命令拥有者的权限去执行

## 有什么问题? 提权

- 可能误设setuid导致可执行文件实现提权
- 普通用户通过vi编辑自己无权访问(r/w)的文件, 会报 **Permission Denied**
- 普通用户尝试kill掉root启动的进程, 会报错, **Operation not permitted**
- 这是合理的设置, 普通用户权限会被限制
- 但正如上述passwd, 以及ping命令来说, 某些场景下一些命令是普通用户也需要进行的, 因此被赋予了setuid
```bash
hosted@Desktop:~$ sudo find / -perm /u=s
[sudo] password for hosted: 
/bin/fusermount
/bin/mount
/bin/ping
/bin/su
/bin/umount
...
```
- 但若是setuid被滥用了, 比如vi, 比如kill, 比如find
  - 给vi赋予setuid, 因为属主是root, 普通用户执行vi便以root的身份去执行, 可进行任意文件的读写操作
  - 给kill赋予setuid, 普通用户执行kill, 就有了root的身份, 可以kill掉任何进程
  - 给find赋予setuid, `-exec` 便可以以root的身份执行命令

<!-- more -->

## SetUID的使用

- setuid只对可执行文件有效, 有 `x`, 没有 `x` 权限, 设置setuid会被标记为 `S`
- 用户要对该文件有执行权限
  - 无法执行, setuid不会生效
  - 执行过程中, setuid生效以属主身份执行
- setuid只在执行过程中有效, 执行完毕, 身份也随之消失
- 防范setuid滥用
  - 敏感目录严格控制写权限
  - 谨慎授予setuid的进程
  - 敏感分区禁用setuid
    - 存放数据, 用来备份的分区等
    - `mount -o remount nosuid /usr1`, 这种是临时禁用
    - `/etc/fstab`, default后加**nosuid**, 然后重新挂载

- root执行属主为普通用户, 设置setuid的可执行文件会怎样

# Linux Cap能力

## 从ping开始谈起

- ping 同样具有setuid

```bash
hosted@Desktop:~$ l /bin/ping
-rwsr-xr-x 1 root root 63K Mar 10  2017 /bin/ping
hosted@Desktop:~$ chmod u-s /bin/ping
hosted@Desktop:~$ ls -l /bin/ping
-rwxr-xr-x 1 root root 64424 Mar 10  2017 /bin/ping
hosted@Desktop:~$ ping 127.0.0.1 -c 4
ping: socket: Operation not permitted
```
- 去掉ping的suid, ping出现报错, **socket: Operation not permitted**
- ping只是需要socket的权限, 就将root的权限临时给它, 这样带来了**安全隐患**
  - 只是需要**RAW套接字建立必要ICMP数据包**，除此之外的其它root权限对这个程序都是没有必要的
- 大多数情况下我们只是需要一小部分特权, 但是使用suid, 却可以拥有root的全部权限. 这样一旦文件存在漏洞, 极有可能被利用, 成功被提权, 以root身份执行其他操作, 因此**suid某种程度上增加了攻击面**
- suid这种权限控制方法有点粗糙, 因此从kernel 2.2开始, linux实现了一种新机制Capabilities, 对权限进行更**精细的控制**
  - 本质上就是将内核调用分门别类，具有相似功能的内核调用被分到同一组中
  - 将root权限细分为不同的领域, 划分能力, 分别启用禁用, 在进行特权操作时, 判别该领域能力是否启用, 并以此决定能否执行该特权操作
- 回到ping命令上来, 收回ping的suid权限, ping报错socket没有操作权限, 那么给ping加上socket相关能力 `cap_net_raw` 试一下
  - `ping` 需要使用raw套接字, 构建icmp包
  - `cap_net_raw`, 允许使用原始(raw)套接字
```bash
hosted@Desktop:~$ sudo setcap cap_net_raw+ep /bin/ping
[sudo] password for hosted: 
hosted@Desktop:~$ getcap /bin/ping
/bin/ping = cap_net_raw+ep
hosted@Desktop:~$ ping 127.0.0.1
PING 127.0.0.1 (127.0.0.1) 56(84) bytes of data.
64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.208 ms
64 bytes from 127.0.0.1: icmp_seq=2 ttl=64 time=0.198 ms
```
- 相比setuid, 他只是**具有必要的特权, 最大化程度上减少了系统的攻击面**
- 能力这种, 也是需要只满足必要的能力, **能力最小化**, 若能力不做限制, 集齐38种能力, 那和不受限制也没什么区别

## 能力集

- **添加能力**, `sudo setcap cap_net_raw+ep /bin/ping`
  - 此处添加能力为**文件能力**, 具体看下文
  - `+`, 为添加指定能力, `-`, 为将指定能力从能力集中移除, `=`, 指定能力
  - `eip`, 为linux中的三个能力集, **Effective**, **Inheritable** 和 **Permitted**
  - `-r`, 为清除能力
- **查看能力**
  - `getcap /bin/ping`
  - `cat /proc/{pid}/status | grep Cap`, 包含进程的五个能力集信息, 通过16进制展示
  - `capsh --decode=302b`, 根据得到的16进制数字查看解码出来的cap能力
```bash
hosted@Desktop:~$ cat /proc/869/status | grep Cap
CapInh:	0000000000000000
CapPrm:	0000001fffffffff
CapEff:	0000001fffffffff
CapBnd:	0000001fffffffff
hosted@Desktop:~$ capsh --decode=302b
0x000000000000302b=cap_chown,cap_dac_override,cap_fowner,cap_kill,cap_net_admin,cap_net_raw
```

- `man capabilities`, 查看能力集相关, 随着内核版本的更新, 截止到4.4.0, cap能力目前共支持38种能力
  - 0~37, 最大能力值则为 `0x3fffffffff`
  - 具体对应位可在该文件查看, `/usr/include/linux/capability.h`
    - ubuntu 18.04.2 LTS存放在上述路径
    - 18.04.3 LTS在上述路径下不存在该文件, find后, 该文件存放在该路径下 `/usr/src/linux-headers-5.0.0-23/include/uapi/linux/capability.h`
- **Capabilities**是细分到线程的，即每个线程可以有自己的capabilities。而完整的capabilities实现，除了对线程的capabilities具有以下相关功能：
  - 对线程(进程)的特权操作，内核续检查其该项特权能力是否启用的
  - 内核提供系统调用，用于获取或修改线程(进程)的能力
  - 文件系统应支持对于**文件能力**的支持, 文件能力在内核2.6.24之后完成支持
    - 能力机制可附加在可执行文件中
    - 文件类型

以下，将分别介绍线程（进程）的capabilities和文件的capabilities

## 线程(进程)能力

- 进程中共有四种能力集合
- 上述章节有提到查看进程能力集的方法
  - `cap /proc/{pid}/status | grep Cap`, 该种方法可查到五种能力集的数值, 需通过capsh 解码为人类可读模式
  - `getpcaps {pid}`, 结果为人类可读的

```bash
hosted@Desktop:~$ ps au
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
hosted      46  0.0  0.0  18396  4832 pts/0    Ss   09:40   0:06 -bash
hosted      99  0.0  0.0  17504  3636 pts/1    Ss   09:42   0:06 -bash
root       869  0.0  0.0  11504   548 pts/1    S    12:40   0:00 nc -lp 5555
root      1224  0.0  0.0  16520  1664 pts/1    S    15:02   0:00 su -
root      1225  0.0  0.0  16924  3420 pts/1    S    15:02   0:00 -su
hosted    1747  0.0  0.0  17380  1912 pts/0    R    19:46   0:00 ps au
hosted@Desktop:~$ getpcaps 869
Capabilities for `869`: = cap_chown,cap_dac_override,cap_dac_read_search,cap_fowner,cap_fsetid,cap_kill,cap_setgid,cap_setuid,cap_setpcap,cap_linux_immutable,cap_net_bind_service,cap_net_broadcast,cap_net_admin,cap_net_raw,cap_ipc_lock,cap_ipc_owner,cap_sys_module,cap_sys_rawio,cap_sys_chroot,cap_sys_ptrace,cap_sys_pacct,cap_sys_admin,cap_sys_boot,cap_sys_nice,cap_sys_resource,cap_sys_time,cap_sys_tty_config,cap_mknod,cap_lease,cap_audit_write,cap_audit_control,cap_setfcap,cap_mac_override,cap_mac_admin,cap_syslog,cap_wake_alarm,cap_block_suspend+ep
hosted@Desktop:~$ getpcaps 46
Capabilities for `46`: =
```
- 未专门进行能力值设置的进程, 一般都根据特权与否来划分能力值
  - 特权进程**基本为全能力**, 受系统边界能力 `cap_bset` 限制, 此时root进程能力等于系统边界能力
  - 普通进程为0能力, 不能进行任何特权操作

- `cap_bset` 不属于进程能力, 其为系统边界能力(系统完整能力), 任何进程能力均小于等于 `cap_bset`
  - 能力边界集(capability bounding set)是系统中所有进程允许保留的能力
  - 如果在能力边界集中不存在某个能力，那么**系统中的所有进程都没有这个能力，即使以超级用户权限执行的进程也一样**。
  - 查看边界值: `cat /proc/sys/kernel/cap_last_cap`, 查看边界值, `sysctl -a`
  - root用户可以向能力边界集中写入新的值来修改系统保留的能力。但是要注意，root用户能够从能力边界集中删除能力，却不能再恢复被删除的能力，只有init进程能够添加能力。通常，一个能力如果从能力边界集中被删除，只有系统重新启动才能恢复。

- 四种进程能力
  - **`Permitted`**, 是一种**规定**, 描述进程所能拥有的**能力上限**, 是Inheritable和Effective的超集, 一个进程在Permitted集合中丢失一个能力，它无论如何不能再次获取该能力(除非特权用户再次赋予它)
  - **`Effective`**, 进程有效能力, **进行特权操作是实际进行判别的能力集**
    - 禁用能力时, `Permitted` 为永久禁止, 需要时只能特权用户再次赋予
    - `Effective` 为临时禁止, 需要时可从 `Permitted` 启用
  - **`Inheritable`**, 执行 `exec()` 系运行其他命令时，能够被新命令**继承的能力**
    - 该能力集并不会自动继承给新进程, 即不会自动添加到新进程的 `Effective` 中
    - 只会影响新进程的 `Permitted` 集合, 下文有提到能力继承
  - **`Ambient`**, **能力掩码**, 4.3之后新增加的一种能力集
    - `Permitted` 和 `Inheritable` 未设置的, `Ambient` 也不能设置, `pA < pP & pI`
    - `Permitted` 或 `Inheritale` 某能力关闭, `Ambient` 也随之关闭
    - 用户从特权用户到非特权用户后, `Ambient` 被清除
    - `ambient` 解决非root用户使用 `exec` 执行一个程序时候如何保留权限的问题。执行 `exec` 的时候，`cap_ambient` 会被添加到 `cap_permitted` 中，同时设置到 `cap_effective` 中。
    - `ambient` 的好处显而易见，举个例子，如果你将 `CAP_NET_ADMIN` 添加到当前进程的 `Ambient` 集合中，它便可以通过 `fork()` 和 `execve()` 调用 shell 脚本来执行网络管理任务，因为 `CAP_NET_ADMIN` 会自动继承下去。

```
贴man手册原文
Ambient (since Linux 4.3):
	This  is a set of capabilities that are preserved across an execve(2) of a program that is not privileged.  The ambient capability set obeys the invariant that no capability can ever be ambient if it is not both permitted and inheritable.
	The ambient capability set can be directly modified using prctl(2).  Ambient capabilities are automatically lowered if either of the corresponding permitted or inheritable capabilities is lowered.
	Executing a program that changes UID or GID due to the set-user-ID or set-group-ID bits or executing a program that has any file capabilities set will clear the ambient set.  Ambient capabilities are added to the permitted set and assigned to the effective set when execve(2) is called.

针对非特权进程execve的能力集
prctl可以直接设置该能力集, permitted, inheritableg关闭某项能力, ambient也随之关闭
setuid, setgid或有任何文件能力, Ambient集合会被清空, 
```

## 文件能力

- 上述通过`setcap` 赋予 `ping` 能力, 便是给可执行文件附加能力
  - `setcap` 一般用于二进制可执行文件。 `setcap` 用于脚本文件时无效
- 文件能力，保存在文件扩展属性中。修改这些扩展属性，需要具有 `CAP_SETFCAP` 的能力。
- **文件与线程的 `capabilities`，共同决定了通过 `exec` 运行该文件后的 `capabilities`**。
- 文件的能力，需要 **文件系统的支持**。如果 **文件系统使用了 `nosuid` 选项进行挂载，那么文件的 `capabilities` 将被忽略。**
- 文件能力包含三种
  - **Permitted**, 进程执行时, 该能力与线程的cap_bset做与运算, 结果加入进程的 `Permitted` 能力中
  - **Inheritable**, 该能力与进程中的 `Inheritable` 能力做与运算, 以确定进程在执行`execve`后新进程的 `Inheritable` 能力
  - **Effective**, 文件能力**标志位**
    - 根据 man 手册提到的, 文件的 `effective` 是**一个bit, 不是一个集合**, 如果设置为开启，那么在执行 `execve` 函数后，`Permitted` 集合中新增的 `capabilities` 会自动出现在进程的 `Effective` 集合中。
    - 按 `setcap` 的使用来说, `sudo setcap cap_net_raw+p /bin/ping`, 只给 `permitted` 添加 `cap_net_raw` 能力即可
```
贴man手册原文
Effective:
	This  is  not a set, but rather just a single bit.  If this bit is set, then during an execve(2) all of the new permitted capabilities for the thread are also raised in the effective set.  If this bit is not set, then after an execve(2), none of the new permitted capabilities is in the new effective set.
	Enabling the file effective capability bit implies that any file permitted or inheritable capability that causes a thread to acquire the corresponding  permitted  capability  during  an execve(2) (see the transformation rules described below) will also acquire that capability in its effective set.  Therefore, when assigning capabilities to a file (setcap(8), cap_set_file(3), cap_set_fd(3)), if we specify the effective flag as being enabled for any capability, then the effective flag must  also  be specified as enabled for all other capabilities for which the corresponding permitted or inheritable flags is enabled.

该位开启, permitted 能力加入进程Effective能力集中, 该位关闭, 没有新的 permitted 能力加入新的 effective 能力集中
该位的开启表明文件的 permitted 或 inheritable 能力可加入到线程的能力中
```

- 迷惑行为? ping只加了permitted能力集, 进程能力Effective为0, 程序能正常执行
```bash
hosted@Desktop:~$ ls -l /bin/ping
-rwxr-xr-x 1 root root 64424 Mar 10  2017 /bin/ping     #没有suid
hosted@Desktop:~$ getcap /bin/ping
/bin/ping = cap_net_raw+p
hosted@Desktop:~$ sudo setcap -r /bin/ping              #此处清空文件能力, 文件本身没任何能力的会报错
hosted@Desktop:~$ getcap /bin/ping                      #查看文件能力, 未回显即为未设置
hosted@Desktop:~$ ping 127.0.0.1 -c 4                   #没有suid, 没有能力, ping出现报错
ping: socket: Operation not permitted
hosted@Desktop:~$ sudo setcap cap_net_raw+p /bin/ping   #只在permitted添加cap_net_raw能力
hosted@Desktop:~$ getcap /bin/ping
/bin/ping = cap_net_raw+p                               #显示当前只在permitted能力集中有cap_net_raw能力
hosted@Desktop:~$ ls -l /bin/ping
-rwxr-xr-x 1 root root 64424 Mar 10  2017 /bin/ping     #此时还是没有suid
hosted@Desktop:~$ ping 127.0.0.1 -c 4                   #ping 正常执行
PING 127.0.0.1 (127.0.0.1) 56(84) bytes of data.
64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=0.184 ms
64 bytes from 127.0.0.1: icmp_seq=2 ttl=64 time=0.297 ms
64 bytes from 127.0.0.1: icmp_seq=3 ttl=64 time=0.178 ms
64 bytes from 127.0.0.1: icmp_seq=4 ttl=64 time=0.216 ms
hosted@Desktop:~$ ps aux                                #查看ping的进程号
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
...
hosted     113  0.2  0.0  14724  1088 pts/1    S    18:39   0:00 ping 127.0.0.1   #非特权进程, 进程号为113
...
hosted@Desktop:~$ getpcaps 113                          #查看进程能力
Capabilities for `113`: = cap_net_raw+p                 #进程能力中只有permitted中有能力
hosted@Desktop:~$ cat /proc/113/status | grep Cap       #另一种查看能力的方式, 辅证
CapInh:	0000000000000000
CapPrm:	0000000000002000
CapEff:	0000000000000000                                #进程Effective能力为空? 怎么判别过的
CapBnd:	0000001fffffffff
hosted@Desktop:~$ sudo setcap -r /bin/ping              # 再次清空能力
hosted@Desktop:~$ getcap /bin/ping                      
hosted@Desktop:~$ sudo setcap cap_net_raw+e /bin/ping   # 只加个effective
hosted@Desktop:~$ getcap /bin/ping
/bin/ping =
hosted@Desktop:~$ ping 127.0.0.1
ping: socket: Operation not permitted
```

# Cap能力

- `Capability` 用**更小的粒度控制超级管理员权限**,可以避免使用 root 权限。
- 软件开发者应该为二进制文件赋予**最小权限**，而不是使用强大的setuid。
- `Capabilities` 的主要思想在于**分割root用户的特权**，即将root的特权分割成不同的能力，每种能力代表一定的特权操作
- 在4.4 版本中, Linux将root权限划分为38种能力

| Cap能力              | 序号 | 描述                                                         |
| -------------------- | ---- | ------------------------------------------------------------ |
| {% label danger@CAP_CHOWN %}   | 0    | 修改文件属主,  属组, 允许使用 `chown`                        |
| {% label danger@CAP_DAC_OVERRIDE %}     | 1    | 忽略对文件的所有DAC访问限制                                  |
| `CAP_DAC_READ_SEARCH`  | 2    | 忽略所有对读、搜索操作的限制,  `DAC_READ_SEARCH`是`DAC_OVERRIDE`的子集 |
| {% label danger@ CAP_FOWNER %}           | 3    | 忽略文件属主ID必须和进程用户ID相匹配的限制<br>**最后操作的UID,覆盖文件的先前的UID**<br>不覆盖DAC, MAC的限制 |
| `CAP_FSETID`           | 4    | 允许设置文件的 `setuid` 位,  确保在文件被修改后不修改setuid/setgid位<br>当文件被修改后,会清除掉文件的`setuid/setgid`位,而设定`CAP_FSETID`后将保证`setuid/setgid` 位不被清除.但这对 `chown` 函数无用 |
| {% label danger@ CAP_KILL %}           | 5    | 对不属于自己的进程发送信号<br>普通用户要用`/bin/kill`这种绝对路径的方式,而不能用`kill`这种方式 |
| `CAP_SETGID`           | 6    | 允许改变进程的组ID, 允许进程使用setgid,  setgroups函数<br>与文件的sgid无关<br>通过UNIX域套接字传递套接字凭证时伪造GID |
| {% label danger@CAP_SETUID  %}          | 7    | 允许改变进程的用户ID, 允许进程使用setuid函数<br>与文件的suid无关<br>通过UNIX域套接字传递套接字凭证时伪造UID |
| `CAP_SETPCAP`          | 8    | 允许向其他进程转移能力以及删除其他进程的能力<br>**事实上只有init进程可以设定其它进程的能力,而其它程序无权对进程授权**<br>root用户也不能对其它进程的能力进行修改<br>只能对当前进程通过cap_set_proc等函数进行修改,而子进程也会继承这种能力. |
| `CAP_LINUX_IMMUTABLE`  | 9    | 允许修改文件的不可修改(**IMMUTABLE**)和只添加(**APPEND-ONLY**)属性<br>允许普通用户执行`chattr`, 添加以上两个属性<br>**只能对自己的文件授权**(immutable/append-only)权限,对于其它用户的权限LINUX_IMMUTABLE不起作用(root除外) |
| `CAP_NET_BIND_SERVICE` | 10   | 允许绑定到**小于1024**的端口                                 |
| ~~`CAP_NET_BROADCAST`~~    | 11   | 允许网络广播和多播访问<br>事实上它**并没有被应用**,普通用户也可以使用 `ping -b  192.168.0.255` 也发送广播包 |
| `CAP_NET_ADMIN`        | 12   | 允许执行**网络管理任务**:接口,防火墙和路由等                     |
| `CAP_NET_RAW`          | 13   | 使用原始(raw)套接字,  为透明代理绑定任何地址。               |
| `CAP_IPC_LOCK`         | 14   | 允许锁定共享内存片段<br>root和普通用户都可以用`mlock`来锁定内存,区别是root不受ulimit下的锁定内存大小限制,而普通用户会受到影响.<br>锁定内存 (`mlock`(2)，`mlockall`(2)，`mmap`(2)，`shmctl`(2))。 |
| `CAP_IPC_OWNER`        | 15   | 忽略IPC所有权检查<br>允许普通用户读取/更改 root用户创建的权限为600的共享内存(`shmget`)<br>可以修改, 但不可以脱离, 删除共享内存 |
| `CAP_SYS_MODULE`       | 16   | 允许普通用户插入和删除内核模块                               |
| `CAP_SYS_RAWIO`        | 17   | 允许用户打开I/O端口,并读取修改端口数据,一般用 `ioperm/iopl` 函数 |
| `CAP_SYS_CHROOT`       | 18   | 允许使用`chroot()`                                           |
| `CAP_SYS_PTRACE`       | 19   | 允许跟踪任何进程,  使用`ptrace()` <br>默认普通用户不能跟踪任何进程,不包括它自己的进程,<br>CAP_SYS_PTRACE可以帮助普通用户跟踪任何进程. |
| `CAP_SYS_PACCT`        | 20   | 允许配置进程记帐process  accounting<br>要完成进程记帐,要保证有写入文件的权限<br>程序通过``acct`函数,将进程的记帐写入到指定文件中,如果 `acct`函数的参数为`NULL`,则关闭进程记帐. |
| `CAP_SYS_ADMIN`        | 21   | 允许执行系统管理任务,如挂载/卸载文件系统,设置磁盘配额,开/关交换设备和文件等 |
| `CAP_SYS_BOOT`         | 22   | 允许普通用使用`reboot()`函数,  非`reboot`命令             |
| `CAP_SYS_NICE`         | 23   | 允许提升优先级,设置其它进程的优先级                          |
| `CAP_SYS_RESOURCE`     | 24   | 忽略资源限制,  允许普通用户使用setrlimit()来突破ulimit的限制 |
| `CAP_SYS_TIME`         | 25   | 允许改变系统时钟                                             |
| `CAP_SYS_TTY_CONFIG`   | 26   | 允许配置TTY设备                                              |
| `CAP_MKNOD`            | 27   | 允许使用 `mknod` 系统调用                                    |
| `CAP_LEASE`            | 28   | 允许在文件上建立租借锁                                       |
| `CAP_AUDIT_WRITE`      | 29   | 向内核审计日志写记录。                                       |
| `CAP_AUDIT_CONTROL`    | 30   | 启用和禁用内核审计；修改审计过滤器规则；提取审计状态和过滤规则。 |
| `CAP_SETFCAP`          | 31   | 允许在指定的程序上授权能力给其它程序                         |
| `CAP_MAC_OVERRIDE`     | 32   | 忽略MAC访问控制                                              |
| `CAP_MAC_ADMIN`        | 33   | 允许配置MAC或状态改变                                        |
| `CAP_SYSLOG`           | 34   | 允许配置内核syslog,  执行特权 syslog(2) 操作                 |
| `CAP_WAKE_ALARM`       | 35   | 触发将唤醒系统的东西 (设置  CLOCK_REALTIME_ALARM 和 CLOCK_BOOTTIME_ALARM 定时器) |
| `CAP_BLOCK_SUSPEND`    | 36   | 可以阻塞系统挂起(epoll(7)  EPOLLWAKEUP，/proc/sys/wake_lock)的特性。 |
| `CAP_AUDIT_READ`       | 37   | 允许通过一个多播  netlink socket 读取审计日志。              |

# Cap能力继承

- Linux系统中的能力分为两部分，一部分是进程能力，一部分是文件能力，而Linux内核最终检查的是进程能力中的`Effective`。而文件能力和进程能力中的其他部分用来完整能力继承、限制等方面的内容。
- 查看 `capabilities` 的man手册, 其中描述能力继承公式如下

```
公式一: P'(ambient)     = (file is privileged) ? 0 : P(ambient)       //file cap, suid, sgid
公式二: P'(permitted)   = (P(inheritable) & F(inheritable)) | (F(permitted) & cap_bset) | P'(ambient)
公式三: P'(effective)   = F(effective) ? P'(permitted) : P'(ambient)
公式四: P'(inheritable) = P(inheritable)    [i.e., unchanged]       //inheritable不变

说明:
    P	  进程能力, execve前
    P'  进程能力, execve后
    F   文件能力
    cap_bset, 系统能力边界值. 为root进程所具有的所有能力
privileged file 是指有能力或设置suid或sgid的可执行文件
```

- 梳理一下上述的公式
  - 上述公式针对的是 `execve()`, `fork()` 会完整继承父进程的cap能力
  - 文件 `Inheritable` 与进程 `Inheritable` 没关系, 根据**公式四**
  - 文件能力只传递在子进程的 `Permitted` 集合中,  根据**公式二**
  - `Effective` 才是进程特权操作判别的能力集
    - 子进程 `Effective` 才是正式继承
    - 两种方法
      - 子进程手动添加能力, `capset()`
      - 子进程可执行文件, 开启 `Effective` 标志位, 根据**公式三**
  - 想要子进程继承父进程能力, 父进程的 `Inheritable` 和 子进程文件的 `Inheritable` 很关键, 根据**公式二**
  - `Ambient` 是 4.4之后支持的能力集, 在不支持该能力集的时候, 将公式中的 `Ambient` 能力集认作 0 即可

- 普通用户执行了 `execve()`，那么 `Permitted` 和 `Effective` 集合中的 `capabilities` 都会被清空, `Inheritable` 未被清空
  - root切换到普通用户, `Permitted` 和 `Effective` 同样会被清空, 除非设置了 `SECBIT_KEEP_CAPS` 或更宽泛的 `SECBIT_NO_SETUID_FIXUP`
- 普通用户切换root, 现有的P集合拷贝到E集合

{% cq %}
如果一个文件系统的用户ID从0变成非0，那么以下的能力在E集合中清除：CAP_CHOWN, CAP_DAC_OVERRIDE,  CAP_DAC_READ_SEARCH,  CAP_FOWNER,  CAP_FSETID,  CAP_LINUX_IMMUTABLE  (since  Linux  2.2.30),  CAP_MAC_OVERRIDE,  CAP_MKNOD，如果一个文件系统的用户ID从0变成非0，那么在P集合中使能的能力将设置到E集合中。
{% endcq %}

- 想要正确继承能力
  - `fork`, 完整继承父进程能力
  - `exec`, 只有三种情况可以
    - 子进程 **euid是root**
      - 父进程是特权进程, 子进程也必然是root(除非子进程中有降权操作)
      - 父进程是普通进程, 则子进程应是 `setuid-root` 进程
    - 子进程**有文件能力**, 关键是 **`Effective` 启用**, `Inheritable` 能力集包含父进程 `Inheritable` 能力集
    - **`Ambient` 能力**, 此情景下子进程可以是普通可执行文件(没有文件能力, 没有suid)
      - 前文有提到, `Ambient` 的提出就是为了解决非root用户使用 `exec` 执行一个程序时候如何保留权限的问题
      - 此种创景参见上述继承公式, 公式一, 二, 三
      - 子进程可执行文件非 `setuid-root`, 也没有文件能力, 此时子进程继承父进程 `Ambient` 能力集, 根据**公式一**
      - 子进程没有文件能力(fI, fP均为0), 则此时子进程 `Permitted` = `Ambient`, 根据**公式三**
      - 子进程没有文件能力(fE为0), 此此时子进程 `Effective` = `Ambient`, 根据**公式三**
      - 参考man手册关于 `Ambient` 的描述, `Ambient` 可以通过 `prctl` 设置
- 还有一种情况, **子进程是脚本文件**, 而非可执行文件
  - 脚本的话会涉及解释器, 如 `bash, python, perl`
  - 这种情况**实质上进行了两次 `execve`**
  - 因此想要脚本中执行的命令继承到权限, 需要保证解析器, 执行命令也满足上述继承能力的场景
    - 但其实也就只有`euid=root` 和 **文件能力** 两条路
  - 本质上需要**保证整个链路上的权限**


# 参考链接

- [Linux进程控制之uid/euid/suid](https://ivanzz1001.github.io/records/post/linux/2017/11/16/linux-unix_uid)
- [【安全科普】Linux提权——利用可执行文件SUID](https://www.anquanke.com/post/id/86979)
- [Linux setuid与权能介绍 - 细语呢喃](https://www.hrwhisper.me/introduction-to-linux-capability/)
- [[转载] Linux的capability深入分析](https://www.cnblogs.com/iamfy/archive/2012/09/20/2694977.html)
- [Linux Capabilities 简介及使用](http://www.freeoa.net/osuport/sysadmin/linux-capabilities-intro_3313.html)
- [Linux能力(capability)机制的继承](https://www.cnblogs.com/gordon0918/p/5328436.html)
- [Linux的capabilities机制](http://rk700.github.io/2016/10/26/linux-capabilities/)
- [Linux 系统用户](https://jin-yang.github.io/post/linux-capabilities-introduce.html)
- [利用capability特征加强Linux系统安全](https://blog.csdn.net/fivedragon/article/details/676849)