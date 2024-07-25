Return-Path: <linux-kernel+bounces-262478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C320993C788
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0042C1C218B3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED1919D8A7;
	Thu, 25 Jul 2024 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="WO7aAWjl"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D11A19AD8B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721927497; cv=none; b=XybrfHK5phbz6h//eszXoieqs4sJADVVmST30QIYupowQGSCV0OBSOC+Kz2t2xO86uutwqkrlBdY8mvRZUgYALuAu6qePu8T31V6ArSO4yNJD78VTh7R0M3fWR0KKF1kauMqva17SR0Hjamfdu2Pe04ACN+TZtnWGBznJvDW6lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721927497; c=relaxed/simple;
	bh=Zhvgju380u+RJ4OPfjTpW3T4MhnljOZvejOUqTnN5To=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=M2aGtFo5AYJHLSzCRubp1FOVYyz9ofizM66ujyyn34yk7WZdtidM27Ul+DmBuAnBeBlW6z38mcmu2SGbTJslpPGhWS7u9VJJIuzkTZu3ADUeto1jbIDPj1AhYEW5RzuJt9RNpGXl8+/ar6ZZMsak+v/89Imk5myLmsi3z9DrGnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=WO7aAWjl; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1721927487;
	bh=Zhvgju380u+RJ4OPfjTpW3T4MhnljOZvejOUqTnN5To=;
	h=From:Date:Subject:To:Cc:From;
	b=WO7aAWjl7MGK303iZXJehrcmGGdJtnyg8gt99msa35mSsTDHY8vKnW3vNh2uoH5FY
	 wYBbLxD4KRvHGGgZ3P6h3AAzaROgAjUlvObeEN3RvnX5go6PKA3vBdm49dn2WTllDY
	 Lnjgax5ANRVavgXlN/xIG9+eYZCSN7rFVpyjiDFY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 25 Jul 2024 19:10:44 +0200
Subject: [PATCH] tools/nolibc: add stdbool.h header
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240725-nolibc-stdbool-v1-1-a6ee2c80bcde@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIABOHomYC/x3MSwqAMAwA0atI1gZsqCheRVz0EzVQWmlFBPHuF
 pdvMfNA4SxcYGoeyHxJkRQrVNuA203cGMVXA3Wku4F6jCmIdVhOb1MKqHo2eiSvrCao0ZF5lfs
 fzsv7fnjnephgAAAA
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721927487; l=2030;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Zhvgju380u+RJ4OPfjTpW3T4MhnljOZvejOUqTnN5To=;
 b=6raiDBvtjIoXpcBzTXMZT6sJNLbbg8NsIbNj6gBiL2uf+slUgYi4GxPH41yNx9CU3gwBdfv6G
 fmgp5pSYGH/Dp2Y5qWS/EIGrSrM3PDbPyez19gH6sYneGHjaUo00x+m
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

stdbool.h is very simple.
Provide an implementation for the user convenience.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/Makefile  |  1 +
 tools/include/nolibc/nolibc.h  |  3 ++-
 tools/include/nolibc/stdbool.h | 16 ++++++++++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index e69c26abe1ea..a1f55fb24bb3 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -35,6 +35,7 @@ all_files := \
 		stackprotector.h \
 		std.h \
 		stdarg.h \
+		stdbool.h \
 		stdint.h \
 		stdlib.h \
 		string.h \
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 989e707263a4..92436b1e4441 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -74,7 +74,8 @@
  *            -I../nolibc -o hello hello.c -lgcc
  *
  * The available standard (but limited) include files are:
- *   ctype.h, errno.h, signal.h, stdarg.h, stdio.h, stdlib.h, string.h, time.h
+ *   ctype.h, errno.h, signal.h, stdarg.h, stdbool.h stdio.h, stdlib.h,
+ *   string.h, time.h
  *
  * In addition, the following ones are expected to be provided by the compiler:
  *   float.h, stddef.h
diff --git a/tools/include/nolibc/stdbool.h b/tools/include/nolibc/stdbool.h
new file mode 100644
index 000000000000..709abed93425
--- /dev/null
+++ b/tools/include/nolibc/stdbool.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Boolean types support for NOLIBC
+ * Copyright (C) 2024 Thomas Weißschuh <linux@weissschuh.net>
+ */
+
+#ifndef _NOLIBC_STDBOOL_H
+#define _NOLIBC_STDBOOL_H
+
+#define _Bool bool
+#define true 1
+#define false 0
+
+#define __bool_true_false_are_defined 1
+
+#endif /* _NOLIBC_STDBOOL_H */

---
base-commit: 6ca8f2e20bd1ced8a7cd12b3ae4b1ceca85cfc2b
change-id: 20240725-nolibc-stdbool-15ea482d1b42

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


