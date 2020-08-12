import socket

clientsocket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
clientsocket.connect(('localhost', 8088))
result = clientsocket.recv(128)
print(result.decode())




# time server/client
# transformar em
# echo server/client


# www.tutorialspoint.com/unix_sockets/
