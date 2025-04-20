#!/bin/bash

APIB="https://check-host.net"

mn() {
clear
echo "----------------------------------------"
echo "  Check-Host.net API Tool "
echo "  TG @DRR_R2 - @cybersecurityTemDF "
echo "----------------------------------------"
echo "1. Ping Check"
echo "2. HTTP Check"
echo "3. TCP Check"
echo "4. DNS Check"
echo "5. List Nodes (IPs)"
echo "6. List Nodes (Hosts)"
echo "7. Check Result"
echo "8. Check Result (Extended)"
echo "9. Exit"
echo "----------------------------------------"
read -p "Enter your choice: " ch
case $ch in
1) pc ;;
2) hc ;;
3) tc ;;
4) dc ;;
5) li ;;
6) lh ;;
7) cr ;;
8) ce ;;
9) exit 0 ;;
*) echo "Invalid choice. Please try again." ; sleep 2; mn ;;
esac
}

pc() {
clear
read -p "Enter host to ping: " ho
read -p "Enter maximum number of nodes: " mx
read -p "Enter specific nodes (comma-separated, leave blank for automatic): " no

ur="
APIB/check-ping?host=
ho&max_nodes=
mx"
if [ ! -z "$no" ]; then
na=($(echo $no | tr "," "\n"))
ur="$APIB/check-ping?host=$ho&max_nodes=$mx&nodes=$(IFS=,; echo "${na[*]}")"
fi

re=$(curl -s -H "Accept:application/json" "$ur")

if echo "$re" | jq -e '.ok==1' >/dev/null; then
ri=$(echo "$re" | jq -r '.request_id')
pl=$(echo "$re" | jq -r '.permanent_link')
echo "Ping check initiated successfully."
echo "Request ID: $ri"
echo "Permanent Link: $pl"
read -p "Press Enter to return to main menu..."
else
echo "Error initiating ping check:"
echo "$re"
read -p "Press Enter to return to main menu..."
fi
mn
}

hc() {
clear
read -p "Enter host to check (e.g., example.com): " ho
read -p "Enter maximum number of nodes: " mx
read -p "Enter specific nodes (comma-separated, leave blank for automatic): " no

ur="
APIB/check-http?host=
ho&max_nodes=
mx"
if [ ! -z "$no" ]; then
na=($(echo $no | tr "," "\n"))
ur="$APIB/check-http?host=$ho&max_nodes=$mx&nodes=$(IFS=,; echo "${na[*]}")"
fi

re=$(curl -s -H "Accept:application/json" "$ur")

if echo "$re" | jq -e '.ok==1' >/dev/null; then
ri=$(echo "$re" | jq -r '.request_id')
pl=$(echo "$re" | jq -r '.permanent_link')
echo "HTTP check initiated successfully."
echo "Request ID: $ri"
echo "Permanent Link: $pl"
read -p "Press Enter to return to main menu..."
else
echo "Error initiating HTTP check:"
echo "$re"
read -p "Press Enter to return to main menu..."
fi
mn
}

tc() {
clear
read -p "Enter host:port to check (e.g., google.com:443): " ho
read -p "Enter maximum number of nodes: " mx
read -p "Enter specific nodes (comma-separated, leave blank for automatic): " no

ur="
APIB/check-tcp?host=
ho&max_nodes=
mx"
if [ ! -z "$no" ]; then
na=($(echo $no | tr "," "\n"))
ur="$APIB/check-tcp?host=$ho&max_nodes=$mx&nodes=$(IFS=,; echo "${na[*]}")"
fi

re=$(curl -s -H "Accept:application/json" "$ur")

if echo "$re" | jq -e '.ok==1' >/dev/null; then
ri=$(echo "$re" | jq -r '.request_id')
pl=$(echo "$re" | jq -r '.permanent_link')
echo "TCP check initiated successfully."
echo "Request ID: $ri"
echo "Permanent Link: $pl"
read -p "Press Enter to return to main menu..."
else
echo "Error initiating TCP check:"
echo "$re"
read -p "Press Enter to return to main menu..."
fi
mn
}

dc() {
clear
read -p "Enter host to check DNS: " ho
read -p "Enter maximum number of nodes: " mx
read -p "Enter specific nodes (comma-separated, leave blank for automatic): " no

ur="
APIB/check-dns?host=
ho&max_nodes=
mx"
if [ ! -z "$no" ]; then
na=($(echo $no | tr "," "\n"))
ur="$APIB/check-dns?host=$ho&max_nodes=$mx&nodes=$(IFS=,; echo "${na[*]}")"
fi

re=$(curl -s -H "Accept:application/json" "$ur")

if echo "$re" | jq -e '.ok==1' >/dev/null; then
ri=$(echo "$re" | jq -r '.request_id')
pl=$(echo "$re" | jq -r '.permanent_link')
echo "DNS check initiated successfully."
echo "Request ID: $ri"
echo "Permanent Link: $pl"
read -p "Press Enter to return to main menu..."
else
echo "Error initiating DNS check:"
echo "$re"
read -p "Press Enter to return to main menu..."
fi
mn
}

li() {
clear
re=$(curl -s -H "Accept:application/json" "$APIB/nodes/ips")
echo "$re" | jq .nodes
read -p "Press Enter to return to main menu..."
mn
}

lh() {
clear
re=$(curl -s -H "Accept:application/json" "$APIB/nodes/hosts")
echo "$re" | jq .nodes
read -p "Press Enter to return to main menu..."
mn
}

cr() {
clear
read -p "Enter Request ID: " ri
re=$(curl -s -H "Accept:application/json" "$APIB/check-result/$ri")
echo "$re" | jq .
read -p "Press Enter to return to main menu..."
mn
}

ce() {
clear
read -p "Enter Request ID: " ri
re=$(curl -s -H "Accept:application/json" "$APIB/check-result-extended/$ri")
echo "$re" | jq .
read -p "Press Enter to return to main menu..."
mn
}

if ! command -v jq &> /dev/null
then
echo "jq is not installed. Please install it using your package manager (e.g., apt install jq)."
exit 1
fi

mn
