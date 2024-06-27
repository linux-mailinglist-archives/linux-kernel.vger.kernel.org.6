Return-Path: <linux-kernel+bounces-232029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B890B91A1D4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40C52B23767
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 08:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D4413A24B;
	Thu, 27 Jun 2024 08:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="pP35tXkk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="GMBHode6"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87F412F59C;
	Thu, 27 Jun 2024 08:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719477928; cv=none; b=tLeqhTaioGIB/Kd6jBDKgE1Nq/MI0yY1BDITgLsQJl3gOM960iQlVQhs+Mco/DySIYUbLZG3nZr9K3y9zay4m4C2w1r0p4JNXtwzyJFxb5Vwb88RJPaRsL+y4p9G13r7ZU+MvYIiD6lxlpfww0FZArPv9EGvfrudEmJQiMA4CYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719477928; c=relaxed/simple;
	bh=CBwnZVqWlwB6ZxzB1zmLqHwmLi/Vd/JNt3u+4OXGpb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIK2HGTnWLbi7RhonwX9aQ1qI+PcMfH0DlpxZJwk65uprisERL/DqRlIfQZAwbXrQxf0V9Xy/nmEwqV+mIipT8xcFB3i+vGx6Krf3bXWNwSyzHcIPfwgDMn1yQasauT01ebh9JzaVH7T3bFtaTcftXKDpZU68SRl6bqT+fc+hgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=pP35tXkk; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=GMBHode6 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1719477926; x=1751013926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZFGqWlGDXLgahl3x+snZ/G6V92Yhfok4ec2lzUw0c3k=;
  b=pP35tXkk0uhTa6PWpTjI6efQh/XBMC+XTpkTs7iuOkdN7ULYrD05g+O+
   Q4LUYv7SD4/4tZf6RIJYMCKpAj6nz2uufH9JJCuQCk5eod5zY0zOcsOCn
   j9ENxqaKsjj6Fy3wF8vsplukJjwtP2xLbf3NDwFBLt7tVbktQKycWpqIB
   s4QayEjypaWvXLuh0T1ljV/LACUFa2KAqnmkexyPt4+T7Ph2M+0B0uS3H
   C8UqEisQfRve8SbFWx+GUdZcmBMg9g7Scnnj7fnKandLiMj1++veLj4YT
   9yfIXAO4VcsZqEOurkGkc+iB2I1sbMczMiwj9/Ejd9Fmc66B5+sVJwXqL
   g==;
X-CSE-ConnectionGUID: fPlsaZRKQwGux1jLtUYd3Q==
X-CSE-MsgGUID: ZHArUhrkQOeLkxzqYXyj5w==
X-IronPort-AV: E=Sophos;i="6.08,269,1712613600"; 
   d="scan'208";a="37617956"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 27 Jun 2024 10:45:25 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B95BC164472;
	Thu, 27 Jun 2024 10:45:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1719477921; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZFGqWlGDXLgahl3x+snZ/G6V92Yhfok4ec2lzUw0c3k=;
	b=GMBHode6N2s/fDaiAlyQLoxp5ChkEBPkZGgwr4/ekQfTnrpl3ldnaKVcCoS0M0tt2JvLLA
	Lf02ZfoqdhHqG/VFoE/rFinb42eDYysVR+ncQcYWYF1e90Ded0XU7V8pmUWaJVGcwc7l2E
	Mas9nz3sDvJfomTnBQTGgOiTmczi7J13sJE6lqoV+lb81iShxLEFURxVY9rN4IMstk5R+x
	tkAf1lcK5CKRDzyg5VQsPCnFDn0FI5NvCGSHj1mx599zqy5MRHcVXFgXsmHXeLD/Ux668P
	grmeyP20nqx8bjVVISflefnGI1c1MHyTeuwkrn+hdpD5VpKz6BS4fhZiI2SM4w==
From: Paul Gerber <paul.gerber@ew.tq-group.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: Paul Gerber <paul.gerber@ew.tq-group.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drm/panel: simple: Add AUO G104STN01 panel entry
Date: Thu, 27 Jun 2024 10:44:44 +0200
Message-ID: <20240627084446.3197196-3-paul.gerber@ew.tq-group.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240627084446.3197196-1-paul.gerber@ew.tq-group.com>
References: <20240627084446.3197196-1-paul.gerber@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add support for the AUO G104STN01 10.4" (800x600) LCD-TFT panel.

Signed-off-by: Paul Gerber <paul.gerber@ew.tq-group.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Tested on TQ TQMa8MPxL on MBa8MPxL.

 drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index dcb6d0b6ced0..5eacd2085a53 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1081,6 +1081,30 @@ static const struct panel_desc auo_g104sn02 = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct drm_display_mode auo_g104stn01_mode = {
+	.clock = 40000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 40,
+	.hsync_end = 800 + 40 + 88,
+	.htotal = 800 + 40 + 88 + 128,
+	.vdisplay = 600,
+	.vsync_start = 600 + 1,
+	.vsync_end = 600 + 1 + 23,
+	.vtotal = 600 + 1 + 23 + 4,
+};
+
+static const struct panel_desc auo_g104stn01 = {
+	.modes = &auo_g104stn01_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 211,
+		.height = 158,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct display_timing auo_g121ean01_timing = {
 	.pixelclock = { 60000000, 74400000, 90000000 },
 	.hactive = { 1280, 1280, 1280 },
@@ -4434,6 +4458,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "auo,g104sn02",
 		.data = &auo_g104sn02,
+	}, {
+		.compatible = "auo,g104stn01",
+		.data = &auo_g104stn01,
 	}, {
 		.compatible = "auo,g121ean01",
 		.data = &auo_g121ean01,
-- 
2.44.1


