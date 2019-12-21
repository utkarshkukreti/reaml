#!/usr/bin/env node

// Modified from https://github.com/baransu/graphql_ppx_re/blob/eca4afaa0e979cd0d43c4d92fe5322aa0856092f/copyPlatformBinaryInPlace.js

const fs = require('fs');

const arch = process.arch;
const platform = process.platform;

if (arch === 'ia32') {
  arch = 'x86';
}

if (platform === 'win32') {
  platform = 'win';
}

copyBinary(`bin/${platform}-${arch}.exe`, './ppx.exe');

function copyBinary(src, dst) {
  const supported = fs.existsSync(src);

  if (!supported) {
    console.error(`\
reaml_ppx does not support this platform :(
reaml_ppx comes prepacked as built binaries to avoid large
dependencies at build-time.

If you want reaml_ppx to support this platform natively,
please open an issue at our repository, linked above. Please
specify that you are on the ${platform} platform,');
on the ${arch} architecture.`);
    process.exit(1);
  }

  if (!fs.existsSync(dst)) {
    fs.copyFileSync(src, dst);
    fs.chmodSync(dst, 0755);
  }
}
