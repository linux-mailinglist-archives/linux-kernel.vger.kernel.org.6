Return-Path: <linux-kernel+bounces-378528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5F19AD1E6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0DC82882AC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B574209698;
	Wed, 23 Oct 2024 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="QC/s7snA"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18D8206941
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702258; cv=none; b=o9GKhHkI8lAaPcroQ9pifPUUJTGxXFSUDUmTW13R4h9tdlZaPVbHci99T7/RJoQWtdKZinTkz95ltgd9B3f6c7eL1wC+9vfrtniU++lZTZVoRcQ1efFYntTSnyc/YvFAW+9pj9N2DZbqw/MVruMijbwhtQy/WkDsuqILs/ikVA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702258; c=relaxed/simple;
	bh=zOfNiFHIr6LUp00eEgBOCOMOPtvRz9GVcA5IPokPhD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PwZJMGZ4H0jgsDGewo8liEGQvPlCUeeSde9H8728wSlPAQmwPLq7LV615ASurbEnm3y4emviEiZ79T/i+zecFn8/6kgAXT2fKHH5VSajqhkMCJw/rR5VENkR3vI9u8Sg9ulpH1TEtAmh27EFX97YVesQS7HJa2XiWmOEB4LXY/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=QC/s7snA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so69622955e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729702254; x=1730307054; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PFtxhxYujLumaUhYyF7W41V3jkXWk5OXPRGFqIjwWy0=;
        b=QC/s7snAilRTzc1d36QEbrNfL0Yi9x7VmfUzr78791SMzIN4IMJl/hmWRKClYgXMDl
         pRjZutPXSHkG8SlCp2I1H/F08M40EdMqn+hhU2jYUdJ3jTqtGQtKFaYeKEi6PG5ipwGm
         q1m1jkhB0Oi1cSUko5sb/PNiXCNJNhUD3/m+VMEVxjASl+Jbdq++th2+4Uoyyo722FWd
         gjVG1jkGtgex0qKDjCJM/UcZMACkouqkCS8kn3NgT3bKPnNMQ46xAThTsC9KuGpMJrOH
         2z7iC269DP+RDD/gIHr9EEEVJOTXpqMdvDT3sdn5S++yMvmmVzefUpiLLPyu7N41Bqny
         LGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729702254; x=1730307054;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFtxhxYujLumaUhYyF7W41V3jkXWk5OXPRGFqIjwWy0=;
        b=bGMV1+G+jrP6R8Hpaslew5am710vIoROByr+DVfPGktnTq4pDlxPk+IG17qTJeC5tG
         R6feTcs5rwV9cZNxRzqMvWP6BcGPGZYzGQE6Ed+zbgtFXMc53QHVrGmyMeiQJILf0TzR
         P7Dm/lDlU7i/JGnUSIVkWXDb4vk3yqBEC7WG21qjeaSpfCSkOB/N71xuAUSc/RZye6hU
         NOaNT9xAJcT+j/qfsgdoRgHNTtOkSSWPuFjUX4coiQ67E8rd6LnhtC9peo1Y768C2m7d
         M8ZoreYnC9EvC7v1KVoMXZTD4guZ+bSNii+AAhJuIcX4QDJKLsi7ENFJJbMmwqRrCnXm
         Qcgg==
X-Forwarded-Encrypted: i=1; AJvYcCUcEh4VJnBwKMyH7Zy+1J1pf0JWDJLDVLBrANu31eWyLWqHlbjuxnLw6T0xL0ZfjMaL269XAKm0D3gunRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMqOyOrdHLFRcfqLv/g35Xj6f/MTRkx3p9yY+maE6vUpVobUyu
	AHEUSNxWvCGj/8W4Rvlll7AvwJWs+YrKIBp1VLaegEyhEKB0NAThzfr00D6rDIw=
X-Google-Smtp-Source: AGHT+IH4dOnkzCDNmAk4RGF4mcO+87rO9BS2DXATZO3jiQ7gGdJCQSnc4CC+BnBw8QyI1TRa/qtaAA==
X-Received: by 2002:a05:600c:4a9a:b0:431:57e5:b245 with SMTP id 5b1f17b1804b1-4318423b9e1mr26772775e9.23.1729702254379;
        Wed, 23 Oct 2024 09:50:54 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43186c50445sm21642035e9.39.2024.10.23.09.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 09:50:53 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 23 Oct 2024 17:50:31 +0100
Subject: [PATCH 34/37] clk: bcm: rpi: Add disp clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-drm-vc4-2712-support-v1-34-1cc2d5594907@raspberrypi.com>
References: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com>
In-Reply-To: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com>
To: Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

From: Maxime Ripard <mripard@kernel.org>

BCM2712 has an extra clock exposed by the firmware called DISP, and used
by (at least) the HVS. Let's add it to the list of clocks to register in
Linux.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/clk/bcm/clk-raspberrypi.c          | 5 +++++
 include/soc/bcm2835/raspberrypi-firmware.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index 89e2c0241ff6..aff9f3195573 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -34,6 +34,7 @@ static char *rpi_firmware_clk_names[] = {
 	[RPI_FIRMWARE_M2MC_CLK_ID]	= "m2mc",
 	[RPI_FIRMWARE_PIXEL_BVB_CLK_ID]	= "pixel-bvb",
 	[RPI_FIRMWARE_VEC_CLK_ID]	= "vec",
+	[RPI_FIRMWARE_DISP_CLK_ID]	= "disp",
 };
 
 #define RPI_FIRMWARE_STATE_ENABLE_BIT	BIT(0)
@@ -139,6 +140,10 @@ raspberrypi_clk_variants[RPI_FIRMWARE_NUM_CLK_ID] = {
 		.export = true,
 		.minimize = true,
 	},
+	[RPI_FIRMWARE_DISP_CLK_ID] = {
+		.export = true,
+		.minimize = true,
+	},
 };
 
 /*
diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
index 73cac8d0287e..e1f87fbfe554 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -152,6 +152,7 @@ enum rpi_firmware_clk_id {
 	RPI_FIRMWARE_M2MC_CLK_ID,
 	RPI_FIRMWARE_PIXEL_BVB_CLK_ID,
 	RPI_FIRMWARE_VEC_CLK_ID,
+	RPI_FIRMWARE_DISP_CLK_ID,
 	RPI_FIRMWARE_NUM_CLK_ID,
 };
 

-- 
2.34.1


