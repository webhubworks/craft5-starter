# Global files

The `/templates/_global/` directory contains all reusable components, macros, etc. across all sites. Keep it clean, maintained, and modular.

An example setup might look like:

- `/templates/_global/`
  - `atoms/` _(reusable macros for basic content)_
    - `icons.twig`
    - `images.twig`
    - `media.twig`
    - `tables.twig`
    - `typography.twig`
  - `components/` _(reusable macros for complex components)_
    - `alerts.twig`
    - `cards.twig`
    - `forms.twig`
    - `modals.twig`
  - `element-partials/` _(for matrix-style content blocks \[see below])_
    - `entry/`
      - `accordion.twig`
      - `button.twig`
      - `fileDownload.twig`
      - `form.twig`
      - `grid.twig`
      - `headline.twig`
      - `heroWithVideo.twig`
      - `image.twig`
      - `images.twig`
      - `richText.twig`
      - `text.twig`
      - `textImage.twig`
    - `asset/`
      - `images.twig`
      - `documents.twig`
  - _et cetera..._

## element-partials/

Craft 5.0 introduced a new feature called "[Element Partials](https://craftcms.com/docs/5.x/system/elements.html#element-partials)" that allows you to render an HTML representation of an element (like an `Entry`) by simply calling `{{ element.render() }}` in your templates. 

For matrix fields like "Content Blocks" (Inhaltblöcke), this streamlines how the HTML gets compiled for each block type. There's no longer a need to loop through each block and include a Twig file per block type. Instead, you provide Twig files per entry type inside a subdirectory (see `/element-partials/entry/` in the example above), and Craft will sort it out through its `.render()` function.

The `element-partials/` directory can't be renamed or moved unless you update the `partialTemplatesPath` [config setting](https://craftcms.com/docs/5.x/reference/config/general.html#partialtemplatespath) in `/config/general.php`.

**NOTE** that Twig files inside `element-partials/{element}/` are named in camelcase (`richText.twig`, for example) instead of the standard kebabcase (`rich-text.twig`). This is because the filenames must match the handles of entry types (for `Entry` elements), volumes (for `Asset`s), etc.

---

_Delete this file once you know your way around._
