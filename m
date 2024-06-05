Return-Path: <linux-kernel+bounces-202741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F15578FD03C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1CD1F22CD0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1091E89C;
	Wed,  5 Jun 2024 13:54:15 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D3017BCD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717595655; cv=none; b=ZxDMLD5JbyiM8wnYKAoKvvj/Ojhzu33DwxHTLxt/skIVvwYOvGCdK5j9MOGd5E+pm97NGAoCgwucqWb74eFDUZpRtX8GOtgxQaI9faLgj8STEI1EnCPHrlpzjkSAkGySMge58CH4UzTxRVfOh0EfRyKvFopNx5YI1mdKvDNdyR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717595655; c=relaxed/simple;
	bh=TXGHJ2+hUM24/BjFwCP02SOE7NoVVnR3kdLEdqV7maw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JTMfxhxz5NAwwMUFrKmNA1MKrBV5OWT7dTNAzzh4eSF3i3uxM6lL5ypLZSWGnorIOAA4skw51N4S5R+TnIeBv9S6u/dn944P9a0U4qRb5nlGBXGJEZhr6wMLeohKOucuQAH/0pwbxzV8mAJFX8AUBR/x2xQ4WkN8pd/SoKGyu7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 10030d24234311ef9305a59a3cc225df-20240605
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:ce8cb58e-4250-420b-b5d4-48e8eb6962e6,IP:25,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-INFO: VERSION:1.1.38,REQID:ce8cb58e-4250-420b-b5d4-48e8eb6962e6,IP:25,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:20
X-CID-META: VersionHash:82c5f88,CLOUDID:c97b73ac3a0f892bfe4b6f8a75eb25d4,BulkI
	D:240605215401EJAVI5UO,BulkQuantity:0,Recheck:0,SF:38|24|72|19|44|66|102,T
	C:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
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
X-UUID: 10030d24234311ef9305a59a3cc225df-20240605
X-User: cuitao@kylinos.cn
Received: from localhost.localdomain [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 151872135; Wed, 05 Jun 2024 21:54:01 +0800
From: cuitao <cuitao@kylinos.cn>
To: mst@redhat.com,
	jasowang@redhat.com,
	virtualization@lists.linux.dev
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	linux-kernel@vger.kernel.org,
	cuitao <cuitao@kylinos.cn>
Subject: [PATCH] tools/virtio: Use the __GFP_ZERO flag of kmalloc to complete the memory initialization.
Date: Wed,  5 Jun 2024 21:52:45 +0800
Message-Id: <20240605135245.14921-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the __GFP_ZERO flag of kmalloc to initialize memory while allocating it,
without the need for an additional memset call.

Signed-off-by: cuitao <cuitao@kylinos.cn>
---
 tools/virtio/linux/kernel.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
index 6702008f7f5c..9e401fb7c215 100644
--- a/tools/virtio/linux/kernel.h
+++ b/tools/virtio/linux/kernel.h
@@ -66,10 +66,7 @@ static inline void *kmalloc_array(unsigned n, size_t s, gfp_t gfp)
 
 static inline void *kzalloc(size_t s, gfp_t gfp)
 {
-	void *p = kmalloc(s, gfp);
-
-	memset(p, 0, s);
-	return p;
+	return kmalloc(s, gfp | __GFP_ZERO);
 }
 
 static inline void *alloc_pages_exact(size_t s, gfp_t gfp)
-- 
2.25.1


