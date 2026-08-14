import { BackgroundImage } from "@mantine/core";
import { Fragment, useState, type FC, type PropsWithChildren } from "react";
import { isEnvBrowser } from "../../utils/misc";
import DevPanel from "./DevPanel";

interface DevWrapperProps extends PropsWithChildren {
  setColor: (color: string) => void;
};

export interface MountState {
  [key: string]: boolean;
};

const DevWrapper: FC<DevWrapperProps> = ({ setColor, children }) => {

  if (!isEnvBrowser()) return <>{children}</>;

  const mountState: MountState = {};
  Object.values(children as any).forEach((child: any) => {
    mountState[child.type.name] = false;
  });

  const [mounted, setMounted] = useState<MountState>(mountState);

  const toggleMount = (key: string) => {
    setMounted((prev) => ({ ...prev, [key]: !prev[key] }));
  };

  return (
    <BackgroundImage src='https://i.postimg.cc/NjzPLRhf/image.png' h='100vh' w='100vw'>
      <DevPanel mounted={mounted} toggleMount={toggleMount} setColor={setColor} />
      
      {Object.values(children as any).map((child: any) => (
        <Fragment key={child.type.name}>
          {mounted[child.type.name] && child}
        </Fragment>
      ))}
    </BackgroundImage>
  );
};

export default DevWrapper;
