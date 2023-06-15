# Visualiseur DMARC Flutter : Client Mobile 📱

> ## :construction: Projet en cours de développement :construction:


**Visualiseur DMARC Flutter** permet de visualiser et de traiter des rapports DMARC. Il est construit pour permettre aux utilisateurs d'interagir facilement avec ces derniers.

## Introduction 👋

**DMARC** (Domain-based Message Authentication, Reporting and Conformance) est une norme de vérification d'email conçue pour lutter contre l'usurpation d'adresse email. Cette technologie permet aux propriétaires de domaine d'indiquer aux serveurs de messagerie comment gérer les emails non authentifiés provenant de leur domaine, contribuant ainsi à protéger les utilisateurs finaux contre l'hameçonnage et autres types d'attaques par usurpation.

La spécification DMARC s'appuie sur deux technologies existantes :

*SPF* (Sender Policy Framework) permet aux propriétaires de domaine de publier une liste de serveurs autorisés à envoyer des emails en leur nom.

*DKIM* (DomainKeys Identified Mail) ajoute une signature numérique à la tête de chaque email envoyé, qui peut être vérifiée par le serveur de messagerie du destinataire pour prouver que l'email est légitime et n'a pas été modifié pendant le transport.

Lorsqu'un serveur de messagerie reçoit un email, il peut vérifier les enregistrements DMARC du domaine de l'expéditeur pour voir comment traiter l'email.

## Fonctionnalités 💡

- **Visualisation des rapports DMARC :** Permet aux utilisateurs de visualiser leurs rapports DMARC d'une manière facile à comprendre.
- **Importer des rapports DMARC au format XML :** L'utilisateur peut importer directement ses rapports depuis l'application.
- **Traiter et supprimer des entrées :** Il est possible d'indiquer comme traité une entrée de rapport.


## Support 👍

**Voici les plateformes supportées :**

| Web | Android | IOS |windows | Linux |
| :----: | :----: | :----: | :----: | :----: |
| Oui | Non | Non | Oui | Oui |


## Installation 💻

### Serveur 🗼

Clonez le dépot suivant et suivez les indications `https://github.com/Rulio974/DMARC-serveur`

### Client 🌐

1. Assurez-vous d'avoir installé [Flutter](https://flutter.dev/docs/get-started/install) sur votre machine.
2. Clonez ce dépôt en utilisant `git clone https://github.com/Rulio974/DMARC-Flutter-Viewer`.
3. Déplacez vous dans le dossier `cd DMARC-Flutter-Viewer`.
3. Exécutez `flutter pub get` pour installer les dépendances.
4. Exécutez l'application.



## Dépendances 📚

### flutter

- pluto_grid: ^6.0.4
- http: ^0.13.6
- auto_size_text: ^3.0.0-nullsafety.0
- file_picker: ^5.3.1

### nodeJS

 - child_process: ^1.0.2
 - cors: ^2.8.5
 - express: ^4.18.2
 - multer: ^1.4.5-lts.1,
 - mysql2: ^3.3.4
