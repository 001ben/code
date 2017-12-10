// Imports ====
import {DOMSource, VNode} from '@cycle/dom';
import xs from 'xstream';
import {Stream} from 'xstream';
import {ISinks, ISources} from './interfaces';
// ===

// "Main" function ====
export function App(sources: ISources): ISinks {
  return { DOM: view(model(intent(sources.DOM))) };
}
// ===

// Interfaces ====
interface IActions {
  changeHeight$: Stream<number>;
  changeWeight$: Stream<number>;
}

interface IState {
  bmi: number;
  height: number;
  weight: number;
}
// ===

// User actions mapping functions ====
function intent(domSource: DOMSource): IActions {
  return {
    changeHeight$: domSource.select('.height').events('input')
      .map((ev) => (ev.target as HTMLInputElement).value)
      .map((val) => parseInt(val, 10)),
    changeWeight$: domSource.select('.weight').events('input')
      .map((ev) => (ev.target as HTMLInputElement).value)
      .map((val) => parseInt(val, 10)),
  };
}
// ===

// Model state tracking and helper ====
function model(actions: IActions): Stream<IState> {
  const weight$ = actions.changeWeight$.startWith(70);
  const height$ = actions.changeHeight$.startWith(170);
  return xs.combine(weight$, height$)
    .map(([weight, height]: [number, number]) => {
      const bmi = calculateBMI(weight, height);
      return {weight, height, bmi};
    });
}

function calculateBMI(weight: number, height: number): number {
  const heightMeters = height * 0.01;
  return Math.round(weight / (heightMeters ** 2));
}
// ===

// View function and helpers ====
function view(state$: Stream<IState>) {
  return state$.map(({weight, height, bmi}: {weight: number, height: number, bmi: number}) =>
    <div>
      {renderWeightSlider(weight)}
      {renderHeightSlider(height)}
      <h2>BMI is {bmi}</h2>
    </div>,
  );
}

function renderWeightSlider(weight: number): VNode {
  return (
    <div>
      Weight {weight} kg
      <input className='weight' type='range' min='40' max='140' value={weight} />
    </div>
  );
}

function renderHeightSlider(height: number): VNode {
  return (
    <div>
      Height {height} cm
      <input className='height' type='range' min='140' max='210' value={height} />
    </div>
  );
}
// ===
