import Vue from 'vue';
import Vuetify from 'vuetify/lib/framework';

Vue.use(Vuetify);

import ru from "vuetify/es5/locale/ru.js";

export default new Vuetify({
    theme: { dark: true },
    locales: { ru },
    current: 'ru',
});
