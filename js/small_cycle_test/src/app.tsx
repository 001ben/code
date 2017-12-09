import xs from 'xstream';
import {ISinks, ISources} from './interfaces';

export function App(sources: ISources): ISinks {
  const vtree$ = xs.of(
    <div>My Awesome Cycle.js app</div>,
  );
  // const vtree$ = xs.periodic(1000).map(i =>
  // )

  return {
    DOM: vtree$,
  };
}
