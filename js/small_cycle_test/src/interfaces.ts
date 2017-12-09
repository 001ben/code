import {DOMSource, VNode} from '@cycle/dom';
import {HTTPSource, RequestInput} from '@cycle/http';
import xs from 'xstream';
import {Stream} from 'xstream';

export interface ISources {
  DOM: DOMSource;
  HTTP: HTTPSource;
}

export interface ISinks {
  DOM: Stream<VNode>;
  HTTP: Stream<RequestInput>;
}

export type Component = (s: ISources) => ISinks;
