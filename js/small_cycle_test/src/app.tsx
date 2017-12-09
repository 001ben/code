import xs from 'xstream';
import {ISinks, ISources} from './interfaces';

export function App(sources: ISources): ISinks {

  const githubUsersRequest$ = sources.DOM.select('.get-random-user').events('click')
    .startWith(new Event('dummy click'))
    .map((ev) => {
      const randomOffset = Math.floor(Math.random() * 500);
      return {
        category: 'users',
        method: 'GET',
        url: `https://api.github.com/users?since=${randomOffset}`,
      };
    });

  const githubUsersResponse$ = sources.HTTP.select('users')
    .flatten()
    .map((res) => res.body);

  const close1Stream = sources.DOM.select('.close1').events('click')
    .startWith(new Event('starting close click'));
  const suggestion1$ = xs.combine(close1Stream, githubUsersResponse$)
    .map(([closeClick, users]) => users[Math.floor(Math.random() * users.length)]);
  const suggestion1WithNulls$ = xs.merge(suggestion1$, githubUsersRequest$.mapTo(null))
    .startWith(null);

  const vdom$ = suggestion1WithNulls$
    .map((user: any) =>
      <div className='github-user'>
      <button className='get-random-user'>Get Random User</button>
        {user === null ? null :
          <div className='user-details'>
            <button className='close1'>X</button>
            <h1 className='user-name'>{user.login}</h1>
            <img src={user.avatar_url} />
            <a className='user-github' href={user.html_url}>{user.html_url}</a>
          </div>
        }
      </div>,
  );

  return {
    DOM: vdom$,
    HTTP: githubUsersRequest$,
  };
}
