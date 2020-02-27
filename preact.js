// This file exports everything Reaml needs to work with Preact without compat
// mode.
//
// If your app is Preact compatible, using this will save a few kilobytes over
// including `preact/compat`.
//
// To use this, add `preact` as a dependency, and alias `react` and `react-dom`
// to `reaml/preact` in your build tool. For Parcel, that requires adding an
// `alias` entry to `package.json`. See [1] for how.
// [1]: https://github.com/utkarshkukreti/reaml-opinionated-starter/blob/master/package.json
export * from 'preact';
export * from 'preact/hooks';
export { memo } from 'preact/compat/src/memo';
export { createPortal } from 'preact/compat/src/portals';
