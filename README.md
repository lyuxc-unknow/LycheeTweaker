# LycheeTweaker

LycheeTweaker is a simple library written for CraftTweaker that adds support for the Lychee mod. Scripts will **ONLY** work on Minecraft version **1.21.1** for **Neoforge**. Scripts *should* work on Fabric but anything labeled "Neoforge Only" in the Lychee docs will most likely not work here.

LycheeTweaker 是一个基于 CraftTweaker 编写的简单库，添加了对 Lychee 模组的支持。脚本**仅**支持**1.21.1**下**Neoforge**的lychee。脚本*应该*适用于 Fabric，但是 Lychee 文档中标有“仅限 Neoforge”的内容很可能无法使用此库。想要更好的支持Fabric，你可能需要修改库来进行更好的适配。

It's highly recommended you use this library in tandem with the official [Lychee Documentation](https://lycheetweaker.readthedocs.io/en/latest/).

强烈建议您将此库与官方 [Lychee 文档](https://lycheetweaker.readthedocs.io/en/latest/)结合使用。

If you're having issues, make sure you're on the latest version of CraftTweaker. If you're still having issues, Please file issues on GitHub.

如果您遇到问题，请确保您使用的是最新版本的 CraftTweaker。如果您仍然遇到问题，请在 GitHub 上提交问题。

## How to Install/Use

Unzip the file and drag the folder into your `scripts` folder in your Minecraft instance. That's it. Once you've done that make sure to either restart the game or type `/reload` to apply new script changes.
Files should be *mostly* documented, if you need extra assistance look at the `lychee_examples.zs` file.

## 如何安装/使用

从Github下载文件，并解压到Minecraft实例文件夹下的`scripts`。完成后，使用`/reload`命令重载或者重启游戏来加载脚本文件。
库中**大部分**文件应该都有文档记录，如果需要更多的帮助，请参阅`lychee_examples.zs`文件