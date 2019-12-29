import React from 'react';
import { createElement as h } from 'react';

export const Counter = ({ initial }) => {
  const [count, setCount] = React.useState(initial);
  return h(
    'div',
    {},
    h('button', { onClick: () => setCount(count - 1) }, '-'),
    ` ${count} `,
    h('button', { onClick: () => setCount(count + 1) }, '+'),
  );
};
