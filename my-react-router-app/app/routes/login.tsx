import { signInWithRedirect } from "aws-amplify/auth";
import { Form, Link, redirect } from "react-router";
import type { Route } from "./+types/login";
import { userContext } from "../middlewares/user-context";

export async function clientLoader({ context }: Route.ClientLoaderArgs) {
  const user = context.get(userContext)
  if (user) {
    throw redirect('/');
  }
}

export default function Login () {
  return (
    <div>
        <button onClick={() => {
          signInWithRedirect({provider: "Google"})
        }}>Login with Google</button>
        <br />
        <Link to="/">BACK TO TOP</Link>
    </div>
  );
}