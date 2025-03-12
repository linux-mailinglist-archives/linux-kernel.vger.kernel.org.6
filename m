Return-Path: <linux-kernel+bounces-557473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A58A5D9AC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD3D3B647C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A214923A9BF;
	Wed, 12 Mar 2025 09:37:41 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC87D22D7A2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741772261; cv=none; b=YAhNRWwnOal9JsvgTCV37Slv67fXdarLMWcg0Vr0TR7f3Fxgq9As2aQZdgurfVrnTB2NZc4nGh5pLg9DzlyJxkx1z+YmFzpv96QDph+j3FoXficpRlrSRrmVutzveh/S7VqmNyUjQ8HdrxfiCnda6VcjcFZCzgzkv9XX4vSuKd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741772261; c=relaxed/simple;
	bh=eCSSo8LX/U3xirAKgDQnnerhGZRgAl2Z6xDzS54RR5M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gN/cvqMawv24zhLLsH+G+O9kE0k5huvSBvYh3hya3Ese6pcOmqK0dwfeJLGh0CggXLSmABFrvpsaVT+7NQJv1n9ud/C6WrfIE7EtbwH7WEa+nWaSCZjLuHsNqsoVXn6i/cZ5/BhydYAdMHXm+lxZv3yQHW1RlbNSXUMBP/J8wlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 99cff5eeff2511efa216b1d71e6e1362-20250312
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
X-CID-O-INFO: VERSION:1.1.45,REQID:72c7efb8-2927-4f0b-9111-95061a1495b0,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:72c7efb8-2927-4f0b-9111-95061a1495b0,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:137f204bfbe3802d2d30eb2f53193e2a,BulkI
	D:250312173724R6LT0BYZ,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|102,T
	C:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:1,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 99cff5eeff2511efa216b1d71e6e1362-20250312
X-User: liuye@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 320306976; Wed, 12 Mar 2025 17:37:23 +0800
From: Liu Ye <liuye@kylinos.cn>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	Liu Ye <liuye@kylinos.cn>
Subject: [PATCH] mm/debug: Add line breaks
Date: Wed, 12 Mar 2025 17:37:17 +0800
Message-Id: <20250312093717.364031-1-liuye@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Missing a newline character at the end of the format string.

Signed-off-by: Liu Ye <liuye@kylinos.cn>
---
 mm/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/debug.c b/mm/debug.c
index 8d2acf432385..db1894c5e8b9 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -165,7 +165,7 @@ static void __dump_page(const struct page *page)
 void dump_page(const struct page *page, const char *reason)
 {
 	if (PagePoisoned(page))
-		pr_warn("page:%p is uninitialized and poisoned", page);
+		pr_warn("page:%p is uninitialized and poisoned\n", page);
 	else
 		__dump_page(page);
 	if (reason)
-- 
2.25.1


