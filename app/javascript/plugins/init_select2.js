import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  $('.sector-picker').select2({
    placeholder: "Select job sectors...",
    allowClear: true
  });
  $('.search_category').select2({
    placeholder: "Select job sectors...",
    allowClear: true,
    width: 'resolve'
  });
};

export { initSelect2 };
