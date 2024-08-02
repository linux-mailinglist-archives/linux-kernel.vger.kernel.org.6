Return-Path: <linux-kernel+bounces-272151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 124A69457DA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0C9D281C55
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 05:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629323FE4A;
	Fri,  2 Aug 2024 05:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="plyF4nbt"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E12A22EE4;
	Fri,  2 Aug 2024 05:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722578216; cv=none; b=luVBnaLRBEgoxsbNw1PCseAuqHA1cXG1PGGGuIhV4ylEFgC5+Hnv9R9FeueGxb+NyKIzqmmpEuPOKABuXAbcHL2eK8Ti/cF3114DZqR0fKpunJafuobvIQDt1f36AMG/IA0MwnzYffP6yfjxURJ1DrTyGYm4RX0ebkqyCi0iEQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722578216; c=relaxed/simple;
	bh=XjxML3ayRQPwapHfwt6u0BUhq6E28TNcXl/KoMNAbJE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pM1MVxJfw7caluK/2KkAMOJ7fj3hWw570xCo6Q3epMBcHge7LE82iNxRodImwjXfsh4NjMG3xIk5eSS7A/fb92oUzEXqOxWZ3QryKEMKezCus4lLhoRE2LtPwuSMng/GlPzOJuCwPqtFnJSQ8466fb1KZeyJtL8037t+mQ1a18c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=plyF4nbt; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722578211; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=5x2JXumwyYzOGSTtoVpLze4Q1NmHGalDzVImpWwTmec=;
	b=plyF4nbtJE9hW18EHpGMGnFlG/1lk6LjJ3MKQQ3nCtFgBU60VlMaAljOigtbjNfXBjDbWqAuVAYC1+/Qr/Nk5D14g+Zv1I929dJWBy2AizH234RrTL0ZPel2g1InwVElP34+q7y7QkdQEiuf+WsklkATI8rYobBMSmv+hnUy8bk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0WBwKVvX_1722578210;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0WBwKVvX_1722578210)
          by smtp.aliyun-inc.com;
          Fri, 02 Aug 2024 13:56:51 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com
Cc: linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next RESEND] alpha: Remove duplicated include in fpreg.c
Date: Fri,  2 Aug 2024 13:56:48 +0800
Message-Id: <20240802055648.17685-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header files asm/fpu.h is included twice in fpreg.c,
so one inclusion of each can be removed.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8945
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 arch/alpha/lib/fpreg.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/alpha/lib/fpreg.c b/arch/alpha/lib/fpreg.c
index 9a238e7536ae..3d32165043f8 100644
--- a/arch/alpha/lib/fpreg.c
+++ b/arch/alpha/lib/fpreg.c
@@ -10,7 +10,6 @@
 #include <linux/preempt.h>
 #include <asm/fpu.h>
 #include <asm/thread_info.h>
-#include <asm/fpu.h>
 
 #if defined(CONFIG_ALPHA_EV6) || defined(CONFIG_ALPHA_EV67)
 #define STT(reg,val)  asm volatile ("ftoit $f"#reg",%0" : "=r"(val));
-- 
2.32.0.3.g01195cf9f


