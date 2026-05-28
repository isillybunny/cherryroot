// Cherry Notebooks — Service Worker (network-first for pages, cache fallback offline)
const CACHE = 'cherry-v5';
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

// Drop old caches on activate, take control immediately
self.addEventListener('activate', (e) => {
  e.waitUntil(
    caches.keys()
      .then((keys) => Promise.all(keys.filter((k) => k !== CACHE).map((k) => caches.delete(k))))
      .then(() => self.clients.claim())
  );
});

// Strategy:
//  - HTML documents (navigations): NETWORK-FIRST so updates show immediately when online,
//    falling back to cache when offline.
//  - Everything else (fonts, icon, manifest): cache-first with background refresh.
self.addEventListener('fetch', (e) => {
  const req = e.request;
  if (req.method !== 'GET') return;

  const isDoc = req.mode === 'navigate' ||
    (req.headers.get('accept') || '').includes('text/html');

  if (isDoc) {
    e.respondWith(
      fetch(req)
        .then((resp) => {
          const copy = resp.clone();
          caches.open(CACHE).then((c) => c.put(req, copy));
          return resp;
        })
        .catch(() => caches.match(req).then((cached) => cached || caches.match('./index.html')))
    );
    return;
  }

  // Static assets: cache-first, refresh in background
  e.respondWith(
    caches.match(req).then((cached) => {
      const network = fetch(req).then((resp) => {
        if (resp && resp.status === 200) {
          const copy = resp.clone();
          caches.open(CACHE).then((c) => c.put(req, copy));
        }
        return resp;
      }).catch(() => cached);
      return cached || network;
    })
  );
});
