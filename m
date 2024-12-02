Return-Path: <linux-kernel+bounces-427728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FD79E0533
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA81284F03
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E67120C464;
	Mon,  2 Dec 2024 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="qFllo910"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A6320C017
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149943; cv=none; b=H9/C8sW1tauMvNjStvwMt0regjlUX18QONehKuoUStUehu3zg/vOZ/bK6BmXH26PwxlLbElGnokDMtPhMZQmqLfTOvVjeszvqq/2p4b09VVTj5vkCz7gQub8JdWHgHYXIuPwHP4YSErd1uEsugUaBJmJyzpkzwWVOiBrSpgh9CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149943; c=relaxed/simple;
	bh=2PwZe615qE2EwcJm/HQBJ/KJWDj8hvYZrNBL6lFE46A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kll328Nc8q4F0hs2Bb519lQoWX9+pmxCh67+aSMVHTaPkJa6aPS4jKwXVxbpJ/xJGB0K+Vb5WT9Wf38FFRxtblPoUb1rlPqihAgqg9dax5SiVls3LgZXAHeWebwdBtmenKt6Bci5MNgiO33Z/uS6DMzkczjLO2ZxeJ9RIrzRMWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=qFllo910; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4349cc45219so39067545e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1733149939; x=1733754739; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p56iPdWdF4pt0TGa+sJ5O54kl+ln7VnNVSZs+/e+76c=;
        b=qFllo910ZhAY/1s2VjgAwyeGF0XoXv0k6I0Am5icZMORl8AUi7HzVm120p805K8shq
         e6fQC/s3vR/2spiYhxOOsiMBf/qaeV7by3ViGrIxhfHQcnL+iNh7VdKJYzlyerySY5D9
         41nyk/4MQ0RM1dTuWt2um6nhetnVGS74mwFlr6fhVKjYLJFgqAMqAa7MGOJWPAJe3Qnn
         CwV+gjXjcxf7odbtWUH8GTiCAshcZmbkf8YvGOnDQTtOt/9oHO/VT3gNprlRwgJ8eNnt
         Eruc5CXvXvMdk3HZ1eIVkdAjfQl1iSReuiH/1MOOSprVvRnRUAcUYL7L7yW6d3BabcYD
         bRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733149939; x=1733754739;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p56iPdWdF4pt0TGa+sJ5O54kl+ln7VnNVSZs+/e+76c=;
        b=S2jmfLTQSw8h29qnPaHXD1E+GhFtVTmfGyfjcIX+651eUajq4Eaor7Nw+emXSFey3j
         sVDpLYE+fE23Pq1fv2uB30Kppg5xVAkIDUO7OdfSLAPucNaNyCxtCSuSKV60Pvr7ApVe
         9lLitimWH921F72783VPz1WNtL8RUWGbLpPxx1MOHpkzCtQl/+jWRK/zkgRfnYSdOAPb
         MVU9UVMW35hqY7jKqxfjMr39G3pFNgT04NIVZZqZlf8f+x7bha5jJopTByQRK9ckQqUD
         eKOYG0z5dBnHWR1fKqd4GsY+Fvh5OuUaP1f9ESGgZhAioUq7PbhgnrMQkE3gCySxZKRq
         yjfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLjB4EW6Z+jO07luCHQogwyn2LtlrPW0H9MsY1S0CpoCL8nsENM8lmIuNNsV24ulYjUwzcpfme2wwDRkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ByPakljPqmaM/8Kzg1mOsBMq2hYuceVpC5jP9P/gBrHYaSBi
	UzNROgaMqkxnn5H/SLDTNsNWhaTdS2sfCTzqiPa1JMlLCRWPAbDteo4sFRFQH+0=
X-Gm-Gg: ASbGncspBhioXViFsVfkf5e8ArTso/1yFe902De9dcVju36Ghh6gOW2I0vaEQtFu2kp
	LQREb2rvZgWXkGDnxjmy8Q8axUdyjZLpUpwPPggd6bBzJAy8n6Pn4m9MrrbXVj/NrBL4B7zHS5w
	/HXC5P6ublVUmD7tE63f9ZircJ2nwuEFazLrhDjZguTWr4W586jttzEl5WBsB0p3JbygF0WgX0v
	k4dXsHMZCysECEoJCCEgzAJEleBx5tEE5RycL71Ng==
X-Google-Smtp-Source: AGHT+IE4Z97WqPTY6whDYYFojroLMECZvQLJmvdqsAduNjh17iqwixHR8OU1x0n8ZEx4yAwnePdiwQ==
X-Received: by 2002:a05:600c:4e8b:b0:431:93d8:e1a1 with SMTP id 5b1f17b1804b1-434a9df1f34mr200128515e9.27.1733149939226;
        Mon, 02 Dec 2024 06:32:19 -0800 (PST)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434aa74f1e6sm188429555e9.9.2024.12.02.06.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:32:18 -0800 (PST)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 02 Dec 2024 14:31:57 +0000
Subject: [PATCH 4/7] arm64: dts: broadcom: Fix device tree warnings for
 BCM2712 display pipeline
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-dt-bcm2712-fixes-v1-4-fac67cc2f98a@raspberrypi.com>
References: <20241202-dt-bcm2712-fixes-v1-0-fac67cc2f98a@raspberrypi.com>
In-Reply-To: <20241202-dt-bcm2712-fixes-v1-0-fac67cc2f98a@raspberrypi.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Eric Anholt <eric@anholt.net>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Doug Berger <opendmb@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, 
 linux-gpio@vger.kernel.org, Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

Fixes up errors on HDMI and interrupt controllers that weren't
noticed before merging.

Fixes: de9bc2dba3db ("arm64: dts: broadcom: Add display pipeline support to BCM2712")
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
index 39305e0869ec..f42fad2d8b37 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -336,7 +336,7 @@ ddc1: i2c@7d508280 {
 			#size-cells = <0>;
 		};
 
-		bsc_irq: intc@7d508380 {
+		bsc_irq: interrupt-controller@7d508380 {
 			compatible = "brcm,bcm7271-l2-intc";
 			reg = <0x7d508380 0x10>;
 			interrupts = <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>;
@@ -344,7 +344,7 @@ bsc_irq: intc@7d508380 {
 			#interrupt-cells = <1>;
 		};
 
-		main_irq: intc@7d508400 {
+		main_irq: interrupt-controller@7d508400 {
 			compatible = "brcm,bcm7271-l2-intc";
 			reg = <0x7d508400 0x10>;
 			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>;
@@ -352,7 +352,7 @@ main_irq: intc@7d508400 {
 			#interrupt-cells = <1>;
 		};
 
-		hdmi0: hdmi@7ef00700 {
+		hdmi0: hdmi@7c701400 {
 			compatible = "brcm,bcm2712-hdmi0";
 			reg = <0x7c701400 0x300>,
 			      <0x7c701000 0x200>,
@@ -381,7 +381,7 @@ hdmi0: hdmi@7ef00700 {
 			ddc = <&ddc0>;
 		};
 
-		hdmi1: hdmi@7ef05700 {
+		hdmi1: hdmi@7c706400 {
 			compatible = "brcm,bcm2712-hdmi1";
 			reg = <0x7c706400 0x300>,
 			      <0x7c706000 0x200>,

-- 
2.34.1


