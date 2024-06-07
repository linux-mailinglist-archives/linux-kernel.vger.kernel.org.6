Return-Path: <linux-kernel+bounces-205261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31BB8FFA16
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 05:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA551C222B8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 03:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8EE17571;
	Fri,  7 Jun 2024 03:06:21 +0000 (UTC)
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34144DDC9;
	Fri,  7 Jun 2024 03:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.114.0.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717729581; cv=none; b=ZMZmKfqp6sIzoUBAICOWEF+aV/07dAhmdWBSgIQeCLgztFkvlOu8yYNqoB/6exhDzgVM2dcXoQWIaxFm0VWP2bz1uaWrrkkLOsSAwjxA3ZnwEmAyyn3PynMoGQu798uGxbmrqL+ULSLepf9z4AthQGFPM5IGO5m7B2KONPMIq94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717729581; c=relaxed/simple;
	bh=r/BCZHrbUXb73Owi/ShfMwGxZYo6J6aemMtwMA69ATQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=RS8fU6NYMk8yWJe3UCl8DtF/FRtIxHZRv5Lyfhn+xfLqDVKTIp2fLBF6qjFewgJaXlfqfOsDc3BFqsXD/RBWYZYqVawQmovUrsOc0MtnXR4P6vu8Rn6GfU6QrPNVuKOIvPm7/hF4g7Dqei67MBHz8KXRtbMiBmWCF8meRuL6GiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=202.114.0.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app2 (Coremail) with SMTP id HwEQrAAHOMRvd2JmCPNjAQ--.45924S2;
	Fri, 07 Jun 2024 10:58:55 +0800 (CST)
Received: from pride-poweredge-r740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wDXEFRjd2JmnmJAAA--.16835S2;
	Fri, 07 Jun 2024 10:58:50 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs/zh_CN: update the translation of security-bugs
Date: Fri,  7 Jun 2024 10:58:26 +0800
Message-Id: <20240607025842.24321-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrAAHOMRvd2JmCPNjAQ--.45924S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoWxKFyfCw45JF4UtFyxXryDtrb_yoW3Xw15p3
	ZFgryxKanrJ3WYkFWfKr1UGF1xGFWfC3y3Krn8Ja4fJF1kAr4vqrn8tryvgayfXryrKayD
	ZFWFkFW3Wry2yrUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQab7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	126r1DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jDkucUUUUU=
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

