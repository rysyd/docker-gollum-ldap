# gollum wiki with benefits

wiki engine - https://github.com/gollum/gollum
Оne needs initialised git repo and config.rb file (example provided)

## features

* ldap auth
* tags/sections/categories (by macros)
field 'setions' and 'title' in frontmatter and macros call for the list of pages
```
---
display_metadata: true,
sections: ['one', 'two', three]
---

<<Sections(one)>>

```