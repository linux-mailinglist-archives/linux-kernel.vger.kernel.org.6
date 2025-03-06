Return-Path: <linux-kernel+bounces-548339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 078B7A5438A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61BC818945A4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715751C6FF3;
	Thu,  6 Mar 2025 07:21:53 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1762718DB04
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 07:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741245713; cv=none; b=YsS1Anu/vsNaHuVkBJsHRcF+jyHGQj6RJp2H59E3PDIl48xofwlGQT2/Xd/S2/6NXTzSITtGoAqXCKKYa1Gr8OvS/b397g7HDieqJAxt6mf1Qi9K9bVsThsGVHa+C0U4VYBacV85MtENI3/fSlu1fQJ1V1UtFSB9Bmnz6Fr/Cno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741245713; c=relaxed/simple;
	bh=iHY5KQh+OO5lCmguUoUqlOpqCa2vC9D+bKJ7PGT05Zo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KCHMftw9y0EuHDBdq3wiUObTgMFQsjvvlT/1ZoQKoqja1952mZsJtIvQO+XOIoOLP9x/I9laXqYY1y48ZVpa4R3d4TMzsLDPgJUQikij4Bv7VQF6mlYMVr/iE+h3gRp543MDzik+cbBLgYtTcDGb967+7iY8OxLuh1LDDfBWAcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a4e8f314fa5b11efa216b1d71e6e1362-20250306
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:7345bea8-c9fe-4f5c-8980-2b8dc4866e55,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:7345bea8-c9fe-4f5c-8980-2b8dc4866e55,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:e19adaef1ae94a8ffbfa234d8795a994,BulkI
	D:250306152141O4QPG1SA,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|102,T
	C:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: a4e8f314fa5b11efa216b1d71e6e1362-20250306
X-User: liuye@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1277318593; Thu, 06 Mar 2025 15:21:38 +0800
From: Liu Ye <liuye@kylinos.cn>
To: akpm@linux-foundation.org
Cc: urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liu Ye <liuye@kylinos.cn>
Subject: [PATCH] mm/vmalloc: Refactoring function __vmalloc_node_range_noprof
Date: Thu,  6 Mar 2025 15:21:31 +0800
Message-Id: <20250306072131.800499-1-liuye@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the code logic, the first parameter of the sub-function
__get_vm_area_node should be size instead of real_size.

Then in the function __get_vm_area_node, the size will be aligned,
so the redundant alignment operation is deleted.

The use of the real_size variable causes code redundancy,
so it is removed to simplify the code.

The real prefix is generally used to indicate the adjusted value of a
parameter, but according to the code logic, it should indicate the
original value, so it is recommended to rename it to original_align.

Signed-off-by: Liu Ye <liuye@kylinos.cn>
---
 mm/vmalloc.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index dc658d4af181..a8488452b70b 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3770,8 +3770,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 	struct vm_struct *area;
 	void *ret;
 	kasan_vmalloc_flags_t kasan_flags = KASAN_VMALLOC_NONE;
-	unsigned long real_size = size;
-	unsigned long real_align = align;
+	unsigned long original_align = align;
 	unsigned int shift = PAGE_SHIFT;
 
 	if (WARN_ON_ONCE(!size))
@@ -3780,7 +3779,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 	if ((size >> PAGE_SHIFT) > totalram_pages()) {
 		warn_alloc(gfp_mask, NULL,
 			"vmalloc error: size %lu, exceeds total pages",
-			real_size);
+			size);
 		return NULL;
 	}
 
@@ -3797,19 +3796,18 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 		else
 			shift = arch_vmap_pte_supported_shift(size);
 
-		align = max(real_align, 1UL << shift);
-		size = ALIGN(real_size, 1UL << shift);
+		align = max(original_align, 1UL << shift);
 	}
 
 again:
-	area = __get_vm_area_node(real_size, align, shift, VM_ALLOC |
+	area = __get_vm_area_node(size, align, shift, VM_ALLOC |
 				  VM_UNINITIALIZED | vm_flags, start, end, node,
 				  gfp_mask, caller);
 	if (!area) {
 		bool nofail = gfp_mask & __GFP_NOFAIL;
 		warn_alloc(gfp_mask, NULL,
 			"vmalloc error: size %lu, vm_struct allocation failed%s",
-			real_size, (nofail) ? ". Retrying." : "");
+			size, (nofail) ? ". Retrying." : "");
 		if (nofail) {
 			schedule_timeout_uninterruptible(1);
 			goto again;
@@ -3861,7 +3859,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 	    (gfp_mask & __GFP_SKIP_ZERO))
 		kasan_flags |= KASAN_VMALLOC_INIT;
 	/* KASAN_VMALLOC_PROT_NORMAL already set if required. */
-	area->addr = kasan_unpoison_vmalloc(area->addr, real_size, kasan_flags);
+	area->addr = kasan_unpoison_vmalloc(area->addr, size, kasan_flags);
 
 	/*
 	 * In this function, newly allocated vm_struct has VM_UNINITIALIZED
@@ -3870,17 +3868,15 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 	 */
 	clear_vm_uninitialized_flag(area);
 
-	size = PAGE_ALIGN(size);
 	if (!(vm_flags & VM_DEFER_KMEMLEAK))
-		kmemleak_vmalloc(area, size, gfp_mask);
+		kmemleak_vmalloc(area, PAGE_ALIGN(size), gfp_mask);
 
 	return area->addr;
 
 fail:
 	if (shift > PAGE_SHIFT) {
 		shift = PAGE_SHIFT;
-		align = real_align;
-		size = real_size;
+		align = original_align;
 		goto again;
 	}
 
-- 
2.25.1


