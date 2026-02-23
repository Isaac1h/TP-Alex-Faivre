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

<p align ="center">
<img width="735" height="311" alt="Image" src="https://github.com/user-attachments/assets/d90afd80-7ef9-43c2-9011-4c957b0ba7b7" />
<img width="446" height="69" alt="Image" src="https://github.com/user-attachments/assets/11d28fde-254f-4bdd-956b-d01a0c07cb9b" />
<img width="261" height="240" alt="Image" src="https://github.com/user-attachments/assets/94efcd09-4b06-4b2c-9b91-2855a59ef822" />
<img width="956" height="140" alt="Image" src="https://github.com/user-attachments/assets/ea225bc2-869f-4d55-9109-ae296b8b8d72" />
<img width="385" height="138" alt="image" src="https://github.com/user-attachments/assets/7084d6d4-2069-469d-9aca-0102d03a7ef6" />
<img width="1025" height="81" alt="Image" src="https://github.com/user-attachments/assets/895f842e-a18c-48ee-8466-fb403611ffc7" />
<img width="436" height="473" alt="Image" src="https://github.com/user-attachments/assets/8b82cd8e-86f8-4a50-9833-63d3a96ce176" />
<img width="1121" height="330" alt="Image" src="https://github.com/user-attachments/assets/0cddd0d3-5a34-4f58-a848-427f90bbfbbc" />
<img width="1111" height="209" alt="Image" src="https://github.com/user-attachments/assets/1669f1e2-3277-48e4-9ab5-228ac1b75edf" />

<img width="420" height="129" alt="image" src="https://github.com/user-attachments/assets/3d625b50-ebf3-462a-9655-35f5188df50d" />
</p>

# TP Azure Cloud Computing : Infrastructure as Code avec Terraform

Ce projet consiste en la création d'une infrastructure complète et hautement disponible sur Microsoft Azure en utilisant Terraform. L'architecture est composée de deux serveurs web derrière un Load Balancer public.

## 🏗️ Architecture du Projet

- **Réseau** : Virtual Network (VNet) avec un sous-réseau (Subnet) dédié.
- **Sécurité** : Network Security Group (NSG) autorisant les flux SSH (22) et HTTP (80).
- **Calcul** : 2 Machines Virtuelles Linux Ubuntu 22.04 LTS.
- **Automatisation** : Installation automatique de Nginx via scripts `custom_data`.
- **Haute Disponibilité** : Azure Load Balancer (SKU Standard) avec sonde de santé et répartition de charge.

---

## 📑 Compte Rendu des Étapes

### Partie 1 & 2 — Configuration & Groupe de Ressources

- **Initialisation** : Configuration du provider `azurerm` et initialisation du backend Terraform.
- **Organisation** : Création d'un Resource Group (`tp-azure-rg`) centralisant toutes les ressources.
- **Variables** : Utilisation d'un fichier `variables.tf` pour piloter la région (`France Central`) et le préfixe des noms de ressources, garantissant un code flexible et réutilisable.

### Partie 3 — Réseau et Sécurité

- **VNet & Subnet** : Mise en place de l'adressage IP privé (`10.0.0.0/16`).
- **Sécurité Réseau** : Configuration d'un NSG (`tp-azure-nsg`) avec des règles de sécurité strictes :
  - Ouverture du port **22** pour l'administration SSH.
  - Ouverture du port **80** pour l'accès public au service web.
- **Liaison** : Association du NSG au sous-réseau pour protéger toutes les instances futures.

### Partie 4 — Machines Virtuelles & Bootstrapping

- **Multi-VM** : Déploiement de deux instances (`vm-1` et `vm-2`) à l'aide de l'argument `count`.
- **Sécurité SSH** : Authentification sécurisée par paire de clés RSA (abandon des mots de passe).
- **Bootstrapping** : Automatisation de l'installation de Nginx et personnalisation de la page d'accueil (`index.html`) pour identifier chaque serveur lors des tests de charge.

### Partie 5 — Load Balancer (Haute Disponibilité)

- **Point d'entrée** : Création d'une IP publique statique et d'un Azure Load Balancer.
- **Backend Pool** : Regroupement des deux serveurs web au sein du pool d'adressage de l'équilibreur.
- **Health Probe** : Surveillance continue du port 80 pour s'assurer que seules les instances saines reçoivent du trafic.
- **Résultat** : Répartition équitable des requêtes HTTP sur l'IP publique du Load Balancer.

### Partie 6 — Cycle de Vie et Nettoyage

- **Destruction** : Utilisation de la commande `terraform destroy` pour libérer les ressources Azure et optimiser les coûts.
- **Sécurité du Code** : Mise en place d'un fichier `.gitignore` pour exclure les fichiers sensibles (`.tfstate`, clés privées) du dépôt Git.

---

<p align="center">
<img width="1107" height="333" alt="Image" src="https://github.com/user-attachments/assets/ce05fa78-8df1-490a-8035-19bfbe34523c" />
<img width="1112" height="352" alt="Image" src="https://github.com/user-attachments/assets/0f2333ff-4fe1-449e-ab95-0ca23fd4469c" />
<img width="719" height="135" alt="Image" src="https://github.com/user-attachments/assets/da6e198b-0db0-4b9d-9ae5-fa66668ab737" />
<img width="1083" height="323" alt="Image" src="https://github.com/user-attachments/assets/8b41fcba-2271-4adf-8e59-be6ba8d7b980" />
<img width="975" height="163" alt="Image" src="https://github.com/user-attachments/assets/6659b9e6-d815-43eb-a424-820ae5b5466d" />
<img width="864" height="485" alt="Image" src="https://github.com/user-attachments/assets/98921fcf-cdc1-491c-a3a2-7a0140f687ad" />
<img width="525" height="58" alt="Image" src="https://github.com/user-attachments/assets/39d6cc7c-2c14-4f38-afcd-e802987d798a" />
</p>
## 🚀 Comment déployer ce projet ?

1. **Initialisation** :
   ```bash
   terraform init
    plannification : terraform plan
    deploiement : terraform apply -auto-approve
    tests : curl http://<LB_PUBLIC_IP>
    nettoyage : terraform destroy -auto-approve
   ```
