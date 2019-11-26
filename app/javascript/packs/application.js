import "bootstrap";
import { openApply, closeApply } from '../components/apply';

import 'mapbox-gl/dist/mapbox-gl.css';
import { initMapbox } from '../plugins/init_mapbox';
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';
import { initAutocomplete } from '../plugins/init_autocomplete';
import { hideMap } from '../components/hideMap';
import { dashboard } from '../components/dashboard';
import "../plugins/flatpickr";
import 'select2/dist/css/select2.css';
import { initSelect2 } from '../plugins/init_select2';

initSelect2();
openApply();
closeApply();
initMapbox();
initAutocomplete();



