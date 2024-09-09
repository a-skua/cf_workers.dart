export function exec(fn, req) {
  return new Promise((resolve) => {
    globalThis.__dart_cf_workers = {
      request: () => req,
      response: (res) => resolve(res),
    };
    fn();
  });
}
