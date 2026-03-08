import { createTheme, DEFAULT_THEME, mergeMantineTheme } from "@mantine/core";

const themeOverrides = createTheme({
  primaryColor: 'blue',
  fontFamily: 'Rubik, sans-serif',
});

export const theme = mergeMantineTheme(DEFAULT_THEME, themeOverrides);