# App-EPI — Gestion des Équipements de Protection Individuelle

Application web (un seul fichier, sans serveur) pour gérer la remise des EPI au personnel.

## Démarrer

Ouvrez `index.html` dans un navigateur (Chrome, Edge, Firefox). Rien à installer.
Les données sont enregistrées dans le navigateur ; utilisez **Import / Export → Télécharger une sauvegarde** régulièrement.

## Fonctionnalités

- **Personnel** : matricule, nom, prénom, fonction, service, tailles (vêtement, pointure, gants), statut actif/inactif, recherche et filtre par fonction.
- **Import de la liste du personnel** depuis Excel (.xlsx/.xls) ou CSV, avec détection automatique des colonnes
  `Matricule, Nom, Prénom (ou "Nom et prénom"), Fonction, Service, EPI, Taille, Pointure, Gants, Date`.
  Si le fichier a une colonne **EPI**, chaque ligne peut devenir une dotation (une personne peut avoir plusieurs lignes).
- **Catégories d'EPI** (modifiables) : chaussures de sécurité, lunettes, gilet haute visibilité, protection anti-bruit,
  casque, gants, masque respiratoire, tenue de travail, harnais antichute — chacune avec sa durée de renouvellement.
- **Dotations** : remise de plusieurs EPI en une fois, taille proposée automatiquement selon la fiche de la personne, motif, date, déduction du stock.
- **Stock** par article et par taille, entrées de stock, inventaire, seuil d'alerte.
- **Tableau de bord** : renouvellements en retard / à prévoir, stock bas, dotations par catégorie.
- **Fiche individuelle EPI imprimable** avec émargement et signatures.
- **Export Excel** : personnel, dotations, stock, situation EPI par personne.

## Fichiers

- `index.html` — l'application
- `vendor/xlsx.full.min.js` — bibliothèque SheetJS (lecture/écriture Excel, licence Apache-2.0)
