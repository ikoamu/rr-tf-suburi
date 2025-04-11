import { Link, redirect } from "react-router";
import { userContext } from "../middlewares/user-context";
import type { Route } from "./+types/logout";
import { signOut } from "aws-amplify/auth";

export async function clientLoader({ context }: Route.ClientLoaderArgs) {
  const user = context.get(userContext)
  if (!user) {
    throw redirect('/');
  }
}

export default function Logout () {
  return (
    <div>
      <button
        onClick={() => {
          signOut()
        }}
      >
        Logout
      </button>
      <br />
      <Link to="/">BACK TO TOP</Link>
    </div>
  );
}