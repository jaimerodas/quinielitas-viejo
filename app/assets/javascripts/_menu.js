document.addEventListener('turbolinks:load', function() {
  document.querySelector('.main-links').className += ' off';
});

$(document).on('click', '.menu-button', function() {
  console.log('click!');
  $('.main-links').toggleClass('off');
});
