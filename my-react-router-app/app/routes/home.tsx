import { Link } from "react-router";
import type { Route } from "./+types/home";
import { userContext } from "../middlewares/user-context";

export async function clientLoader({ context }: Route.ClientLoaderArgs) {
	const user = context.get(userContext);
	return { user }
}

export default function Home({
	loaderData
}: Route.ComponentProps) {
	const {user} = loaderData;
	return (
		<ul>
			<li>
				<Link to="/dashboard">
					DASHBOARD
				</Link>
			</li>
			<li>
				{user ? (
					<Link to="/logout">
						LOGOUT
					</Link>
				): (
				<Link to="/login">
					LOGIN
				</Link>
				)}
			</li>
		</ul>
	);
}
