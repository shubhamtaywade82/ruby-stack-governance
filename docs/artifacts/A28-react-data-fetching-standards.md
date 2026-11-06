# A28 — React Data Fetching and Server Components Standards

**Layer:** runtime · **Stacks:** react · **Mirror:** react-data-fetching-standards

## Scope

HTTP request lifecycles, query caching and invalidation, optimistic updates,
and the Server/Client component boundary.

## Standards

1. Server state goes through the app's query layer with cache keys that
   include every input; `useEffect` + `setState` fetching is a defect.
2. Mutations invalidate declaratively by key — manual refetch sprinkles
   are defects; optimistic updates always define their rollback.
3. Every async surface has explicit loading, error, and empty states;
   async UI without an error boundary is a defect.
4. Server Components own route data; `'use client'` is a deliberate
   boundary declaration, not a default; server-only code and secrets
   never leak past the boundary (A35).
5. Waterfalls are banned — independent fetches run in parallel; suspense
   boundaries sit where the UX tolerates async, not around everything.
6. Query keys are typed and exported from a single module per feature;
   string-literal keys inline in components are defects.
7. Credentials live in server fetchers and httpOnly cookies; tokens in
   client fetch code are defects (A35).

## Enforcement

- `web_test` covers loading/error/empty paths and invalidation;
  `web_lint` for boundary directives; review for data ownership (A13).

## Agent Digest

- Queries own server state — cache keys include every input; useEffect+setState fetching is a defect.
- Mutations invalidate by key declaratively; optimistic updates always define rollback.
- Loading/error/empty are explicit on every async surface; error boundaries wrap async UI.
- Server Components own route data; 'use client' is a deliberate boundary; secrets stay server-side (A35).
- No waterfalls — independent fetches run in parallel; suspense sits where UX tolerates async.
- Query keys are typed and live in one module per feature — never inline string literals.
