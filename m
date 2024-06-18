Return-Path: <linux-kernel+bounces-218548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 842C890C1C0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 04:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6D128352C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2669E18B1A;
	Tue, 18 Jun 2024 02:17:55 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E074689
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 02:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718677074; cv=none; b=PbYu4Eu5jMz/KW/qYgZEGL+BID4mD3RhRmFbk+yAknzt3XTayUgsd3aSGzFS1yvy9aSTvR0VvXKj9N6MFI8wNssVMXUpAF9zDVscN5M6KGbv/TtAMZ3wi+lHGYs74pLN2KEkczv/1pq3rzyMxzFyYO0kfl/6Wdvw1AJYVyJtHPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718677074; c=relaxed/simple;
	bh=vozIaQ3SmAeCFCnzgGlIwGb9OCx0Xu21bviml6F2h44=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ctdXnd4afWvUroh52xOS41mF89pOeEgoG0rTmz/lvAdIwjzHJ8Xs0Z8eBzXNabqz5a9kBL1H4cRZidKbMBqROotmDHarbK7iwZiiduD6HImrJ3z8JjdcdlH5kydVPFxm7p13imleI8QPqyFpwpalP67j/pIRTNGV02W/XkiJdE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7497720e2d1411ef9305a59a3cc225df-20240618
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:c3f8d9b5-79d8-4cab-8348-7e72cbe7caab,IP:15,
	URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:5
X-CID-INFO: VERSION:1.1.38,REQID:c3f8d9b5-79d8-4cab-8348-7e72cbe7caab,IP:15,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-META: VersionHash:82c5f88,CLOUDID:de079e7db15eee2918a1ab7ec45f4431,BulkI
	D:24061809453831AL2JP5,BulkQuantity:0,Recheck:0,SF:66|24|72|19|44|102,TC:n
	il,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_UNFAMILIAR
	SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-UUID: 7497720e2d1411ef9305a59a3cc225df-20240618
X-User: lihongfu@kylinos.cn
Received: from localhost.localdomain [(223.70.159.255)] by mailgw.kylinos.cn
	(envelope-from <lihongfu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2099277101; Tue, 18 Jun 2024 09:45:35 +0800
From: Hongfu Li <lihongfu@kylinos.cn>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Hongfu Li <lihongfu@kylinos.cn>
Subject: [PATCH] khugepaged: Simplify the allocation of slab caches
Date: Tue, 18 Jun 2024 09:45:17 +0800
Message-Id: <20240618014517.25954-1-lihongfu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
---
 mm/khugepaged.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 774a97e6e2da..f8d08b49420c 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -385,10 +385,7 @@ int hugepage_madvise(struct vm_area_struct *vma,
 
 int __init khugepaged_init(void)
 {
-	mm_slot_cache = kmem_cache_create("khugepaged_mm_slot",
-					  sizeof(struct khugepaged_mm_slot),
-					  __alignof__(struct khugepaged_mm_slot),
-					  0, NULL);
+	mm_slot_cache = KMEM_CACHE(khugepaged_mm_slot, 0);
 	if (!mm_slot_cache)
 		return -ENOMEM;
 
-- 
2.25.1


