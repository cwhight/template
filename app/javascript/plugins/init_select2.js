import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  $('.sector-picker').select2({
    placeholder: "Select job sectors...",
    allowClear: true
  });
};

export { initSelect2 };
