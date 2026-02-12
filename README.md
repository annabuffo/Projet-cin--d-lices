Ciné Délices
Une plateforme de partage de recettes inspirée des films et des séries télévisées. Construit avec Svelte (frontend) + API Express REST (backend) + PostgreSQL/Sequelize. Comprend une authentification JWT via cookies httpOnly (avec prise en charge du jeton Bearer), un back-office administratif, une intégration TMDB pour les données vidéo, et la génération de recettes alimentée par IA via Mistral.

Démo live
URL de production : https://cinedelices-frontend.calmglacier-7bdfaf80.canadacentral.azurecontainerapps.io

Caractéristiques
Authentification utilisateur - Gestion des registres, de connexion et de profil avec des jetons JWT
Gestion des recettes - Créer, modifier, supprimer des recettes avec contrôle de propriété
Intégration des films - Parcourez les films/séries via l’API TMDB et reliez des recettes vers eux
Génération de recettes par IA - Générer des idées de recettes avec Mistral AI basées sur des films sélectionnés
Administration Back-Office - Gérer les utilisateurs, recettes, catégories et médias
Responsive Design - Interface adaptée aux mobiles
Pile technologique
Frontend
Svelte 5 + Vite - Framework d’interface réactive moderne
svelte-spa-router - Routage côté client
CSS réactif - Conception mobile-first
Backend
Node.js 20 + Express 5 - Serveur API REST
Sequelize + PostgreSQL - ORM et base de données
Authentification JWT - Cookies httpOnly + prise en charge du jeton porteur
Sécurité - Casque, limitation de vitesse, CORS, validation d’entrée
Infrastructures
Docker - Déploiement conteneurisé
Azure Container Apps - Hébergement en production
Azure Container Registry - Docker image storage
Azure Database for PostgreSQL - Managed database
GitHub Actions - CI/CD pipeline
Démarrage rapide (développement local)
Prérequis
Node.js 20+
Docker & Docker Compose
PostgreSQL (ou utiliser Docker)
1. Clonage et mise en place
git clone https://github.com/cool-machine/cinedelices_simplified.git
cd cinedelices_simplified
2. Variables d’environnement
Copiez le fichier env d’exemple et configurez :

cp .env.example .env
Variables requises :

# Database
DATABASE_URL=postgres://user:password@localhost:5433/cinedelices
DB_HOST=localhost
DB_PORT=5433
DB_NAME=cinedelices
DB_USER=user
DB_PASSWORD=password

# Auth
JWT_SECRET=your-secret-key

# Frontend URL (for CORS)
FRONTEND_URL=http://localhost:5173

# TMDB API
TMDB_API_KEY=your-tmdb-api-key

# Mistral AI (optional, for recipe generation)
MISTRAL_API_KEY=your-mistral-api-key
MISTRAL_MODEL=mistral-small-latest
MISTRAL_API_URL=https://api.mistral.ai/v1/chat/completions
3. Commencez avec Docker Compose
# Start all services (database, backend, frontend)
docker-compose -f docker-compose.dev.yml up
Ou gérer les services individuellement :

# Start database only
docker-compose -f docker-compose.dev.yml up db

# Backend (in another terminal)
cd backend
npm install
npm run dev

# Frontend (in another terminal)
cd frontend
npm install
npm run dev
4. Initialisation de la base de données
cd backend
npm run db:migrate
npm run db:seed
Réinitialisez la base de données si nécessaire :

npm run db:reset
Structure du projet
cinedelices_simplified/
├── backend/
│   ├── src/
│   │   ├── controllers/    # Route handlers
│   │   ├── middlewares/    # Auth, validation
│   │   ├── models/         # Sequelize models
│   │   ├── routes/         # API routes
│   │   ├── services/       # TMDB, Mistral integrations
│   │   └── utils/          # JWT, helpers
│   ├── tests/              # Jest tests
│   └── Dockerfile
├── frontend/
│   ├── src/
│   │   ├── components/     # Reusable UI components
│   │   ├── pages/          # Route pages
│   │   ├── lib/            # API client, stores
│   │   └── assets/         # Images, styles
│   └── Dockerfile
├── docs/                   # Documentation
└── .github/workflows/      # CI/CD
Points d’accès API
Authentification
POST /api/v1/auth/register - Enregistrer un nouvel utilisateur
POST /api/v1/auth/login - Connexion
POST /api/v1/auth/logout - Déconnexion
GET /api/v1/auth/me - Obtenir l’utilisateur actuel
Recettes
GET /api/v1/recipes - Lister toutes les recettes
GET /api/v1/recipes/:id - Obtenir les détails de la recette
POST /api/v1/recipes - Créer une recette (authentification requise)
PUT /api/v1/recipes/:id - Mise à jour de la recette (uniquement propriétaire)
DELETE /api/v1/recipes/:id - Supprimer la recette (propriétaire uniquement)
POST /api/v1/recipes/generate - Génération de recettes par IA (authentification requise)
Films (TMDB)
GET /api/v1/tmdb/search?query=...&type=... - Rechercher des films/séries TV
GET /api/v1/tmdb/:id?type=... - Obtenir des détails sur les films ou les séries TV
Administration
GET /api/v1/admin/users - Lister les utilisateurs (administrateur uniquement)
DELETE /api/v1/admin/users/:id - Supprimer l’utilisateur (administrateur uniquement)
... (catégories, gestion des médias)
Essais
cd backend
npm test           # Run all tests
npm run test:watch # Watch mode
Les tests utilisent Jest + Supertest avec la prise en charge des modules ESM.

Déploiement
Azure Container Apps (Production)
L’application est déployée sur Azure avec :

Azure Container Apps - Conteneurs frontend et backend
Azure Container Registry - Docker images
Azure Database for PostgreSQL - Managed database
Actions sur GitHub - CI/CD automatisé sur la poussée vers le principal
Configuration de mise à l’échelle
Pour éliminer les démarrages à froid, fixez un minimum de répliques :

# Keep at least 1 replica running (no cold starts)
az containerapp update --name cinedelices-backend --resource-group oclock-resources --min-replicas 1
az containerapp update --name cinedelices-frontend --resource-group oclock-resources --min-replicas 1

# Scale to zero when not needed (cost savings)
az containerapp update --name cinedelices-backend --resource-group oclock-resources --min-replicas 0
az containerapp update --name cinedelices-frontend --resource-group oclock-resources --min-replicas 0
Déploiement manuel
Voir docs/azure-deployment-guide.md pour la configuration Azure étape par étape.

CI/CD
Flux de travail GitHub Actions () automatiquement :.github/workflows/azure-deploy.yml

Crée des images Docker pour le frontend et le backend
Pushes to Azure Container Registry
Déploie vers Azure Container Apps
Déclenché en poussant vers la branche.main

Documentation
Notes de développement - Progression du sprint et décisions techniques
Guide de déploiement Azure - Instructions de configuration cloud
Documentation visuelle - captures d’écran, wireframes, vidéo de démonstration
Comptes par défaut (Développement)
Après l’amorçage de la base de données :

Rôle	Email	Mot de passe
Administration	admin@test.com	Password123
Utilisateur	user@test.com	Password123
Licence
AVEC