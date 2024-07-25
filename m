Return-Path: <linux-kernel+bounces-262501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F80593C7D0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11C41C21965
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6263219B3CC;
	Thu, 25 Jul 2024 17:47:48 +0000 (UTC)
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD295381C8;
	Thu, 25 Jul 2024 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721929667; cv=none; b=krSD1321lABceQ3UmhAFEg1LRXojTxl8bFXzkkJiFfb1WA1gGnSxJ5SLnb0GzqIZXRngHf1WNnApBfjlxWFeS3gjh7YeyWuXR9fWif5DPq9cvaEg1LJZPM0WgNawzgjRshbtS9mO1CEX974MCKzWmBSaNwmATYLTDKxtFCDKxIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721929667; c=relaxed/simple;
	bh=GfHEn3SpY/1xshfBTUlmNjztxmDXI5GHDYSbFF8UkQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m3Mw78ZciuFm2eJHQq2Cyu9jKByZpOtVrJ/o/aJ6w9XwJ6nH8ThmMN25eQ5cyTnPFVfjZ21Fp4SjgMqFQyJ4pB0wAjzqGdNnRyaqvNAp5i5Fib9hucHXvGXAvyXO1hwA8J0+6CZ8suYOvXF9AkkwGTlDwd+IUQEo2aleJFSoHVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app2 (Coremail) with SMTP id HwEQrADXfxSGj6JmIWlSAA--.26718S2;
	Fri, 26 Jul 2024 01:46:46 +0800 (CST)
Received: from russ.tail3da2e.ts.net (unknown [10.12.177.116])
	by gateway (Coremail) with SMTP id _____wA3oHB5j6JmEy1vAA--.22887S2;
	Fri, 26 Jul 2024 01:46:45 +0800 (CST)
From: Haoyang Liu <tttturtleruss@hust.edu.cn>
To: Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: hust-os-kernel-patches@googlegroups.com,
	Haoyang Liu <tttturtleruss@hust.edu.cn>,
	kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: update dev-tools/kcsan.rst url about KTSAN
Date: Fri, 26 Jul 2024 01:46:31 +0800
Message-Id: <20240725174632.23803-1-tttturtleruss@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:HwEQrADXfxSGj6JmIWlSAA--.26718S2
Authentication-Results: app2; spf=neutral smtp.mail=tttturtleruss@hust
	.edu.cn;
X-Coremail-Antispam: 1UD129KBjvdXoW7GFy5Cr1fGw1xur4kCry8Xwb_yoWkXrXE9F
	WfXFs3J3s5JFyvgrnYkrsrWr47ua1rJrykAr4qkrZ8Gasay3ZxXF9YyrW5uF1UZ3y7uF9x
	Ar4avrWayw1xCjkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbvkYjsxI4VWxJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
	8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E
	87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2kKe7AKxV
	WUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02
	F40EFcxC0VAKzVAqx4xG6I80ewAv7VACjcxG62k0Y48FwI0_Gr1j6F4UJwAv7VCjz48v1s
	IEY20_GFW3Jr1UJwAv7VCY1x0262k0Y48FwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_
	Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l42
	xK82IY6x8ErcxFaVAv8VW8uFyUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E
	14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnI
	WIevJa73UjIFyTuYvjxUVBHqDUUUU
X-CM-SenderInfo: rxsqjiqrssiko6kx23oohg3hdfq/1tbiAQsIAmagdi8lywAIs5

The KTSAN doc has moved to
https://github.com/google/kernel-sanitizers/blob/master/KTSAN.md.
Update the url in kcsan.rst accordingly.

Signed-off-by: Haoyang Liu <tttturtleruss@hust.edu.cn>
---
 Documentation/dev-tools/kcsan.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index 02143f060b22..d81c42d1063e 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -361,7 +361,8 @@ Alternatives Considered
 -----------------------
 
 An alternative data race detection approach for the kernel can be found in the
-`Kernel Thread Sanitizer (KTSAN) <https://github.com/google/ktsan/wiki>`_.
+`Kernel Thread Sanitizer (KTSAN)
+<https://github.com/google/kernel-sanitizers/blob/master/KTSAN.md>`_.
 KTSAN is a happens-before data race detector, which explicitly establishes the
 happens-before order between memory operations, which can then be used to
 determine data races as defined in `Data Races`_.
-- 
2.25.1


