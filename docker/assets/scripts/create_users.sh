# --------
#
# Create users
#
# --------
# Linux
groupadd -g 1000 user1000
useradd -u 1000 -m -d '/home/user1000' -g user1000 user1000
chown -R 1000:1000 /home/user1000

groupadd -g 1001 user1001
useradd -u 1001 -m -d '/home/user1001' -g user1001 user1001
chown -R 1001:1001 /home/user1001

groupadd -g 1002 user1002
useradd -u 1002 -m -d '/home/user1002' -g user1002 user1002
chown -R 1002:1002 /home/user1002

groupadd -g 1003 user1003
useradd -u 1003 -m -d '/home/user1003' -g user1003 user1003
chown -R 1003:1003 /home/user1003

groupadd -g 1004 user1004
useradd -u 1004 -m -d '/home/user1004' -g user1004 user1004
chown -R 1004:1004 /home/user1004

# Mac
useradd -u 500 -m -d '/home/user500' -g 20 user500
chown -R 500:20 /home/user500

useradd -u 501 -m -d '/home/user501' -g 20 user501
chown -R 501:20 /home/user501

useradd -u 502 -m -d '/home/user502' -g 20 user502
chown -R 502:20 /home/user502

useradd -u 503 -m -d '/home/user503' -g 20 user503
chown -R 503:20 /home/user503

useradd -u 504 -m -d '/home/user504' -g 20 user504
chown -R 504:20 /home/user504
