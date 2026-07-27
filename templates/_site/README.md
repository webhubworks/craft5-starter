# Site files

The `/templates/_site/` files are for everything specific to the website you're building. The name of this directory is just the default, which you can edit if you wish. If you do, remember to update your `{% extends %}` everywhere this directory is referenced.

## Adding more `_site/`-like subdirectories

If your Craft setup is multi-site, but each site is just a different language/locale, then one `/templates/_site/` directory is enough.

If you have a multi-site setup, where each site is its own thing, then create a sibling directory for its files. Examples might be:
- `/templates/`
  - `_account/` _(for front-end user accounts)_
  - `_microsites/` _(standalone pages)_
  - `_email/` _(email templates)_
  - `_my-other-site/` _(a totally different Craft site managed alongside your primary site)_
  - `_cp/` _(for custom Twig used in Craft's field layouts in the **C**ontrol **P**anel)_

Just like the default `_site/` directory, each of these represents files for its own **_scope_**. Anything shared between, say, `_site/` and `_account/`, for example, like UI components, can go in `/templates/_global/`. Anything low-level that's shared can go in `/templates/_boilerplate/`. Shared low-level JavaScript snippets, for example, can be stored in `/templates/_boilerplate/partials/`.

## _layouts/

In the existing `/templates/_site/` directory, when you create a template for a page/section, it will need to extend one of this site's layouts. Currently, there are two:
1. `/templates/_site/_layouts/static.twig`: for standard static HTML pages. In this case, JavaScript might be needed, but there's no JavaScript framework involved like Vue.
2. `/templates/_site/_layouts/vue.twig`: for HTML pages needing Vue.

The `/templates/_site/_layouts/_base.twig` template is the shared parent between the two layouts above.

Feel free to customize these, add more, remove what's not needed, etc. Ultimately, your `_base.twig` layout should extend to one of the files in `/templates/_boilerplate/base-layouts/` (most likely to the `webpage.twig` file).

## Other files/directories

If you need a template for a single section (like the Homepage or "About Us"), a single file might suffice (`/templates/_site/homepage.twig` or `/templates/_site/about-us.twig`). 

If you need templates for a section, like "News", create a subdirectory:
- `/templates/_site/news/`
  - `entry.twig` _(the news article's details page)_
  - `index.twig` _(the listing page with all news articles)_
  - `category.twig` _(a listing page that filters articles by a selected news category)_
  - `search-results.twig` _(a listing page that filters articles by a search query)_

If there are UI components that are unique to this site, add `_site/_components/` or `_site/_partials/` with their respective files. Make sure your code could easily be moved to the `/templates/_global/` directory in the event that other `_site/`-like directories could share them too. Ideally, you'd have _**no**_ components/macros inside your `_site/` directory (try to make your components reusable). But you're free to treat the `_site/` directory however you wish.

## Where's the site's header and footer?

A site's header and footer are located in `/templates/_site/_layouts/partials/`. These are included into the `/templates/_site/_site/_layouts/` files, since, after all, they're a part of a page's layout for this site.

These are not stored in `/templates/_boilerplate/` because each site needs its own ability to style its own header/footer.

## What is http-error.twig for?
This page is for HTTP status code errors like `404` (page not found), `503` (service unavailable), etc. Each `_site/`-like directory should have its own `http-error.twig` file that'll display the error message in the style as the rest of the site.

See `/templates/error.twig` for how the `http-error.twig` file comes into play, or read the `/templates/README.md` file.

---

_Delete this file once you know your way around._
