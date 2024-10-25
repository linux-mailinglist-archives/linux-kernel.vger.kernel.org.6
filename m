Return-Path: <linux-kernel+bounces-382248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 816B29B0B7C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A172855B6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90C920EA31;
	Fri, 25 Oct 2024 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="kNdafAIY"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECEA22AD9E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876598; cv=none; b=QZPoE+tlEG3KiA4zrMOJC2uwRE3BYenjFRnfZbpwOsnzK2S/vZXzBKh4VqqYO8VfXEx5Vgg4BY6fVbbHmpiyuGvSV34tSeXhvdAC1wqHR1EWR6w1GI2+Z5ossuyQIU/WQLZHycF//6HkoutptO+6ZN1yMax5kHk6kjpZp0O9qgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876598; c=relaxed/simple;
	bh=XBzj1denapOs56Du29PEQKEZahYGIqXLFsG73uRG2VE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OiU1EgnwNNlWXAewQxHhSZLQYUS87IL4OkolwkOb9aiH4Q0TxkuZfgr0E4+8LDZwhbRVQWGXGZyJv6koQUD8U0xmUwnHlKKAydedEHQ0K0pCxLfRpNc4BtkBSRHHKALq8iUeGgbdpjEMPKMWDBsnX/CL3jOXdRZV403RbprePuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=kNdafAIY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so22546315e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729876591; x=1730481391; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLNEe24VVIwAaP5agwCiuxY7rB4nwlR4wJvUVCZVQ/E=;
        b=kNdafAIYshrHa6sbvPV0peVIFCgeHSpHEHygIXhw87zhQ/hIrUZmEU7zMi3WKFq+z4
         lUHKxwNB0k3dFJetKPrXlxp2zbshMp1zjPolYYPBN478inYGDi2iD/GhvqL9hXrD/HUW
         jJ7emcdeurB9AXrwN5l6b3fAB0D6K4RJTQmQ+W67IW9O/00SI6l+7FUnBeGW+BQRHxCK
         TmhWzKZv1S2ZwIKdyV0jsjOu0hwK0SutmoQxWWXYbjtaxb8ll0rP4YRYYHNa1g+BjMPs
         RlzxnMavvYF7VBm075frWU2S0nSRohtfEjRBI0jXsQgeKJ+8J/6UPPaHFcnZxGUXDvo6
         U6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876591; x=1730481391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLNEe24VVIwAaP5agwCiuxY7rB4nwlR4wJvUVCZVQ/E=;
        b=WbM6/3DS9gftirHUfqiQ0eefAadI9T3j+IFwiZf0biJv+Myy2wi+UPrqTNLGc+vJty
         +n9BWxJZ7FjY9X1tUNDWUdPeYxVohdfw/3QIhM8YAfPzWIem3F+iWVrnADUJzhbv3RAF
         jUMTBJUHrsWjrS2clEDAOTuyu6uPFrd6Bbyfe/Vemf9lmiEP0dWLApqWoTx/QOC2h4hX
         U7E5VHFZNx87mRUbuCODV+m7QP1HfzBTHAEltwSueKodnR/ScXgwKz/lIj5R0kom1JU9
         D5JbUaJGOz6VBP3Ij0CXSMCKSMVYdm8wBM5IG+0y6/n/bMZIrwOSGnCwzuehcAqVWyEk
         m24A==
X-Forwarded-Encrypted: i=1; AJvYcCXQ2KbUTrjp+6/AJextQZwAyHrrt1AYl1IS/jF4QvfE/xC1gMGpb+30memx1KtSNCD1KU033sePaQy0vqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc4muamr9oKpEQEMzFRtQPZftAP8fE9vhfZU+iVIy2KGx8MxTP
	ZqXocJv8Rgmr+jxExRlJd8gBqsF14IMYpGh18aygJwL4HqlC5B6YYkpRw2wMCXI=
X-Google-Smtp-Source: AGHT+IEf4KZxMhq0qk7/lCgwke2nZYw7jfKwbBRjQajizbRblmsymhNJTGNxxKLe3CTSVhp57vlUig==
X-Received: by 2002:adf:f411:0:b0:37d:4e59:549a with SMTP id ffacd0b85a97d-380611418abmr124517f8f.16.1729876591324;
        Fri, 25 Oct 2024 10:16:31 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38058b91f50sm2013649f8f.94.2024.10.25.10.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 10:16:30 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Fri, 25 Oct 2024 18:16:02 +0100
Subject: [PATCH v2 31/36] clk: bcm: rpi: Enable minimize for all firmware
 clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-drm-vc4-2712-support-v2-31-35efa83c8fc0@raspberrypi.com>
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
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dom Cobley <popcornmix@gmail.com>
X-Mailer: b4 0.14.1

From: Dom Cobley <popcornmix@gmail.com>

There isn't a reason not to minimise the clocks, and it saves
some power.

Signed-off-by: Dom Cobley <popcornmix@gmail.com>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/clk/bcm/clk-raspberrypi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index d374538e7108..9f716b2223ae 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -111,21 +111,27 @@ raspberrypi_clk_variants[RPI_FIRMWARE_NUM_CLK_ID] = {
 	},
 	[RPI_FIRMWARE_V3D_CLK_ID] = {
 		.export = true,
+		.minimize = true,
 	},
 	[RPI_FIRMWARE_PIXEL_CLK_ID] = {
 		.export = true,
+		.minimize = true,
 	},
 	[RPI_FIRMWARE_HEVC_CLK_ID] = {
 		.export = true,
+		.minimize = true,
 	},
 	[RPI_FIRMWARE_ISP_CLK_ID] = {
 		.export = true,
+		.minimize = true,
 	},
 	[RPI_FIRMWARE_PIXEL_BVB_CLK_ID] = {
 		.export = true,
+		.minimize = true,
 	},
 	[RPI_FIRMWARE_VEC_CLK_ID] = {
 		.export = true,
+		.minimize = true,
 	},
 };
 

-- 
2.34.1


