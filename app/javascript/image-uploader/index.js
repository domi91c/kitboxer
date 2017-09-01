import Vue from 'vue/dist/vue.esm';
import BootstrapVue from 'bootstrap-vue';
import 'bootstrap-vue/dist/bootstrap-vue.css';
import TurbolinksAdapter from 'vue-turbolinks';
import ImageUploader from '../image-uploader/ImageUploader.vue';

Vue.use(BootstrapVue);

document.addEventListener('DOMContentLoaded', () => {
  let el = document.querySelector('.js-image-uploader');
  if (el !== null) {
    const props = JSON.parse(el.getAttribute('data'));

    new Vue({
      render: h => h(ImageUploader, { props }),
      mixins: [TurbolinksAdapter],
    }).$mount(el);

  }
});

