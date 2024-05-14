Return-Path: <linux-kernel+bounces-178286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8962B8C4B6B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 05:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0391C214AE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 03:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6010311725;
	Tue, 14 May 2024 03:14:21 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2326111AA
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 03:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715656461; cv=none; b=QnhFAPIvvc6nBsDTcM7UEQQ9r4+j9DgCskbVUDEOORkxiJFMU8bJCt0ke8yN/WPbuB2Z1OyA+LWkw4bVXHu7/OMVGlJWnDGOk4jKy8HVhl/12WiaQVVLBE20kVC2d4wFDaiYORLvMUB0Gn5T/4o628KAdudonKp/lVptl7AUqX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715656461; c=relaxed/simple;
	bh=snUCrlYSOP2eFW6684Pm8LxxgGbtjRvRmOA9GcQqO7I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rF0BQpmk9ksv/qzRqvXRyE7oMlQ5pHtEp81CKwmb8c7nD+lPWifu3lz4o1LB9TdFHny9wTqJmb+sIzjuaB7d6hyXkqW2kyq5omRfrjFDIDs51sjfD7l4+kqML6ozyn+fsFcbz6fONAF/PiifgH5qJ3jhxoECFt0PkBbFmiyX84U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 08a3914811a011ef9305a59a3cc225df-20240514
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:b2ba4032-03ae-4963-8b55-f28e8b96816b,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:10
X-CID-INFO: VERSION:1.1.38,REQID:b2ba4032-03ae-4963-8b55-f28e8b96816b,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:10
X-CID-META: VersionHash:82c5f88,CLOUDID:e90e5226e805bd28d80d2b63f52d0017,BulkI
	D:240514111412IINTNKZK,BulkQuantity:0,Recheck:0,SF:66|38|24|72|19|44|102,T
	C:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_LOWREP
	SA_EXISTED, SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-UUID: 08a3914811a011ef9305a59a3cc225df-20240514
X-User: cuitao@kylinos.cn
Received: from localhost.localdomain [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1243275688; Tue, 14 May 2024 11:14:10 +0800
From: cuitao <cuitao@kylinos.cn>
To: maarten.lankhorst@linux.intel.com,
	dri-devel@lists.freedesktop.org
Cc: mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	linux-kernel@vger.kernel.org,
	cuitao <cuitao@kylinos.cn>
Subject: [PATCH] drm/xe: Simplify the allocation of sync slab caches
Date: Tue, 14 May 2024 11:13:48 +0800
Message-Id: <20240514031348.15173-1-cuitao@kylinos.cn>
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

Signed-off-by: cuitao <cuitao@kylinos.cn>
---
 drivers/gpu/drm/xe/xe_hw_fence.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_hw_fence.c b/drivers/gpu/drm/xe/xe_hw_fence.c
index a5de3e7b0bd6..0f4eee529c6a 100644
--- a/drivers/gpu/drm/xe/xe_hw_fence.c
+++ b/drivers/gpu/drm/xe/xe_hw_fence.c
@@ -20,9 +20,7 @@ static struct kmem_cache *xe_hw_fence_slab;
 
 int __init xe_hw_fence_module_init(void)
 {
-	xe_hw_fence_slab = kmem_cache_create("xe_hw_fence",
-					     sizeof(struct xe_hw_fence), 0,
-					     SLAB_HWCACHE_ALIGN, NULL);
+	xe_hw_fence_slab = KMEM_CACHE(xe_hw_fence, SLAB_HWCACHE_ALIGN);
 	if (!xe_hw_fence_slab)
 		return -ENOMEM;
 
-- 
2.25.1


