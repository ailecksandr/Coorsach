# Solver

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;![Solver](https://raw.githubusercontent.com/ailecksandr/Coorsach/master/app/assets/images/favicon.png)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Example on Heroku.](https://protected-tundra-9177.herokuapp.com/)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Playing with *twitter-bootstrap, js, form_tag, routing, modules, i18n*.

## Usage

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;That's demonstrative project that firstly was targeted to be a term project for my friend.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This is the comparator for your formulas, that compare two formulas for equality. You may work with it like a default calculator or calculate formulas with parameters.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Before using parameters you must create params `.json` file that may be created at the "Create". After that enter formulas and correct filename in corresponding fields. Parameters without value equals 0 by default.\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;When you entered all data click "Accept". You'll receive a results with full map of current parameters in each formula or information about errors. Project supports internationalization.

## Features

- Created module `Polish` for Revert Polish Notation algorithm (form Revert Polish Notation view from common view and calculate it);
- Created class `Formula` that receives view of formula and array of parameters (if it exists, `default = nil`) and give a functionality to receive a result of entered formula, normal view (with one space between terms), hash with parameters and its values;
- Created small module `FloatNumber` that include method to check if string is a float number;
- Working with params using `.json` files inside the project, that could be created and removed by user;
- JQuery and JS features, like a generating color for window and relatively form text color, alerts disappearing and re-show it on hovering, preloader;
- Project supports i18n.