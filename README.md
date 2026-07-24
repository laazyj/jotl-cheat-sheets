# Gloomhaven: Jaws of the Lion — Cheat Sheets

Four print-ready A4 quick-reference sheets — one per mercenary — covering the
rules a returning group most often forgets: scenario setup, the round loop,
end-of-scenario scoring, and levelling up. Styled after the JOTL ability cards
(sepia parchment, dark banner headers, dense two-column layout).

Built for a group that plays a few times a year and loses table time re-learning
the rules each session.

| # | Character | Sheet | Covers |
|---|-----------|-------|--------|
| I | Hatchet | **Scenario Setup** | Setup checklist, opening doors, monster placement, common setup traps |
| II | Red Guard | **The Round** | Round sequence, end-of-round upkeep, elements, conditions, monster focus, movement |
| III | Voidwarden | **The Reckoning** | Scenario end, XP & gold, battle goals, town steps, failure handling |
| IV | Demolitionist | **Levelling Up** | Level-up steps, XP thresholds, perks, milestones, difficulty |

## Print these

Grab the PDFs from **[`dist/v1.0/`](dist/v1.0/)** — the four numbered files are the
individual sheets; `jotl-cheat-sheets.pdf` is all four bundled.

> **Print at 100% / Actual Size — not "fit to page"** — so the A4 geometry and
> margins stay true.

## Repository layout

```
content/            CONTENT.md — the reviewed rules text (source of truth)
src/                jotl-cheat-sheets.html — the final 4-sheet document
assets/
  fonts/            Pirata One + Alegreya, self-hosted (.woff2 + fonts.css)
  logos/
    svg/            traced mercenary logos used in the sheets
    source/         original raster logos + the reference photo
design/
  variations/       the three explored design directions (.html)
    previews/       one-page PDF preview of each direction
dist/
  v1.0/             released PDFs (see CHANGELOG.md)
build.sh            regenerate the PDFs from src/
```

## Rebuild the PDFs

Everything renders offline from local assets — no network needed.

```sh
./build.sh              # renders to ./build/ (git-ignored)
./build.sh dist/v1.1    # or render straight into a new release folder
```

Requires headless **Google Chrome** (or Chromium) for rendering; PDF splitting
uses poppler's `pdfseparate` when available, otherwise falls back to Chrome.

To preview or tweak by hand, open `src/jotl-cheat-sheets.html` directly in a
browser. Per-sheet density is tuned with the `tight` / `airy` / `loose` classes
on each `.page`; the `--accent` colour is set by the character class
(`hatchet`, `redguard`, `voidwarden`, `demolitionist`).

## Making changes

1. Edit the rules in `content/CONTENT.md` and mirror them into
   `src/jotl-cheat-sheets.html` (the HTML is what actually renders).
2. Run `./build.sh` and check the result.
3. For a release, render into a new `dist/vN.N/` folder and add a
   `CHANGELOG.md` entry. Older releases stay put for posterity.

To try a different look, start from one of the `design/variations/` sketches
rather than editing the final in place.

## Content accuracy

Every rule was verified against the official *Gloomhaven: Jaws of the Lion*
rulebook. `content/CONTENT.md` is the canonical text; the sheets are a typeset
subset of it.

## Contributing

This is a personal project and **contributions are not accepted** — see
[`CONTRIBUTING.md`](CONTRIBUTING.md). You're welcome to read and print the
sheets for your own games.

## Licence

The original material — layout, HTML/CSS, build tooling, and the typesetting of
the sheets — is licensed **[CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)**:
share, print, and adapt it for non-commercial use, with credit, keeping
derivatives under the same terms. Full text in [`LICENSE`](LICENSE).

This does **not** cover the game itself. *Gloomhaven: Jaws of the Lion*, its
rules, artwork, character names, and logos are the property of **Cephalofair
Games**; these sheets are an unofficial fan-made reference, not affiliated with
or endorsed by the publisher, and that content is not relicensed here. The
bundled [Pirata One](https://fonts.google.com/specimen/Pirata+One) and
[Alegreya](https://fonts.google.com/specimen/Alegreya) fonts are used under the
SIL Open Font License.
