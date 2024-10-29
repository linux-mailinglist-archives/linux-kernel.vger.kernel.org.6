Return-Path: <linux-kernel+bounces-386663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DD99B4696
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873F6282A63
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC96E204F78;
	Tue, 29 Oct 2024 10:19:18 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B16204098
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730197158; cv=none; b=JlBC8tlnZ+kAIYigAJqmL1G/YnBwizJsNJ1AYl8o5IRNw5HEXvAvOXkJM94IWUQB2SUs2E+8iZB9F44UTPv/gjdXA8rErCh4dUrQyXtgjoKqbK4/1/ATbAUspSY51T+ndvyAA3gW0q79yKYUq0BKnfIl06r080u17F/4O1mdABc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730197158; c=relaxed/simple;
	bh=LVKDUrcQcElxjQbX8op354Jgek9F9zCXPV5kpWMUO7E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MJMiPAvJNo00t0d71VLH3CDZjyYzUMiFqBgf3x+Pgm5pi5GkP6trIVSScG28zJkEP7Gb6ZK59g+fHdt4IYF7CvKCa+KZm8Py/EQqTJIdbhO+rN7499VP25qkZ32lF3tKG9aCuHr0eo3jFAyepcy63ge6UnvVlzj/YFVYrizpOJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3a9341c695df11efa216b1d71e6e1362-20241029
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, DN_TRUSTED
	SRC_TRUSTED, SA_UNTRUSTED, SA_UNFAMILIAR, SN_UNTRUSTED, SN_UNFAMILIAR
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:6b8f3b12-faf5-4a8d-a269-1b9dc56d5702,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:18,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:38
X-CID-INFO: VERSION:1.1.38,REQID:6b8f3b12-faf5-4a8d-a269-1b9dc56d5702,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:18,FILE:0,BULK:0,RULE:Release_HamU,ACTION
	:release,TS:38
X-CID-META: VersionHash:82c5f88,CLOUDID:197810b0e41b391e0c9a1f3cd400b1fd,BulkI
	D:2410291819064NGZ8PPP,BulkQuantity:0,Recheck:0,SF:19|43|74|66|841|38|23|1
	6|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_USA
X-UUID: 3a9341c695df11efa216b1d71e6e1362-20241029
X-User: zhangguopeng@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 875702192; Tue, 29 Oct 2024 18:19:06 +0800
From: zhangguopeng <zhangguopeng@kylinos.cn>
To: linmiaohe@huawei.com,
	linux-mm@kvack.org
Cc: nao.horiguchi@gmail.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	zhangguopeng <zhangguopeng@kylinos.cn>
Subject: [PATCH] mm/memory-failure: Replace sprintf() with sysfs_emit()
Date: Tue, 29 Oct 2024 18:18:53 +0800
Message-Id: <20241029101853.37890-1-zhangguopeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Documentation/filesystems/sysfs.rst suggested, show() should only
use sysfs_emit() or sysfs_emit_at() when formatting the value to be
returned to user space.

Signed-off-by: zhangguopeng <zhangguopeng@kylinos.cn>
---
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 7194d6639720..fff849daceba 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -100,7 +100,7 @@ static ssize_t _name##_show(struct device *dev,			\
 {								\
 	struct memory_failure_stats *mf_stats =			\
 		&NODE_DATA(dev->id)->mf_stats;			\
-	return sprintf(buf, "%lu\n", mf_stats->_name);		\
+	return sysfs_emit(buf, "%lu\n", mf_stats->_name);	\
 }								\
 static DEVICE_ATTR_RO(_name)
 
-- 
2.25.1


