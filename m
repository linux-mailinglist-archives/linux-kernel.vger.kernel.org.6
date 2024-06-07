Return-Path: <linux-kernel+bounces-205681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87DA8FFED5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8912128A10B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26EC15CD40;
	Fri,  7 Jun 2024 09:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dM9pec0l"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0617E15B997
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751230; cv=none; b=aobIUW/enClaUwNliYmE0+Ec6tvUZ2UJK/WLaVNI1/eUeuF1nToGCFXXxAniRE701oRHnsBF0PTafzd43cLfiE24RUngOg3KTZNqL+vsNCn5uLqigKbAjhX01vo6HR6zk7z8G1JB62tPMhI2myoQ042oCluIi1G3RQLzY4NiVhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751230; c=relaxed/simple;
	bh=epivP2uBLRqvpctNXQMwG3GU7MMVJao62DVIac0tabs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b8GDJczMISAWJ+z805rbBpjxIXkRH46uXI9bkv4EMfEnN5NDu6zgpJKiOVMap3YO7l+ZlGKbM7ECgYOG8s13tQzjY+NL0YgLykxaQtjyyrfz7yUKSLUZ7w16KIDH/ky0CxME71GBHkLA4lh4CKyq0SEbVdKEcq5y6ey5mW+tfRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dM9pec0l; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717751218; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=XILA5jiIXZmNOoilABjFA6RvVJDrCCLZRgYJ8+gWU6E=;
	b=dM9pec0lphg6V+qdr4SN6kpkpgwEWrMbVHPE/zPlNFlLxD6NYv3JICjU0ajvFWlGrB7DKmv3NgH0OvyuhsVLXpDxF8TjIdxz3V1tYDTpSTcGNx0mXqVXe0IDYtCKeBalS13oF8gsHtczxr+uuOngEkbrVCBjOXvKYRLO4vwLLOY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W8-cD2-_1717751217;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W8-cD2-_1717751217)
          by smtp.aliyun-inc.com;
          Fri, 07 Jun 2024 17:06:58 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: jstultz@google.com,
	tglx@linutronix.de,
	sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] timekeeping: Add missing kernel-doc function comments for do_adjtimex and hardpps
Date: Fri,  7 Jun 2024 17:06:56 +0800
Message-Id: <20240607090656.104883-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kernel-doc style comments for the do_adjtimex and hardpps functions.
These comments provide descriptions for the function parameters and a
concise function description to enhance code readability and
maintainability in accordance with the kernel coding standards.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9301
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 kernel/time/timekeeping.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index da984a368a95..d6d6597c089e 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2547,6 +2547,7 @@ EXPORT_SYMBOL_GPL(random_get_entropy_fallback);
 
 /**
  * do_adjtimex() - Accessor function to NTP __do_adjtimex function
+ * @txc: Pointer to kernel_timex structure containing NTP parameters
  */
 int do_adjtimex(struct __kernel_timex *txc)
 {
@@ -2615,6 +2616,8 @@ int do_adjtimex(struct __kernel_timex *txc)
 #ifdef CONFIG_NTP_PPS
 /**
  * hardpps() - Accessor function to NTP __hardpps function
+ * @phase_ts: Pointer to timespec64 structure representing phase timestamp
+ * @raw_ts: Pointer to timespec64 structure representing raw timestamp
  */
 void hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_ts)
 {
-- 
2.20.1.7.g153144c


