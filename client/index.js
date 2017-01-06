import './phoenix_html'
import './app.scss'

function init() {
  var images = document.getElementsByTagName('img');
  for (var i = 0; i < images.length; i++) {
    if (images[i].getAttribute('data-src')) {
      images[i].setAttribute('src', images[i].getAttribute('data-src'));
    }
  }
}

window.onload = init;
