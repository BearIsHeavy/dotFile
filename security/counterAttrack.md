# Prevent

## 确定攻击时间
1. 通过云服务器的提示（如果没有请忽略）
1. 通过`last`命令，或者`cat /var/log/auth.log`文件`last -f /var/log/wtmp`(重点)
1. 使用`history`命令(一般来说黑客都会删除这些记录)

## 确定并且删除相关进程
1. **检查cpu, memory使用情况**
    1. `top`命令查看当前cpu和memory的占用率
    1. 使用`kill`关闭(防止因为cpu和mermory占用过高导致后续操作失败)
1. **查看那些文件会被设置为自启动**
    1. `export VISUAL=vi \ export EDITOR`使用vim为默认编辑器
    1. 使用`crontab -l`查看那些进程会被启动(很多的病毒都会写在这，并且可以通过相关的地址进一步确定病毒文件)
    1. `systemctl list-unit-files --state=enable`查看自启动信息
1. 可以使用`systemctl list-units --type=service`查看相关信息也可以用来锁定病毒的位置
1. **检查ssh_key**
    1. 检查路径 _$HOME/.ssh_ 文件，删除不确定的密钥
    1. 并将用户改为不允许密码登录, 修改 _/etc/ssh/sshd_config_ 文件
1. **利用查看进程状况**
    1.`lsof -i` lsof是一个非常重要的命令(`tldr`命令进行学习)
    1. `tail -f`可以realy-time输出信息
1. 参数查看网络状况，检查端口以及宽带使用状况
    1. `netstat -luptn`用于检查
1. 用于查看目录最近修改情况
    1. `find / -type f -mtime 0`查看攻击时间前后所修改的所有文档
    1. (`sort`,`uniq`相关命令)确定相关目录(注意：有些目录是被系统修改的，所以可以使用`grep`命令进行筛选)后，多多使用`ls -lt`命令根据攻击时间来排序

## 预防攻击的注意事项
1. **ssh_key** 代替 password
1. 严格的权限管理，尤其注意**sudo**(ALL:ALL) __极度不安全__ 的权限管理
1. 注意**apache**的配置，这个地方很容易被网络渗透，以至于导致主机出现问题
1. 伪装成linux系统文件，用于混淆通过时间追踪的手段
1. 伪装成systemctl的启动文件，或者修改某些启动文件，用于同时启动病毒文件(`excect: /path/to/file && /path/to/volunrable/file`),这样就不容易被发现
1. 强化建设`ufw`这一层防火墙
    1. 过滤国外ip
    1. 某些特定端口只允许某些特定ip访问
1. 使用`fail2ban`去拦截默写违反规定的连接
    1. 例如拦截连接次数超过3次，且密码不正确的ssh服务(限制ssh一个ip的登录次数)
        ``` text
        [sshd]
        enabled = true
        port = ssh
        filter = sshd
        logpath = /var/log/auth.log
        maxretry = 3
        bantime = 3600
        ```

## 反攻击的一些策略
1. 强制设置( _read-only_ 模式)文件用于记录相关操作
    1. **注意这些方法在拿到root权限后都可以被删除，只是删除的成本会增加**
    1. 修改 _history-file_ `chattr`属性(只读)
    1. 修改将当前历史记录定期写入 _histroy-file_(`crontabl 1 * * * * * history >> /path/to/file`)
    1. 修改/etc/log/authentic.log文件，设置( _Append_ 属性)

## learning tips
1. `@reboot` key in `crontabl` will be used to run once when the system boots up.
1. `fail2ban`用于防止undistrubuted attack攻击
```shell
sudo ufw status # checkout ufw status
# Enable UFW
sudo ufw enable
# Allow Connection
sudo ufw allow ssh/tcp && sudo ufw allow ssh/udp
# Deny Connection
sudo ufw deny 
# Delete Rules
sudo ufw delete {rule_number}
# Logging
sudo ufw logging on # enable logging, Logs are stored in /var/log/ufw.log
# disable ufw
sudo ufw disable
# ufw default followed by 'allow' 'deny' 'reject'
# for example
sudo ufw default deny incoming # will deny all incoming connecions by default
sudo ufw deault deny outgoing

sudo ufw allow from {ip}
```

