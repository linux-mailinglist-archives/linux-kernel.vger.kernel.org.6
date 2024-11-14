Return-Path: <linux-kernel+bounces-408516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5E59C7FDE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 02:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999BB1F22621
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7801E3792;
	Thu, 14 Nov 2024 01:20:14 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9AC225A8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 01:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731547214; cv=none; b=Hkd/Ok6hhVrDcAvzrLUNZIEkxEvLJCzVMZRJws23TZZ1wg0awemt2VhXJCafWgbfLmA7iiBGyKcxex0KiR2nuuiglovab9OKxaJnaJSEhr1tHWQXjuqHeclgi02l6GbOWbC46AUvYJ8sVQ59xLnr9VLFweK4PVh7S/qT6mqDod4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731547214; c=relaxed/simple;
	bh=fk+5egIR3JVH8QatI0uOV5bbmhySbrgZhyxOflMEIrM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NwduqHjj/xVT6IgE/YteBA5M9IcB+tKdJ7JtqKIFoHh2ChePUFK+FwfcPmenJRG0a9LS5NY2IhZyc3HQbYO4i09slDa5T2MVr8lgybtGwa8TuWyqY3SBuqFHMFqnz6odrobXYAMSjqGA7wrbK0aceXL9lFfPH7bfAxQFs6vKDd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee1673550416e2-ecff7;
	Thu, 14 Nov 2024 09:20:02 +0800 (CST)
X-RM-TRANSID:2ee1673550416e2-ecff7
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.103])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee467355041d0f-8b5be;
	Thu, 14 Nov 2024 09:20:02 +0800 (CST)
X-RM-TRANSID:2ee467355041d0f-8b5be
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: linus.walleij@linaro.org,
	linux@armlinux.org.uk
Cc: ardb@kernel.org,
	arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Luo Yifan <luoyifan@cmss.chinamobile.com>
Subject: [PATCH v2] ARM: vfp: Fix typographical errors in vfpmodule.c
Date: Thu, 14 Nov 2024 09:19:39 +0800
Message-Id: <20241114011939.296230-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <CACRpkdb6T5dqgmcVi5m_52uQ4F_wESv4K95Fk1hsZcSaUsY8xA@mail.gmail.com>
References: <CACRpkdb6T5dqgmcVi5m_52uQ4F_wESv4K95Fk1hsZcSaUsY8xA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the misspellings of "noftify" (should be "notify") and "swtich"
(should be "switch").

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 arch/arm/vfp/vfpmodule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index b68efe643..409165077 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -140,7 +140,7 @@ static void vfp_thread_copy(struct thread_info *thread)
 /*
  * When this function is called with the following 'cmd's, the following
  * is true while this function is being run:
- *  THREAD_NOFTIFY_SWTICH:
+ *  THREAD_NOTIFY_SWITCH:
  *   - the previously running thread will not be scheduled onto another CPU.
  *   - the next thread to be run (v) will not be running on another CPU.
  *   - thread->cpu is the local CPU number
-- 
2.27.0




