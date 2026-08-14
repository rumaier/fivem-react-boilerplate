import { Button, Divider, SimpleGrid, Text } from "@mantine/core";

import { Center, FloatingWindow } from "@mantine/core";
import type { FC } from "react";
import type { MountState } from "./DevWrapper";

interface DevPanelProps {
  mounted: MountState;
  toggleMount: (key: string) => void;
  setColor: (color: string) => void;
};

const colors = [ 'dark', 'gray', 'red', 'pink', 'grape', 'violet', 'indigo', 'blue', 'cyan', 'teal', 'green', 'lime', 'yellow', 'orange' ];

const DevPanel: FC<DevPanelProps> = ({ mounted, toggleMount, setColor }) => {
  
  return (
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

        <Divider label='Components' mt='xs' />
        <SimpleGrid cols={3} spacing='xs' mt='xxs' p='xs'>
          {Object.keys(mounted).map((key) => (
            <Button key={key} variant={mounted[key] ? 'filled' : 'light'} onClick={() => toggleMount(key)}>
              {key}
            </Button>
          ))}
        </SimpleGrid>
      </FloatingWindow>
  );
};

export default DevPanel;