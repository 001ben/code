import {DOMSource, VNode} from '@cycle/dom';
import {HTTPSource, RequestInput} from '@cycle/http';
import xs from 'xstream';
import {Stream} from 'xstream';

export interface ISliderProps {
  label: string;
  max: number;
  min: number;
  unit: string;
  value: number;
}

export interface ISources {
  DOM: DOMSource;
}

export interface ISliderSources extends ISources {
  props: Stream<ISliderProps>;
}

export interface ISinks {
  DOM: Stream<VNode>;
}

export interface ISliderSinks extends ISinks {
  value: Stream<number>;
}

export type Component = (s: ISources) => ISinks;
