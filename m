Return-Path: <linux-kernel+bounces-220439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E8D90E1CC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 05:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE36B1F234A5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 03:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488C452F7A;
	Wed, 19 Jun 2024 03:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="jlmokgAw"
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1440A80C;
	Wed, 19 Jun 2024 03:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718766096; cv=none; b=ZLtLDj1AKQr0uUYMozImr77UPm02781iL/lZ6ntaXGjw1lGZ/ciXi0eua0U8BVGNFAl8LPc/tRV0b/tXq6TdN5htsNduXVFgkUrk9scDcFe6uxyXo2zM4EiKmwfwDxdg4RTMminTiIl6iSf33qX+ayUdx/gxd/Mz9BnP6ywLsTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718766096; c=relaxed/simple;
	bh=vZvt+Q/LzP1eRGX/oERlVvO2kvVkxg1YNUil1WnrQXw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=EdP3xU1v67qsKEuxOLwiEi4OJZBr+iTO3pKQzTaEDF63dTXzA2ZsTnulI+rt2YnHy7TZMdyD8ApWpgIDv61XAp2mn5+hspOrRajR+AJVvM3P9rfrlNsHh1Zl678hw5aYk7f8znrxchJdFsE4Rac1bXtuGHYFMg525EtAL9MBH1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=jlmokgAw; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1718766090;
	bh=0hRYs10zniVh/Kbu/d3Ip8FfbIfjenzhLGf7tpfWBTQ=;
	h=From:To:Cc:Subject:Date;
	b=jlmokgAwNvm6ELi/DVliMXdd4BZPVnr+/36zWfmR6lUcImnu3E8fldx534Qm3sXm+
	 Z6VqkgAylQhsasKlkupnOJMJjebZ68InT/uv30wjG9pXxIcSCO7+hlzDqLTlIclRtu
	 LCJ5ud8BUbGSTKK1d29RcBhpSvEW5BjIVReGiWJk=
Received: from localhost.localdomain ([203.119.160.17])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 5AB561B; Wed, 19 Jun 2024 11:01:26 +0800
X-QQ-mid: xmsmtpt1718766086tdnz6c130
Message-ID: <tencent_83C854981B8ACA301E4D0282AA961AC50406@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8tP9BJAzFHdz/bdbMa8zMAoYEa/BexjDyovkbn/YVumePIzk29d
	 EfkwUiR5gJbHWt63KbFDQr/lIw3yNoedxroGnvXa8riBv3kyhXcpUQddxX1jiuilZeDaD/om8yY/
	 iN37iWZr/c9EdnYD22OS5kyWvUklniIyqopW1m3hsVGQMh9LvPlUJYlm/TkdkrWHLRP4lI01fyU2
	 VK4S0/AQXBUdsxVFqOx3czZh6yjC5GSdvkDXqoui05fI+JabUm+bQOripuZJ/wcVEfxC7/YtJO8P
	 m3SgQz/FrVetpWcqUteJKRjR0J+cBayX6tUONZ+2WX+ymbSzAetrPg+IKHmHjJrUPtwWTXKGQWYT
	 yEi56ZI9uYG/Colwl6w43ASylNFUgHzX0u7OxDv82p/Ela+dRZv6uPc++8mrnmmjNBzh7R0RDV68
	 OVeBGb1hHwsHZHrgLo0pF3ImZhzZGjVR6aHR5W5Plr78tSJznyfzhJsD1pAjRRwVMWeUzxCYfWJl
	 4n8/wl7ed8K0YqChu6pxxRgJf6Lu+eUWiOGIvao92E2lV/oaUZXKXXaIhtggSy3u+onhLQOmGpIF
	 M+XY/ejf+wh1nQbViZXjAt0dbNG8Ox5NjN9r6v95O+gLMJ2Y7437u2cnzPrGV1TDOzMvXr7Em9i1
	 /WGujtO4yRu13eaHggyhOZTu/40y8YiH6BJk4B3kxNrX0SxYzAgaJ1eDGVPsYcVfXV9ykyv0BAsX
	 ZaDtsa87wY7K4obWczkfz2bb2GMeZ2ilSKK1nBqJAARULhsyoidV0b3lz9RdR7k8shP+dEDkWcJK
	 sv1yzDgblhKhNwmiG2aK0+rVSBgXKxTH8rg1iOQtzVpuy2hvZaOTUJTvftIJaRoHzffB8xXBHK/R
	 vmTzRXCBI64kYXIDQ+vzUxo9qg5QbDx6poC2+jpTM/OMChPxXI2n1WtLcbw8lzVNyr6JP1Dplrw9
	 f9gKvOS0GlpL+iJbi+p6q4QQ9GhSPnIvuo6pmjil2LUwee1ZdcBQ==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Tao Zou <wodemia@foxmail.com>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Tao Zou <wodemia@linux.alibaba.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] zh_CN/admin-guide: Add zh_CN/admin-guide/numastat.rst translation document
