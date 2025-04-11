import { Outlet, redirect } from "react-router";
import { authMiddleware } from "../middlewares/auth-middleware";
import type { Route } from "./+types/private";
import { userContext } from "../middlewares/user-context";

export const unstable_clientMiddleware = [authMiddleware];

export async function clientLoader({ context }: Route.ClientLoaderArgs) {
  const user = context.get(userContext);
  if (!user) {
    return redirect("login");
  }
}

export default function PrivateLayout () {
  return (
    <Outlet/>
  );
}