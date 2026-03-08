export const isEnvBrowser = (): boolean => {
  return !(window as any).invokeNative;
};

export const wait = (ms: number): Promise<void> => {
  return new Promise((resolve) => setTimeout(resolve, ms));
};