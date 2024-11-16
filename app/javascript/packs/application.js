// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "channels";

// bootstrap
import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application";

// raty.js関連
import Raty from "raty.js";

// RatyをjQueryのプラグインとして登録
$.fn.raty = function (options) {
  return this.each(function () {
    const raty = new Raty(this, options);
    raty.init();
  });
};

// Ratyの初期化スクリプト
import "./raty_initializer";

// Railsの基本機能
Rails.start();
Turbolinks.start();
ActiveStorage.start();
