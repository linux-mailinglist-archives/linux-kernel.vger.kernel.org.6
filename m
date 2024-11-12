Return-Path: <linux-kernel+bounces-405552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F134F9C52CA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B46D3283BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE0320EA2D;
	Tue, 12 Nov 2024 10:08:26 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC7C20E337
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406105; cv=none; b=WHLThtgvvcR+m4dbtm72lSJPCftaCPWbGTooPykJsuYh7BZSmYuCnz9oQ/Ef3m25Y5GFuAItdbDVusC8YRGLpE2YoGUlILpFF55vInIO72bKojEHbWYBv897Pqnk0QD1uQ0ExVLlc+GVx+OqgyGZTonFXlDREOZ5YVmAzRqtKu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406105; c=relaxed/simple;
	bh=YrfLIcJgQTwImHYjUAqcuYI8mfVECW0Zp/cBeTI7zgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kKmncA4arUhFS0TpsnmVRD06R35lLSwxZJvEymZCaMDzE9Ty+riYCLQG0452GumKs5IlWKiInBlZFdyWmxvWksndOlQsUKHO2oUK9k9x8P7xQedXENuJtJLqfJ2/gL1JjawJR47EtSHGXWRxh0LvcOdXT3A4Uej9BVuLtRSQoqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76733290e56c-0f589;
	Tue, 12 Nov 2024 18:08:19 +0800 (CST)
X-RM-TRANSID:2ee76733290e56c-0f589
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea67332912573-543f9;
	Tue, 12 Nov 2024 18:08:19 +0800 (CST)
X-RM-TRANSID:2eea67332912573-543f9
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: linus.walleij@linaro.org,
	ardb@kernel.org,
	arnd@arndb.de
Cc: linux-kernel@vger.kernel.org,
	Luo Yifan <luoyifan@cmss.chinamobile.com>
Subject: [PATCH] ARM: vfp: Fix the cacography in vfpmodule.c
Date: Tue, 12 Nov 2024 18:08:17 +0800
Message-Id: <20241112100817.287702-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20241022092302.123253-1-luoyifan@cmss.chinamobile.com>
References: <20241022092302.123253-1-luoyifan@cmss.chinamobile.com>
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




