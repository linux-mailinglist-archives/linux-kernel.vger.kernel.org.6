Return-Path: <linux-kernel+bounces-558033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD327A5E0B2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E271883AC1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BD52561C2;
	Wed, 12 Mar 2025 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="S0ehEW0q"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A44E156C6F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794086; cv=none; b=AtnSG9MFoadbvaHfZY1g/z3Q6RR6Zfom/NPywwkQO0P+f57zjnBeKFV4IwOGtEn1SK5lRVI/EVnugMgT8Lfe3Vi9N8dJtQonmIQAItz8zR9wec5os0yH0sbxYkCm5+5yBt46L84nmz3y09XKEXxTuypK83+STLzAFDB1aCt2SHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794086; c=relaxed/simple;
	bh=ttjbYA7yaI7UDQBnkiqg0UmkK7tRlb+j8MXZbpjoXrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E/CN/4j0chOhAlfZAvaSVkjjUaHspxQF6vrxGRDU8rGfovdA+RzxfYiovbN/VXWh9AyV/g4mkG10nLulrGPy5DPcmJi7VizSUXgrTVpvrzNzdeeaKlkPkuCanzLrRvoJwrsZu5ZCIMqmX1xj/e7VUD/PBrFBIaHH1aUgR2gj+zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=S0ehEW0q; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf257158fso24890945e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 08:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1741794082; x=1742398882; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1oEmtbJbAjDfE5NhrrJZgMsbc4ZNOupTbBSety67qvQ=;
        b=S0ehEW0qy7Mk/84tgpvf7AWu04LqNNbbMrGymBUxn1lvZy08q9QNp0BzpZq0LaAAGf
         zQ4gH4XiQ3C6rv87YPs3aSurB/25TQejIRHGPBE98hbo8RZpzDxHpQMxG2ZzRjvaEBjn
         WL5JrGw+ezQjj8mS2HcsajyZTIlCc4qpYFeV4XmTI2gAzkqJuFfpkwBmjnmAj/e1glmT
         3FeOyKjXuJhWEOxPc1TCaMXgC/OTck0F+SGtNcvWTIdg7MsbeADt+Wb7PmoK2VARB4pF
         PNOa4kOMODoVBdMboX9nnaHgd01YsOtde8iVgT+FiUCqMotFeIenvSO3DgFBYCJU0t4d
         UWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741794082; x=1742398882;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1oEmtbJbAjDfE5NhrrJZgMsbc4ZNOupTbBSety67qvQ=;
        b=Hn3AX6RYVGRqncuJaCNfMA29/zWkrDIZdlFmFh2OW3XjQH0yV0HFLmBW1V85zah7gD
         uY10xXUiZEnKR2KdLyfaV1r/RdXhAnDfMwSFwAzp8Hh0sG4jGOxg3vW0iyLlwUtkvs/t
         MQ41clZAvqDoAT6zPJFTgxgziPbUgFGzwLgl5pjX4Go/RvcS722OxCMg4+Op+CMD2jQe
         ltpuPahttPp/WcX3kAQRZsvMD4PBUGLlryGyWzC9WI2ThnFdG0sHKdI8h5CapAeI8obC
         jeHZlC4bAY0HLBus0YuRh5vI/SvVzcvy3B7aXF62Z6FwfIw9L5ZjazhFT18MflOfytBx
         KU1g==
X-Forwarded-Encrypted: i=1; AJvYcCXWaao6PDWpRK9ZFklwNxCKbJ+670ZUP0ARusXZRR8/+KyPRxwmN9VENRfnrGHn0BUbjV+VIyVkS9Zd7vI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVqGyYPknWv/+ED8LYx5Ac7lhdIGA3ZhTBn8qzlkqRwadGI/Ar
	wBSNiL5UoiNoVptfvQS2lpKwaAuS0MBOn7BQsipXkDX7UEMlnKrl9n6kaqEWmo4hCMDpr0luzNC
	3dcA=
X-Gm-Gg: ASbGncuhKQiYYUgS/fo1tzkdgFNkMYKoa4mIXY5DTBwXXCCVQ5xUkhJ8dQFS3N1cB2Z
	QJZbj3eap9Bsprtdayfcvx2A8DphQOH9rJMFautEaEsoQK3ymgXQFGnZP/p+olWfMN06Ldzddr3
	YxJqcnWiMNYE6nf6mxpnf5bYG++TXcuLQ3VIxc2EQpYJ2m02a6Pb0LGOdQaRQx0DZsmRA1OzloI
	H6OqmePBK8OVinAW03b/VVn0XtEivt/1IUcrQ1kd1wxnl6Asjt8wUlxUA7T6+KYPppL7n74gLxF
	yYK8ucC6MH69FxAohR0RPbPuY2p3WQA3Gqaa4x3xQfIG
