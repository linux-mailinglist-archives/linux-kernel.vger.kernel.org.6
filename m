Return-Path: <linux-kernel+bounces-552854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31131A57FE2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 00:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E66C16D5C0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 23:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7AE1B4F08;
	Sat,  8 Mar 2025 23:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="otgD3b0c"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C98D1A3177
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 23:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741477448; cv=none; b=cZnjjPkmp5YqpOZkEc8L3/4mFMUc1QQFvxxuS9EhyNzJhBkn/twzzP+WpJTD3R8EBmDH/49nbHQelj4Hq66mCZky7wOwsETCLsk0JOmQtlFH4KI3GG0G2iOTqjEJq0jxkRxbeClvNSKjVGgbNsoUW4NTRQu2bwOSLCWVu0ON1XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741477448; c=relaxed/simple;
	bh=nAuWPdaj5906azzD8D92vcsiEemeTPQO2pJz1/11o5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s0m2B1Oiy/pxa0cH1un5UFm8clGBkOIR3XjTMJhtk/phTTy7+Be2hLLJcX7wW/sxJZ1vmYNHYW/TpiEsF5ixuXyFgqt7LjcnHIOW9DIpCSyL/Lw6+FbQCAzC+dstwmael+w5yK2OxhcVmL0YkQCfGSAqD3p0WMsNvUw6lks8Zww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=otgD3b0c; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=PRNBdzFOkXTmT7dggCnLiOeBjPIbxamWaZHWg1YH34k=; b=otgD3b0cb2aOpsT0
	WKxWiPHF5ZlEABWoPsGTtyw6yK/Pk0t2DDmHfAdeBOUItOdWsw7XcHcWSbgNr31wsnwmvWRol3HXC
	pInLM2hoE9iQlNThDX7p5x/bEpvIlY6ChqcFRiBGx5ZI8SgDAMP3pXaqu+tqPguhYtdHEv5LDOGh3
	x/YhS0risjIKAey37wUSxJQdAwTiUpEvi2C7YLP5iGTv9F75Om6yt/lbhJh5ZHyzJpEWJL5UP4QiZ
	xSeRGnpzxwEW0+HvAc4OhSUnITezQBlYg6qyt9ziNyPv9crmvLrsep4FkT+3YiHmdP++a3G10NYq3
	W6/n2a7trbWve+xfHg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tr3pl-003f0E-08;
	Sat, 08 Mar 2025 23:43:57 +0000
From: linux@treblig.org
To: patrik.r.jakobsson@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] drm/gma500/psb_intel_modes: Remove unused psb_intel_ddc_probe
Date: Sat,  8 Mar 2025 23:43:56 +0000
Message-ID: <20250308234356.255114-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

psb_intel_ddc_probe() was added in 2011 by
commit 89c78134cc54 ("gma500: Add Poulsbo support")
but has remained unused (probably because drm_get_edid is used
instead).

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/gpu/drm/gma500/psb_intel_drv.h   |  1 -
 drivers/gpu/drm/gma500/psb_intel_modes.c | 31 ------------------------
 2 files changed, 32 deletions(-)

diff --git a/drivers/gpu/drm/gma500/psb_intel_drv.h b/drivers/gpu/drm/gma500/psb_intel_drv.h
index 2499fd6a80c9..d80f2d0b712e 100644
--- a/drivers/gpu/drm/gma500/psb_intel_drv.h
+++ b/drivers/gpu/drm/gma500/psb_intel_drv.h
@@ -182,7 +182,6 @@ struct gma_i2c_chan *gma_i2c_create(struct drm_device *dev, const u32 reg,
 void gma_i2c_destroy(struct gma_i2c_chan *chan);
 int psb_intel_ddc_get_modes(struct drm_connector *connector,
 			    struct i2c_adapter *adapter);
-extern bool psb_intel_ddc_probe(struct i2c_adapter *adapter);
 
 extern void psb_intel_crtc_init(struct drm_device *dev, int pipe,
 			    struct psb_intel_mode_device *mode_dev);
diff --git a/drivers/gpu/drm/gma500/psb_intel_modes.c b/drivers/gpu/drm/gma500/psb_intel_modes.c
index 8be0ec340de5..45b10f30a2a9 100644
--- a/drivers/gpu/drm/gma500/psb_intel_modes.c
+++ b/drivers/gpu/drm/gma500/psb_intel_modes.c
@@ -11,37 +11,6 @@
 
 #include "psb_intel_drv.h"
 
-/**
- * psb_intel_ddc_probe
- * @adapter:   Associated I2C adaptor
- */
-bool psb_intel_ddc_probe(struct i2c_adapter *adapter)
-{
-	u8 out_buf[] = { 0x0, 0x0 };
-	u8 buf[2];
-	int ret;
-	struct i2c_msg msgs[] = {
-		{
-		 .addr = 0x50,
-		 .flags = 0,
-		 .len = 1,
-		 .buf = out_buf,
-		 },
-		{
-		 .addr = 0x50,
-		 .flags = I2C_M_RD,
-		 .len = 1,
-		 .buf = buf,
-		 }
-	};
-
-	ret = i2c_transfer(adapter, msgs, 2);
-	if (ret == 2)
-		return true;
-
-	return false;
-}
-
 /**
  * psb_intel_ddc_get_modes - get modelist from monitor
  * @connector: DRM connector device to use
-- 
2.48.1


