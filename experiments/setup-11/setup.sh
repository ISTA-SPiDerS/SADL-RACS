pwd=$(pwd)
. "${pwd}"/experiments/setup-11/ip.sh

reset_directory="rm -r /home/${user_name}/mandator/ ; mkdir -p /home/${user_name}/mandator/logs"
local_binary_path="${pwd}/experiments/binary/"
replica_home_path="/home/${user_name}/mandator/"

# generate config files

python3 experiments/python/paxos-config.py               11 11 ${replica1_ip} ${replica2_ip} ${replica3_ip} ${replica4_ip} ${replica5_ip} ${replica6_ip} ${replica7_ip} ${replica8_ip} ${replica9_ip} ${replica10_ip} ${replica11_ip} ${client1_ip} ${client2_ip} ${client3_ip} ${client4_ip} ${client5_ip} ${client6_ip} ${client7_ip} ${client8_ip} ${client9_ip} ${client10_ip} ${client11_ip}  > experiments/binary/paxos.yml
python3 experiments/python/mandator-sporades-config.py   11 11 ${replica1_ip} ${replica2_ip} ${replica3_ip} ${replica4_ip} ${replica5_ip} ${replica6_ip} ${replica7_ip} ${replica8_ip} ${replica9_ip} ${replica10_ip} ${replica11_ip} ${client1_ip} ${client2_ip} ${client3_ip} ${client4_ip} ${client5_ip} ${client6_ip} ${client7_ip} ${client8_ip} ${client9_ip} ${client10_ip} ${client11_ip}  > experiments/binary/mandator-sporades.yml


for i in "${machines[@]}"
do
   echo "copying files to ${i}"
   sshpass ssh -o "StrictHostKeyChecking no" "$i" -i ${cert} "${reset_directory}"
   scp -r -i ${cert} ${local_binary_path} "$i":${replica_home_path}
done


rm experiments/binary/mandator-sporades.yml
rm experiments/binary/paxos.yml

echo "11 replica setup complete"

