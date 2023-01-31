# Renderfarm
- This repository contains my scripts for managing a Flamenco 3 render farm on Linux. 

- The code assumes that both the manager and workers share a home directory, e.g. via a NAS.

- You need to install Blender yourself, in the created "flamenco/software"-directory.

  

## Disclaimer

- Please refer to the [official Flamenco installation](https://flamenco.blender.org/usage/quickstart/) guide if you do not understand exactly what the code in this repository does.

- This repository is **not** an official repository of Flamenco.

## Setup

1. Clone and open the repository.
2. Run the setup:

  ```shell
  ./renderfarm/setup.sh
  ```

3. Please install [jq 1.6 64-bit](https://stedolan.github.io/jq/download/) in the **$HOME/Rendering/init/** directory.
3. Run the following command on the manager node:
  ```shell
   crontab -l > mycron; echo -e "@reboot $HOME/Rendering/init/manager.sh" >> mycron; crontab mycron
  ```
  This code ensures that when a render node has been restarted, the manager process gets started again.

4. Run the following command on every worker node:
  ```shell
  crontab -l > mycron; echo -e "@reboot $HOME/Rendering/init/worker.sh\n*/10 * * * * $HOME/Rendering/init/reconcileWorker.sh" >> mycron; crontab mycron
  ```
  This code ensures that when a render node has been restarted, the worker process gets started again. It also checks every 10 minutes if the worker process has crashed and restarts it if necessary.

5. After ten minutes at most, the workers should be visible in the Flamenco web interface.
6. To uninstall the whole thing, remove the created cronjobs from the cron using a code editor like VIM:
  ```shell
  crontab -e
  ```
And then stop the workers:
  ```shell
  screen -X -S flamenco-worker quit
  ```
And last but not least the manager:
  ```shell
  screen -X -S flamenco-manager quit
  ```

## Notes

- If you can only communicate with the target systems through SSH, you might be able to use X11 to access the target systems; on one with X11 installed, you can use the following command:
```shell
  ssh -Y -C <addr>
```
and start Blender or Firefox.
- It may be that your NFS is too slow to handle the traffic, this may manifest itself in an increased number of Linux kernel errors related to NFS, check with:
```shell
  dmesg
```
- If you change the flamenco installation you are using, remember to adjust the call in the scripts as well.
