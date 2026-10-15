
name: Deploy Study Buddy Website

on:
  push:
    branches:
      - main
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: github-pages
  cancel-in-progress: false

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Check website file
        run: |
          if [ ! -f index.html ]; then
            echo "Error: index.html must be in the repository root."
            exit 1
          fi

      - name: Configure GitHub Pages
        uses: actions/configure-pages@v5

      - name: Upload website artifact
        uses: actions/upload-pages-artifact@v4
        with:
          path: .

      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
