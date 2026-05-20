// Cherry Notebooks — Service Worker
const CACHE = 'cherry-v1';
const ASSETS = [
  './',
  './index.html',
  './cherry-code.html',
  './cherry-code-compact.html',
  './cherry-root-notebook.html',
  './cherry-root-quick-edition.html',
  './manifest.webmanifest',
  './icon.svg'
];

// Pre-cache core pages on install
self.addEventListener('install', (e) => {
  e.waitUntil(
    caches.open(CACHE).then((c) => c.addAll(ASSETS)).then(() => self.skipWaiting())
  );
});

// Clean old caches on activate
self.addEventListener('activate', (e) => {
  e.waitUntil(
    caches.keys()
      .then((keys) => Promise.all(keys.filter((k) => k !== CACHE).map((k) => caches.delete(k))))
      .then(() => self.clients.claim())
  );
});

// Cache-first, with runtime caching for fonts and anything else (works offline after first visit)
self.addEventListener('fetch', (e) => {
  if (e.request.method !== 'GET') return;
  e.respondWith(
    caches.match(e.request).then((cached) => {
      if (cached) return cached;
      return fetch(e.request).then((resp) => {
        if (resp && resp.status === 200) {
          const copy = resp.clone();
          caches.open(CACHE).then((c) => c.put(e.request, copy));
        }
        return resp;
      }).catch(() => cached);
    })
  );
});
