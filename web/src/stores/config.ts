import { create } from "zustand";
import { fetchNui } from "../utils/fetchNui";
import { addInitialFetch } from "../utils/initFetch";

export const useConfigStore = create<any>(() => ({}));

// Populated from Lua buildNuiConfig() whitelist — not the full server Cfg table.
addInitialFetch('fetchConfig', () => {
  fetchNui<any>('fetchConfig').then((resp) => {
    useConfigStore.setState(resp);
  }).catch((err) => {
    console.error('Failed to fetch config', err);
  });
});
