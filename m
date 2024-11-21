Return-Path: <linux-kernel+bounces-416490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8F89D45CF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 639882848ED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 02:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC819146A6F;
	Thu, 21 Nov 2024 02:40:25 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BDF43ACB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 02:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732156825; cv=none; b=huTs9+l6YH3PA+xr3S56WTjm1kOJzhrRC4DHW73FReF7b53NowHoNZhwz5bId87WT26Mq4wgl3ZCLUu369FTzcFJvLzOGMFEydzuOUr+GRfdaa23vUW/Ex7dGXgmfu9OfRjdPh3IwFsTIJTLhEXjvfvvOxMH93Biemxby2r404g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732156825; c=relaxed/simple;
	bh=SLEhnJjeqm/j9MyZ+qS5cLrwfvSHIy51IzjM7E2b6lo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b28sdT5XGQZ8buyj3BBvZzPd8vbkk2aPA8GcRagBirSGs0HrrBGENNtB1wVf1JGSSjLpwuFdi2ZidoLbND+9QoXb4XES44d3f7q5bYEnlL0/sUITXfThUjBGkZaBf68rTxPFCnZu4V44K8QAVTd2LjoHyMUGz8DvEv5sv7+dx5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ebeacc80a7b111efa216b1d71e6e1362-20241121
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI, GTI_FG_IT
	GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI
	AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:85a52618-bc1c-4517-88d6-fd6292af722f,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:15
X-CID-INFO: VERSION:1.1.38,REQID:85a52618-bc1c-4517-88d6-fd6292af722f,IP:0,URL
	:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-META: VersionHash:82c5f88,CLOUDID:9141f5d206595f2c7eeb1c3031ef7f88,BulkI
	D:241121104009WRZHCVZB,BulkQuantity:0,Recheck:0,SF:19|66|841|38|17|102,TC:
	nil,Content:0,EDM:5,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-UUID: ebeacc80a7b111efa216b1d71e6e1362-20241121
X-User: xiaopei01@kylinos.cn
Received: from xiaopei-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 153133919; Thu, 21 Nov 2024 10:40:08 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: suzuki.poulose@arm.com,
	mike.leach@linaro.org,
	james.clark@linaro.org,
	alexander.shishkin@linux.intel.com,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] coresight: Fix dsb_mode_store() unsigned val is never less than zero
Date: Thu, 21 Nov 2024 10:40:03 +0800
Message-Id: <122503017ada249fbf12be3fa4ee6ccb8f8c78cc.1732156624.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202410150702.UaZ7kvet-lkp@intel.com>
References: <202410150702.UaZ7kvet-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dsb_mode_store() warn: unsigned 'val' is never less than zero.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410150702.UaZ7kvet-lkp@intel.com/
Fixes: 018e43ad1eee ("coresight-tpdm: Add node to set dsb programming mode")
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/hwtracing/coresight/coresight-tpdm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c b/drivers/hwtracing/coresight/coresight-tpdm.c
index b7d99e91ab84..158950243d83 100644
--- a/drivers/hwtracing/coresight/coresight-tpdm.c
+++ b/drivers/hwtracing/coresight/coresight-tpdm.c
@@ -640,8 +640,7 @@ static ssize_t dsb_mode_store(struct device *dev,
 	struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	unsigned long val;
 
-	if ((kstrtoul(buf, 0, &val)) || (val < 0) ||
-			(val & ~TPDM_DSB_MODE_MASK))
+	if ((kstrtoul(buf, 0, &val)) || (val & ~TPDM_DSB_MODE_MASK))
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-- 
2.34.1


