Return-Path: <linux-kernel+bounces-282180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B14594E083
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 10:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611721C20D1C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 08:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD8825632;
	Sun, 11 Aug 2024 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="NcLchHCR"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBA822318
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 08:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723364925; cv=pass; b=qWFIGoQrpMQzdG1Bbo6Vdag2V0pqFMkA0/Jn8uFNSZfi+4DLxp8sOKeicp/Lho1DRpt6cbsIn3fhXjhRNiF6YOohE+LZeWrAwMSlUi9Aj3uokEpMhj6amjNK38bFYSOKHvX+NdnUgXQplI4fG2X7tgUp2dD96vjy0WFBU2SzF9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723364925; c=relaxed/simple;
	bh=S2nYibSkxPlNJG6UY/XLEQBlCscsxwspcWrjARwiP54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=meYBXVGdai2Z4DAg67vpP6aBPH5SJ0YhNRbDTuqQtwqePnFtyoHqJ4vOzgc0OdsLzac66yEtugE3j/kTV8/1cgCDeYvcpTgxBkra/7HBWmizTymF55GjGXYgtRBh/2N1mLuMPj3B+JeSOvd0adY0JTI9BrFxRbUVI0Z2RLPgbDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=NcLchHCR; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
Delivered-To: uwu@icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1723364911; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=B+0C5KHeuBVdfBK7ZyL0s0sW8SYPjQ6YtghcVAZ8yIkRlEli78S+FV9xJNtljFCcYyHuZknqzzEyT5Lmr7QcZWSyKIlGmpqOY3hTJy6OSXvxcu7j98EPLDh61kwL7AdzBtEE542yqCV1y7vaJGyIbKvrmqz/B+VNcQAHAcVCGUk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723364911; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=f7hdzgnS4D8cvOAiuoGZzS0Zmgqk/HH2cuB+RJSCCpw=; 
	b=CGpyvGnK2QWw5HPNKRCUI2yn/VNBiRGU6mnLPSlVDTUmvoA9djfIsZugkz+DxjX3rLXYl27NmF8k8UoJK4UnkFJm/yxMUSyZfH5yzEuzGbfNwKcy6qNA8nhyG/XLVvyIBBfG7ZsyWNs9ucUn2BfYEhLDlOH8icI0pnJGTjpcVAY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723364911;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=f7hdzgnS4D8cvOAiuoGZzS0Zmgqk/HH2cuB+RJSCCpw=;
	b=NcLchHCRq4P5PlvH3MM8ecsPeQK9hjB+1qO4H62ZVxbfRVSJGpHUQQ9l3EQhw+uE
	XF9wZq6uEZvL4tgJrp20A6G6VGX8losVXK6mcRmAfMZXdV+bs1OvOz5jeLLn6ShHeO4
	RAZbomKrkUUDjIv0bcRCy4NvQ169Q9ez+oURSXrFtlupyBzLAcIi2KjbRiI/icfJGXi
	m5v58Ow3pXDz006WIjb/PVJz8fb4HNBYvQxkZNUpaPXKMoVNAuZgeoAs8S0z70KB3Fz
	jdunSGrLwyxqXkVsUrmomtRSzh2LsiLwSTnr8EKMdjpNyVP7sRIrEAcvjnY8rk6p4Gl
	dBtyUUp5UA==
Received: by mx.zohomail.com with SMTPS id 1723364909058364.2343906969842;
	Sun, 11 Aug 2024 01:28:29 -0700 (PDT)
From: Icenowy Zheng <uwu@icenowy.me>
To: Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH] drm/imagination: properly support stopping LAYOUT_MARS = 1 cores
Date: Sun, 11 Aug 2024 16:28:13 +0800
Message-ID: <20240811082813.245871-1-uwu@icenowy.me>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Some new Rogue GPU cores have an extra MARS power domain, which
controlls the power of the firmware core and allows the firmware core to
power down most parts of the GPU.

Adapt to this by ignoring power domains that should be powered down by
the fiwmare and checking MARS idle status instead.

The logic mimics RGXStop() function in the DDK kernel mode source code.

