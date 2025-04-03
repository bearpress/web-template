# Managing the Sharetribe Web Template Submodule for kid.coop

This document outlines the steps and philosophy behind setting up, customizing, and maintaining the Sharetribe `web-template` as a Git submodule within the `kid.coop` project.

## ✅ Setup Summary

### 1. Fork Sharetribe Web Template
- Fork the Sharetribe repo on GitHub: [https://github.com/sharetribe/web-template](https://github.com/sharetribe/web-template)
- Your fork becomes `git@github.com:YOURNAME/web-template.git`

### 2. Add Fork as Submodule
```bash
mv web-template web-template-backup
# Use your fork URL and target a custom branch

git submodule add -b kidcoop-custom git@github.com:YOURNAME/web-template.git web-template
git submodule update --init --recursive
```

### 3. Restore Customizations
```bash
diff -r web-template-backup web-template
# Carefully copy changes back in meaningful commits
```

### 4. Push Custom Branch
```bash
cd web-template
git checkout -b kidcoop-custom  # if not already on it
git add .
git commit -m "Kid.coop customizations"
git push origin kidcoop-custom
```

### 5. Commit Submodule Link in Main Repo
```bash
cd ..  # back to kid.coop root
git add web-template
git commit -m "Track web-template as a submodule on kidcoop-custom branch"
```

---

## 🔁 Syncing with Upstream (Sharetribe)
```bash
cd web-template
git remote add upstream https://github.com/sharetribe/web-template.git

# Periodically pull upstream changes

git fetch upstream
git checkout kidcoop-custom
git merge upstream/main
# Resolve conflicts if needed

git push origin kidcoop-custom
```

This keeps your local custom branch updated with Sharetribe improvements while preserving your changes.

---

## 🔧 Customizing Build Behavior

The `web-template` submodule gives us full flexibility to:

### 🔁 Change Environment Behavior
- Modify `.env`, `.env.local`, or `.env.development`
- Inject runtime values from Bitwarden or the parent repo via the `kc env dev export` flow

### 🌍 Change API Endpoints
- Edit `src/util/config.js` or `src/util/sdkLoader.js`
- Override `baseUrl`, `clientId`, etc., to point at dev, staging, or production backends

### 🔨 Modify Build Pipeline
- Customize `webpack.config.js` for additional plugins or rules
- Adjust `package.json` scripts
  - e.g., add `npm run lint:fix`, `npm run analyze`, or `npm run build:preview`
- Add tools like Prettier, ESLint, TypeScript, or PostCSS

### 🧩 Add Custom Pages or Components
- Create new React pages under `src/containers/`
- Add modular UI in `src/components/`
- Customize routing via `src/routing/routeConfiguration.js`

---

## 🧠 Future-Forward Philosophy

By using a **submodule with a custom branch**, `kid.coop` gains:

- **Separation of concerns**: upstream improvements and our changes live side-by-side
- **Upgrade flexibility**: update upstream when ready, never forced
- **Version control clarity**: track changes in both repos
- **Collaboration workflow**: developers can make PRs to either main repo or submodule

This structure aligns with kid.coop's broader cooperative vision — modular, flexible, and built for stewardship.

---

## 🚀 Next Steps

- [ ] Set up automatic syncing with `upstream/main`
- [ ] Define a build variant for `kidcoop-preview` or `kidcoop-dev`
- [ ] Document expected environment variables and where they come from
- [ ] Add CI hooks or GitHub Actions for linting + submodule update detection

Let this doc serve as the foundation for a shared, sustainable frontend ecosystem under the kid.coop banner. ❤️

