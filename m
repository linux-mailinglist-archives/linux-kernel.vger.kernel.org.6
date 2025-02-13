Return-Path: <linux-kernel+bounces-514003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB71A35137
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FFE016DE65
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47183270EB1;
	Thu, 13 Feb 2025 22:25:17 +0000 (UTC)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E7F19DF61
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739485516; cv=none; b=oP6wOb+1rJZ5ByxKVHx3+aR1KvYtUrPHAGx7Ppi0XnabyFtoGYlxrc58Gw3V5L2lscUIu0Iw1Nhs6OccdQR8Pl9J8HIVz7U3zskSsFHz7/IWMuDgOLKse4/u4Yfye0LK8o9p+6wdqyx8MkXcC+WFAbePIZpmSS5+RgrvtxaqRcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739485516; c=relaxed/simple;
	bh=JNmWTqXHg0QRaCYV5/93bQe4KFEpmNNUiOpOxM8Hhhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJRPVq35O7rXWqGV/+DjuqRni93PqWUU/3VDQPSjNzlEOQctpYi8mBtxluMyLB2ln+fpkknojbsaDrCJS80tjdPdO2/4VZqiCnd1ZONy9dfhDQyRbvEmhnVceeobD+PXFl+oNN5R3p5b5gXLVUe9T/n7MElv5T+MnKZSNw/e/YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uejji.net; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uejji.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3f3da0b72caso783270b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:25:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739485513; x=1740090313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5Koqqds6/Oa1Ks59aNVsxFB/wqKaebUccbyhlEMaPk=;
        b=udjullkw0fqEwZaVsvQLorSI6j9Pp0gtXudedYBc8zOo7X1NE8wA5hzqNclq/xirIu
         TpNQIevPEezoDtMbXjpAyzfItyRdGwuaUkeQLgrN8ENpqANXKwOM6zp/tK81A/T1x00C
         D0FUmqBgmAaN94p7aNs9o5NBrLN8rwgPDv/vfjixR4+pXDvASDNcKx9oss+pKIoP/XaZ
         5iXCxAZs++7WUPZkeGz8VtZo4wuNzgVttASdgtYbN1rCabxtDiMMY0Cr/LauYbTrLta9
         hS8nIYmjCOprNqiGG1Pxd2FTG/ueILspr/cwS6alZavzlLX+sndx61v/DS7trc9llW/N
         Bruw==
X-Forwarded-Encrypted: i=1; AJvYcCWA6dfDR0LviB0W21STPN1SE3iALwNv+h/KvrGimQUCrtAWUPITsxYlKRqqXRjTUCfxXSf8aiHTSZTpcMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz34vOUiau4JG9lfwyH1dh+3kmoMvW39HRURu/JNXlOKOnwK0yw
	2m7YDXyNeyoOrbC0VKbjFEG6msUaS9ORV3p8/g5EjyvXpSgVAdD6
X-Gm-Gg: ASbGnctvpvGeaTENCbrN4Xv1CeH2hNBp3MiJ1n0Im8isfhb1kymtAxRFts1V/iwbLj+
	r9hVynC1cPsO200TGaBPJhyZEV9/vuRZLc1JSTUBKZXsiaO/PL/q1/ZL6xgkMGXleCSUSXSXQdB
	zv+IkKh/Lli/QPiGSRby9kdTki9KNfvhbvdc3pTR/7g6PSCyZOrcUvBtVxySxuyQ7y2mYGvnZ1f
	ZHzQdKVkU4LlMiBAe0uK2jTIVaruaRTMnRRpr4ow4YVRwFISIEsdZVE1go+ANKV15NcPhhRn6GZ
	52qA8rBYaMztd2ff
X-Google-Smtp-Source: AGHT+IGgZGSQ0bjsz7JLGz80TDQRbnkyLOC23cDSniTL9nQuAzEpOrzRjMZqGE4A3Tts2LgXfxfIeA==
X-Received: by 2002:a05:6808:350b:b0:3f3:e0ea:86f7 with SMTP id 5614622812f47-3f3e0ea8937mr522134b6e.16.1739485513346;
        Thu, 13 Feb 2025 14:25:13 -0800 (PST)
Received: from muster.uejji.net ([47.188.205.107])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-727001cde00sm984184a34.5.2025.02.13.14.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:25:13 -0800 (PST)
From: John Edwards <uejji@uejji.net>
To: Hans de Goede <hdegoede@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: John Edwards <uejji@uejji.net>,
	Andrew Wyatt <fewtarius@steamfork.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] drm: panel-orientation-quirks: Add quirk for AYA NEO Slide
Date: Thu, 13 Feb 2025 22:24:51 +0000
Message-ID: <20250213222455.93533-4-uejji@uejji.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250213222455.93533-1-uejji@uejji.net>
References: <20250213222455.93533-1-uejji@uejji.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrew Wyatt <fewtarius@steamfork.org>

The AYANEO Slide uses a 1080x1920 portrait LCD panel.  This is the same
panel used on the AYANEO Air Plus, but the DMI data is too different to
match both with one entry.

Add a DMI match to correctly rotate the panel on the AYANEO Slide.

This also covers the Antec Core HS, which is a rebranded AYANEO Slide with
the exact same hardware and DMI strings.

Signed-off-by: Andrew Wyatt <fewtarius@steamfork.org>
Signed-off-by: John Edwards <uejji@uejji.net>
Tested-by: John Edwards <uejji@uejji.net>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index c5acf2628..9e6708cd1 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -244,6 +244,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_BOARD_NAME, "KUN"),
 		},
 		.driver_data = (void *)&lcd1600x2560_rightside_up,
+	}, {	/* AYA NEO SLIDE */
+		.matches = {
+		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AYANEO"),
+		  DMI_MATCH(DMI_PRODUCT_NAME, "SLIDE"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {    /* AYN Loki Max */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ayn"),
-- 
2.43.0


