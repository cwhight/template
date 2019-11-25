import "bootstrap";
import { openApply, closeApply } from '../components/apply';

import 'mapbox-gl/dist/mapbox-gl.css';
import { initMapbox } from '../plugins/init_mapbox';
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';
import { initAutocomplete } from '../plugins/init_autocomplete';
import { hideMap } from '../components/hideMap';
import { dashboard } from '../components/dashboard';

openApply();
closeApply();
initMapbox();
initAutocomplete();



