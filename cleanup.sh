#!/bin/bash
echo "🚀 Cleaning FoodBridgeAI repo from large/unwanted files..."

# Make sure git-filter-repo is installed
if ! command -v git-filter-repo &> /dev/null
then
    echo "⚠️ git-filter-repo not found. Install with: pip install git-filter-repo"
    exit
fi

# Step 1: Remove already committed node_modules, venv, build, dist, models, db files
git filter-repo --path node_modules --invert-paths
git filter-repo --path frontend/node_modules --invert-paths
git filter-repo --path backend/venv --invert-paths
git filter-repo --path rasa/models --invert-paths
git filter-repo --path build --invert-paths
git filter-repo --path dist --invert-paths
git filter-repo --path *.sqlite3 --invert-paths
git filter-repo --path *.db --invert-paths

# Step 2: Remove blobs larger than 50MB
git filter-repo --strip-blobs-bigger-than 50M

echo "✅ Cleanup done. Now force push:"
echo "   git push origin main --force"
