import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  $('.sector-picker').select2({
    placeholder: "Filter by categories...",
    allowClear: true
  });
};

export { initSelect2 };
