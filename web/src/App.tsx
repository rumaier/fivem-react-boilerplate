import { MantineProvider, mergeMantineTheme, type MantineTheme } from "@mantine/core";
import { ModalsProvider } from '@mantine/modals';
import { useEffect, useState, type FC } from "react";
import DevWrapper from "./components/DevWrapper";
import { useConfigStore } from "./stores/config";
import { theme } from "./theme";
import { runInitialFetches } from "./utils/initFetch";

const App: FC = () => {
  
  const nuiColor = useConfigStore((state) => state.NuiColor);
  const [mantineTheme, setMantineTheme] = useState<MantineTheme>(theme);

  useEffect(() => {
    if (!nuiColor) return;
    const newTheme = mergeMantineTheme(theme, {
      primaryColor: nuiColor,
    });
    setMantineTheme(newTheme);
  }, [nuiColor]);

  useEffect(() => {
    runInitialFetches();
  }, []);

  return (
    <MantineProvider theme={mantineTheme} forceColorScheme='dark'>
      <ModalsProvider>
        <DevWrapper setTheme={setMantineTheme}>
          
        </DevWrapper>
      </ModalsProvider>
    </MantineProvider>
  );
};

export default App;