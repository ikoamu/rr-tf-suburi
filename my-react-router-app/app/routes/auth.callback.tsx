import type { Route } from "./+types/auth.callback";
import 'aws-amplify/auth/enable-oauth-listener';
import { userContext } from "../middlewares/user-context";
import { redirect } from "react-router";

export async function clientLoader({ context }: Route.ClientLoaderArgs) {
  const user = context.get(userContext)
  if (user) {
    return redirect('/dashboard');
  }
}

export default function AuthCallback ({
}: Route.ComponentProps) {
  return (
    <>ログイン中...</>
  );
}