Return-Path: <linux-kernel+bounces-429128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9389E17B5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2391C165881
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BCC1DFD8D;
	Tue,  3 Dec 2024 09:33:31 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AD01DE882
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 09:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218411; cv=none; b=Rtu/HJ5zEZQLlfZAJrOqfkfg4JoyyGogPjAZtQ8B+xqtgoFf+GgNG09kH8FiKyiEtn1vrQuYfao7Gvw51kmikuORRUPtbE1NFdM5SBFx7usbX72MrUGc61xZReCibY7zjrE0QPR5WutOEKBNab2L3SG3XTacP32+q2f6I6ZiVJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218411; c=relaxed/simple;
	bh=hs9pSwBhmBSMbVF9K3iLga+M+zHCahCzTFy61YS6nkY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=tFCFAfNtJfaw54eaNUIBA5zpY108o6Jk6XrcHatZLoDzMQ0Yp4Kx5HeSl25/5DNcq5c6F99NUvzkiROkuVK5B9JotnTMWEMfT00nEdFVXycEJTQoxn03/ToxQSmmUqpKQCTrDuZdFg/IUWPgPi/ME/oLOiXrcJO23znx5jTT2sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee1674ed064e38-92750;
	Tue, 03 Dec 2024 17:33:25 +0800 (CST)
X-RM-TRANSID:2ee1674ed064e38-92750
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee9674ed064de8-2691c;
	Tue, 03 Dec 2024 17:33:25 +0800 (CST)
X-RM-TRANSID:2ee9674ed064de8-2691c
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: catalin.marinas@arm.com
Cc: will@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [RESEND] arm64: asm: Fix typo in pgtable.h
Date: Tue,  3 Dec 2024 01:33:23 -0800
Message-Id: <20241203093323.7831-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The word 'trasferring' is wrong, so fix it.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 arch/arm64/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index c329ea061dc9..4a5acf522c82 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1338,7 +1338,7 @@ static inline void ___ptep_set_wrprotect(struct mm_struct *mm,
 }
 
 /*
- * __ptep_set_wrprotect - mark read-only while trasferring potential hardware
+ * __ptep_set_wrprotect - mark read-only while transferring potential hardware
  * dirty status (PTE_DBM && !PTE_RDONLY) to the software PTE_DIRTY bit.
  */
 static inline void __ptep_set_wrprotect(struct mm_struct *mm,
-- 
2.17.1




