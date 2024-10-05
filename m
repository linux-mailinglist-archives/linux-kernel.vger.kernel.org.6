Return-Path: <linux-kernel+bounces-351908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE17D991782
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 16:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8371F280BE3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 14:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85EA1547C9;
	Sat,  5 Oct 2024 14:50:13 +0000 (UTC)
Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0ED7F6;
	Sat,  5 Oct 2024 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728139813; cv=none; b=dh78FODsRnxAQO1es5XTMhIB7bRLS2cD0kgau+Q6RGU0iLRRLD5qw3blWRl9ozRlngC2jtBb/7yjlId2gX4UbOA7Wc8EU5nP4I7kKnGGrO1D67eFnNH29/rz+MDj94PSR0CdO06e0RS3RstPfQtTMHWHBaw64D10QWZJG11e1Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728139813; c=relaxed/simple;
	bh=dpxyLIksqhWul0H1Y0wfSw94zcJaYszy77L79Ar/wCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g6WSIMD71bz5kR8I25gmLUci+WVSFT3eN3o5cQHz1Mb4qU8kwizrdGtDhCesMheVuQeUCmbat819nStmviy5dgBA0xGcjr16InWbttiOaEqw3MOD3MUJ+PLRF8kE+7FTAiMjaUGkwfm/huI01oqiZ72LAjBuE9fCxSa0upw8Fow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app2 (Coremail) with SMTP id HwEQrAAXH88VUAFnDJ76AA--.52506S2;
	Sat, 05 Oct 2024 22:41:25 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wDXg40UUAFn1zzZAA--.6552S2;
	Sat, 05 Oct 2024 22:41:25 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Dongliang Mu <dzm91@hust.edu.cn>
Cc: hust-os-kernel-patches@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs/zh_CN: add the translation of kbuild/kconfig.rst
Date: Sat,  5 Oct 2024 22:40:48 +0800
Message-ID: <20241005144121.3953919-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrAAXH88VUAFnDJ76AA--.52506S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW3Cr43XFyfGrW8ArWUJFW7twb_yoWkAw13pF
	1DWryxJanrAFyrAFWIkryrWF1DC3Z7Cr43Kwn7G3W3tr1FyFW5Ar4DK34jgF9xWaykArWU
	WFZ5CF12y3y2y3JanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQFb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUAV
	WUtwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AI
	YIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VACjcxG62k0Y48FwI0_Cr
	0_Gr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1UMcvj
	eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04
	k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UGApnUUUUU=
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

Finish the translation of kbuild/kconfig.rst and move kconfig
from TODO to the main body.

Update to commit f6314b76d826 ("docs: kbuild/kconfig: reformat/cleanup")

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 .../translations/zh_CN/kbuild/index.rst       |   2 +-
 .../translations/zh_CN/kbuild/kconfig.rst     | 259 ++++++++++++++++++
 2 files changed, 260 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/kbuild/kconfig.rst

diff --git a/Documentation/translations/zh_CN/kbuild/index.rst b/Documentation/translations/zh_CN/kbuild/index.rst
index b51655d981f6..e8eb448c1197 100644
--- a/Documentation/translations/zh_CN/kbuild/index.rst
+++ b/Documentation/translations/zh_CN/kbuild/index.rst
@@ -12,6 +12,7 @@
 .. toctree::
     :maxdepth: 1
 
+    kconfig
     headers_install
     gcc-plugins
 
@@ -20,7 +21,6 @@ TODO:
 - kconfig-language
 - kconfig-macro-language
 - kbuild
-- kconfig
 - makefiles
 - modules
 - issues