Tested on BXE-4-32 (36.50.54.182) with firmware build 6503725 OS provided
by Imagination Technologies.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 .../gpu/drm/imagination/pvr_fw_startstop.c    | 49 +++++++++++++------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw_startstop.c b/drivers/gpu/drm/imagination/pvr_fw_startstop.c
index 159a4c3dd65b..4301a7aded64 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_startstop.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_startstop.c
@@ -201,19 +201,28 @@ pvr_fw_stop(struct pvr_device *pvr_dev)
 				       ~(ROGUE_CR_SIDEKICK_IDLE_GARTEN_EN |
 					 ROGUE_CR_SIDEKICK_IDLE_SOCIF_EN |
 					 ROGUE_CR_SIDEKICK_IDLE_HOSTIF_EN);
+	const u32 mars_idle_mask = ROGUE_CR_MARS_IDLE_CPU_EN |
+				   ROGUE_CR_MARS_IDLE_MH_SYSARB0_EN;
 	bool skip_garten_idle = false;
+	u32 mars = 0;
 	u32 reg_value;
 	int err;
 
+	if (PVR_HAS_FEATURE(pvr_dev, layout_mars))
+		PVR_FEATURE_VALUE(pvr_dev, layout_mars, &mars);
+
 	/*
 	 * Wait for Sidekick/Jones to signal IDLE except for the Garten Wrapper.
 	 * For cores with the LAYOUT_MARS feature, SIDEKICK would have been
 	 * powered down by the FW.
 	 */
-	err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_SIDEKICK_IDLE, sidekick_idle_mask,
-				sidekick_idle_mask, POLL_TIMEOUT_USEC);
-	if (err)
-		return err;
+	if (mars) {
+		err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_SIDEKICK_IDLE,
+					sidekick_idle_mask,
+					sidekick_idle_mask, POLL_TIMEOUT_USEC);
+		if (err)
+			return err;
+	}
 
 	/* Unset MTS DM association with threads. */
 	pvr_cr_write32(pvr_dev, ROGUE_CR_MTS_INTCTX_THREAD0_DM_ASSOC,
@@ -267,21 +276,27 @@ pvr_fw_stop(struct pvr_device *pvr_dev)
 	 * For cores with the LAYOUT_MARS feature, SLC would have been powered
 	 * down by the FW.
 	 */
-	err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_SLC_IDLE,
-				ROGUE_CR_SLC_IDLE_MASKFULL,
-				ROGUE_CR_SLC_IDLE_MASKFULL, POLL_TIMEOUT_USEC);
-	if (err)
-		return err;
+	if (mars) {
+		err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_SLC_IDLE,
+					ROGUE_CR_SLC_IDLE_MASKFULL,
+					ROGUE_CR_SLC_IDLE_MASKFULL,
+					POLL_TIMEOUT_USEC);
+		if (err)
+			return err;
+	}
 
 	/*
 	 * Wait for Sidekick/Jones to signal IDLE except for the Garten Wrapper.
 	 * For cores with the LAYOUT_MARS feature, SIDEKICK would have been powered
 	 * down by the FW.
 	 */
-	err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_SIDEKICK_IDLE, sidekick_idle_mask,
-				sidekick_idle_mask, POLL_TIMEOUT_USEC);
-	if (err)
-		return err;
+	if (mars) {
+		err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_SIDEKICK_IDLE,
+					sidekick_idle_mask,
+					sidekick_idle_mask, POLL_TIMEOUT_USEC);
+		if (err)
+			return err;
+	}
 
 	if (pvr_dev->fw_dev.processor_type == PVR_FW_PROCESSOR_TYPE_META) {
 		err = pvr_meta_cr_read32(pvr_dev, META_CR_TxVECINT_BHALT, &reg_value);
@@ -297,7 +312,13 @@ pvr_fw_stop(struct pvr_device *pvr_dev)
 			skip_garten_idle = true;
 	}
 
-	if (!skip_garten_idle) {
+	if (mars) {
+		err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_MARS_IDLE,
+					mars_idle_mask, mars_idle_mask,
+					POLL_TIMEOUT_USEC);
+		if (err)
+			return err;
+	} else if (!skip_garten_idle) {
 		err = pvr_cr_poll_reg32(pvr_dev, ROGUE_CR_SIDEKICK_IDLE,
 					ROGUE_CR_SIDEKICK_IDLE_GARTEN_EN,
 					ROGUE_CR_SIDEKICK_IDLE_GARTEN_EN,
-- 
2.46.0


