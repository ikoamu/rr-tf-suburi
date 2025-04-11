import { Link } from "react-router";
import { userContext } from "../middlewares/user-context";
import type { Route } from "./+types/dashboard";

export async function clientLoader({ context }: Route.ClientLoaderArgs) {
  const user = context.get(userContext)
  return {
    user
  }
}

export default function Dashboard ({
  loaderData
 }: Route.ComponentProps) {
  const {user} = loaderData;
  return (
    <div>
      <p>dashboard: {JSON.stringify(user)}</p>
      <br />
      <Link to="/">BACK TO TOP</Link>
    </div>
  );
}