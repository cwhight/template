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
import { initSweetalert } from '../plugins/init_sweetalert';
import { showJobs} from '../components/showJobs';
import { stickyNavbar} from '../components/stickyNavbar';
import { openMessages } from '../components/inbox';

if (document.getElementById("open-apps")) {
  openMessages();

}

initSweetalert('#confirm-job', {
  title: "Done",
  text: "Your shift was successfully posted. You'll recieve applications soon!",
  icon: "success",
  buttons: false
});

initSweetalert('#employee-apply-sweetalert', {
  title: "Done",
  text: "Application sent. You'll hear back shortly!",
  icon: "success",
  buttons: false
});


initSelect2();
openApply();
closeApply();
initMapbox();
initAutocomplete();

const checkBox = document.querySelector(".user_employer");
const employerSvg = document.querySelector(".employer");
const employeeSvg = document.querySelector(".employee");

if (checkBox) {
  checkBox.addEventListener("click", () => {
    employerSvg.classList.toggle("full-opacity")
    employeeSvg.classList.toggle("full-opacity")
  })
}
