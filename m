Return-Path: <linux-kernel+bounces-365962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4035099EE9D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D70285070
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E561C07D4;
	Tue, 15 Oct 2024 14:02:38 +0000 (UTC)
Received: from zg8tmja2lje4os43os4xodqa.icoremail.net (zg8tmja2lje4os43os4xodqa.icoremail.net [206.189.79.184])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656FF1B2197;
	Tue, 15 Oct 2024 14:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.79.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000958; cv=none; b=byxAqbLJx1izBMGofwCfV8uRxrNOCWiyITekxsl/mruikchS47F4YtyGWqLYSUeLYu6wmDORzYmQ69/qzNaLS16Hcg3YGYdrm7iHahSWB2gqij//pkl7eCFZdDpUutWRwKeyXf43OHyszGUM/6Kww4VCnhPlkJ5cxhOple01UyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000958; c=relaxed/simple;
	bh=WCIixjPVUsi5A6a0hBxdzf3+ZO1NSQkbn7E+fmOCPTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q9b9Pc83QfVHZa0ralIe859OddZ2PwIPK11yUboFCBh5JkY6UBcYCFTVljgAYIj1ui4hwhyHBaWcWiJUEUIXEKWgfQgvII9wdKIOLXE/lT5DObB5Ijdu0lWXuEa5sUH8UII2PuLM0m2M9QfJbXChNzcayw/GXCGvRFDngqZMoNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=206.189.79.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app2 (Coremail) with SMTP id HwEQrAAHsBTzdQ5nAAkRAQ--.36771S2;
	Tue, 15 Oct 2024 22:02:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.12.177.116])
	by gateway (Coremail) with SMTP id _____wAXIULydQ5nxbFIAA--.32737S2;
	Tue, 15 Oct 2024 22:02:27 +0800 (CST)
From: Haoyang Liu <tttturtleruss@hust.edu.cn>
To: Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: hust-os-kernel-patches@googlegroups.com,
	Haoyang Liu <tttturtleruss@hust.edu.cn>,
	kasan-dev@googlegroups.com,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs/dev-tools: fix a typo
Date: Tue, 15 Oct 2024 22:01:59 +0800
Message-Id: <20241015140159.8082-1-tttturtleruss@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrAAHsBTzdQ5nAAkRAQ--.36771S2
Authentication-Results: app2; spf=neutral smtp.mail=tttturtleruss@hust
	.edu.cn;
X-Coremail-Antispam: 1UD129KBjvdXoW7Gry3WFWrWFyDGFy7Xr4Dtwb_yoWfKFbEyF
	WIqa1DAr98AF90qr40yrs7Xr1Svw4rWF1rCayfArW5G3sFywsxJF9Fvws0qr4Uuw47uFnr
	Crs3Zr9xtw13KjkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbkAYjsxI4VWxJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
	8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUXV
	WUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VACjcxG62k0Y48FwI0_Cr0_Gr1UMcIj6x8ErcxFaVAv8V
	W8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF04k20x
	vE74AGY7Cv6cx26r4fZr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_
	Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxUFa9aDUUUU
X-CM-SenderInfo: rxsqjiqrssiko6kx23oohg3hdfq/1tbiAQgLAmcN5cAjpwAFsO

fix a typo in dev-tools/kmsan.rst

Signed-off-by: Haoyang Liu <tttturtleruss@hust.edu.cn>
---
 Documentation/dev-tools/kmsan.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kmsan.rst b/Documentation/dev-tools/kmsan.rst
index 6a48d96c5c85..0dc668b183f6 100644
--- a/Documentation/dev-tools/kmsan.rst
+++ b/Documentation/dev-tools/kmsan.rst
@@ -133,7 +133,7 @@ KMSAN shadow memory
 -------------------
 
 KMSAN associates a metadata byte (also called shadow byte) with every byte of
-kernel memory. A bit in the shadow byte is set iff the corresponding bit of the
+kernel memory. A bit in the shadow byte is set if the corresponding bit of the
 kernel memory byte is uninitialized. Marking the memory uninitialized (i.e.
 setting its shadow bytes to ``0xff``) is called poisoning, marking it
 initialized (setting the shadow bytes to ``0x00``) is called unpoisoning.
-- 
2.25.1


