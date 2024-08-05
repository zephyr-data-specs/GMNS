# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)<!-- , and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html) -->.

## [Unreleased]

### Added

- Auto-generated Markdown files using Frictionless (resolves #64)
- Adds empty template SQLite databases (one using integer and the other using string IDs) to hold a network formatted in accordance with GMNS. This is a convenience for users who may wish to exchange GMNS-formatted networks via databases rather than `.csv` files.
    - Also adds SQL create statements used to create these. The database and create statements are placed in `usage/database`
- Documentation website (where you're hopefully reading this now!) at https://zephyr-data-specs.github.io/GMNS/

### Changed

- In the json schema files, the ID fields (`node_id`, `link_id`, etc.) has always been defined as type "any", allowing text or integer to be used. This follows the example of `unique_ID` as defined in GTFS. It is certainly possible that an application may further restrict ID fields to be integer (issue #83).
- The automated generation of markdown has resulted in several non-substantive changes to the markdown files:
    - Their names are in lower case (e.g., `node.md`) rather than mixed case (e.g., `Node.id`)
    - Datatypes for the ID fields are "any", carried straight from the json files
    - Datatypes are number (rather than numeric), string (rather than text)

## [0.95] - 2024-06-14

### Added

- Add expanded example network (Cambridge, MA)

### Changed

- Branch names were changed from `development` -> `master` to `develop` -> `main` (fixed #62).
- Directory layout changed as follows (fixes #63):
    - `Conversion_Tools` -> `usage\conversion`
    - `Images` -> `docs\img`
    - `Small_Network_Examples` -> `examples`
    - `Specification` -> `spec`
    - `Specification_md` -> `docs\spec`
    - `Validation_Tools` -> `usage\validation`

## [0.94] - 2023-06-15

### Added

- Config information is now stored as a new `config` table at the dataset level (fixes #59)
- New `curb`_seg table to provide a separate segment object for curbside regulations, which may change at different locations (and more frequently) than segment-level changes to the travel lanes
- Addition of zone tables to two examples (fixed #56)

### Changed

- Adjustments to the signal phasing tables to fix #57
- Standardized `bike_facility` type names to fix #58
- Updates to validation code to use Zephyr-hosted repo (GMNSpy#2)
- Minor updates to reflect spec changes above
