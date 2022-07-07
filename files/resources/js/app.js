require('./bootstrap');
window.Vue = require('vue');
import vuetify from "./vuetify";
import router from "./router";
import ckeditor from "./ckeditor";
import swiper from "./swiper";
import VuePageTransition from 'vue-page-transition';
import store from "./store";
Vue.component('pagination', require('laravel-vue-pagination'));

import Vue from 'vue'
import excel from 'vue-excel-export'

Vue.use(excel)

Vue.use(VuePageTransition);

Vue.filter('stripHtml', function (value) {
    var div = document.createElement("div");
    div.innerHTML = value;
    var text = div.textContent || div.innerText || "";
    return text;
});

var filter = function(text, length, clamp){
    clamp = clamp || '...';
    var node = document.createElement('div');
    node.innerHTML = text;
    var content = node.textContent;
    return content.length > length ? content.slice(0, length) + clamp : content;
};

Vue.filter('truncate', filter);

import App from './components/AppComponent';

new Vue({
    el: '#app',
    router,
    vuetify,
    store,
    components:{
        'App': App
    }
});
