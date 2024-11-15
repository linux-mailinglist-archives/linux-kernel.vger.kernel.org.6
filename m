Return-Path: <linux-kernel+bounces-410453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0249CDBD5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A7A1F235BF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4B418EFD4;
	Fri, 15 Nov 2024 09:49:19 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F1718CC10
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731664159; cv=none; b=kkqXKxax/axwXcMou5Yq5qLShjsfEXPlyQqqVbM19yF5GBqULtoLOjFzqwb9wcYTS9AveL27w4QxDtUAWGqNQorN9vUijJpGY/bLbCRO5PK3ynTnpRsMj/X+xx5u2K6GhwM3Su3Kh47Cacdk57/XjU55BfArMbrCQqZcz3+gslI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731664159; c=relaxed/simple;
	bh=vTO/IRNMGEhwCbdwSRgpkc9c3zuO8EDzihR47G7s/m0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=tVBaNE8E5OAq90f71YYSbLD4KWrO7zhhRoepqrsxp31ec/ngSBYiVBPehQJrYaGTH3x4EPhdiW5mc2cpEsuLA4LtM+J4Y6pNmVoN4ZLB9oHJxO8JNffvPavZOir+pfpnGYe0pDl/7hpyWUngGT3ybIxUy/Q+/doosyjDssUgd/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86737190fada-67b25;
	Fri, 15 Nov 2024 17:49:08 +0800 (CST)
X-RM-TRANSID:2ee86737190fada-67b25
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26737191374d-f98cd;
	Fri, 15 Nov 2024 17:49:08 +0800 (CST)
X-RM-TRANSID:2ee26737191374d-f98cd
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: catalin.marinas@arm.com
Cc: will@kernel.org,
	ardb@kernel.org,
	peterx@redhat.com,
	joey.gouly@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH v2] arm64: asm: Fix typo in pgtable.h
Date: Fri, 15 Nov 2024 01:49:04 -0800
Message-Id: <20241115094904.7682-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The word 'trasferring' is wrong, so fix it.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
v1->v2:
	modify cacography to typo

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




