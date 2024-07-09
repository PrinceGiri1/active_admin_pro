self.addEventListener('push', function(event) {
  const options = {
    body: event.data.text(),
    icon: '',
    badge: ''
  };

  event.waitUntil(
    self.registration.showNotification('Web Push Notification', options)
  );
});
	