Date: Wed, 19 Jun 2024 11:01:07 +0800
X-OQ-MSGID: <20240619030107.47012-1-wodemia@foxmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tao Zou <wodemia@linux.alibaba.com>

Add translation zh_CN/admin-guide/numastat.rst and link it to
zh_CN/admin-guide/index.rst while clean its todo entry.

commit 77691ee92d4a("Documentation: update numastat explanation")

Signed-off-by: Tao Zou <wodemia@linux.alibaba.com>
--- 
v1->v2: drop the useless label "+.. _cn_numastat:" and unnecessary "=", 
	add a commit tag of origin document in commit description

 .../translations/zh_CN/admin-guide/index.rst  |  2 +-
 .../zh_CN/admin-guide/numastat.rst            | 48 +++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/admin-guide/numastat.rst

diff --git a/Documentation/translations/zh_CN/admin-guide/index.rst b/Documentation/translations/zh_CN/admin-guide/index.rst
index ac2960da33e6..0db80ab830a0 100644
--- a/Documentation/translations/zh_CN/admin-guide/index.rst
+++ b/Documentation/translations/zh_CN/admin-guide/index.rst
@@ -68,6 +68,7 @@ Todolist:
    cpu-load
    cputopology
    lockup-watchdogs
+   numastat
    unicode
    sysrq
    mm/index
@@ -109,7 +110,6 @@ Todolist:
 *   module-signing
 *   mono
 *   namespaces/index
-*   numastat
 *   parport
 *   perf-security
 *   pm/index
diff --git a/Documentation/translations/zh_CN/admin-guide/numastat.rst b/Documentation/translations/zh_CN/admin-guide/numastat.rst
new file mode 100644
index 000000000000..817043676c90
--- /dev/null
+++ b/Documentation/translations/zh_CN/admin-guide/numastat.rst
@@ -0,0 +1,48 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/admin-guide/numastat.rst
+:Translator: Tao Zou <wodemia@linux.alibaba.com>
+
+
+=======================
+Numa策略命中/未命中统计
+=======================
+
+/sys/devices/system/node/node*/numastat
+
+所有数据的单位都是页面。巨页有独立的计数器。
+
+numa_hit、numa_miss和numa_foreign计数器反应了进程是否能够在他们偏好的节点上分配内存。
+如果进程成功在偏好的节点上分配内存则在偏好的节点上增加numa_hit计数，否则在偏好的节点上增
+加numa_foreign计数同时在实际内存分配的节点上增加numa_miss计数。
+
+通常，偏好的节点是进程运行所在的CPU的本地节点，但是一些限制可以改变这一行为，比如内存策略，
+因此同样有两个基于CPU本地节点的计数器。local_node和numa_hit类似，当在CPU所在的节点上分
+配内存时增加local_node计数，other_node和numa_miss类似，当在CPU所在节点之外的其他节点
+上成功分配内存时增加other_node计数。需要注意，没有和numa_foreign对应的计数器。
+
+更多细节内容:
+
+=============== ============================================================
+numa_hit        一个进程想要从本节点分配内存并且成功。
+
+numa_miss       一个进程想要从其他节点分配内存但是最终在本节点完成内存分配。
+
+numa_foreign    一个进程想要在本节点分配内存但是最终在其他节点完成内存分配。
+
+local_node      一个进程运行在本节点的CPU上并且从本节点上获得了内存。
+
+other_node      一个进程运行在其他节点的CPU上但是在本节点上获得了内存。
+
+interleave_hit  内存交叉分配策略下想要从本节点分配内存并且成功。
+=============== ============================================================
+
+你可以使用numactl软件包（http://oss.sgi.com/projects/libnuma/）中的numastat工具
+来辅助阅读。需要注意，numastat工具目前只在有少量CPU的机器上运行良好。
+
+需要注意，在有无内存节点（一个节点有CPUs但是没有内存）的系统中numa_hit，numa_miss和
+numa_foreign统计数据会被严重曲解。在当前的内核实现中，如果一个进程偏好一个无内存节点（即
+进程正在该节点的一个本地CPU上运行），实际上会从距离最近的有内存节点中挑选一个作为偏好节点。
+结果会导致相应的内存分配不会增加无内存节点上的numa_foreign计数器，并且会扭曲最近节点上的
+numa_hit、numa_miss和numa_foreign统计数据。
-- 
2.39.3 (Apple Git-146)


