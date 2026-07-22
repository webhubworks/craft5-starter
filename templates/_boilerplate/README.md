# Boilerplate files

Everything in the `_boilerplate/` directory should be project-agnostic and sharable between all webhub Craft projects. The boilerplate templates are based on nystudio107's article "[An Effective Twig Base Templating Setup](https://nystudio107.com/blog/an-effective-twig-base-templating-setup)," but the files have been modernized and modified for webhub's needs.

## base-layouts/

The way it works is that all of your `extends` should eventually point to a file in the `base-layouts/` directory. Simply pick the appropriate layout to extend to, and that's it. You can overwrite `{% block %}` tags in your own layout files to customize the output (see the files in `/templates/_site/_layouts/` for examples).

## envelopes/

Some base layouts (specifically `webpage.twig`) will extend further into the `envelopes/` files, depending on whether it's a standard webpage or an AJAX request that only needs to render a page's `{% content %}` block.

_Generally, you may never need to edit these files unless you're adding new ones._

## partials/

The `partials/` directory contains low-level files to `{% include %}`, especially for things like inline JavaScript snippets, polyfills, and other loose ends for the boilerplate. Add more if you need to and include them in the `{% block headJsEnd %}` in `_boilerplate/base-layouts/webpage.twig`. Just make sure they're site-agnostic.

---

_Delete this file once you know your way around._
