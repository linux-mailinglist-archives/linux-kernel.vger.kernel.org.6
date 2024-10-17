Return-Path: <linux-kernel+bounces-370039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 637539A2664
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BDEDB26D32
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CC01DED51;
	Thu, 17 Oct 2024 15:17:37 +0000 (UTC)
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D6F1DED55;
	Thu, 17 Oct 2024 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178257; cv=none; b=n9O+uPlqu0vhS6wY6VFwxBoC4ME1NS58tkEnPmBi85h3wgWWT55xgseIgECfzcH72dnYHRX7OVnOs8f38Zq/hqf0lj+ljHsUTkwZ0Tj1YxwHBijcmhQ801pVZoXt8o2vAVV3gOkRuRGqlEw4YYrwbKZI7At/BfIye2UFKeLTqIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178257; c=relaxed/simple;
	bh=N8FDTjAAHjLrgVYYhi2Io42aCBZbm6lwhNbA2oeQm+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rlD4uDm0AjQ4rfc/Ea24nDxtrAGrcpC/O2q3MJjUe0dp0md+Cu6dCYNSvTz8tUfumvs0Fl2pvNF6+MMNGDjXg6xjno4RGn8iPFynxJBLO21X6pNX86nv5eibfqKHBJ8udnMNZ8nwB/TDOTIyn24R97OpguiANiYt/erT3A/ihtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app1 (Coremail) with SMTP id HgEQrADXGqRWKhFntYz1Bw--.55446S2;
	Thu, 17 Oct 2024 23:16:38 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.129])
	by gateway (Coremail) with SMTP id _____wD3_49UKhFnazxNAA--.51778S2;
	Thu, 17 Oct 2024 23:16:37 +0800 (CST)
From: Dongliang Mu <dzm91@hust.edu.cn>
To: si.yanteng@linux.dev,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Jonathan Corbet <corbet@lwn.net>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	SeongJae Park <sj@kernel.org>,
	Federico Vaga <federico.vaga@vaga.pv.it>,
	Dongliang Mu <dzm91@hust.edu.cn>
Cc: hust-os-kernel-patches@googlegroups.com,
	Miguel Ojeda <ojeda@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs/zh_CN: update the translation of process/coding-style.rst
Date: Thu, 17 Oct 2024 23:16:17 +0800
Message-ID: <20241017151624.3532430-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HgEQrADXGqRWKhFntYz1Bw--.55446S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7KFy5ZFy5Ar1xZF1xtF1kZrb_yoW8Ww18pF
	y7Kr1xGa18Cryjk34xGry8Xr48GF18Jay5Kr4agwnaqFs5CFyIvrZxtF9Yva47XrW0yay5
	XF4akrW8Gw1FvaUanT9S1TB71UUUUbUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ2b7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUAV
	WUtwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AI
	YIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VACjcxG62k0Y48FwI0_Cr
	0_Gr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1UMcvj
	eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04
	k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUorcTDUUUU
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/

Update to commit c5d436f05a3f ("docs/process: fix typos")

scripts/checktranstatus.py reports:

Documentation/translations/zh_CN/process/coding-style.rst
commit c5d436f05a3f ("docs/process: fix typos")
commit 82b8000c28b5 ("net: drop special comment style")
2 commits needs resolving in total

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 .../translations/zh_CN/process/coding-style.rst       | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/Documentation/translations/zh_CN/process/coding-style.rst b/Documentation/translations/zh_CN/process/coding-style.rst
index 10b9cb4f6a65..0484d0c65c25 100644
--- a/Documentation/translations/zh_CN/process/coding-style.rst
+++ b/Documentation/translations/zh_CN/process/coding-style.rst
@@ -560,17 +560,6 @@ Documentation/translations/zh_CN/doc-guide/index.rst 和 scripts/kernel-doc 。
 	 * with beginning and ending almost-blank lines.
 	 */
 
-对于在 net/ 和 drivers/net/ 的文件，首选的长 (多行) 注释风格有些不同。
-
-.. code-block:: c
-
-	/* The preferred comment style for files in net/ and drivers/net
-	 * looks like this.
-	 *
-	 * It is nearly the same as the generally preferred comment style,
-	 * but there is no initial almost-blank line.
-	 */
-
 注释数据也是很重要的，不管是基本类型还是衍生类型。为了方便实现这一点，每一行
 应只声明一个数据 (不要使用逗号来一次声明多个数据)。这样你就有空间来为每个数据
 写一段小注释来解释它们的用途了。
-- 
2.43.0


