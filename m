Return-Path: <linux-kernel+bounces-231812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9970919E81
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022FB1C22C12
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 05:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FE31C2AD;
	Thu, 27 Jun 2024 05:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RdmepvZs"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119C71B947
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 05:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719465098; cv=none; b=DQnOvUEDWog1yRBCYuCal2HGA/CfAWLf3kLdyvvSpOJRGkXNLPc9ZXjSGTbW2uWEaSiq0fcX0tfWqHDTQ9r01SqC4yc+dDu6G+90kRjmvxWcDYIvYTq+M9EhOqGSA6mZp3noHQdAEZZ79YntvB7IrImdJ6EXftPeG1tPw5FuRUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719465098; c=relaxed/simple;
	bh=WuWHpJmXDv6g3BssnqX5RX5nEbdiXnCa8I0e1tCBJc8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JfW8mp+N8cEifpyEf7fQjc6I3bwrxq2VdoNUrtXS6Oli2IohRZp5D5l4oxXf0NXeV8Ngiq9IY+fApban1vleHFSLqbfIdW3mBN9cY6drjtKEGaZ3lIZTkH6EKCm+ozzWj4t1/nREZL57BnK4zW6WC6SrTfevyFILA+1+EehU8q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=RdmepvZs; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b763a018344311ef99dc3f8fac2c3230-20240627
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=iQzqbkPgiFi/rlQxpl1z1jRA4cpZEngiRGiwDf3ts9A=;
	b=RdmepvZsetO/fTI+4H24d6CFZP+x/CjrMWBU+oUEEMXamOELWjzbGJFyGYxNBCprwUq7ZaNnvX4yl5X92spbWG4RkqJZWARKBT6CHE8mFSiBer2TkUFKKR3nhHXlTgWDObhkWzXE21Dxt/+jxhnS6rPKaEM+Y0BT7KoUsFpPpQs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:758515d5-9830-408c-bd72-5006f8cce8be,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:7ddd9685-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b763a018344311ef99dc3f8fac2c3230-20240627
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <mark-pk.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1261336259; Thu, 27 Jun 2024 13:11:31 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 27 Jun 2024 13:11:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 27 Jun 2024 13:11:29 +0800
From: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To: Jens Wiklander <jens.wiklander@linaro.org>, Sumit Garg
	<sumit.garg@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <yj.chiang@mediatek.com>, Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
	"ming-jen . chang" <ming-jen.chang@mediatek.com>,
	<op-tee@lists.trustedfirmware.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH] tee: optee: ffa: Fix missing-field-initializers warning
Date: Thu, 27 Jun 2024 13:11:17 +0800
Message-ID: <20240627051125.24084-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--6.025600-8.000000
X-TMASE-MatchedRID: LgKL3nvPUKSE9zgVMk3pXuIfK/Jd5eHmbtUOg4wiVGD7a38GZa638wXG
	B3tb8aAxThbvLLI8RvPxY0WGgfScA89tfSEZlKTRjtK7dC6UBnmOhEhoAl74KJsoi2XrUn/Jn6K
	dMrRsL14qtq5d3cxkNetBOdQ/FYIPqaYAMJWlyDYC/JB2Q6Hcy9VFGi+YsWFlpv2b2upGJmjAvp
	LE+mvX8g==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.025600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 278060FC629C8497EE8B26FBEC3A4804E38C7605AD06555C004F5A98FE2A032E2000:8
X-MTK: N

The 'missing-field-initializers' warning was reported
when building with W=2.
This patch ensures that the remaining fields of
'ffa_send_direct_data' are zero-initialized.

Signed-off-by: ming-jen.chang <ming-jen.chang@mediatek.com>
Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 drivers/tee/optee/ffa_abi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
index 3235e1c719e8..1aa995752682 100644
--- a/drivers/tee/optee/ffa_abi.c
+++ b/drivers/tee/optee/ffa_abi.c
@@ -660,7 +660,7 @@ static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,
 					const struct ffa_ops *ops)
 {
 	const struct ffa_msg_ops *msg_ops = ops->msg_ops;
-	struct ffa_send_direct_data data = { OPTEE_FFA_GET_API_VERSION };
+	struct ffa_send_direct_data data = { OPTEE_FFA_GET_API_VERSION, 0, 0, 0, 0 };
 	int rc;
 
 	msg_ops->mode_32bit_set(ffa_dev);
@@ -677,7 +677,7 @@ static bool optee_ffa_api_is_compatbile(struct ffa_device *ffa_dev,
 		return false;
 	}
 
-	data = (struct ffa_send_direct_data){ OPTEE_FFA_GET_OS_VERSION };
+	data = (struct ffa_send_direct_data){ OPTEE_FFA_GET_OS_VERSION, 0, 0, 0, 0 };
 	rc = msg_ops->sync_send_receive(ffa_dev, &data);
 	if (rc) {
 		pr_err("Unexpected error %d\n", rc);
@@ -698,7 +698,7 @@ static bool optee_ffa_exchange_caps(struct ffa_device *ffa_dev,
 				    unsigned int *rpc_param_count,
 				    unsigned int *max_notif_value)
 {
-	struct ffa_send_direct_data data = { OPTEE_FFA_EXCHANGE_CAPABILITIES };
+	struct ffa_send_direct_data data = { OPTEE_FFA_EXCHANGE_CAPABILITIES, 0, 0, 0, 0 };
 	int rc;
 
 	rc = ops->msg_ops->sync_send_receive(ffa_dev, &data);
-- 
2.18.0


