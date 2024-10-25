Return-Path: <linux-kernel+bounces-382218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D54A09B0B15
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1272A1C25B2C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5101820F3F6;
	Fri, 25 Oct 2024 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="ezsNy5JI"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7CF20F3E5
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876566; cv=none; b=LlLpLO/yHDaXYtf3Ndw3L2NemzOEhgbeIdIO4g4x5l2AfE0DyCTd2I/Hlg0BGmo9X0MShqHkTRHNt2K1iDOxqzWZF6wuHg+vITBFtOaFiY2EALzs1BgxOMuG/wTBI+SCO80PTbVsNACVqsXVAedH/2K5L7VdHxMVSULRrNfAr6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876566; c=relaxed/simple;
	bh=ivKc1N4Mmh0vuWkC2a0EqN95MvZ1q0W3nPRNkGt3VSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QmO+3AQnixeZMqn6j2yYPv4NVcPo35xq/LEMj7OZSDf5uorEpFtilMxlqfcnMjCigfYzKtPqBxDpd9wQaEgQRtxSFx7x0bCkAZQytrgfcUj/eFZoJN9lXY88K4+A8BLJkrVzej/qs6/mQxJ18ExxWyPZW4/8ejoO9d5MHD7B0ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=ezsNy5JI; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d518f9abcso1663955f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729876562; x=1730481362; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mE1J+qWE3+MY5OdGTFndB6Yv1OgEwWzvu24HL6ntl3Y=;
        b=ezsNy5JIiUAp5606R9ZC8NRkX4ZOAJp5V8k+NWoc0p3DeiEx5rrvxDJ+ibMaLbrzUw
         B1N4nW8zydTdgZrtDR5j4A//Lg1hPovVJGFHLErAh7OgTUL/qyQZZAMobj8uOu7l5CGs
         z6q+HeAKpdd2d3z6QutOdsmBrueGupoqx95Q9oaBZrmx/KVdRx6Dr7y3vcUVaPy8C/xW
         BYWBerUt2pJPsi1LB/LcS7ufnz8L5dx+m1qaQPeA3BQcRhsfn0FzPXCeeMQLfWTv2IPN
         xiMFsVLVDscunNVdXEqLXHxkqcX9ql5/buwRyRuPFBDcmoM6ix4iSsqSv20kKpND/KuC
         y9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876562; x=1730481362;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mE1J+qWE3+MY5OdGTFndB6Yv1OgEwWzvu24HL6ntl3Y=;
        b=Okt5MJaW3XtHXNP7qIOENrnHxOEkEcsgt+SXyAfhZgTvAwGvOeKYBRs1gSOQfl5ur5
         5nmQYTMqqS1s8O4SzwSIInoeAeeJ28pF3Z0YKsozRmy/KHcHNjNfpLjINfoHFmvGcI5d
         werhSJe4dF18C5M68NOF4d8Y+XqQq31uP+T94vGd6oCDB1B9QLLfI4wWhrZdPzl6pyQw
         asXkDfcOq5vGW61uAPYC9fVWn4mMi5JxltadpMExN495/CbDLMXBzDZ3vOg5x30l6Tg1
         h7Vci0QPlDeU5M/ihg8e7gkLxrzEQSUtDqrbIilXW8F8wxA56QVEVrms4yo6bnY7C7N6
         Lnjw==
X-Forwarded-Encrypted: i=1; AJvYcCVRFGLO9KCeLX6H4FHtK1esG05n23KxWi9qouYr7hhonevgLlsSVN4Tb6SlJy4W96j+PkFj406KJ3eaPn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+mfqk7RYmIa3d/kI++jwIEkxemcKblpsTvAoNxXyG/IK6BdCr
	yVbp8ILhKdsv3geta5A2oU1gmh6w32hdoOW3+gXPoW6g+mrW7imDHRzR23vaVwg=
X-Google-Smtp-Source: AGHT+IEHBMyfg8LeLTWXyBsyEhO7uNb2SflsZSQOS0RHT+/8zxN2LWxj0WgsnINVEDyefqmgv9Nkcw==
X-Received: by 2002:adf:a29b:0:b0:37d:3f5c:5a83 with SMTP id ffacd0b85a97d-38061128754mr107580f8f.19.1729876561858;
        Fri, 25 Oct 2024 10:16:01 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38058b91f50sm2013649f8f.94.2024.10.25.10.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 10:16:01 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Fri, 25 Oct 2024 18:15:32 +0100
Subject: [PATCH v2 01/36] drm/vc4: Use of_device_get_match_data to set
 generation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-drm-vc4-2712-support-v2-1-35efa83c8fc0@raspberrypi.com>
References: <20241025-drm-vc4-2712-support-v2-0-35efa83c8fc0@raspberrypi.com>
In-Reply-To: <20241025-drm-vc4-2712-support-v2-0-35efa83c8fc0@raspberrypi.com>
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

Use of_device_get_match_data to retrieve the generation value
as set in the struct of_device_id, rather than manually comparing
compatible strings.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_drv.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index d47e5967592f..3099292f22a5 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -300,10 +300,7 @@ static int vc4_drm_bind(struct device *dev)
 
 	dev->coherent_dma_mask = DMA_BIT_MASK(32);
 
-	if (of_device_is_compatible(dev->of_node, "brcm,bcm2711-vc5"))
-		gen = VC4_GEN_5;
-	else
-		gen = VC4_GEN_4;
+	gen = (enum vc4_gen)of_device_get_match_data(dev);
 
 	if (gen > VC4_GEN_4)
 		driver = &vc5_drm_driver;
@@ -462,9 +459,9 @@ static void vc4_platform_drm_shutdown(struct platform_device *pdev)
 }
 
 static const struct of_device_id vc4_of_match[] = {
-	{ .compatible = "brcm,bcm2711-vc5", },
-	{ .compatible = "brcm,bcm2835-vc4", },
-	{ .compatible = "brcm,cygnus-vc4", },
+	{ .compatible = "brcm,bcm2711-vc5", .data = (void *)VC4_GEN_5 },
+	{ .compatible = "brcm,bcm2835-vc4", .data = (void *)VC4_GEN_4 },
+	{ .compatible = "brcm,cygnus-vc4", .data = (void *)VC4_GEN_4 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, vc4_of_match);

-- 
2.34.1


