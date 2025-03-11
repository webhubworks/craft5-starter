# Craft 5 CMS Starter

An opinionated starter template for Craft CMS 5 projects at Webhub.

## Features

- [Craft CMS 5](https://craftcms.com/) – A flexible and powerful CMS
- [DDEV](https://ddev.com/) – A modern local development environment
- [Vite 6](https://vite.dev/) – Lightning-fast frontend tooling
- [Tailwind CSS 4](https://tailwindcss.com/) – Utility-first CSS framework
- [Vue 3](https://vuejs.org/) – Reactive JavaScript framework

## Requirements

Before getting started, ensure you have the following installed:

- [Composer](https://getcomposer.org/)
- [DDEV](https://ddev.com/)
- [1Password CLI](https://developer.1password.com/docs/cli/get-started/) (optional but recommended)
- git

### Installing 1Password CLI (Optional)

Using 1Password CLI allows for automatic installation of Craft CMS. To install it via Homebrew, run:

```sh
brew install 1password-cli
```

Then, enable CLI integration in 1Password:

1. Open the **1Password Desktop App**
2. Go to **Settings > Developer**
3. Enable **"Integrate with 1Password CLI"**

## Usage

### Using the Command Line

To create a new project using this starter, run:

```sh
composer create-project webhubworks/craft5-starter <project-name>
cd <project-name>
ddev start
```

### Using This Template

Alternatively, you can create a new repository from this template on GitHub and clone it locally. Then, manually run the setup script:

```sh
./scripts/init.sh
ddev start
```

## Contributing

For better IDE support, configure file associations:

- `.gitignore.default` → GitIgnore
- `.json.default` → JSON
- `.md.default` → Markdown
