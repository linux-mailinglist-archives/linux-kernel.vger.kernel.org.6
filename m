Return-Path: <linux-kernel+bounces-222285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD5F90FF35
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25668B26214
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852671AB8E4;
	Thu, 20 Jun 2024 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="P5d6FVCA"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599A019DF71;
	Thu, 20 Jun 2024 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873009; cv=none; b=caqxhQkTh36XCeKbts/R5VBd+T8RcyyFLAxvhchH6VviUHeAf0HTZ+uXciI3CrwuCp3eUImHe3ZCxKMF6ggjeUmlJcMv/ULYdCBNrJAuQk2aZcZrore+FMJ/IwsRc4eBlObKv9wgCLWMakng1sWqRay+UGlwWIQ5Lv4cNGJssmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873009; c=relaxed/simple;
	bh=TsOTJsXOEnVharVSeCupIbwL7W/Y+vDaQQnvOUY6CMY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=V9BCgMhVDsJ1SWn3nCxMBb1DuJaVxuIdCL1ePuOvcRGSS1nAtnvtyR4/jgBDm9nOrwFpa7Mpf3KBNuWo6nC6/TdYFUV2k9qU65PXa0zV2hTdFCmJwT8k/axZmpxtjW/8y12Ybfw3sYo5d54D33bdCRb5kg0YVzhCmCr8Rx/LcX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=P5d6FVCA; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1718872995;
	bh=FGlwTX7JS0brarckQg49dCoIerp11+y1/d+gT6mkM+s=;
	h=From:To:Cc:Subject:Date;
	b=P5d6FVCAOj1ockYlezDI69Bs3R4AqWBatkssl9Oxri3FxLM7OBLfIZQhDUXi4mjqX
	 w2usOPQuS4zG3DfHeDr1b9M409Vmbu+3AclT4Jl4uIVsfmcpgV11hzZlgnOjwung1A
	 uN3ZJ8cDkWiW25WW2kt6keyI884tdwkDfL3iWtDM=
Received: from localhost.localdomain ([203.119.160.30])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id ACC87E15; Thu, 20 Jun 2024 16:43:12 +0800
X-QQ-mid: xmsmtpt1718872992tubi3c2zy
Message-ID: <tencent_AB1A2D84652D748A2290F5305B94D4612307@qq.com>
X-QQ-XMAILINFO: NGsJ5Fy+2UsS6JkGEwNv3B2kTyx3ePqvfLeK6X3k8mUl2Ks+wBoycLUK8/SOzM
	 wRHWyBGQcX2JBlDMjJ3RqL6TxhtnnbmaH8va/Rbx2TPsZ4spBbJ11SUhqONKhhYoQIysIXDQNwwT
	 QLpaiV8k3iRzfZNrap6lEKgvSFQA1fvhviMM6fqltGBt6xFYWsObdC1LY9Wj+PQS0+89wcsFXqHG
	 550ghq6nOz3xz2X+yXyA3vMoF3iBbVe9qN3k2Mpvf4L75w0z5GqDfOKahP5BMKCxO/PgSqFYJO/o
	 AGQEYf+AzIhpC+fKZjACAyGrLGws4NlERtrBQaqgj7fVc3QgJQdz8ngiUbX5L5jD2yHrSvgJsZtA
	 SzDOvCD7DDPT2iyrBckWbbmBJYmM3qnHUaO+ioEUyytmfnGTsdkxkzNKcI5HqBpl7GE+Vrk5La6j
	 FyD2lK0O2kx1+tAPXNbRiBqKPvVRg8TK5ZPoSoljtsj/scHj5W3Mr09SodHrWn0/UkTebhzTzbGc
	 5SPl2vDGRa/7MvGjSexn1eQ6K4rx9J11PZenWibEQfI256U2A6qn/VH50vlrm5N4D7m7YdFAKzfJ
	 UFP+0c+czRqOqxYlIJe3jfvi6FAT3PU8T0hQXKhGEOVKJSpmO8mP3ezggCcIfgLAU0PVSUMppmq9
	 t4NYB9ziLWA6zy3CrxKwkAlFro3GChbj2JIMHksjfGyQqMnVSlCdqRrr7z8QD522QfXM6BEQHxrF
	 Nkqh6MSSJKv3tLRlXMkfrVjyTPR8iJ6LDefR0mSRHA/dsiPFR+KBg8UBcEzbOWoCr9wbGXfBR9Wb
	 93QV526EdbgU0GcIrkWMxBHjQD8z9JQKfNl/OjckFYg32zSMeeq8dzX73Q/aZ+TgVx1pRlspb2Ey
	 aFt/xmHBhuhgFIHF1jDOWqoHE6o2Oe6ynzhHM00RcaopNs0mgZhrBpfsCQnxuqId89mvMfVwGFJD
	 yFMKEfpHOIxQAFDMHN8G11UizOX8RyOCLuIu6r08Ej28IfTwvFSPn3aZ/09ps+ruS804jxY1g=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Tao Zou <wodemia@foxmail.com>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Tao Zou <wodemia@linux.alibaba.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] zh_CN/admin-guide: Add zh_CN/admin-guide/numastat.rst translation document
Date: Thu, 20 Jun 2024 16:43:09 +0800
X-OQ-MSGID: <20240620084310.23823-1-wodemia@foxmail.com>
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

commit 77691ee92d4a ("Documentation: update numastat explanation")

Signed-off-by: Tao Zou <wodemia@linux.alibaba.com>
Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
Reviewed-by: Alex Shi <alexs@kernel.org>
---
v3->v4: replace "在有无内存节点" with "在包含无内存节点" 
v2->v3: add space in origin commit tag
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


