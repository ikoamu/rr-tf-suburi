import {
  index,
  layout,
  route,
  type RouteConfig,
} from "@react-router/dev/routes";

export default [
  layout("./layouts/public.tsx", [
    index("routes/home.tsx"),
    route("login", "routes/login.tsx"),
    route("logout", "routes/logout.tsx"),
    route("callback", "routes/auth.callback.tsx"),
  ]),
  layout("./layouts/private.tsx", [
    route("dashboard", "./routes/dashboard.tsx"),
  ]),
] satisfies RouteConfig;
