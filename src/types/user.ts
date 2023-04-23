import {z} from 'zod';

export const RegisterUserRequest = z.object({
  body: z.object({
    name: z.string({
      required_error: 'Name is required',
    }).min(1, {
      message: 'Name is required',
    }).trim(),
    email: z.string({
      required_error: 'Email is required',
    }).min(1, {
      message: 'Email is required',
    }).email().trim().toLowerCase(),
    password: z.string({
      required_error: 'Password is required',
    }).min(8, {
      message: 'Password minimum length is 8',
    }),
  }),
});

export type RegisterUserResponse = {}

export const LoginUserRequest = z.object({
  body: z.object({
    email: z.string({
      required_error: 'Email is required',
    }).min(1, {
      message: 'Email is required',
    }).email().trim().toLowerCase(),
    password: z.string({
      required_error: 'Password is required',
    }).min(1, {
      message: 'Password is required',
    }),
  }),
});

export type LoginUserResponse = {};

export type ValidateUserResponse = {
  id: number;
  name: string;
  email: string;
}
