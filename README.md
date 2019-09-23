# BackyardBrains

## Downloading the repository

### Download .zip
For users unfamiliar with git, the latest version of the repository can be downloaded by simply clicking the green "Clone or download" button, and then clicking "Download .zip".

### Fork

Please [make a fork](https://help.github.com/articles/fork-a-repo/) of this repository to your own account, clone that fork to your local machine, and then [upstream remote](https://help.github.com/articles/fork-a-repo/#step-3-configure-git-to-sync-your-fork-with-the-original-spoon-knife-repository) to keep it synchronized with the main repository.

If you have generated an ssh key and associated it with your Github account, you can use the following code

```
git remote add upstream git://github.com/benfulcher/hctsa.git
```

Otherwise you can use the https version (that may ask you for your credentials every time you interact with Github):
```
git remote add upstream https://github.com/benfulcher/hctsa.git
```

You can then update to the latest stable version of the repository by pulling the master branch to your local repository:

```
git pull upstream master
```
