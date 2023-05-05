export type BaseResponse<T = any> = {
  success: boolean;
  message: string | null;
  data: T | null;
  error: any;
};
