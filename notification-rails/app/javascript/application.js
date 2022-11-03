// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "channels";

const openNotification = document.querySelector("#open_notification");
const notificationContainer = document.querySelector("#notificationContainer");

openNotification.onclick = () => {
  notificationContainer.classList.toggle("show");
};

document.onclick = (e) => {
  if (
    !notificationContainer.contains(e.target) &&
    !openNotification.contains(e.target)
  ) {
    notificationContainer.classList.remove("show");
  }
};
