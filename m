Return-Path: <linux-kernel+bounces-376002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A119A9E6A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 666A3B21BC3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055D319884A;
	Tue, 22 Oct 2024 09:23:31 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7308120D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729589010; cv=none; b=dWRlbaVLR46qY2Kowv9njjYwfykNC43u0CY13Vvjn+qgdY+mX+RO6Ju2Yk+pbrQB/xPIGqzBg53oeptWkS9WAwABGOxIy4HN1i9C8W30Ukj+DmMUEXsM2irty3SNvm/9gjBrJzw60jQvnkak8RYWh16YyBT/w80/QjOIwis+xkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729589010; c=relaxed/simple;
	bh=YrfLIcJgQTwImHYjUAqcuYI8mfVECW0Zp/cBeTI7zgU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oOmDEyFoionYdd9+JVKxMxqTT9C1HftLFUyn6t+V8qUINd0cczgMmZJI/6P0vOHr4bT7Z1J2xLV7Cu+OQpg4Lb9oE8ab+zo8m9t+xkNk80fLWoW1jz1saL4Tib14M8Me431RJM1bFmiN4Kxjs9+Jo5/XTjIFEK516lz322sV804=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee467176f087df-300e0;
	Tue, 22 Oct 2024 17:23:23 +0800 (CST)
X-RM-TRANSID:2ee467176f087df-300e0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.96])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee967176f0ab22-87817;
	Tue, 22 Oct 2024 17:23:22 +0800 (CST)
X-RM-TRANSID:2ee967176f0ab22-87817
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: linux@armlinux.org.uk,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	trivial@kernel.org,
	Luo Yifan <luoyifan@cmss.chinamobile.com>
Subject: [PATCH] ARM: vfp: Fix the cacography in vfpmodule.c
Date: Tue, 22 Oct 2024 17:23:02 +0800
Message-Id: <20241022092302.123253-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The word 'swtich' is wrong, so fix it.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 arch/arm/vfp/vfpmodule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index b68efe643..63f053d6f 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -140,7 +140,7 @@ static void vfp_thread_copy(struct thread_info *thread)
 /*
  * When this function is called with the following 'cmd's, the following
  * is true while this function is being run:
- *  THREAD_NOFTIFY_SWTICH:
+ *  THREAD_NOFTIFY_SWITCH:
  *   - the previously running thread will not be scheduled onto another CPU.
  *   - the next thread to be run (v) will not be running on another CPU.
  *   - thread->cpu is the local CPU number
-- 
2.27.0




