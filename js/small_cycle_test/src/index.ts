import {makeDOMDriver} from '@cycle/dom';
import {makeHTTPDriver} from '@cycle/http';
import {run} from '@cycle/run';
import xs from 'xstream';
import {Component} from './interfaces';

import {App, LabeledSlider} from './app';

const main: Component = App;

const drivers = {
  DOM: makeDOMDriver('#root'),
  // HTTP: makeHTTPDriver(),
};

run(main, drivers);
