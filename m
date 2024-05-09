Return-Path: <linux-kernel+bounces-174328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DD48C0D1C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 11:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071C61F226FC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B3314A4EF;
	Thu,  9 May 2024 09:06:13 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA13C14C5BF
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 09:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245572; cv=none; b=DxXdB4lBfiBODR7xh0irkzMju2qI9I6ZNcH4lMHEHvy7c/V+FG27P+HxsY0tTWGjwfZjIhyNFYVlBm0W5Hpft8uL7uUFIG3qtqu8pAoQ0Toha1QViCdY0fCzLyqvaP9wS2Tlb3avcgWDz8NGWCiD0BYNoml+pH7AoyaxpetG+sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245572; c=relaxed/simple;
	bh=vYC5NvNJ4aJ9CJ6rl24BmigQQLD96y14k7heirDSbpc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UP0SGO5pYUbkFt5nc7eA7RwNZ0MHCURkZbKO6Q1YMBNBLp2TTn+yale7U9kSCv4I9Y+ORJimvIuGNAk6FxDgPz+Mrrdbj6775SJvdyfmEAgVehpYjDnZejmY0KJCpk0kqXzNKfzOmpvK+dCwverPRzuXg+6HSs/4LvlqV+gev3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5b94af880de311ef9305a59a3cc225df-20240509
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:f99393cb-0013-4c06-972b-1c94c77f2aa8,IP:10,
	URL:0,TC:0,Content:-25,EDM:25,RT:0,SF:-11,FILE:0,BULK:0,RULE:Release_Ham,A
	CTION:release,TS:-1
X-CID-INFO: VERSION:1.1.37,REQID:f99393cb-0013-4c06-972b-1c94c77f2aa8,IP:10,UR
	L:0,TC:0,Content:-25,EDM:25,RT:0,SF:-11,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-1
X-CID-META: VersionHash:6f543d0,CLOUDID:03449bcc8d4fcf2644a010ca5f18e3b8,BulkI
	D:240509170604U15SBRAY,BulkQuantity:0,Recheck:0,SF:66|25|17|19|44|102,TC:n
	il,Content:0,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	DN_TRUSTED, SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-UUID: 5b94af880de311ef9305a59a3cc225df-20240509
X-User: oushixiong@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw.kylinos.cn
	(envelope-from <oushixiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 95223455; Thu, 09 May 2024 17:06:01 +0800
From: oushixiong <oushixiong@kylinos.cn>
To: Xinliang Liu <xinliang.liu@linaro.org>
Cc: Tian Tao <tiantao6@hisilicon.com>,
	Xinwei Kong <kong.kongxinwei@hisilicon.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Yongqin Liu <yongqin.liu@linaro.org>,
	John Stultz <jstultz@google.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] drm/hisilicon: Fix a NULL pointer access when call hibmc_unload
Date: Thu,  9 May 2024 17:05:01 +0800
Message-Id: <20240509090501.127975-1-oushixiong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shixiong Ou <oushixiong@kylinos.cn>

If Calling hibmc_mm_init() failed in hibmc_load(), the hibmc_unload()
will access a NULL pointer, as it don't call ww_mutex_init() to
initialize mode_config.connection_mutex but try to lock it when
calling drm_atomic_helper_shutdown().

[   50.939211][  0] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000018
	......
[   51.149882][  0] Call trace:
[   51.152750][  0]  ww_mutex_lock+0xf0/0x1e0
[   51.156829][  0]  drm_modeset_lock+0x184/0x2c0
[   51.161254][  0]  drm_modeset_lock_all_ctx+0x98/0x188
[   51.166284][  0]  drm_atomic_helper_shutdown+0xa4/0x128
[   51.171487][  0]  hibmc_unload+0x50/0x2f0
[   51.175479][  0]  hibmc_load+0x5d8/0x888
[   51.179386][  0]  drm_dev_register+0x280/0x558
[   51.183811][  0]  drm_get_pci_dev+0x140/0x3c8
[   51.188150][  0]  hibmc_pci_probe+0x148/0x190
[   51.192489][  0]  local_pci_probe+0xc4/0x180
[   51.196742][  0]  pci_device_probe+0x328/0x530
[   51.201167][  0]  really_probe+0x498/0x9a0
[   51.205248][  0]  driver_probe_device+0x224/0x308
[   51.209932][  0]  device_driver_attach+0xec/0x128
[   51.214616][  0]  __driver_attach+0x144/0x280
[   51.218955][  0]  bus_for_each_dev+0x120/0x1a0
[   51.223380][  0]  driver_attach+0x48/0x60
[   51.227372][  0]  bus_add_driver+0x328/0x578
[   51.231625][  0]  driver_register+0x148/0x398
[   51.235965][  0]  __pci_register_driver+0x15c/0x1c8
[   51.240823][  0]  hibmc_init+0x2c/0x34
[   51.244557][  0]  do_one_initcall+0xc8/0x4a8
[   51.248810][  0]  kernel_init_freeable+0x678/0x75c
[   51.253582][  0]  kernel_init+0x18/0x128
[   51.257489][  0]  ret_from_fork+0x10/0x18

Add a initialized flag to avoid this.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 8 ++++++--
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 57c21ec452b7..343f64d66e75 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -99,6 +99,7 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
 	ret = drmm_mode_config_init(dev);
 	if (ret)
 		return ret;
+	priv->mode_config_initialized = true;
 
 	dev->mode_config.min_width = 0;
 	dev->mode_config.min_height = 0;
@@ -240,9 +241,12 @@ static int hibmc_hw_init(struct hibmc_drm_private *priv)
 static int hibmc_unload(struct drm_device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
 
-	drm_atomic_helper_shutdown(dev);
-
+	if(priv->mode_config_initialized){
+		drm_atomic_helper_shutdown(dev);
+		priv->mode_config_initialized = false;
+	}
 	free_irq(pdev->irq, dev);
 
 	pci_disable_msi(to_pci_dev(dev->dev));
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index 207aa3f660b0..08fd7cb59bb5 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -37,6 +37,7 @@ struct hibmc_drm_private {
 	struct drm_crtc crtc;
 	struct drm_encoder encoder;
 	struct hibmc_connector connector;
+	bool mode_config_initialized;
 };
 
 static inline struct hibmc_connector *to_hibmc_connector(struct drm_connector *connector)
-- 
2.25.1


