Return-Path: <linux-kernel+bounces-410440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D059CDBB1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D92528328B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F1618FC84;
	Fri, 15 Nov 2024 09:35:05 +0000 (UTC)
Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662CE189F39
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731663305; cv=none; b=agw4acqVUEc4xf0aMlaZTVvzNmDPbiazRzqDen1rHoyCNFWRQA8q4Tohj/R2gV/q8OjPhiB3IlLSmIoz/RlPDupKCJoZmpJAxnpit4jAFsevnF1Wkxz8MwGo+o9GjnOeM+j9yIpOcqNYCmwPi9m9MkZsllYBBMYHlwnAAkQqZcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731663305; c=relaxed/simple;
	bh=hs9pSwBhmBSMbVF9K3iLga+M+zHCahCzTFy61YS6nkY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Fljfca/6k0AH+3gjOB+bNq5Oqu7/n5j6GNviTUWv/rFTgZVlu2spVnwobbeabQHEjlxyFKTIEWZnRACDPvg2JnmB6pxD+gi2wK13PugQNWPsbZ/nQms1MWJHx4KJoIsxr5hXOjkI1EaX8IZ/B98pvZX0K0zkzzCT5JG8X0uw9Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee9673715c170c-32722;
	Fri, 15 Nov 2024 17:34:58 +0800 (CST)
X-RM-TRANSID:2ee9673715c170c-32722
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee1673715c2037-f4c40;
	Fri, 15 Nov 2024 17:34:58 +0800 (CST)
X-RM-TRANSID:2ee1673715c2037-f4c40
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: catalin.marinas@arm.com
Cc: will@kernel.org,
	ardb@kernel.org,
	peterx@redhat.com,
	joey.gouly@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [PATCH] arm64: asm: Fix the cacography in pgtable.h
Date: Fri, 15 Nov 2024 01:34:56 -0800
Message-Id: <20241115093456.7310-1-zhujun2@cmss.chinamobile.com>
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