diff --git a/Documentation/translations/zh_CN/kbuild/kconfig.rst b/Documentation/translations/zh_CN/kbuild/kconfig.rst
new file mode 100644
index 000000000000..3b06d8913dbf
--- /dev/null
+++ b/Documentation/translations/zh_CN/kbuild/kconfig.rst
@@ -0,0 +1,259 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/kbuild/kconfig.rst
+:Translator: 慕冬亮 Dongliang Mu <dzm91@hust.edu.cn>
+
+================
+配置目标和编辑器
+================
+
+本文件包含使用 ``make *config`` 的一些帮助。
+
+使用 ``make help`` 列出所有可能的配置目标。
+
+xconfig（'qconf'）、menuconfig（'mconf'）和 nconfig（'nconf'）程序也包含
+内嵌的帮助文本。请务必查看这些帮助文本以获取导航、搜索和其他帮助信息。
+
+gconfig（'gconf'）程序的帮助文本较少。
+
+
+通用信息
+========
+
+新的内核版本通常会引入新的配置符号。更重要的是，新的内核版本可能会重命名配置符号。
+当这种情况发生时，使用之前正常工作的 .config 文件并运行 "make oldconfig"
+不一定会生成一个可正常工作的新内核，因此，你可能需要查看哪些新的内核符号被引入。
+
+要查看新配置符号的列表，请使用::
+
+    cp user/some/old.config .config
+    make listnewconfig
+
+配置程序将列出所有新配置符号，每行一个。
+
+或者，你可以使用暴力破解方法::
+
+    make oldconfig
+    scripts/diffconfig .config.old .config | less
+
+
+环境变量
+========
+
+``*config`` 的环境变量：
+
+``KCONFIG_CONFIG``
+    该环境变量可用于指定一个默认的内核配置文件名，以覆盖默认的 ".config"。
+
+``KCONFIG_DEFCONFIG_LIST``
+    该环境变量指定了一个配置文件列表，当 .config 不存在时，这些文件可用作基础配置。
+    列表中的条目以空格分隔，只有第一个存在的文件会被使用。
+
+``KCONFIG_OVERWRITECONFIG``
+    如果该环境变量被设置，当 .config 是指向其他位置的符号链接时，Kconfig 不会
+    破坏符号链接。
+
+``KCONFIG_WARN_UNKNOWN_SYMBOLS``
+    该环境变量使 Kconfig 对配置输入中所有无法识别的符号发出警告。
+
+``KCONFIG_WERROR``
+    如果该环境变量被设置，Kconfig 将所有警告视为错误。
+
+``CONFIG_``
+    如果该环境变量被设置，Kconfig 将在保存配置时，为所有符号添加其值作为前缀，
+    而不是使用默认值。
+
+``{allyes/allmod/allno/rand}config`` 的环境变量：
+
+``KCONFIG_ALLCONFIG``
+    allyesconfig/allmodconfig/allnoconfig/randconfig 这些变体也可以使用环境
+    变量 KCONFIG_ALLCONFIG 作为标志或包含用户要求设置为特定值的配置符号的文件名。
+    如果 KCONFIG_ALLCONFIG 未指定文件名，即 KCONFIG_ALLCONFIG == "" 或
+    KCONFIG_ALLCONFIG == "1"，则 ``make *config`` 将查找名为
+    "all{yes/mod/no/def/random}.config" 的文件（对应于所使用的 ``*config``
+    命令）以强制符号值。如果找不到此文件，它会查找名为 "all.config" 的文件以包含
+    强制值。
+
+    这可以创建“微型”配置（miniconfig）或自定义配置文件，其中仅包含感兴趣的配置符号。
+    然后，内核配置系统将生成完整的 .config 文件，包括 miniconfig 文件中的符号。
+
+    ``KCONFIG_ALLCONFIG`` 文件包含许多预设配置符号（通常是所有符号的子集）。
+    这些变量设置仍需遵守正常的依赖性检查。
+
+    示例::
+
+        KCONFIG_ALLCONFIG=custom-notebook.config make allnoconfig
+
+    或::
+
+        KCONFIG_ALLCONFIG=mini.config make allnoconfig
+
+    或::
+
+        make KCONFIG_ALLCONFIG=mini.config allnoconfig
+
+    这些示例将禁用大多数配置选项（allnoconfig），但启用或禁用 miniconfig 文件
+    中显式列出的选项。
+
+``randconfig`` 的环境变量：
+
+``KCONFIG_SEED``
+    如果你想调试 kconfig 解析器/前端的行为，你可以将此变量设置整数值，用于初始化
+    随机数生成器。如果未设置，将使用当前时间。
+
+``KCONFIG_PROBABILITY``
+    该变量可用于倾斜概率分布。此变量可不设置或设置为空，或设置为以下三种不同格式：
+
+    =======================     ==================  =====================
+    KCONFIG_PROBABILITY         y:n 分配             y:m:n 分配
+    =======================     ==================  =====================
+    未设置或设置为空               50  : 50            33  : 33  : 34
+    N                            N  : 100-N         N/2 : N/2 : 100-N
+    [1] N:M                     N+M : 100-(N+M)      N  :  M  : 100-(N+M)
+    [2] N:M:L                    N  : 100-N          M  :  L  : 100-(M+L)
+    =======================     ==================  =====================
+
+其中 N、M 和 L 是范围在 [0,100] 内的整数（以十进制表示），并且需满足：
+
+    [1] N+M 的范围在 [0,100] 之间
+
+    [2] M+L 的范围在 [0,100] 之间
+
+示例::
+
+    KCONFIG_PROBABILITY=10
+        10% 的布尔值将设置为 'y'，90% 设置为 'n'
+        5% 的三态值将设置为 'y'，5% 设置为 'm'，90% 设置为 'n'
+    KCONFIG_PROBABILITY=15:25
+        40% 的布尔值将设置为 'y'，60% 设置为 'n'
+        15% 的三态值将设置为 'y'，25% 设置为 'm'，60% 设置为 'n'
+    KCONFIG_PROBABILITY=10:15:15
+        10% 的布尔值将设置为 'y'，90% 设置为 'n'
+        15% 的三态值将设置为 'y'，15% 设置为 'm'，70% 设置为 'n'
+
+``syncconfig`` 的环境变量：
+
+``KCONFIG_NOSILENTUPDATE``
+    如果该变量非空，它将阻止静默的内核配置更新（需要明确更新）。
+
+``KCONFIG_AUTOCONFIG``
+    该环境变量可以设置为 "auto.conf" 文件的路径和名称。默认值为
+    "include/config/auto.conf"。
+
+``KCONFIG_AUTOHEADER``
+    该环境变量可以设置为 "autoconf.h" 头文件的路径和名称。默认值为
+    "include/generated/autoconf.h"。
+
+menuconfig
+==========
+
+在 menuconfig 中搜索：
+
+    搜索功能会搜索内核配置符号名称，因此你必须知道欲搜索内容的大致名称。
+
+    示例::
+
+        /hotplug
+        这会列出所有包含 "hotplug" 的配置符号，例如，HOTPLUG_CPU，
+        MEMORY_HOTPLUG。
+
+    若需要搜索帮助，输入 / 后跟 TAB-TAB（高亮显示 <Help>）并按回车键。
+    这说明你还可以在搜索字符串中使用正则表达式（regex），所以如果你对
+    MEMORY_HOTPLUG 不感兴趣，你可以尝试::
+
+        /^hotplug
+
+    在搜索时，符号将按以下顺序排序：
+
+    - 首先，完全匹配的符号，按字母顺序排列（完全匹配是指搜索与符号名称完全匹配）；
+    - 然后是其他匹配项，按字母顺序排列。
+
+    例如，^ATH.K 匹配::
+
+        ATH5K ATH9K ATH5K_AHB ATH5K_DEBUG [...] ATH6KL ATH6KL_DEBUG
+        [...] ATH9K_AHB ATH9K_BTCOEX_SUPPORT ATH9K_COMMON [...]
+
+    其中只有 ATH5K 和 ATH9K 完全匹配，因此它们排在前面（按字母顺序），
+    接下来是其他符号，同样按字母顺序排列。
+
+    在此菜单中，按下以 (#) 为前缀的键将直接跳转到该位置。退出此新菜单后，
+    你将返回当前的搜索结果。
+
+'menuconfig' 的用户界面选项：
+
+``MENUCONFIG_COLOR``
+    可以使用变量 MENUCONFIG_COLOR 选择不同的配色主题。使用以下命令选择主题::
+
+        make MENUCONFIG_COLOR=<theme> menuconfig
+
+    可用的主题有::
+
+      - mono       => 选择适合单色显示器的颜色
+      - blackbg    => 选择具有黑色背景的配色方案
+      - classic    => 经典外观，蓝色背景
+      - bluetitle  => 经典外观的 LCD 友好版本（默认）
+
+``MENUCONFIG_MODE``
+    此模式会将所有子菜单显示为一个大树状结构。
+
+    示例::
+
+        make MENUCONFIG_MODE=single_menu menuconfig
+
+nconfig
+=======
+
+nconfig 是一个替代的基于文本的配置工具。它在终端（窗口）底部列出功能键，用于执行
+命令。除非你在数据输入窗口中，否则你也可以直接使用相应的数字键来执行命令。例如，你
+可以直接按 6，而非 F6 进行保存。
+
+使用 F1 获取全局帮助或 F3 打开简短帮助菜单。
+
+在 nconfig 中搜索：
+
+    你可以在菜单项“提示”字符串中或配置符号中进行搜索。
+
+    使用 / 开始在菜单项中搜索。这不支持正则表达式。使用 <Down> 或 <Up>
+    分别为下一个命中项和上一个命中项。使用 <Esc> 退出搜索模式。
+
+    F8（SymSearch）在配置符号中搜索给定的字符串或正则表达式（regex）。
+
+    在 SymSearch 中，按下 (#) 前缀的键会直接跳转到该位置。退出该新菜单后，
+    你将返回到当前的搜索结果。
+
+环境变量：
+
+``NCONFIG_MODE``
+    此模式会将所有子菜单显示为一个大型树结构。
+
+    示例::
+
+        make NCONFIG_MODE=single_menu nconfig
+
+xconfig
+=======
+
+在 xconfig 中搜索：
+
+    搜索功能会搜索内核配置符号名称，因此你必须知道欲搜索内容的大致名称。
+
+    示例::
+
+        Ctrl-F hotplug
+
+    或::
+
+        菜单：File, Search, hotplug
+
+    列出所有符号名称中包含 "hotplug" 的配置符号项。在此搜索对话框中，
+    你可以更改任何未灰显条目的配置设置。你还可以输入不同的搜索字符串，
+    而无需返回主菜单。
+
+gconfig
+=======
+
+在 gconfig 中搜索：
+
+    gconfig 中没有搜索命令。然而，gconfig 具有几种不同的查看选择、模式和选项。
-- 
2.43.0


