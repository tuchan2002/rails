import consumer from "channels/consumer";

consumer.subscriptions.create("NotificationsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log(data);
    const openNotification = document.querySelector("#open_notification");
    const notificationList = document.querySelector("#notificationList");
    notificationList.innerHTML = data.notification + notificationList.innerHTML;
    openNotification.innerHTML = data.counter;
  },
});
