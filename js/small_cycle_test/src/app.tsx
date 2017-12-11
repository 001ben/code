// Imports ====
import {DOMSource, VNode} from '@cycle/dom';
import isolate from '@cycle/isolate';
import xs from 'xstream';
import {Stream} from 'xstream';
import {ISinks, ISliderSinks, ISliderSources, ISources} from './interfaces';
// ===

// App function ====
export function App(sources: ISources): ISinks {
  // return { DOM: view(model(intent(sources.DOM))) };
  const weightProps$ = xs.of({
    label: 'Weight', max: 150, min: 40, unit: 'kg', value: 70,
  });
  const heightProps$ = xs.of({
    label: 'Height', max: 210, min: 140, unit: 'cm', value: 170,
  });

  const weightSources = {DOM: sources.DOM, props: weightProps$};
  const heightSources = {DOM: sources.DOM, props: heightProps$};

  const weightSlider = isolate(LabeledSlider)(weightSources);
  const heightSlider = isolate(LabeledSlider)(heightSources);

  const actions$: IActions = {
    changeHeight$: heightSlider.value,
    changeWeight$: weightSlider.value,
  };
  const state$ = model(actions$).remember();

  const weightVDom$ = weightSlider.DOM;
  const heightVDom$ = heightSlider.DOM;
  const vdom$ = xs.combine(state$, weightVDom$, heightVDom$)
    .map(([{ bmi }, weightVDom, heightVDom]) =>
      <div>
        {weightVDom}
        {heightVDom}
        <h2>BMI is {bmi}</h2>
      </div>,
    );

  return {
    DOM: vdom$,
  };
}
// ===

// LabeledSlider Component ====
export function LabeledSlider(sources: ISliderSources): ISliderSinks {
  const domSource = sources.DOM;
  const props$ = sources.props;

  const newValue$ = domSource
    .select('.slider')
    .events('input')
    .map((ev) => (ev.target as HTMLInputElement).value)
    .map((val) => parseInt(val, 10));

  const state$ = props$
    .map((props) => newValue$
      .map((val) => ({
        label: props.label,
        max: props.max,
        min: props.min,
        unit: props.unit,
        value: val,
      }))
      .startWith(props),
    )
    .flatten()
    .remember();

  const vdom$ = state$
    .map((state) =>
      <div className='labelled-slider'>
        <span className='label'>{`${state.label} ${state.value}${state.unit}`}</span>
        <input className='slider' type='range' min={state.min} max={state.max} value={state.value} />
      </div>,
    );

  const sinks = {
    DOM: vdom$,
    value: state$.map((state) => state.value),
  };

  return sinks;
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
