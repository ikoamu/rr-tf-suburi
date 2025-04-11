import { Link, redirect } from "react-router";
import { userContext } from "../middlewares/user-context";
import type { Route } from "./+types/dashboard";
import { getTodos } from "../services/db";

export async function clientLoader({ context }: Route.ClientLoaderArgs) {
  const user = context.get(userContext)
  if (!user?.userId) {
    throw redirect("/login");
  }
  const todos = await getTodos(user.userId);
  return {
    user,
    todos
  }
}

export default function Dashboard ({
  loaderData
 }: Route.ComponentProps) {
  const {user, todos} = loaderData;
  return (
    <div>
      <p>hello! {user?.attributes.email}</p>
      <ul>
        {JSON.stringify(todos)}
      </ul>
      <Link to="/">BACK TO TOP</Link>
    </div>
  );
}