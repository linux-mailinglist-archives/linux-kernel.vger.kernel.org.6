Return-Path: <linux-kernel+bounces-169567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 271B38BCA94
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D722B283F15
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F6B1422D8;
	Mon,  6 May 2024 09:24:33 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2599A1422A7
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714987472; cv=none; b=Qf0vj4vc0m6E1DhFfI57WOZaTvLRg3wdI0rOO7g+XqAopGGi0WrufnPlfpOb6RqI4sGnAq2nS6gZLa1ctVOBI2X8yJgb1sXqihziOwCREO0mPG0v81frn9raDpf98kkRMrORIu8/C31Kd+L0+ArG39+hKqvtbONejCDoT91SgJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714987472; c=relaxed/simple;
	bh=BOOw4MeFYxFwk72FN29ozva5foxX5wj2uo2DtW10F20=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ay7/E4jdYrZDhEEqncOz42RXjGsEh0mb7zJLyQzc2oDeIKe80WX9fHnn+uOquLSpa2XfmwpfaL59QyfmqfX0sSwdzuPzaZRrLKwayXiXDSAlKPaVDoM9pxfx0Uu86G925XCx7CyF9vMqEmt6MBFBOOIBqf8fq9bR9HHkAzwli7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6c0a41120b8a11ef9305a59a3cc225df-20240506
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:d8e3611c-4a62-4832-ab66-0c02a044ac3c,IP:-3,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-2
X-CID-INFO: VERSION:1.1.37,REQID:d8e3611c-4a62-4832-ab66-0c02a044ac3c,IP:-3,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:-2
X-CID-META: VersionHash:6f543d0,CLOUDID:5d5fb924ee6c1fd64a0869cef45e4289,BulkI
	D:2405061724248U620WGO,BulkQuantity:0,Recheck:0,SF:66|38|24|72|19|43|74|10
	2,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC
	:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-UUID: 6c0a41120b8a11ef9305a59a3cc225df-20240506
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(39.156.73.14)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1613980171; Mon, 06 May 2024 17:24:21 +0800
From: Li Jun <lijun01@kylinos.cn>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	lvjianmin@loongson.cn,
	dongbiao@loongson.cn,
	zhangbaoqi@loongson.cn
Cc: lijun01@kylinos.cn,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] LoongArch: Update the flush cache policy
Date: Mon,  6 May 2024 17:24:19 +0800
Message-Id: <20240506092419.4109941-1-lijun01@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix when LoongArch s3 resume, Can't find image information

Signed-off-by: Li Jun <lijun01@kylinos.cn>
Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Biao Dong <dongbiao@loongson.cn>
---
 arch/loongarch/mm/cache.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/mm/cache.c b/arch/loongarch/mm/cache.c
index 6be04d36ca07..52872fa0e5d8 100644
--- a/arch/loongarch/mm/cache.c
+++ b/arch/loongarch/mm/cache.c
@@ -63,6 +63,28 @@ static void flush_cache_leaf(unsigned int leaf)
 	} while (--nr_nodes > 0);
 }
 
+static void flush_cache_last_level(unsigned int leaf)
+{
+	u64 addr;
+	int i, j, nr_nodes, way_size;
+	struct cache_desc *cdesc = current_cpu_data.cache_leaves + leaf;
+
+	nr_nodes = loongson_sysconf.nr_nodes;
+
+	addr = CSR_DMW1_BASE;
+	iocsr_write32(0x1, 0x280);
+	way_size = cdesc->sets * cdesc->linesz;
+	do {
+		for (i = 0; i < (cdesc->ways * 3); i++) {
+			for (j = 0; j < (cdesc->sets); j++) {
+				*(volatile u32 *)addr;
+				addr += cdesc->linesz;
+			}
+		}
+		addr += 0x100000000000;
+	} while (--nr_nodes > 0);
+}
+
 asmlinkage __visible void __flush_cache_all(void)
 {
 	int leaf;
@@ -71,7 +93,7 @@ asmlinkage __visible void __flush_cache_all(void)
 
 	leaf = cache_present - 1;
 	if (cache_inclusive(cdesc + leaf)) {
-		flush_cache_leaf(leaf);
+		flush_cache_last_level(leaf);
 		return;
 	}
 
-- 
2.34.1


