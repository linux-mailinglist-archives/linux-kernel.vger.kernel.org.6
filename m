Return-Path: <linux-kernel+bounces-389906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 526159B72B2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 04:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C340C2860A2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403A784E11;
	Thu, 31 Oct 2024 03:02:54 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868F61BD9EA
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 03:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730343773; cv=none; b=nUqyAaeJ2MLNqUfKPR2L1c89NqphVGyRrOwZxpvzKWqreLljU1Qy4I80/a2sAj976/ocoIJVqckknNbnOY0M5pnJuqjgJPo60KDC9CzdlXprrmtiYT+N+v+ewlBS5uPCJw/mQQEe7AqpgcBgUrMPxsnj6WkI95HqNVijyAX2pz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730343773; c=relaxed/simple;
	bh=4xzVZBzv2VEJx70ge8Ckzl86wAwNYn6ikKui/eaNHTI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kFab/l7X3P9yR9HmqXPu53MFYMPNtDfubJZbTXcFvY6+MKMfdsNQH/VUXxbp2G9cEu7kBjUer2vzMuAJRpMDxGqaXTiYG/IJt5Z9DVUrOqKzB7R0nJeqpirqtiP2m9uoV7wdzN7pc721/tes6OFlbFPWtq06JZQdUt99uFmlhCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 930b79bc973411efa216b1d71e6e1362-20241031
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:1156ef05-7704-4831-a6e7-3835a6f6075c,IP:5,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-5
X-CID-INFO: VERSION:1.1.38,REQID:1156ef05-7704-4831-a6e7-3835a6f6075c,IP:5,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:f37f4de97c5af6867ce5ba883aee855b,BulkI
	D:241031110235TPRFPUH8,BulkQuantity:0,Recheck:0,SF:841|25|17|19|45|66|102,
	TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:ni
	l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 930b79bc973411efa216b1d71e6e1362-20241031
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(111.48.58.10)] by mailgw.kylinos.cn
	(envelope-from <yaolu@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 262588545; Thu, 31 Oct 2024 11:02:33 +0800
From: Lu Yao <yaolu@kylinos.cn>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Lu Yao <yaolu@kylinos.cn>
Subject: [PATCH] drm/radeon/ni: Fix memory leak and missing error handling in ni_init_microcode()
Date: Thu, 31 Oct 2024 11:02:28 +0800
Message-Id: <20241031030228.46563-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'smc_fw' is not released when its size is not as expected, causing memory
leak. And when other firmware sizes do not meet expectations, 'err' is
assigned but does not jump to 'out'.

Signed-off-by: Lu Yao <yaolu@kylinos.cn>
---
 drivers/gpu/drm/radeon/ni.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ni.c b/drivers/gpu/drm/radeon/ni.c
index 3890911fe693..11f7a05a5261 100644
--- a/drivers/gpu/drm/radeon/ni.c
+++ b/drivers/gpu/drm/radeon/ni.c
@@ -765,6 +765,7 @@ int ni_init_microcode(struct radeon_device *rdev)
 		pr_err("ni_cp: Bogus length %zu in firmware \"%s\"\n",
 		       rdev->me_fw->size, fw_name);
 		err = -EINVAL;
+		goto out;
 	}
 
 	snprintf(fw_name, sizeof(fw_name), "radeon/%s_rlc.bin", rlc_chip_name);
@@ -775,6 +776,7 @@ int ni_init_microcode(struct radeon_device *rdev)
 		pr_err("ni_rlc: Bogus length %zu in firmware \"%s\"\n",
 		       rdev->rlc_fw->size, fw_name);
 		err = -EINVAL;
+		goto out;
 	}
 
 	/* no MC ucode on TN */
@@ -787,6 +789,7 @@ int ni_init_microcode(struct radeon_device *rdev)
 			pr_err("ni_mc: Bogus length %zu in firmware \"%s\"\n",
 			       rdev->mc_fw->size, fw_name);
 			err = -EINVAL;
+			goto out;
 		}
 	}
 
@@ -795,9 +798,7 @@ int ni_init_microcode(struct radeon_device *rdev)
 		err = request_firmware(&rdev->smc_fw, fw_name, rdev->dev);
 		if (err) {
 			pr_err("smc: error loading firmware \"%s\"\n", fw_name);
-			release_firmware(rdev->smc_fw);
-			rdev->smc_fw = NULL;
-			err = 0;
+			err = -EINVAL;
 		} else if (rdev->smc_fw->size != smc_req_size) {
 			pr_err("ni_mc: Bogus length %zu in firmware \"%s\"\n",
 			       rdev->smc_fw->size, fw_name);
@@ -818,6 +819,8 @@ int ni_init_microcode(struct radeon_device *rdev)
 		rdev->rlc_fw = NULL;
 		release_firmware(rdev->mc_fw);
 		rdev->mc_fw = NULL;
+		release_firmware(rdev->smc_fw);
+		rdev->smc_fw = NULL;
 	}
 	return err;
 }
-- 
2.25.1


