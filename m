Return-Path: <linux-kernel+bounces-557189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA68A5D4B8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 04:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB0E47A9B5A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 03:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F6219882B;
	Wed, 12 Mar 2025 03:24:02 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F474C85
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741749841; cv=none; b=LK6zqZKNnMDtdTIi3pBVSBqBv+PSUEGGEvfVkAYTQq7QvdTFBibC5xjru2ZuIYtIyEAtgLp4m4ccsNUjzSXm853CKJfLPsSr5lktb+S39lTNvEjeNLH44P70zPano3BpYp0ts+pVsG5kfx/vNYOom/SKgwJ4qxVkUqzY0qBPjLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741749841; c=relaxed/simple;
	bh=Y6SVdAECs2gi8txONHweoVGcYvHJ5BYU59n3WU71QcE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wo4B5m190r1SFKwraqZiFZJV59mfkhX3zLvMDEjN+n9W0Y8xNZW5P+HgqmwNRADZMI0o6mTQyGbN5U6QH/6jKSS/DDJ1QkLA4oD0BGKJdu4Hw3LnMdbRzPw9sbOiJJ6nlQxjwAP9tmOvgGWASUVBrGHyXqxSMSTosBrVGkFMVHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6aae9be6fef111efa216b1d71e6e1362-20250312
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:11a57a68-89c1-4180-a672-f20610d247a7,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.45,REQID:11a57a68-89c1-4180-a672-f20610d247a7,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:845d2dae1041badea67863155d66218d,BulkI
	D:250312112352OQV2NXMX,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|102,T
	C:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 6aae9be6fef111efa216b1d71e6e1362-20250312
X-User: liuye@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 867985988; Wed, 12 Mar 2025 11:23:50 +0800
From: Liu Ye <liuye@kylinos.cn>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liu Ye <liuye@kylinos.cn>
Subject: [PATCH v2] mm/debug: Fix minor issues in mm
Date: Wed, 12 Mar 2025 11:23:44 +0800
Message-Id: <20250312032344.297946-1-liuye@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch includes several minor fixes:

- Simplify compound page judgment conditions.
- Missing a newline character at the end of the format string.

Each change is independent.

Signed-off-by: Liu Ye <liuye@kylinos.cn>

---
V2 : drop Fix out-of-bounds access in page_type_name().
---
---
 mm/debug.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/debug.c b/mm/debug.c
index 8d2acf432385..544b2b05c567 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -132,15 +132,15 @@ static void __dump_page(const struct page *page)
 again:
 	memcpy(&precise, page, sizeof(*page));
 	head = precise.compound_head;
-	if ((head & 1) == 0) {
+	if (head & 1) {
+		foliop = (struct folio *)(head - 1);
+		idx = folio_page_idx(foliop, page);
+	} else {
 		foliop = (struct folio *)&precise;
 		idx = 0;
 		if (!folio_test_large(foliop))
 			goto dump;
 		foliop = (struct folio *)page;
-	} else {
-		foliop = (struct folio *)(head - 1);
-		idx = folio_page_idx(foliop, page);
 	}
 
 	if (idx < MAX_FOLIO_NR_PAGES) {
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


