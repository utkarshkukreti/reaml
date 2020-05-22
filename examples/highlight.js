import hljs from 'highlight.js/lib/core';
import ocaml from 'highlight.js/lib/languages/ocaml';
import javascript from 'highlight.js/lib/languages/javascript';

hljs.registerLanguage('ocaml', ocaml);
hljs.registerLanguage('javascript', javascript);

document.querySelectorAll('pre code').forEach(block => {
  hljs.highlightBlock(block);
});
