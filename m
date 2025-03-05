Return-Path: <linux-kernel+bounces-545949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 922C2A4F444
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDD5B16A162
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0739A130AC8;
	Wed,  5 Mar 2025 02:01:41 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929EC1096F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 02:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741140100; cv=none; b=hTrOfhG49c5oG9Z3oP81yMUEtUJhD3y58Asud/Qaj6oHeqaiPH/S8IMHtrdcQhTjMQDm1rA1yMJc5Rf2Cg7JcRyu77rz7NJyzL65UZ847Xi+Z2fXXUFbeNTkfxrSgSNwSwokYdk9aSb9HYG1HM7taQT5dIQPaCaTBj2PbQGWVVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741140100; c=relaxed/simple;
	bh=hAofAIEqD6jqFphM74J7uWc3PTngqSKnEWNyQATsA94=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hKDt+K6tYFrw/Zbl8RQPexxQ/sBNFMpayZO12za6TrUyTSplUmd3u65CD6QNaoKbTc3o90nPyqjC/iW75H+LgDNxs0Y0/toWzC2GvYGyFW1JLw2M3oTm3wkDKzZWqTWx4ekncNGpHHOFsjQdWl3bkQ3TQhxTIaMq/MRvr/PxN6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c08401d2f96511efa216b1d71e6e1362-20250305
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:0238dafa-989b-4e74-8877-6f1d242694f5,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:0238dafa-989b-4e74-8877-6f1d242694f5,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:04d3d84079e81ad0c78bc98d82cfcc6a,BulkI
	D:250305100129VIYHD579,BulkQuantity:0,Recheck:0,SF:17|19|24|38|44|66|78|10
	2,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,B
	EC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: c08401d2f96511efa216b1d71e6e1362-20250305
X-User: liuye@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1422417236; Wed, 05 Mar 2025 10:01:28 +0800
From: Liu Ye <liuye@kylinos.cn>
To: akpm@linux-foundation.org,
	david@fromorbit.com
Cc: zhengqi.arch@bytedance.com,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liu Ye <liuye@kylinos.cn>
Subject: [PATCH] mm/shrinker_debug: Fix possible memory leak in shrinker_debugfs_rename function.
Date: Wed,  5 Mar 2025 10:01:23 +0800
Message-Id: <20250305020123.605496-1-liuye@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After calling debugfs_change_name function, the return value should be
checked and the old name restored. If debugfs_change_name fails, the new
name memory should be freed.

Signed-off-by: Liu Ye <liuye@kylinos.cn>
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


