import { fetchNui } from "./fetchNui";

export const isEnvBrowser = (): boolean => {
  return !(window as any).invokeNative;
};

export const setNuiFocus = (focus: boolean) => {
  if (isEnvBrowser()) return;
  fetchNui('setNuiFocus', focus);
};

export const rem = (value: number): number => {
  const root = parseFloat(getComputedStyle(document.documentElement).fontSize);
  return value * root;
};