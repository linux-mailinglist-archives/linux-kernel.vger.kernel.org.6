Return-Path: <linux-kernel+bounces-510410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE43BA31C71
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B4BB3A6D96
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293C61D88A4;
	Wed, 12 Feb 2025 02:59:15 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55121D516D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739329154; cv=none; b=u907n4kdOfqbOXE3q+nKJtVoFIphCsfHjyekU14/gjn+DdFLmC0wrCPsK+GZs9Rum0VOwRCeZ4IuriJDpnL2RQPn1APHLV9824mQYPktSFeLhp03uMbVUxX2E2Zd6916KK/8jC93AfyWinWFRt5+aH+2lNCYQ59LZ8Q45rKK2uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739329154; c=relaxed/simple;
	bh=grLQdsLQ1ZkH/aIIT1aXQVNhT1FavSq/NtUxMMtW/PM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qFQ43w3edEct+cfK75CjvkXhRw/XzrZSNIO9XDbqWH0MP8LXWDt+MyOrGO2AZS55icfIxh07zHKdE6N61Ym5Z91OnnNH3f82F1oULejjVESCCyENC/3cB76Ckg19+7jLnhR2eR8cGz8J62M9EHvDYj5NAbxiIFTChyvPLIu7aqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4eb44d2ee8ed11efa216b1d71e6e1362-20250212
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:30c93d93-f2fd-4b6a-ad32-cddf86305237,IP:10,
	URL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-25
X-CID-INFO: VERSION:1.1.45,REQID:30c93d93-f2fd-4b6a-ad32-cddf86305237,IP:10,UR
	L:0,TC:0,Content:-5,EDM:-25,RT:0,SF:-5,FILE:0,BULK:0,RULE:EDM_GE969F26,ACT
	ION:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:554b448c421ed6c24026b7b687b4ed6b,BulkI
	D:250212100238CDFLER86,BulkQuantity:3,Recheck:0,SF:17|19|25|38|45|66|78|81
	|82|102,TC:nil,Content:0|50,EDM:1,IP:-2,URL:11|1,File:nil,RT:nil,Bulk:40,Q
	S:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULN
X-UUID: 4eb44d2ee8ed11efa216b1d71e6e1362-20250212
X-User: liuye@kylinos.cn
Received: from localhost.localdomain [(223.70.253.31)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 999580327; Wed, 12 Feb 2025 10:58:59 +0800
From: Liu Ye <liuye@kylinos.cn>
To: brauner@kernel.org,
	dhowells@redhat.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Liu Ye <liuye@kylinos.cn>
Subject: [PATCH 1/2] mm/folio_queue: Delete __folio_order and use folio_order directly
Date: Wed, 12 Feb 2025 10:58:42 +0800
Message-Id: <20250212025843.80283-2-liuye@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250212025843.80283-1-liuye@kylinos.cn>
References: <20250212025843.80283-1-liuye@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__folio_order is the same as folio_order, remove __folio_order and then
just include mm.h and use folio_order directly.

Signed-off-by: Liu Ye <liuye@kylinos.cn>
---
 include/linux/folio_queue.h | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/linux/folio_queue.h b/include/linux/folio_queue.h
index 4d3f8074c137..45ad2408a80c 100644
--- a/include/linux/folio_queue.h
+++ b/include/linux/folio_queue.h
@@ -15,6 +15,7 @@
 #define _LINUX_FOLIO_QUEUE_H
 
 #include <linux/pagevec.h>
+#include <linux/mm.h>
 
 /*
  * Segment in a queue of running buffers.  Each segment can hold a number of
@@ -216,13 +217,6 @@ static inline void folioq_unmark3(struct folio_queue *folioq, unsigned int slot)
 	clear_bit(slot, &folioq->marks3);
 }
 
-static inline unsigned int __folio_order(struct folio *folio)
-{
-	if (!folio_test_large(folio))
-		return 0;
-	return folio->_flags_1 & 0xff;
-}
-
 /**
  * folioq_append: Add a folio to a folio queue segment
  * @folioq: The segment to add to
@@ -241,7 +235,7 @@ static inline unsigned int folioq_append(struct folio_queue *folioq, struct foli
 	unsigned int slot = folioq->vec.nr++;
 
 	folioq->vec.folios[slot] = folio;
-	folioq->orders[slot] = __folio_order(folio);
+	folioq->orders[slot] = folio_order(folio);
 	return slot;
 }
 
@@ -263,7 +257,7 @@ static inline unsigned int folioq_append_mark(struct folio_queue *folioq, struct
 	unsigned int slot = folioq->vec.nr++;
 
 	folioq->vec.folios[slot] = folio;
-	folioq->orders[slot] = __folio_order(folio);
+	folioq->orders[slot] = folio_order(folio);
 	folioq_mark(folioq, slot);
 	return slot;
 }
-- 
2.25.1


