from scapy.all import IP, ICMP, sr1

target = "8.8.8.8"
packet = IP(dst=target)/ICMP()
response = sr1(packet, timeout=6)
print(response)

if response:
    print("Response received!")
else:
    print("No reply.")
