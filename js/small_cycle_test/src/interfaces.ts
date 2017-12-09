import {DOMSource, VNode} from '@cycle/dom';
import xs from 'xstream';
import {Stream} from 'xstream';

export interface ISources {
  DOM: DOMSource;
}

export interface ISinks {
  DOM: Stream<VNode>;
}

export type Component = (s: ISources) => ISinks;
