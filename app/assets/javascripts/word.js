var array_id = new Array();

function set_number(id) {
  if (check(id) == false) {
    var value = document.getElementById('number_of_done').innerHTML;
    value++;
    document.getElementById('number_of_done').innerHTML = value;
  }
}

function check(id) {
  for (var i = 0; i < array_id.length; i++) {
    if(array_id[i] == id)
      return true;
  }
  array_id.push(id);
  return false;
}

function timeOut() {
  $('.edit_lesson').submit();
  document.getElementById('time_lesson').innerHTML = 0;
}

function startTimer(time_created, display) {
  var timer = time_created, minutes, seconds;
  setInterval(function () {
    minutes = parseInt(timer / 60, 10);
    seconds = parseInt(timer % 60, 10);

    minutes = minutes < 10 ? '0' + minutes : minutes;
    seconds = seconds < 10 ? '0' + seconds : seconds;

    display.textContent = minutes + ':' + seconds;

    if (--timer < 0) {
      timer = 0;
      timeOut();
    }
  }, 1000);
}

window.onload = function () {
  var value = document.getElementById('time_lesson').innerHTML;
  var display = document.querySelector('#time_lesson');
  startTimer(value, display);
  var e = document.getElementById('refreshed');
  if (e.value == 'no')
    e.value = 'yes';
  else{
    e.value = 'no';
    location.reload();
  }
};

$(window).on('popstate', function (e) {
  var state = e.originalEvent.state;
  if (state !== null) {
    location.reload();
  }
});
