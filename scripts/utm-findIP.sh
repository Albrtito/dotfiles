#!/bin/bash

# Script para obtener la dirección IP de una máquina virtual en UTM
# La máquina virtual debe de estar ejecutándose y el agente QEMU debe estar instalado y funcionando.

VM_NAME="$1"

if [ -z "$VM_NAME" ]; then
    echo "Error: Debes proporcionar el nombre de la máquina virtual."
    echo "Uso: ./utm-findIP [nombre_de_vm]"
    exit 1
fi


# Ejecuta el comando ip addr dentro de la VM para obtener información de red
UTM_RESULT=$(utmctl ip-address $VM_NAME)

if [ $? -ne 0 ]; then
    echo "Error al ejecutar el comando en la VM. Comprueba que:"
    echo "1. La VM está en ejecución"
    echo "2. El agente QEMU está instalado y ejecutándose"
    echo "IA: (Opciones por Claude para ubuntu)"
    echo "Instalación del agente QEMU (dentro de la VM $VM_NAME):"
    echo "sudo apt update && sudo apt install -y qemu-guest-agent"
    echo "sudo systemctl enable qemu-guest-agent && sudo systemctl start qemu-guest-agent"
    exit 1
fi

if [ -z "$UTM_RESULT" ]; then
    echo "No se encontró ninguna dirección IP válida."
    exit 1
fi

# Extrae solo la primera dirección IPv4 (formato X.X.X.X)
IPV4_ADDRESS=$(echo "$UTM_RESULT" | grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' | head -1)

# Imprime solo la dirección IPv4 sin texto adicional
echo "$IPV4_ADDRESS"
exit 0
