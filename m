Return-Path: <linux-kernel+bounces-233238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1758D91B4AE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 03:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B6D1F22B58
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C8D11CA9;
	Fri, 28 Jun 2024 01:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="v9xK6vHq"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6948B2139A7;
	Fri, 28 Jun 2024 01:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719538611; cv=none; b=T8QGbQtiZVZISnptWEryaxoLSDfxvwhFMOjtrbZqP2jvp/wuQhd67wlAMq+k6vjyDGLCg02WT4AN7vjmT9ne8/K9j9VxkogSStLoxL+NB9iO/3xa0QWeSsNeurLS/mjLkKpqO+qVAy1fuCxuLPDKlkxfVsgboCt781yRXx8nogI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719538611; c=relaxed/simple;
	bh=cm+QsmGQ91yNDaHPh+Q0+zctgCiUlvxaouRRHE+n9Ak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=X32HrJ7lrt/OIDXO+MS7qZSpvGFo0r25ymhAIKEhUGC6QUc+OqreXSLJFGlp2IwASq09ej1agLATaVfHia0GLAPbWoO5UhhvfsTMprcXGTWKsjJJBDVbuycFZPD9hf1bWwaJNCuu0+UX5JiBDwBQpaEPcpR7SocJNbZUBDIZRsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=v9xK6vHq; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719538600; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=Kmb8kttOq7xbDfKI1ccEDiYQbB2zK2LbPs9zivACKls=;
	b=v9xK6vHqxY7n+FWlhhmNnmQ99NxeJXIznv8hxMdUmCzMYmYxHxrLwiDMdZDC1/rI92E+SkCi9EHMenWi01uUgUHgCj8BLWUxFLeoG1b7IACmhUUHbgYnCO/Ujt5uvg9bYvtry0m4VyUo55qMZIkstDAkkSoyzpXgIocup4gFk7E=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023225041;MF=wodemia@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W9OGQul_1719538598;
Received: from localhost.localdomain(mailfrom:wodemia@linux.alibaba.com fp:SMTPD_---0W9OGQul_1719538598)
          by smtp.aliyun-inc.com;
          Fri, 28 Jun 2024 09:36:39 +0800
From: Tao Zou <wodemia@linux.alibaba.com>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Tao Zou <wodemia@linux.alibaba.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 RESEND] zh_CN/admin-guide: Add zh_CN/admin-guide/numastat.rst translation document
Date: Fri, 28 Jun 2024 09:36:20 +0800
Message-Id: <20240628013621.46741-1-wodemia@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add translation zh_CN/admin-guide/numastat.rst and link it to
zh_CN/admin-guide/index.rst while clean its todo entry.

commit 77691ee92d4a ("Documentation: update numastat explanation")

Signed-off-by: Tao Zou <wodemia@linux.alibaba.com>
Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
Reviewed-by: Alex Shi <alexs@kernel.org>
---
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
index 000000000000..c0f54d9a6b05
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
+需要注意，在包含无内存节点（一个节点有CPUs但是没有内存）的系统中numa_hit、numa_miss和
+numa_foreign统计数据会被严重曲解。在当前的内核实现中，如果一个进程偏好一个无内存节点（即
+进程正在该节点的一个本地CPU上运行），实际上会从距离最近的有内存节点中挑选一个作为偏好节点。
+结果会导致相应的内存分配不会增加无内存节点上的numa_foreign计数器，并且会扭曲最近节点上的
+numa_hit、numa_miss和numa_foreign统计数据。
-- 
2.39.3 (Apple Git-146)


