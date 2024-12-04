Return-Path: <linux-kernel+bounces-430749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98509E353C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E36BB242E8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB469189F56;
	Wed,  4 Dec 2024 08:09:15 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3E41FA4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 08:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299755; cv=none; b=ZRONdqviSqIc135y4LiNJQJzxYEWpfp0pvPWNyybY3qp23NjRDiiqjHohLnXD/UEv7gjoQmwfR7sKrhVric3JQ+/jDLy3Od6kBD3X0Gy3dfCUaB77ahI4Z6w9qRAWOfZE1i1wpmgjNPxBbb2Rfk5C3svG1pMAKWy6OvUdHLMYpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299755; c=relaxed/simple;
	bh=suzMQ/uACmWfdxFFbnZyZQ3zVssbkTB8UBMarrAI8AI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=COjHbLekM3zz1HjX6DybIt+FHnhG9hKti4SN4AQRg191jnhgpQu35es9MVS/hB68NmRb+DI1+KfZhHg8JJ/RDcku4yI6pOOQ1winU9v0M+EucC9EmCXQFNGGa/ULxHTdKXWXUl5J2husTDPP5zz+61qZzYh17sXRoEpkeaTTs1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee667500e255d7-99ea8;
	Wed, 04 Dec 2024 16:09:09 +0800 (CST)
X-RM-TRANSID:2ee667500e255d7-99ea8
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee967500e24e60-5eb85;
	Wed, 04 Dec 2024 16:09:09 +0800 (CST)
X-RM-TRANSID:2ee967500e24e60-5eb85
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: anna-maria@linutronix.de
Cc: frederic@kernel.org,
	tglx@linutronix.de,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] posix-timers: Fix typo in posix-timers.c
Date: Wed,  4 Dec 2024 00:09:07 -0800
Message-Id: <20241204080907.11989-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The word 'accross' is wrong, so fix it.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 kernel/time/posix-timers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 881a9ce96..1b675aee9 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -538,7 +538,7 @@ static struct k_itimer *__lock_timer(timer_t timer_id, unsigned long *flags)
 	 * When the reference count reaches zero, the timer is scheduled
 	 * for RCU removal after the grace period.
 	 *
-	 * Holding rcu_read_lock() accross the lookup ensures that
+	 * Holding rcu_read_lock() across the lookup ensures that
 	 * the timer cannot be freed.
 	 *
 	 * The lookup validates locklessly that timr::it_signal ==
-- 
2.17.1




