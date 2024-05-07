Return-Path: <linux-kernel+bounces-170589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D107E8BD96D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 04:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C971C21C85
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 02:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9807321101;
	Tue,  7 May 2024 02:35:20 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B144CC122;
	Tue,  7 May 2024 02:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715049320; cv=none; b=kfD1ke9UGAkLnh3gh6TEV6FoGPXPlSzOKsFDKd9/qYpJckcXc7kRdPzQiuXWmFwqEkhh1EWYSHn41mLtzk8OP2z5uULaeGG+51AaOaF4xbuYkPU9PZluiZY9Vtox+Th36fJkw6DodbswxO3nibezl4H/vc/EOGNCGzfty9oaeDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715049320; c=relaxed/simple;
	bh=4nE0YoLavCG6nFcdk9BRRJ2U6lOzfw5OrR+znhpEmAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BvzWLfrmgW/d4Ll9dkJdgedBUM3P+NiXNRIzN0NURpcVzCmy+E08pdbfgt38Ll57110kTpcQP0w3DI55IGytZOhBmumM5kxc9YTQlswC/mdNbCyY0etdQWdNS2WgMrIVA8ypW8HklB8gWELYlW+mTO90WDaIptyevG/vETeZNgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 62f8615e0c1a11ef9305a59a3cc225df-20240507
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:010cd294-beaf-4dd7-a1a8-c915b23136d4,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-1,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:9
X-CID-INFO: VERSION:1.1.37,REQID:010cd294-beaf-4dd7-a1a8-c915b23136d4,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:9
X-CID-META: VersionHash:6f543d0,CLOUDID:6d4a49c856b5df577091a647cb68c95e,BulkI
	D:240507103454O43WAFO1,BulkQuantity:0,Recheck:0,SF:66|38|25|72|19|44|102,T
	C:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	DN_TRUSTED, SRC_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-UUID: 62f8615e0c1a11ef9305a59a3cc225df-20240507
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <yaolu@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1333284287; Tue, 07 May 2024 10:34:54 +0800
From: Lu Yao <yaolu@kylinos.cn>
To: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lu Yao <yaolu@kylinos.cn>
Subject: [PATCH] btrfs: scrub: fix a compilation warning
Date: Tue,  7 May 2024 10:34:17 +0800
Message-Id: <20240507023417.31796-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following error message is displayed:
  ../fs/btrfs/scrub.c:2152:9: error: ‘ret’ may be used uninitialized
  in this function [-Werror=maybe-uninitialized]"

Signed-off-by: Lu Yao <yaolu@kylinos.cn>
---
gcc version: (Debian 10.2.1-6) 10.2.1 20210110
---
 fs/btrfs/scrub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 4b22cfe9a98c..afd6932f5e89 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2100,7 +2100,7 @@ static int scrub_simple_mirror(struct scrub_ctx *sctx,
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	const u64 logical_end = logical_start + logical_length;
 	u64 cur_logical = logical_start;
-	int ret;
+	int ret = 0;
 
 	/* The range must be inside the bg */
 	ASSERT(logical_start >= bg->start && logical_end <= bg->start + bg->length);
-- 
2.25.1


