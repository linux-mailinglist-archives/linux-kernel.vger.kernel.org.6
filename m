Return-Path: <linux-kernel+bounces-204230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DF48FE615
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEBB21F2560C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEADD195967;
	Thu,  6 Jun 2024 12:09:18 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E5A1667E3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675758; cv=none; b=MuHDpxkUp8iLRHhQ9VTmmV/zhrF0qUN8GmH2ShBLsEVrNmLHGx4ormtDepUwxXXEoExk/k5q7cj3QeFTYF2AarLk1ocw39TxTjjq/K4p75B7TUoQ1BY72+RgIkAe2ohwoWwZyp/ZcZ1U1UJ0vMHqRGNCHrL/nE8sBH9QOs4ZoWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675758; c=relaxed/simple;
	bh=dM3fg9UVmmAVw4KeOAZWi4d6ofeyiVFvAa39WV5HAiw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UANqwsKHtWu/GVUr+uW6TztvpfVLvpvM+xcBAWAoaa4j1WLGFVL1vuN9B8TuGlaGF6WqHdZ7exakq8uWoXTZcsY8f0K+JAc8n28aobXFVxJxCH/d9iQBqNSrLO1D6jZooAJ6l+8kmKo6q0SpuykSBX74as2EhYpgTlGuY2+vbFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9215e79023fd11ef9305a59a3cc225df-20240606
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:fea27831-eeb0-439f-8a9c-de7b6491236c,IP:25,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-1,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-1
X-CID-INFO: VERSION:1.1.38,REQID:fea27831-eeb0-439f-8a9c-de7b6491236c,IP:25,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-1,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-1
X-CID-META: VersionHash:82c5f88,CLOUDID:901b4fd3b59d44e3d60918a0391e12b0,BulkI
	D:240606200906C0SIN0UP,BulkQuantity:0,Recheck:0,SF:66|25|72|19|44|102,TC:n
	il,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED, SA_UNFAMILIAR
	SN_UNTRUSTED, SN_UNFAMILIAR, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-UUID: 9215e79023fd11ef9305a59a3cc225df-20240606
X-User: pengfuyuan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <pengfuyuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1518246745; Thu, 06 Jun 2024 20:09:05 +0800
From: pengfuyuan <pengfuyuan@kylinos.cn>
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	pengfuyuan <pengfuyuan@kylinos.cn>,
	k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] arm/komeda: Remove all CONFIG_DEBUG_FS conditional compilations
Date: Thu,  6 Jun 2024 20:08:42 +0800
Message-Id: <20240606120842.1377267-1-pengfuyuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the debugfs functions have no-op stubs for CONFIG_DEBUG_FS=n,
the compiler will optimize the rest away since they are no longer referenced.

The benefit of removing the conditional compilation is that the build
is actually tested for both CONFIG_DEBUG_FS configuration values.
Assuming most developers have it enabled, CONFIG_DEBUG_FS=n is not tested
much and may fail the build due to the conditional compilation.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>
---
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
index 14ee79becacb..5ba62e637a61 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -12,10 +12,8 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/dma-mapping.h>
-#ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
-#endif
 
 #include <drm/drm_print.h>
 
@@ -43,7 +41,6 @@ static int komeda_register_show(struct seq_file *sf, void *x)
 
 DEFINE_SHOW_ATTRIBUTE(komeda_register);
 
-#ifdef CONFIG_DEBUG_FS
 static void komeda_debugfs_init(struct komeda_dev *mdev)
 {
 	if (!debugfs_initialized())
@@ -55,7 +52,6 @@ static void komeda_debugfs_init(struct komeda_dev *mdev)
 	debugfs_create_x16("err_verbosity", 0664, mdev->debugfs_root,
 			   &mdev->err_verbosity);
 }
-#endif
 
 static ssize_t
 core_id_show(struct device *dev, struct device_attribute *attr, char *buf)
@@ -265,9 +261,7 @@ struct komeda_dev *komeda_dev_create(struct device *dev)
 
 	mdev->err_verbosity = KOMEDA_DEV_PRINT_ERR_EVENTS;
 
-#ifdef CONFIG_DEBUG_FS
 	komeda_debugfs_init(mdev);
-#endif
 
 	return mdev;
 
@@ -286,9 +280,7 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
 
 	sysfs_remove_group(&dev->kobj, &komeda_sysfs_attr_group);
 
-#ifdef CONFIG_DEBUG_FS
 	debugfs_remove_recursive(mdev->debugfs_root);
-#endif
 
 	if (mdev->aclk)
 		clk_prepare_enable(mdev->aclk);
-- 
2.25.1


