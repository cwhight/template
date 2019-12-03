//= require rails-ujs
//= require_tree .
//= require moment
//= require fullcalendar
//= require fullcalendar/locale-all

let upcoming = JSON.parse(document.getElementById("calendar").dataset.upcoming)
let past = JSON.parse(document.getElementById("calendar").dataset.past)
let pending = JSON.parse(document.getElementById("calendar").dataset.pending)

$('#calendar').fullCalendar({
  eventSources: [
  upcoming,
  past,
  pending
  ]
});


 $(".js-range-slider").ionRangeSlider({});
