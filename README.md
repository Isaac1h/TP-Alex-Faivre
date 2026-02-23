# 🚀 Azure Infrastructure as Code avec Terraform

![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)
![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)

## 📝 Aperçu (Overview)

Ce projet documente la mise en œuvre d'une infrastructure cloud sur **Microsoft Azure** via une approche **Infrastructure as Code (IaC)**. L'objectif est de déployer de manière automatisée, sécurisée et reproductible une machine virtuelle Linux ainsi que son environnement réseau complet (VNet, Subnet, NSG).

## 🛠 Stack Technique

- **Provisioning :** Terraform v1.14.5
- **Cloud Provider :** Microsoft Azure (Abonnement Azure for Students)
- **CLI :** Azure CLI v2.83.0
- **OS Invité :** Ubuntu 18.04 LTS
- **IDE :** Visual Studio Code

---

## 🏗 Architecture & Ressources

Le projet définit de manière déclarative **7 ressources** interdépendantes :

1.  **Resource Group :** `rg-tp-azure` (Conteneur logique).
2.  **Virtual Network (VNet) :** `vnet-tp` (10.0.0.0/16).
3.  **Subnet :** `internal` (10.0.1.0/24).
4.  **Network Security Group (NSG) :** Contrôle des accès.
5.  **Security Rule :** Autorisation du port **SSH (22)**.
6.  **Network Interface (NIC) :** Liaison réseau de la VM.
7.  **Linux VM :** Instance `vm-tp-linux` (Standard_B1s).

---

## 🚀 Installation & Usage

### 1. Préparation de l'environnement

L'installation de Terraform et d'Azure CLI a été réalisée via **Winget** pour garantir une configuration propre des variables système.

```powershell
# Installation via gestionnaire de paquets
winget install Hashicorp.Terraform
winget install Microsoft.AzureCLI


az login          # Connexion au compte Microsoft
terraform init    # Téléchargement des plugins AzureRM


terraform plan   # Analyse des changements
terraform apply  # Exécution (Tapez 'yes' pour confirmer)

## ⚠️ Défis Techniques & Solutions (Troubleshooting)

| Problème | Cause | Solution |
| :--- | :--- | :--- |
| **Binaire non reconnu** | Fichier `.exe` mal renommé ou variable `PATH` absente. | Installation via **Winget** pour automatiser la déclaration système. |
| **Commande 'az' inconnue** | Azure CLI manquant sur l'hôte. | Installation du package `Microsoft.AzureCLI` et redémarrage du terminal. |
| **"Opération annulée"** | Blocage de sécurité Windows SmartScreen (binaire non signé). | Utilisation de la commande `Unblock-File` en PowerShell ou passage par Winget. |
| **Fuite de données** | Risque de versionner les fichiers d'état sensibles. | Création d'un fichier `.gitignore` excluant `terraform.tfstate` et `.terraform/`. |

---

## 🏁 Résultat Final

Une fois le déploiement terminé, la machine virtuelle est pleinement opérationnelle et accessible via SSH. L'intégralité de l'infrastructure est désormais pilotée par le code (IaC), garantissant une reproductibilité totale.

---
**Auteur :** Isaac Hassani
```
