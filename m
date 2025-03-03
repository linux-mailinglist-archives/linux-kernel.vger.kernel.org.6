Return-Path: <linux-kernel+bounces-540861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAACA4B5E5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3F93AEAD6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 01:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E489013C82E;
	Mon,  3 Mar 2025 01:57:28 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A828F2B9A6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 01:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740967048; cv=none; b=FybZj1ly0uoShSyqjK50oD23lz3RZ3TViFC1y+GQW/W79F8ZDhp/5qMcP/erQUbqcvafHoU7Aw130MViZ373sWEyZaEQZLKzWSKyp+cxWU1sYjj4SeP7ctCedSGOzKeISFjANYsmuSJgQzXw1G9PNBOC69llbVX+LG+Thon3OuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740967048; c=relaxed/simple;
	bh=oMBg7P6oV0+5C04SihdpMhD2ox/w3GeEyxXzyAExQU4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VKg6KNEKzORTzRaid5TlTjDwT+ug09wmiFWjyavZggAhU40wKGCu2LS05utlvr/DhjVZi5BMp1B6S3Qzoah6o4VDuErvVq1OSwMq0jmm3VTLGPZV6kyEo8YuArDmWjVt4nOMv1eIUp4m/3MpVM0TwBcCPTUxHJk0hCSSdlRRNKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d2e0496af7d211efa216b1d71e6e1362-20250303
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:c605b5b3-edfd-4127-a2c6-aa105ceb2a29,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:43
X-CID-INFO: VERSION:1.1.45,REQID:c605b5b3-edfd-4127-a2c6-aa105ceb2a29,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_HamU,ACTION
	:release,TS:43
X-CID-META: VersionHash:6493067,CLOUDID:14aa765bd3339adb6d5948ae338d1a50,BulkI
	D:250303095713XL76UOVB,BulkQuantity:0,Recheck:0,SF:16|19|24|44|66|78|102,T
	C:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_USA
X-UUID: d2e0496af7d211efa216b1d71e6e1362-20250303
X-User: liuye@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1208996738; Mon, 03 Mar 2025 09:57:12 +0800
From: Liu Ye <liuye@kylinos.cn>
To: akpm@linux-foundation.org
Cc: urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liu Ye <liuye@kylinos.cn>
Subject: [PATCH] mm/vmalloc: Move free_vm_area(area) from the __vmalloc_area_node function to the __vmalloc_node_range_noprof function
Date: Mon,  3 Mar 2025 09:57:02 +0800
Message-Id: <20250303015702.319416-1-liuye@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Moved free_vm_area from the __vmalloc_area_node function to the
__vmalloc_node_range_noprof function so that allocation and freeing
of the area can be paired in one function for better readability.

Signed-off-by: Liu Ye <liuye@kylinos.cn>
---
 mm/vmalloc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a6e7acebe9ad..dc658d4af181 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3651,7 +3651,6 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 		warn_alloc(gfp_mask, NULL,
 			"vmalloc error: size %lu, failed to allocated page array size %lu",
 			nr_small_pages * PAGE_SIZE, array_size);
-		free_vm_area(area);
 		return NULL;
 	}
 
@@ -3844,8 +3843,10 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 
 	/* Allocate physical pages and map them into vmalloc space. */
 	ret = __vmalloc_area_node(area, gfp_mask, prot, shift, node);
-	if (!ret)
+	if (!ret) {
+		free_vm_area(area);
 		goto fail;
+	}
 
 	/*
 	 * Mark the pages as accessible, now that they are mapped.
-- 
2.25.1


