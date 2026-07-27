# Twig Template Organization

---

_**NOTE**: the template organization strategy presented in these files is a modified version of what Andrew Welch (nystudio107) explains in his article, "[An Effective Twig Base Templating Setup](https://nystudio107.com/blog/an-effective-twig-base-templating-setup)," specifically the `/templates/_boilerplate/` files._

---

The `templates/` directory not only contains the Twig files your site uses to render Craft's content, it also represents the _**global**_ scope of all templates and sites. Nothing in the top level should be site-specific, but rather globally reusable files. Here's a quick rundown of what's here:
- `_boilerplate/`: the directory that constructs the base HTML document itself, in which your content sits. Generally speaking, you'll rarely have to edit anything in here (if ever). Just make sure your layout files extend to one of its `base-layouts/`.
- `_global/`: the directory that holds reusable components/macros, includes/partials, or anything that's shared from Craft site to Craft site.
- `_site`: the directory for all files related to the website you're building. By default, this represents your primary Craft site.
- `error.twig`: the file Craft uses when an HTTP error occurs (see below).
- `index.twig`: the default template Craft serves up unless you tell it otherwise (see below).

## error.twig

[According to Craft's docs](https://craftcms.com/docs/5.x/system/routing.html#error-templates), when Craft encounters an HTTP error response (like `404` "page not found"), it will first look for a `/templates/404.twig` file. If one doesn't exist, it'll look for a `/templates/error.twig` file. If that doesn't exist, Craft will show its own stylized page that will look different from your website.

The `error.twig` file contains this simple code:
```twig
{% extends [
    "_#{currentSite.handle}/http-error.twig",
    '_site/http-error.twig',
] %}
```

All this says is, "Look for an `http-error.twig` file inside a directory named after a Craft site's `handle` (prefixed with an `_`)." So for example, if your site in Craft's CP is registered with the handle `mySite`, then it'll first look for the error template in `_mySite/http-error.twig`. If that doesn't exist, it goes to the next entry in the array, which is the default `_site/http-error.twig`.

If you add more sibling directories to `_site/`, make sure you update this array to include a path to the error file in your new directory. This allows `_site/` and `_mySite/` to style their error pages to match their design.

## index.twig

This is Craft's default template that it uses in cases of uncertainty (like where to redirect a user after they log out of a front-end user account, for example). Generally, this would be your homepage, but in some multi-site cases, where each site needs its own stylized homepage, this one file won't suffice.

So, inside `index.twig`, there's this simple code:
```twig
{% extends [
    "_#{currentSite.handle}/homepage.twig",
    '_site/homepage.twig',
] %}
```

Read the `error.twig` section above to understand how this works. Basically, this will allow you to route this default `index.twig` file through each of your site subdirectories like `_site/` or `_mySite/` and show their respective homepages. Be sure to update this if you add more `_site/`-like subdirectories or edit `_site/`'s name.

---

_Delete this file once you know your way around._
