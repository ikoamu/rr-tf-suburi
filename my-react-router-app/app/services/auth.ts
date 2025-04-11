import {
  fetchUserAttributes,
  getCurrentUser,
  type UserAttributeKey,
} from "aws-amplify/auth";

export type AppUser = {
  username: string;
  userId: string;
  attributes: Partial<Record<UserAttributeKey, string>>;
};

export async function getUser(): Promise<AppUser | null> {
  try {
    const user = await getCurrentUser();
    const userAttributes = await fetchUserAttributes();
    return {
      userId: user.userId,
      username: user.username,
      attributes: userAttributes,
    };
  } catch (_) {
    return null;
  }
}