X-Google-Smtp-Source: AGHT+IEuj+E29WQ/OOpJvqQ3EDVSbJiu5HyHbTRxHeTQ9s89qRgpRlIWvsn6eHPGJl3Ru6tmiOdhpg==
X-Received: by 2002:a05:600c:3b94:b0:43c:f8fc:f69a with SMTP id 5b1f17b1804b1-43cf8fcf902mr113708705e9.4.1741794082171;
        Wed, 12 Mar 2025 08:41:22 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a78bdbfsm24374915e9.25.2025.03.12.08.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 08:41:21 -0700 (PDT)
From: David Turner <david.turner@raspberrypi.com>
Date: Wed, 12 Mar 2025 15:40:56 +0000
Subject: [PATCH v3 2/2] drm/vc4: hdmi: Add jack detection to HDMI audio
 driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-vc4_hotplug-v3-2-d75878677de8@raspberrypi.com>
References: <20250312-vc4_hotplug-v3-0-d75878677de8@raspberrypi.com>
In-Reply-To: <20250312-vc4_hotplug-v3-0-d75878677de8@raspberrypi.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 David Turner <david.turner@raspberrypi.com>, 
 Stefan Wahren <wahrenst@gmx.net>
X-Mailer: b4 0.14.2

Add ALSA jack detection to the vc4-hdmi audio driver so userspace knows
when to add/remove HDMI audio devices.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Signed-off-by: David Turner <david.turner@raspberrypi.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 18 ++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_hdmi.h |  7 +++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 37a7d45695f236d3ab281d9a8676921fd434955c..a29a6ef266f9a5952af53030a9a2d313e2ecdfce 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -51,6 +51,7 @@
 #include <linux/reset.h>
 #include <sound/dmaengine_pcm.h>
 #include <sound/hdmi-codec.h>
+#include <sound/jack.h>
 #include <sound/pcm_drm_eld.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -2175,6 +2176,22 @@ static const struct drm_connector_hdmi_audio_funcs vc4_hdmi_audio_funcs = {
 	.shutdown = vc4_hdmi_audio_shutdown,
 };
 
+static int vc4_hdmi_codec_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct vc4_hdmi *vc4_hdmi = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_component *component = snd_soc_rtd_to_codec(rtd, 0)->component;
+	int ret;
+
+	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT,
+				    &vc4_hdmi->hdmi_jack);
+	if (ret) {
+		dev_err(rtd->dev, "HDMI Jack creation failed: %d\n", ret);
+		return ret;
+	}
+
+	return snd_soc_component_set_jack(component, &vc4_hdmi->hdmi_jack, NULL);
+}
+
 static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 {
 	const struct vc4_hdmi_register *mai_data =
@@ -2288,6 +2305,7 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 	dai_link->cpus->dai_name = dev_name(dev);
 	dai_link->codecs->name = dev_name(&vc4_hdmi->connector.hdmi_audio.codec_pdev->dev);
 	dai_link->platforms->name = dev_name(dev);
+	dai_link->init = vc4_hdmi_codec_init;
 
 	card->dai_link = dai_link;
 	card->num_links = 1;
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index e3d989ca302b72533c374dfa3fd0d5bd7fe64a82..a31157c99bee6b33527c4b558fc72fff65d2a278 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -4,6 +4,7 @@
 #include <drm/drm_connector.h>
 #include <media/cec.h>
 #include <sound/dmaengine_pcm.h>
+#include <sound/hdmi-codec.h>
 #include <sound/soc.h>
 
 #include "vc4_drv.h"
@@ -211,6 +212,12 @@ struct vc4_hdmi {
 	 * KMS hooks. Protected by @mutex.
 	 */
 	enum hdmi_colorspace output_format;
+
+	/**
+	 * @hdmi_jack: Represents the connection state of the HDMI plug, for
+	 * ALSA jack detection.
+	 */
+	struct snd_soc_jack hdmi_jack;
 };
 
 #define connector_to_vc4_hdmi(_connector)				\

-- 
2.34.1


