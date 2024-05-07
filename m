Return-Path: <linux-kernel+bounces-170523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5461E8BD8AD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 02:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A09A1F245FD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 00:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF65110A;
	Tue,  7 May 2024 00:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JY9tXfZm"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11D57E2;
	Tue,  7 May 2024 00:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715042096; cv=none; b=R14a0tcy2twPiM11ZydREwj2L7liMTDP4g9D293ZBOMIrvq9DBXZ2Mf9kD/zRviDjEd2bSO5FV4SPBEPy3G+KVO/hn8MOLCysCzC63OXTmddQYbbb6Uq8fAHHQECxTd0SetHkQ84EMYWeO3NN025yBgb5WDq2fiJek+jVHY3ykg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715042096; c=relaxed/simple;
	bh=lmoD7OVGd+QojINcFSvTvWpgNlKx2KIF+0G96Ys6I/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l+vVvso/6/sj1cdzIArMUGcnx9F/PxH4jmOIA7XG8nqYoTS8snGJOGbZnxee73Q/7Vtu/Kn/N2U7bNM/b3eJX82GGv49VfOUdqnirWNtfo7+LcmC8+e3bCi5egdmmysh71VhsJzyY8SNf8Wtro39DjBPCLbIXSUSZDCvUbrcD/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JY9tXfZm; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715042090; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Ba+5FP5FJO2/Suyp4hDjWNInibf1ZnvZ5BNqQp+lmQA=;
	b=JY9tXfZmXxK6N5sSt8tk2Xrk/FjngPwj8Sv6ErqYe949B01AF2dcHXuhmUC/s2DOzTX+hZFUIWzRxQytnsXB/n26rw1L1uLyD+6eUYWhLxW5wa70C7g8Fc4tRGUoi8PuZbIwICDVaK94X4SThhTiokBBBKxda77giCp3KhA8J80=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W6-1Pzd_1715042088;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W6-1Pzd_1715042088)
          by smtp.aliyun-inc.com;
          Tue, 07 May 2024 08:34:49 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com
Cc: linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] alpha: Remove duplicated include in fpreg.c
Date: Tue,  7 May 2024 08:34:47 +0800
Message-Id: <20240507003447.35833-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
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
2.20.1.7.g153144c


