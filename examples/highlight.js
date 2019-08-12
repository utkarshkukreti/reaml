import hljs from 'highlight.js/lib/highlight';
import ocaml from 'highlight.js/lib/languages/ocaml';

hljs.registerLanguage('ocaml', ocaml);

document.querySelectorAll('pre code').forEach(block => {
  hljs.highlightBlock(block);
});
