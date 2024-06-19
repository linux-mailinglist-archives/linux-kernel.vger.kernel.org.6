Return-Path: <linux-kernel+bounces-220497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C349C90E28B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 07:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810051F23FA8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 05:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7075951C5A;
	Wed, 19 Jun 2024 05:04:31 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445F34654D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 05:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718773471; cv=none; b=FPfO4vx0P7YC2cILGMO/yAPga1mTUidCEaA0UYzwJWhHNiCaxlPJdysoZ5ik066SIx5HI/rsdMGlEXv0IKbT93dHPx+K5Xyq1aI71guGJSw1qBezK8sIgrUUScZVDfTXn5Vw1fdKBC+WVR4UoFaukYm27XbVzf+WFSuRWxmwbgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718773471; c=relaxed/simple;
	bh=EHUgha5u7fohurTy6PZa19AkqnAfQC7XiQ3B29XSOrk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hn/AFH54exHOZLItMB+NID4NXDOgEEYHRTOQv1iZ9FvjuPIT7TJt/Q4fFhuDE1M843nLwszzVNizv6vKZDLt73DCES6OobXOkD7oZyxkDIyVbKa7UuiX6ODcnfinH4obVL7w9f/dCH5fQddcETSoi313bUk/R518VwmHZT2kf+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 603cdbce2df911ef9305a59a3cc225df-20240619
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:8e3301a6-d820-407b-a2f3-d4ede3c00dd7,IP:15,
	URL:0,TC:0,Content:0,EDM:-25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-15
X-CID-INFO: VERSION:1.1.38,REQID:8e3301a6-d820-407b-a2f3-d4ede3c00dd7,IP:15,UR
	L:0,TC:0,Content:0,EDM:-25,RT:0,SF:-5,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTI
	ON:release,TS:-15
X-CID-META: VersionHash:82c5f88,CLOUDID:5cf67c838c7cce21705faa17b19f583a,BulkI
	D:24061913041699OXWORV,BulkQuantity:0,Recheck:0,SF:44|66|24|72|19|102,TC:n
	il,Content:0,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_LOWREP
	SA_EXISTED, SN_UNTRUSTED, SN_LOWREP, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-UUID: 603cdbce2df911ef9305a59a3cc225df-20240619
X-User: lihongfu@kylinos.cn
Received: from localhost.localdomain [(223.70.159.255)] by mailgw.kylinos.cn
	(envelope-from <lihongfu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1943321471; Wed, 19 Jun 2024 13:04:15 +0800
From: Hongfu Li <lihongfu@kylinos.cn>
To: aahringo@redhat.com,
	teigland@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hongfu Li <lihongfu@kylinos.cn>
Subject: [PATCH] dlm: use KMEM_CACHE in dlm_memory_init
Date: Wed, 19 Jun 2024 13:03:58 +0800
Message-Id: <20240619050358.411888-1-lihongfu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using KMEM_CACHE() macro makes the code more concise and easy to read.

Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
---
 fs/dlm/memory.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/dlm/memory.c b/fs/dlm/memory.c
index 15a8b1cee433..829cc4fe7bf1 100644
--- a/fs/dlm/memory.c
+++ b/fs/dlm/memory.c
@@ -34,8 +34,7 @@ int __init dlm_memory_init(void)
 	if (!mhandle_cache)
 		goto mhandle;
 
-	lkb_cache = kmem_cache_create("dlm_lkb", sizeof(struct dlm_lkb),
-				__alignof__(struct dlm_lkb), 0, NULL);
+	lkb_cache = KMEM_CACHE(dlm_lkb, 0);
 	if (!lkb_cache)
 		goto lkb;
 
@@ -43,14 +42,11 @@ int __init dlm_memory_init(void)
 	if (!msg_cache)
 		goto msg;
 
-	rsb_cache = kmem_cache_create("dlm_rsb", sizeof(struct dlm_rsb),
-				__alignof__(struct dlm_rsb), 0, NULL);
+	rsb_cache = KMEM_CACHE(dlm_rsb, 0);
 	if (!rsb_cache)
 		goto rsb;
 
-	cb_cache = kmem_cache_create("dlm_cb", sizeof(struct dlm_callback),
-				     __alignof__(struct dlm_callback), 0,
-				     NULL);
+	cb_cache = KMEM_CACHE(dlm_callback, 0);
 	if (!cb_cache)
 		goto cb;
 
-- 
2.25.1


