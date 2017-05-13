import React from 'react';
import ReactDOM from 'react-dom';

import Router from './Router';

import '../../node_modules/normalize.css/normalize.css';
import '../../node_modules/font-awesome/css/font-awesome.css';
import './styles/styles.scss';

if (module.hot) {
    module.hot.accept();
}

/* global document:true */
ReactDOM.render(
    <Router />,
    document.getElementById('app')
);
