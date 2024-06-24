Return-Path: <linux-kernel+bounces-226637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B8191416B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 06:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99301C21A11
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 04:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64C610940;
	Mon, 24 Jun 2024 04:52:56 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4783012E4D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719204776; cv=none; b=QQwP4ACVvu8HH7OdFsCkQu4JtEMtOVJ65kVMs53oumNHvRp9d5qAWpvR0N51cviYo0EiwLu9vAUFddJqyVLWBxTpcuoKouTgKib23ETdbsBDeDGAsOAHfFTqs/YiyGLsVz1LjIsaijVKYS6PJmMVb2lUH9EMcSdY5l1GltmbTGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719204776; c=relaxed/simple;
	bh=VO6rn1iRJpsezuy47uDlROc9yR1Lzf670tKqqbjH2JY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ESApry+GrkhTmtkHIVLnIhljXpLgBOLAX1a4i2R4/2sc4R6JKOu16aIILMNqrDp4eFlCJVwHS6LIw3uT+uVMDtF2NY748T/BniYSWwn0E8DuOky/Z5mEHDmwlwwRkZOopauuztOT5xELPFI/E3iTOBhkU8uqXgxMSAfKyiI1ZLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 97c90f3c31e511ef9305a59a3cc225df-20240624
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:513e5f83-4bc0-4c29-9adf-5881a04f0a2b,IP:15,
	URL:0,TC:0,Content:0,EDM:-25,RT:0,SF:-1,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-11
X-CID-INFO: VERSION:1.1.38,REQID:513e5f83-4bc0-4c29-9adf-5881a04f0a2b,IP:15,UR
	L:0,TC:0,Content:0,EDM:-25,RT:0,SF:-1,FILE:0,BULK:0,RULE:EDM_GE969F26,ACTI
	ON:release,TS:-11
X-CID-META: VersionHash:82c5f88,CLOUDID:ae42ce6172741fa5beedcdd08076e516,BulkI
	D:24062412423347W5T7XY,BulkQuantity:1,Recheck:0,SF:72|19|44|66|25|102,TC:n
	il,Content:0,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-UUID: 97c90f3c31e511ef9305a59a3cc225df-20240624
X-User: lizhenneng@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <lizhenneng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1586047465; Mon, 24 Jun 2024 12:52:43 +0800
From: Zhenneng Li <lizhenneng@kylinos.cn>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Zhenneng Li <lizhenneng@kylinos.cn>
Subject: [PATCH] migrate_pages: modify max number of pages to migrate in batch
Date: Mon, 24 Jun 2024 12:51:20 +0800
Message-Id: <20240624045120.121261-1-lizhenneng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We restrict the number of pages to be migrated to no more than
HPAGE_PMD_NR or NR_MAX_BATCHED_MIGRATION, but in fact, the
number of pages to be migrated may reach 2*HPAGE_PMD_NR-1 or 2
*NR_MAX_BATCHED_MIGRATION-1, it's not in inconsistent with the context.

Please refer to the patch: 42012e0436d4(migrate_pages: restrict number
of pages to migrate in batch)

Signed-off-by: Zhenneng Li <lizhenneng@kylinos.cn>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 781979567f64..7a4b37aac9e8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1961,7 +1961,7 @@ int migrate_pages(struct list_head *from, new_folio_t get_new_folio,
 			break;
 	}
 	if (nr_pages >= NR_MAX_BATCHED_MIGRATION)
-		list_cut_before(&folios, from, &folio2->lru);
+		list_cut_before(&folios, from, &folio->lru);
 	else
 		list_splice_init(from, &folios);
 	if (mode == MIGRATE_ASYNC)
-- 
2.25.1


