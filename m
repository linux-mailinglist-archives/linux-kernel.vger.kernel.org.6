Return-Path: <linux-kernel+bounces-256948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF719372F9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 06:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C30E1F21F31
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 04:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6279A376E7;
	Fri, 19 Jul 2024 04:15:20 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B093236;
	Fri, 19 Jul 2024 04:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721362519; cv=none; b=ohOmq5bHDHQ8GlgK5l/bfmlDrokB9+xox57gWY7dVxiDRAXsSDDpJn9slGAPmRH0u23uWq4FMd1b5z5/Ga4KROAuAZQEqm7a6YTLJ422vPBXPKQrnGGHQLLW0bTMRwLTF/N16e046VR8PlwAaZeT5MOMa++u+kir0RKLGugfEro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721362519; c=relaxed/simple;
	bh=ewcG7xqXr6f2MmXfeYswZvnssTP40xufMckIKbFuPx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ujm6X6T8nbk/mOVJj+y1/HvTvVUBYq/Dp1GhdxzNFCXen3J/yb1J+U9LSX/5DJS3VMuZEjb2YHfZyKFwwdY6RoYLIRke0QSzgdd9X9Ox6uwzRvYkUWwSJqV9a9vztlc2LaqPWnw+ylVaoAtDUNXGItcbwEEEClvoopOGNLH4bzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrACnrn4v6JlmkWx4AQ--.34901S2;
	Fri, 19 Jul 2024 12:14:39 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wAnhh4I6JlmCSoKAA--.20209S4;
	Fri, 19 Jul 2024 12:14:38 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: chengziqiu@hust.edu.cn,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] doc-guide: add help documentation checktransupdate.rst
Date: Fri, 19 Jul 2024 12:13:34 +0800
Message-ID: <20240719041400.3909775-3-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240719041400.3909775-1-dzm91@hust.edu.cn>
References: <20240719041400.3909775-1-dzm91@hust.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrACnrn4v6JlmkWx4AQ--.34901S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw1kGw1kuw4UtrW5ZFWrXwb_yoW7CFWxpa
	4YkFyxW3Z7Kw13Ar1fKa4DZr13AFyxCa15KF1xt3ZYvFn8tw4vqr43ta4rKFWDJrWrZay5
	XFWYkrWI9rWFvaUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQIb7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_Jr
	v_JF1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
	0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26F
	4j6r4UJwAv7VCjz48v1sIEY20_GFW3Jr1UJwAv7VCY1x0262k0Y48FwI0_Gr1j6F4UJwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42
	xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uFyUJr1UMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Eks3UUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

This commit adds help documents - doc-guide/checktransupdate.rst
and zh_CN/doc-guide/checktransupdate.rst for scripts/checktransupdate.py
, including English and Chinese versions

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 Documentation/doc-guide/checktransupdate.rst  | 53 ++++++++++++++++++
 Documentation/doc-guide/index.rst             |  1 +
 .../zh_CN/doc-guide/checktransupdate.rst      | 55 +++++++++++++++++++
 .../translations/zh_CN/doc-guide/index.rst    |  1 +
 4 files changed, 110 insertions(+)
 create mode 100644 Documentation/doc-guide/checktransupdate.rst
 create mode 100644 Documentation/translations/zh_CN/doc-guide/checktransupdate.rst

diff --git a/Documentation/doc-guide/checktransupdate.rst b/Documentation/doc-guide/checktransupdate.rst
new file mode 100644
index 000000000000..dabbf9ecd187
--- /dev/null
+++ b/Documentation/doc-guide/checktransupdate.rst
@@ -0,0 +1,53 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Check translation update
+
+This script helps track the translation status of the documentation in
+different locales, i.e., whether the documentation is up-to-date with
+the English counterpart.
+
+How it works
+------------
+
+It uses ``git log`` command to track the latest English commit from the
+translation commit (order by author date) and the latest English commits
+from HEAD. If any differences occur, the file is considered as out-of-date,
+then commits that need to be updated will be collected and reported.
+
+Features implemented
+
+-  check all files in a certain locale
+-  check a single file or a set of files
+-  provide options to change output format
+-  track the translation status of files that have no translation
+
+Usage
+-----
+
+::
+
+   ./scripts/checktransupdate.py --help
+
+Please refer to the output of argument parser for usage details.
+
+Samples
+
+-  ``./scripts/checktransupdate.py -l zh_CN``
+   This will print all the files that need to be updated in the zh_CN locale.
+-  ``./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-tools/testing-overview.rst``
+   This will only print the status of the specified file.
+
+Then the output is something like:
+
+::
+
+    Documentation/dev-tools/kfence.rst
+    No translation in the locale of zh_CN
+
+    Documentation/translations/zh_CN/dev-tools/testing-overview.rst
+    commit 42fb9cfd5b18 ("Documentation: dev-tools: Add link to RV docs")
+    1 commits needs resolving in total
+
+Features to be implemented
+
+- files can be a folder instead of only a file
diff --git a/Documentation/doc-guide/index.rst b/Documentation/doc-guide/index.rst
index 7c7d97784626..24d058faa75c 100644
--- a/Documentation/doc-guide/index.rst
+++ b/Documentation/doc-guide/index.rst
@@ -12,6 +12,7 @@ How to write kernel documentation
    parse-headers
    contributing
    maintainer-profile
+   checktransupdate
 
 .. only::  subproject and html
 
diff --git a/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst b/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
new file mode 100644
index 000000000000..d20b4ce66b9f
--- /dev/null
+++ b/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
@@ -0,0 +1,55 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/doc-guide/checktransupdate.rst
+
+:译者: 慕冬亮 Dongliang Mu <dzm91@hust.edu.cn>
+
+检查翻译更新
+
+这个脚本帮助跟踪不同语言的文档翻译状态，即文档是否与对应的英文版本保持更新。
+
+工作原理
+------------
+
+它使用 ``git log`` 命令来跟踪翻译提交的最新英文提交（按作者日期排序）和英文文档的
+最新提交。如果有任何差异，则该文件被认为是过期的，然后需要更新的提交将被收集并报告。
+
+实现的功能
+
+- 检查特定语言中的所有文件
+- 检查单个文件或一组文件
+- 提供更改输出格式的选项
+- 跟踪没有翻译过的文件的翻译状态
+
+用法
+-----
+
+::
+
+    ./scripts/checktransupdate.py --help
+
+具体用法请参考参数解析器的输出
+
+示例
+
+-  ``./scripts/checktransupdate.py -l zh_CN``
+   这将打印 zh_CN 语言中需要更新的所有文件。
+-  ``./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-tools/testing-overview.rst``
+   这将只打印指定文件的状态。
+
+然后输出类似如下的内容：
+
+::
+
+    Documentation/dev-tools/kfence.rst
+    No translation in the locale of zh_CN
+
+    Documentation/translations/zh_CN/dev-tools/testing-overview.rst
+    commit 42fb9cfd5b18 ("Documentation: dev-tools: Add link to RV docs")
+    1 commits needs resolving in total
+
+待实现的功能
+
+- 文件参数可以是文件夹而不仅仅是单个文件
diff --git a/Documentation/translations/zh_CN/doc-guide/index.rst b/Documentation/translations/zh_CN/doc-guide/index.rst
index 78c2e9a1697f..0ac1fc9315ea 100644
--- a/Documentation/translations/zh_CN/doc-guide/index.rst
+++ b/Documentation/translations/zh_CN/doc-guide/index.rst
@@ -18,6 +18,7 @@
    parse-headers
    contributing
    maintainer-profile
+   checktransupdate
 
 .. only::  subproject and html
 
-- 
2.43.0


