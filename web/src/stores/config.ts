import { create } from "zustand";
import { addInitialFetch } from "../utils/initFetch";
import { fetchNui } from "../utils/fetchNui";

export const useConfigStore = create<any>(() => ({}));

addInitialFetch('fetchConfig', () => {
  fetchNui<any>('fetchConfig').then((resp) => {
    useConfigStore.setState(resp);
  }).catch((err) => {
    console.error('Failed to fetch config', err);
  });
});