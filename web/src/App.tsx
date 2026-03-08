import { MantineProvider, mergeMantineTheme, type MantineTheme } from "@mantine/core";
import { ModalsProvider } from '@mantine/modals';
import { useEffect, useState, type FC } from "react";
import { useConfigStore } from "./stores/config";
import { theme } from "./theme";
import { runInitialFetches } from "./utils/initFetch";

const App: FC = () => {
  const nuiColor = useConfigStore((state) => state.NuiColor);

  const [mantineTheme, setMantineTheme] = useState<MantineTheme>(
    mergeMantineTheme(theme, {
      primaryColor: nuiColor,
    }),
  );

  useEffect(() => {
    setMantineTheme(
      mergeMantineTheme(theme, {
        primaryColor: nuiColor,
      }));
  }, [nuiColor]);

  useEffect(() => {
    runInitialFetches();
  }, []);

  console.log('Current Mantine Theme:', mantineTheme);

  return (
    <MantineProvider theme={mantineTheme} forceColorScheme='dark'>
      <ModalsProvider>
        {/* App goes here */}
      </ModalsProvider>
    </MantineProvider>
  );
};

export default App;