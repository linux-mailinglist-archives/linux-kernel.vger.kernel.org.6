Return-Path: <linux-kernel+bounces-541298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A55A4BB0E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67E23B284F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253861F2365;
	Mon,  3 Mar 2025 09:44:28 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3711F12F6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995067; cv=none; b=cCYyGsDJZhv1WebvxUAjFwjRoWTAG6+EN0g17YPn2gKl5nipWwo1THSciYZLgrBfgunza27Hngws22R59L8ObAFr0lXU9/L1l3Y4uIc8VFJ3GerBqRB5dTPIjY0TlMylrYzhYaPnLU17kkv3qj8zmL0mdCtFutujG7YN39VQK7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995067; c=relaxed/simple;
	bh=JmbXDUeQQzLzo44I2b+w3Xm/hHA3EJBuvahO5cGdQCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fbWAVk0EWqJ4konSucmUr0N9DKi4aGGrsppTDfNCPgdfF6koI7b4PVJ0R564OESwhHeOg/oCestrNRCOwv5/ABOzS39Ogt+GzAJakEfU+QLxjT4zdjMf3jP/yIiSwwarY6DP3JTfnWwqEmUtqZefkm53n/8id3GmLKKj4ChQy0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 138b381cf81411efa216b1d71e6e1362-20250303
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:5383d249-2c70-42eb-b87c-0d7c4c43adca,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.45,REQID:5383d249-2c70-42eb-b87c-0d7c4c43adca,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:25d1d2012f27b339e62b923a1ac414a9,BulkI
	D:250303172846IT4R4S2D,BulkQuantity:2,Recheck:0,SF:17|19|24|44|66|78|81|82
	|102,TC:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 138b381cf81411efa216b1d71e6e1362-20250303
X-User: liuye@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 154557428; Mon, 03 Mar 2025 17:44:18 +0800
From: Liu Ye <liuye@kylinos.cn>
To: akpm@linux-foundation.org
Cc: urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liu Ye <liuye@kylinos.cn>
Subject: [PATCH 3/4] mm/vmalloc: Remove the real_size variable to simplify the code in __vmalloc_node_range_noprof
Date: Mon,  3 Mar 2025 17:44:09 +0800
Message-Id: <20250303094410.437985-4-liuye@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250303094410.437985-1-liuye@kylinos.cn>
References: <20250303094410.437985-1-liuye@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of the real_size variable causes code redundancy,
so it is removed to simplify the code.

Signed-off-by: Liu Ye <liuye@kylinos.cn>
---
 mm/vmalloc.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e311ee33f9ef..b4d2010e5105 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3770,7 +3770,6 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 	struct vm_struct *area;
 	void *ret;
 	kasan_vmalloc_flags_t kasan_flags = KASAN_VMALLOC_NONE;
-	unsigned long real_size = size;
 	unsigned long real_align = align;
 	unsigned int shift = PAGE_SHIFT;
 
@@ -3780,7 +3779,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 	if ((size >> PAGE_SHIFT) > totalram_pages()) {
 		warn_alloc(gfp_mask, NULL,
 			"vmalloc error: size %lu, exceeds total pages",
-			real_size);
+			size);
 		return NULL;
 	}
 
@@ -3808,7 +3807,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 		bool nofail = gfp_mask & __GFP_NOFAIL;
 		warn_alloc(gfp_mask, NULL,
 			"vmalloc error: size %lu, vm_struct allocation failed%s",
-			real_size, (nofail) ? ". Retrying." : "");
+			size, (nofail) ? ". Retrying." : "");
 		if (nofail) {
 			schedule_timeout_uninterruptible(1);
 			goto again;
@@ -3860,7 +3859,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 	    (gfp_mask & __GFP_SKIP_ZERO))
 		kasan_flags |= KASAN_VMALLOC_INIT;
 	/* KASAN_VMALLOC_PROT_NORMAL already set if required. */
-	area->addr = kasan_unpoison_vmalloc(area->addr, real_size, kasan_flags);
+	area->addr = kasan_unpoison_vmalloc(area->addr, size, kasan_flags);
 
 	/*
 	 * In this function, newly allocated vm_struct has VM_UNINITIALIZED
@@ -3869,9 +3868,8 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 	 */
 	clear_vm_uninitialized_flag(area);
 
-	size = PAGE_ALIGN(size);
 	if (!(vm_flags & VM_DEFER_KMEMLEAK))
-		kmemleak_vmalloc(area, size, gfp_mask);
+		kmemleak_vmalloc(area, PAGE_ALIGN(size), gfp_mask);
 
 	return area->addr;
 
@@ -3879,7 +3877,6 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 	if (shift > PAGE_SHIFT) {
 		shift = PAGE_SHIFT;
 		align = real_align;
-		size = real_size;
 		goto again;
 	}
 
-- 
2.25.1


