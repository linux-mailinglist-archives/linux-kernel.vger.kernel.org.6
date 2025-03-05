Return-Path: <linux-kernel+bounces-546209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB51A4F7C4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E553A61EE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242851DE4EC;
	Wed,  5 Mar 2025 07:18:13 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A9D1DB34C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 07:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741159092; cv=none; b=lKKJ2KdaCgYgFw2zuvR/zo2cOLwbYa4Q/0pgWZmyVFQ9V//cjdc37RFWrf3QxefgwwfLLOmlhnHllRu3xovPFJqXgUzp78Q39M8QNBEg33IpdXFhbp73+Ukfumj/3NAeJBoE0rMBrsV9qy7AlchluIMC/l7TN9RlOQlTHDeDF1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741159092; c=relaxed/simple;
	bh=N8haDKa62zb1X773whUADPgULNkfOIbaAup2z2ULzd4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Dg3CSHVsjh8LLbqbFEcIOvG0xuRIZyzOOuqIs1TqbhQOlOiDgxbWSRTVPL1rHtWZB0JoQupJMHhnNYV0JDaAhv20AUJaLsmVF75jGA7b6hhhKtHv4J+HVLUR2wejhclTEvbOsCfvwqhG7hfs8KmoqohAz7j5anMKtQc3LnIbwd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fa4cb2e8f99111efa216b1d71e6e1362-20250305
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:3b56a26c-4a68-4eb0-8273-47a82070a962,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:3b56a26c-4a68-4eb0-8273-47a82070a962,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:dfce84a5b08fa50e1769222d2197d96c,BulkI
	D:250305151804YU9YWGP2,BulkQuantity:0,Recheck:0,SF:17|19|24|38|44|66|78|10
	2,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:ni
	l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
	0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_ULN
X-UUID: fa4cb2e8f99111efa216b1d71e6e1362-20250305
X-User: liuye@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1321683669; Wed, 05 Mar 2025 15:18:03 +0800
From: Liu Ye <liuye@kylinos.cn>
To: akpm@linux-foundation.org,
	david@fromorbit.com
Cc: zhengqi.arch@bytedance.com,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liu Ye <liuye@kylinos.cn>
Subject: [PATCH v2] mm/shrinker: fix name consistency issue in shrinker_debugfs_rename()
Date: Wed,  5 Mar 2025 15:17:59 +0800
Message-Id: <20250305071759.661055-1-liuye@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After calling debugfs_change_name function, the return value should be
checked and the old name restored. If debugfs_change_name fails, the new
name memory should be freed. The effect is that the shrinker->name is not
consistent with the name displayed in debugfs.

Signed-off-by: Liu Ye <liuye@kylinos.cn>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by：Qi Zheng <zhengqi.arch@bytedance.com>

---
V2: Modify the subject add Reviewed-by.
---
---
 mm/shrinker_debug.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 794bd433cce0..20eaee3e97f7 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -214,10 +214,14 @@ int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
 	ret = debugfs_change_name(shrinker->debugfs_entry, "%s-%d",
 			shrinker->name, shrinker->debugfs_id);
 
+	if (ret) {
+		shrinker->name = old;
+		kfree_const(new);
+	} else {
+		kfree_const(old);
+	}
 	mutex_unlock(&shrinker_mutex);
 
-	kfree_const(old);
-
 	return ret;
 }
 EXPORT_SYMBOL(shrinker_debugfs_rename);
-- 
2.25.1


