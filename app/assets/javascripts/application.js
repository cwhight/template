//= require rails-ujs
//= require moment
//= require fullcalendar
//= require fullcalendar/locale-all
//= require_tree .

let upcoming = JSON.parse(document.getElementById("calendar").dataset.upcoming);
let past = JSON.parse(document.getElementById("calendar").dataset.past);
let pending = JSON.parse(document.getElementById("calendar").dataset.pending);

$('#calendar').fullCalendar({
  eventSources: [
    upcoming,
    past,
    pending
  ],
  dayRender: function(calEvent, cell, date) {
      cell.css('background-color', '#f4f4f4');
  }
});


 $(".js-range-slider").ionRangeSlider({});
