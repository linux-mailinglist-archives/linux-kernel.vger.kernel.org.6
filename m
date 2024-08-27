Return-Path: <linux-kernel+bounces-303581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC8D960F24
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0271F2248C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24521C93CE;
	Tue, 27 Aug 2024 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="S8o5Yl+W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0411A1C5792
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770507; cv=none; b=ceEGUfsnKzTyowpUEG/prLbPxGNJQh46GR5A1dgdW2qQgaY6Wbi19m5olnnAPx1s1ZPH8zp+2WKiY2GbjxhHWKpBemEmHKMa3kTwAMZ4oeZ3/mYO3E1WzGyzqudHhZXIm8KpEjZz2n3g27PLD1zM9u8vyoLsPCxeXj5ycJOPFvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770507; c=relaxed/simple;
	bh=O7qAhe2cSB3nmkK7P42MxJ69ddHjyjGLwmbiylUXWO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fmwOqr1TdHW8S/oi8WxUKTsH81JH9qHzG7lHmHPWDYCaZno4IS1DO+ab6c3TOpcggKAXuhAUTTShks1zLmcO8PVLV3Im8G7yHvIuscggSRKcPPRp2dfUPLwbVxppgpbIpV1bQZILKwmUBFiJQT4a29S4EdjZaUlRvYr7F+dKuwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=S8o5Yl+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBDBC4E691;
	Tue, 27 Aug 2024 14:55:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="S8o5Yl+W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724770504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H2OWpixOinJIHrVPeHRAC79bLQm2Gq/N3vn1/xF5OzA=;
	b=S8o5Yl+WORSo/6wyUhqOibeAyVPcL2ALUTAhxItMUgcHS8YcjXYmETNHHry9/Hvywc2ntc
	ToBz+Mge9eXh9iFRjhGq1bHcbPVWG8d7d6KxzWh8mC6iIpdqyy3k6sYFV76mLeDMsiEdMQ
	dluTrqSTO5aE4OpvWWF4spupD7DEqDc=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1d45b1fe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Aug 2024 14:55:04 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kernel@vger.kernel.org,
	adhemerval.zanella@linaro.org,
	christophe.leroy@csgroup.eu
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] selftests/vDSO: remove unnecessary command line defs from chacha test
Date: Tue, 27 Aug 2024 16:54:24 +0200
Message-ID: <20240827145454.3317093-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_FUNCTION_ALIGNMENT=0 is no longer necessary and BULID_VDSO wasn't
spelled right while BUILD_VDSO isn't necessary, so just remove these.

Reported-by: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 tools/testing/selftests/vDSO/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index 834aa862ba2c..d1452c7d6d4f 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -46,5 +46,4 @@ $(OUTPUT)/vdso_test_chacha: LDLIBS += $(SODIUM_LIBS)
 $(OUTPUT)/vdso_test_chacha: CFLAGS += -idirafter $(top_srcdir)/tools/include \
                                       -idirafter $(top_srcdir)/arch/$(ARCH)/include \
                                       -idirafter $(top_srcdir)/include \
-                                      -D__ASSEMBLY__ -DBULID_VDSO -DCONFIG_FUNCTION_ALIGNMENT=0 \
-                                      -Wa,--noexecstack $(SODIUM_CFLAGS)
+                                      -D__ASSEMBLY__ -Wa,--noexecstack $(SODIUM_CFLAGS)
-- 
2.46.0


