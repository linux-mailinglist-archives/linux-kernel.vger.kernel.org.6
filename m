Return-Path: <linux-kernel+bounces-510411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B59A31C72
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3CE67A392C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21531DB933;
	Wed, 12 Feb 2025 02:59:15 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54AF1B21AD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739329155; cv=none; b=PQLAKkkxZ1yXFvsKVCRD92FPAhdVY8SJl3QniYJbzJxl1JnM83DufSWuEpSI5MRCTlKfx8MrkfBsBhkB2ON54JXIrbO+BPq1DRcKyVd48UhvysCWWkRIBx4t6VItJr52gjhUDLx9jRaR+28UztIny/CEjyk/9cv9YsmXCneGWy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739329155; c=relaxed/simple;
	bh=7CUfID6HdZsryrIInsAKRbRo8sqorcpQZFpxldomQjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IoKrj3yN2oqR/3C7PcBrljOPdG7i10SVVAjP1sZz6kVtxtzsvGiM92gElIxRgzw0Qg/5FhxXAmWTRx3DRUteOZFjZN6mZ7gpGYLzcStD8KncohtLTfSrnBCoLyNROXdYoL5y6/416sE9x1/EkEEkegGoeTAckJr6KIIi8AcGrXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4f8e10d6e8ed11efa216b1d71e6e1362-20250212
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:f4ca7371-eeee-4ed1-970f-69c577e032f3,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.1.45,REQID:f4ca7371-eeee-4ed1-970f-69c577e032f3,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:6493067,CLOUDID:d49b93826a871673d7c8b078915368c3,BulkI
	D:250212100240HKQ61LWW,BulkQuantity:3,Recheck:0,SF:17|19|25|38|45|66|78|81
	|82|102,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 4f8e10d6e8ed11efa216b1d71e6e1362-20250212
X-User: liuye@kylinos.cn
Received: from localhost.localdomain [(223.70.253.31)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1944486207; Wed, 12 Feb 2025 10:59:01 +0800
From: Liu Ye <liuye@kylinos.cn>
To: brauner@kernel.org,
	dhowells@redhat.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Liu Ye <liuye@kylinos.cn>
Subject: [PATCH 2/2] mm/mm.h: Write folio->_flags_1 & 0xff as a macro definition
Date: Wed, 12 Feb 2025 10:58:43 +0800
Message-Id: <20250212025843.80283-3-liuye@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250212025843.80283-1-liuye@kylinos.cn>
References: <20250212025843.80283-1-liuye@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are multiple locations in mm.h where (folio->_flags_1 & 0xff) is
used. Write it as a macro definition to improve the readability and
maintainability of the code.

Signed-off-by: Liu Ye <liuye@kylinos.cn>
---
 include/linux/mm.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b1068ddcbb7..750e75f45557 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1098,6 +1098,8 @@ int vma_is_stack_for_current(struct vm_area_struct *vma);
 struct mmu_gather;
 struct inode;
 
+#define FOLIO_ORDER(folio) ((folio)->_flags_1 & 0xff)
+
 /*
  * compound_order() can be called without holding a reference, which means
  * that niceties like page_folio() don't work.  These callers should be
@@ -1111,7 +1113,7 @@ static inline unsigned int compound_order(struct page *page)
 
 	if (!test_bit(PG_head, &folio->flags))
 		return 0;
-	return folio->_flags_1 & 0xff;
+	return FOLIO_ORDER(folio);
 }
 
 /**
@@ -1127,7 +1129,7 @@ static inline unsigned int folio_order(const struct folio *folio)
 {
 	if (!folio_test_large(folio))
 		return 0;
-	return folio->_flags_1 & 0xff;
+	return FOLIO_ORDER(folio);
 }
 
 #include <linux/huge_mm.h>
@@ -2061,7 +2063,7 @@ static inline long folio_nr_pages(const struct folio *folio)
 #ifdef CONFIG_64BIT
 	return folio->_folio_nr_pages;
 #else
-	return 1L << (folio->_flags_1 & 0xff);
+	return 1L << FOLIO_ORDER(folio);
 #endif
 }
 
@@ -2086,7 +2088,7 @@ static inline unsigned long compound_nr(struct page *page)
 #ifdef CONFIG_64BIT
 	return folio->_folio_nr_pages;
 #else
-	return 1L << (folio->_flags_1 & 0xff);
+	return 1L << FOLIO_ORDER(folio);
 #endif
 }
 
-- 
2.25.1