Update to commit 5928d411557e ("Documentation: Document the Linux Kernel
CVE process")

commit 0217f3944aeb ("Documentation: security-bugs.rst: linux-distros
relaxed their rules")
commit 3c1897ae4b6b ("Documentation: security-bugs.rst: clarify CVE
handling")
commit 4fee0915e649 ("Documentation: security-bugs.rst: update
preferences when dealing with the linux-distros group")
commit 44ac5abac86b ("Documentation/security-bugs: move from admin-guide/
to process/")

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 .../translations/zh_CN/admin-guide/index.rst  |  1 -
 .../translations/zh_CN/process/index.rst      |  3 +-
 .../zh_CN/process/security-bugs.rst           | 84 +++++++++++++++++++
 3 files changed, 86 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/translations/zh_CN/process/security-bugs.rst

diff --git a/Documentation/translations/zh_CN/admin-guide/index.rst b/Documentation/translations/zh_CN/admin-guide/index.rst
index ac2960da33e6..773c53956000 100644
--- a/Documentation/translations/zh_CN/admin-guide/index.rst
+++ b/Documentation/translations/zh_CN/admin-guide/index.rst
@@ -37,7 +37,6 @@ Todolist:
 
    reporting-issues
    reporting-regressions
-   security-bugs
    bug-hunting
    bug-bisect
    tainted-kernels
diff --git a/Documentation/translations/zh_CN/process/index.rst b/Documentation/translations/zh_CN/process/index.rst
index 5c6c8ccdd50d..011dc2cf583a 100644
--- a/Documentation/translations/zh_CN/process/index.rst
+++ b/Documentation/translations/zh_CN/process/index.rst
@@ -49,10 +49,11 @@ TODOLIST:
 
    embargoed-hardware-issues
    cve
+   security-bugs
 
 TODOLIST:
 
-* security-bugs
+* handling-regressions
 
 其它大多数开发人员感兴趣的社区指南：
 
diff --git a/Documentation/translations/zh_CN/process/security-bugs.rst b/Documentation/translations/zh_CN/process/security-bugs.rst
new file mode 100644
index 000000000000..a8f5fcbfadc9
--- /dev/null
+++ b/Documentation/translations/zh_CN/process/security-bugs.rst
@@ -0,0 +1,84 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: :doc:`../../../process/security-bugs`
+
+:译者:
+
+ 吴想成 Wu XiangCheng <bobwxc@email.cn>
+ 慕冬亮 Dongliang Mu <dzm91@hust.edu.cn>
+
+安全缺陷
+=========
+
+Linux内核开发人员非常重视安全性。因此我们想知道何时发现了安全漏洞，以便尽快
+修复和披露。请向Linux内核安全团队报告安全漏洞。
+
+联络
+-----
+
+可以通过电子邮件<security@kernel.org>联系Linux内核安全团队。这是一个安全人员
+的私有列表，他们将帮助验证错误报告并开发和发布修复程序。如果您已经有了一个
+修复，请将其包含在您的报告中，这样可以大大加快处理进程。安全团队可能会从区域维护
+人员那里获得额外的帮助，以理解和修复安全漏洞。
+
+与任何缺陷一样，提供的信息越多，诊断和修复就越容易。如果您不清楚哪些信息有用，
+请查看“Documentation/translations/zh_CN/admin-guide/reporting-issues.rst”中
+概述的步骤。任何利用漏洞的攻击代码都非常有用，未经报告者同意不会对外发布，
+除非已经公开。
+
+请尽可能发送无附件的纯文本电子邮件。如果所有的细节都藏在附件里，那么就很难对
+一个复杂的问题进行上下文引用的讨论。把它想象成一个
+:doc:`常规的补丁提交 <../process/submitting-patches>` （即使你还没有补丁）：
+描述问题和影响，列出复现步骤，然后给出一个建议的解决方案，所有这些都是纯文本的。
+
+披露和限制信息
+---------------
+
+安全列表不是公开渠道。为此，请参见下面的协作。
+
+一旦开发出了健壮的补丁，发布过程就开始了。对公开的缺陷的修复会立即发布。
+
+尽管我们倾向于在未公开缺陷的修复可用时即发布补丁，但应报告者或受影响方的请求，
+这可能会被推迟到发布过程开始后的7日内，如果根据缺陷的严重性需要更多的时间，
+则可额外延长到14天。推迟发布修复的唯一有效原因是为了适应QA的逻辑和需要发布
+协调的大规模部署。
+
+虽然可能与受信任的个人共享受限信息以开发修复，但未经报告者许可，此类信息不会
+与修复程序一起发布或发布在任何其他披露渠道上。这包括但不限于原始错误报告和
+后续讨论（如有）、漏洞、CVE信息或报告者的身份。
+
+换句话说，我们唯一感兴趣的是修复缺陷。提交给安全列表的所有其他资料以及对报告
+的任何后续讨论，即使在解除限制之后，也将永久保密。
+
+与其他团队协调
+--------------
+
+虽然内核安全团队仅关注修复漏洞，但还有其他组织关注修复发行版上的安全问题以及协调
+操作系统厂商的漏洞披露。协调通常由 "linux-distros" 邮件列表处理，而披露则由
+公共 "oss-security" 邮件列表进行。两者紧密关联且被展示在 linux-distros 维基：
+<https://oss-security.openwall.org/wiki/mailing-lists/distros>
+
+请注意，这三个列表的各自政策和规则是不同的，因为它们追求不同的目标。内核安全团队
+与其他团队之间的协调很困难，因为对于内核安全团队，保密期（即最大允许天数）是从补丁
+可用时开始，而 "linux-distros" 则从首次发布到列表时开始计算，无论是否存在补丁。
+
+因此，内核安全团队强烈建议，作为一位潜在安全问题的报告者，在受影响代码的维护者
+接受补丁之前，且在您阅读上述发行版维基页面并完全理解联系 "linux-distros"
+邮件列表会对您和内核社区施加的要求之前，不要联系 "linux-distros" 邮件列表。
+这也意味着通常情况下不要同时抄送两个邮件列表，除非在协调时有已接受但尚未合并的补丁。
+换句话说，在补丁被接受之前，不要抄送 "linux-distros"；在修复程序被合并之后，
+不要抄送内核安全团队。
+
+CVE分配
+--------
+
+安全团队不分配 CVE，同时我们也不需要 CVE 来报告或修复漏洞，因为这会使过程不必要
+的复杂化，并可能延误漏洞处理。如果报告者希望为确认的问题分配一个 CVE 编号，
+可以联系 :doc:`内核 CVE 分配团队 <../process/cve>` 获取。
+
+保密协议
+---------
+
+Linux内核安全团队不是一个正式的机构实体，因此无法签订任何保密协议。
-- 
2.34.1


