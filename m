Return-Path: <linux-kernel+bounces-573548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E5CA6D8F3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DAD03A6D9B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD4F25D91A;
	Mon, 24 Mar 2025 11:12:49 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00391487D1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 11:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742814769; cv=none; b=OZY77gM5xG1QTE6iatbmr4bD/r6kXp4Dpl2hvZQ6pL9VaZkZDWqpMiQG1sbQCtyYgw8IWXYMtoV1xCkvavxHI5CFPclxCdBC8TmK9q/J5qRBHMzC98pYpEzZdh3Q+fy2/uwzeiNKjXZj5VFtrWRnEmSUgt3QVnZWO8Y/enI4TZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742814769; c=relaxed/simple;
	bh=xmzxxesLRb1PznTqO0dyHA+EcSoCm0R8PqLZKb3XSCQ=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=dnY18h4AH1g6T+gqIx+wwNEritsHtUL0uQG2OawF49KerZUoQKyt/iZu3tB5dwMXFSrLHgIzbsJ6CjH/dAW3Id7DLhfnJ81DuMNhCHt+uKza2tsMOErkD49BM38ld/ia4J5Gag4vqPG3B5Y1v14uQfelozlNgdw0J3bWEpQ1vyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZLr4P2pP9z5B1Jt;
	Mon, 24 Mar 2025 19:12:37 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 52OBCQes099737;
	Mon, 24 Mar 2025 19:12:27 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 24 Mar 2025 19:12:30 +0800 (CST)
Date: Mon, 24 Mar 2025 19:12:30 +0800 (CST)
X-Zmail-TransId: 2afb67e13e1effffffffd1e-c2365
X-Mailer: Zmail v1.0
Message-ID: <20250324191230477zpGtgIRSH4mEHdtxGtgx9@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <luto@kernel.org>
Cc: <tglx@linutronix.de>, <vincenzo.frascino@arm.com>,
        <linux-kernel@vger.kernel.org>, <yang.yang29@zte.com.cn>,
        <xu.xin16@zte.com.cn>, <ye.xingchen@zte.com.cn>,
        <jiang.peng9@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSByYW5kb206IHZEU086IEZpeCBzaGFkb3cgZGVjbGFyYXRpb25z?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 52OBCQes099737
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67E13E25.005/4ZLr4P2pP9z5B1Jt

From: Peng Jiang <jiang.peng9@zte.com.cn>

Compiling the kernel with gcc12.3 W=2 produces a warning:
In file included from linux-next/lib/vdso/getrandom.c:10,
                 from <command-line>:
linux-next/lib/vdso/getrandom.c: In function 'memcpy_and_zero_src':
./include/vdso/unaligned.h:6:44:
warning: declaration of '__pptr' shadows a previous local [-Wshadow]
  6 | const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);
    |                                    ^~~~~~
./include/vdso/unaligned.h:12:22:
note: in definition of macro '__put_unaligned_t'
 12 | __pptr->x = (val);
    |               ^~~
linux-next/lib/vdso/getrandom.c:25:41:
note: in expansion of macro '__get_unaligned_t'
 25 | __put_unaligned_t(type, __get_unaligned_t(type, src), dst);
    |                                         ^~~~~~~~~~~~~~~~~
linux-next/lib/vdso/getrandom.c:37:25:
note: in expansion of macro 'MEMCPY_AND_ZERO_SRC'
 37 | MEMCPY_AND_ZERO_SRC(u64, dst, src, len);

To reproduce the issue before applying the patch:
make defconfig ARCH=arm64 CROSS_COMPILE=aarch64-linux-
make vmlinux ARCH=arm64 CROSS_COMPILE=aarch64-linux- W=2

The existing implementation of the __get_unaligned_t and __put_unaligned_t
macros in include/vdso/unaligned.h uses a local variable named '__pptr'
which can lead to variable shadowing when these macros are used in
the same scope. This results in a -Wshadow warning during compilation.

To address this issue, we have renamed the local variables within
the macros to ensure uniqueness:
- In __get_unaligned_t, '__pptr' has been renamed to '__get_pptr'.
- In __put_unaligned_t, '__pptr' has been renamed to '__put_pptr'.

These changes prevent variable shadowing and eliminate the
-Wshadow warning, improving code readability and maintainability.

Signed-off-by: Peng Jiang <jiang.peng9@zte.com.cn>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
 include/vdso/unaligned.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/vdso/unaligned.h b/include/vdso/unaligned.h
index eee3d2a4dbe4..ff0c06b6513e 100644
--- a/include/vdso/unaligned.h
+++ b/include/vdso/unaligned.h
@@ -2,14 +2,14 @@
 #ifndef __VDSO_UNALIGNED_H
 #define __VDSO_UNALIGNED_H

-#define __get_unaligned_t(type, ptr) ({						\
-	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
-	__pptr->x;								\
+#define __get_unaligned_t(type, ptr) ({							\
+	const struct { type x; } __packed * __get_pptr = (typeof(__get_pptr))(ptr);	\
+	__get_pptr->x;									\
 })

-#define __put_unaligned_t(type, val, ptr) do {					\
-	struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);		\
-	__pptr->x = (val);							\
+#define __put_unaligned_t(type, val, ptr) do {						\
+	struct { type x; } __packed * __put_pptr = (typeof(__put_pptr))(ptr);		\
+	__put_pptr->x = (val);								\
 } while (0)

 #endif /* __VDSO_UNALIGNED_H */
-- 
2.25.1

