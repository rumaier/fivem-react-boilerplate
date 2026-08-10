import { BackgroundImage, Button, Center, Divider, FloatingWindow, SimpleGrid, Text, type MantineTheme } from "@mantine/core";
import type { Dispatch, FC, PropsWithChildren, SetStateAction } from "react";
import { isEnvBrowser } from "../utils/misc";

interface DevWrapperProps extends PropsWithChildren {
  setTheme: Dispatch<SetStateAction<MantineTheme>>;
};

const DevWrapper: FC<DevWrapperProps> = ({ setTheme, children }) => {

  const colors = [ 'dark', 'gray', 'red', 'pink', 'grape', 'violet', 'indigo', 'blue', 'cyan', 'teal', 'green', 'lime', 'yellow', 'orange' ];
  
  const setColor = (color: string) => {
    setTheme((theme) => ({
      ...theme,
      primaryColor: color,
    }));
  };
  
  return isEnvBrowser() ? (
    <BackgroundImage src='https://i.postimg.cc/NjzPLRhf/image.png' h='100vh' w='100vw'>
      <FloatingWindow dragHandleSelector='.drag-handle' withBorder initialPosition={{top: 10, left: 10 }} style={{ userSelect: 'none' }}>
        <Center h='1.25rem' bg='dark.9' className='drag-handle'>
          <Text size='xs'>
            Dev Mode
          </Text>
        </Center>
        <Divider />

        <Divider label='Primary Color' mt='xs' />
        <SimpleGrid cols={7} spacing='xs' mt='xxs' p='xs'>
          {colors.map((color) => (
            <Button key={color} bdrs='xxl' color={color} onClick={() => setColor(color)} />
          ))}
        </SimpleGrid>
      </FloatingWindow>
      {children}
    </BackgroundImage>
  ) : (
    <>{children}</>
  );
};

export default DevWrapper;
