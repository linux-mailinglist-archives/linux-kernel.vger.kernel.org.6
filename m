Return-Path: <linux-kernel+bounces-170828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F2A8BDC9A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34ED5285A2F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFED13C667;
	Tue,  7 May 2024 07:44:13 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DE113C3E4
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 07:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715067852; cv=none; b=dk7KBZhXsTnQh1FBp6KEeHOES6y1BRnu/ZX8fo7PCZ4PscKMxKoMBvgxYfhqI5adYv+Hk2/k0ibV82W0XgntF4MiUri3zAxPb7lzjpEKp3fzz12F7VfLS78y7h+ux60eDG+P0U3x/H5VWoiJJC2UlX2XCIIM7IIH+9OdS++cAE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715067852; c=relaxed/simple;
	bh=dE9VGICyh+huStmvgxP1XR5gfGCKHKoL5yk42rNw5vc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K3ce0C8xheyYUJZ31IOM0kAKTGIqqGQ04erw57PvOR3MMzZ5qnbA937nVIqNuzmSw0ickPO4jJ0uVd3W66mFHmuhEX54lLuHG1uCFniNCTqTFBcAKZZVB8kI9aDbG8TgrnuoKHPZMiVZ1SqcXHmWgo0amQXkmWOhLJqEfOdv6Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 916f4ebe0c4511ef9305a59a3cc225df-20240507
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:fa673317-ca0d-47ab-870d-6b19f269f72a,IP:-13
	,URL:0,TC:0,Content:0,EDM:-30,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-52
X-CID-INFO: VERSION:1.1.37,REQID:fa673317-ca0d-47ab-870d-6b19f269f72a,IP:-13,U
	RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:-9,FILE:0,BULK:0,RULE:EDM_GN8D19FE,ACT
	ION:release,TS:-52
X-CID-META: VersionHash:6f543d0,CLOUDID:54c47b824903fa8c38e66720df0171e7,BulkI
	D:2405071544025Y87I3AH,BulkQuantity:0,Recheck:0,SF:66|38|24|17|19|43|74|10
	2,TC:nil,Content:0,EDM:2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-UUID: 916f4ebe0c4511ef9305a59a3cc225df-20240507
X-User: lijun01@kylinos.cn
Received: from localhost.localdomain [(39.156.73.14)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1017552724; Tue, 07 May 2024 15:44:00 +0800
From: Li Jun <lijun01@kylinos.cn>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	lvjianmin@loongson.cn,
	dongbiao@loongson.cn,
	zhangbaoqi@loongson.cn
Cc: lijun01@kylinos.cn,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] LoongArch: Update the flush cache policy
Date: Tue,  7 May 2024 15:43:57 +0800
Message-Id: <20240507074357.2156083-1-lijun01@kylinos.cn>
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
 arch/loongarch/mm/cache.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/mm/cache.c b/arch/loongarch/mm/cache.c
index 6be04d36ca07..89eeb9a97dd5 100644
--- a/arch/loongarch/mm/cache.c
+++ b/arch/loongarch/mm/cache.c
@@ -63,6 +63,27 @@ static void flush_cache_leaf(unsigned int leaf)
 	} while (--nr_nodes > 0);
 }
 
+static void flush_cache_last_level(unsigned int leaf)
+{
+	u64 addr;
+	int i, j, nr_nodes;
+	struct cache_desc *cdesc = current_cpu_data.cache_leaves + leaf;
+
+	nr_nodes = loongson_sysconf.nr_nodes;
+
+	addr = CSR_DMW1_BASE;
+	iocsr_write32(0x1, 0x280);
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
@@ -71,7 +92,7 @@ asmlinkage __visible void __flush_cache_all(void)
 
 	leaf = cache_present - 1;
 	if (cache_inclusive(cdesc + leaf)) {
-		flush_cache_leaf(leaf);
+		flush_cache_last_level(leaf);
 		return;
 	}
 
-- 
2.34.1


