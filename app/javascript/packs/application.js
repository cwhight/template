import "bootstrap";
import { openApply, closeApply } from '../components/apply';
import { initUpdateNavbarOnScroll } from '../components/navbar';
import 'mapbox-gl/dist/mapbox-gl.css';
import { initMapbox } from '../plugins/init_mapbox';
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css';
import { initAutocomplete } from '../plugins/init_autocomplete'

initUpdateNavbarOnScroll();
openApply();
closeApply();
initMapbox();
initAutocomplete();




