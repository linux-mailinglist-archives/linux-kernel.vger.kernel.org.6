Return-Path: <linux-kernel+bounces-443727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB729EFB33
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3CE18868E6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D10D22655D;
	Thu, 12 Dec 2024 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="KOHtoC1K"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D231223C40
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028610; cv=none; b=T8oelHyvx4fWGT8D96jXDfrK5OObjmexMLukzKQaZZJ7B1suQ7zet+i4TUN6Hs2QybAwrWhZiXtAFwVu+YXt2sz4zGDs9c5Y1ctGCgJFmqQoSano/8+YLAn0X6uZSse/uT8yJuznJ5WFeqxNo7+MLnRVwD2YmeRuw97IVr3pz3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028610; c=relaxed/simple;
	bh=FBDqCJYmfxkJaZt8Un7aPuYwrUM7R7Q4/pNQK9op6mo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nvflCzpftlqlBP9zROsVzVhjemzzwgxN/cuRqJxwgiyem00o2W8AnxS5vR44+5vhb5rJmk7aN+vhmhjBgbvbxMz2y+7hpBsAzeBot36jl0aoS+V3gOsQyKTuHxEWpb7x+WIPPMfiWuguM6wlva/QRLLfmtk5/KI0XK78cfD2TxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=KOHtoC1K; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436281c8a38so4174785e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1734028606; x=1734633406; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3qoOTheHNyDXx09eLZAAbq+8+9HV4ZRvdNqNlfNALco=;
        b=KOHtoC1KCJeeGZxjQqq2Xtz/CRudTdBmaTyl9ISAPZG/SjIzdEkzwuxf98qSeHy9Cr
         9cVEVlIWv4ftQljnUZd5PMxxTGge3Kawu7pKbGaMksyuMnP6nRTUOLEZBzJZWEvMqYUT
         HIbhVAfkXlciNuBfB9jBHus2a9z6+8tfiRIo73GrA2ZzkvSTrn5JJUH46OWmeM78TiyF
         a03arhGu7abYOxQUfxlgFJBlRF6gLkyeiDLQDTNgHAhUECCOwzW8JpdsXX033c4O2CPt
         EvS4HOTi8DyJu4Hjymaby7zmp34N60Y70QWOyz3XJY1U5v/+61n/p+ERixDpSb/rxDbG
         TYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734028606; x=1734633406;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qoOTheHNyDXx09eLZAAbq+8+9HV4ZRvdNqNlfNALco=;
        b=wlQoQffsbn9nMKDs8wN4Kb+ITjVD+nyYQSjm8ONy3l6elt5QrmSDuoo3f331HAMeHn
         vVtJSASKthmrARJ/fyUlWGilyFXfdRkX/8Y3KuOiKMuQIWqFUvY6y7rUVNfxJLrE7TXR
         SsrpS72prsVSmSwRHj2FlELxCzF3iQsyfFCh9WBhxh4w8PtwGqPpiWbrszJDLC8Rwpik
         jvTmKrHbwEUZCwjzNTvK5Vhrho2dM954oAQcIuCKvHRoNRLQwl3najqVeqGj2n1uE+Rp
         kGQGaZtyRVA0Gi/6gdoVMPP1QysGIfeCoe5QZVA9jLUggb3VO6we2dgJRvFniJ+5EWuq
         3jqw==
X-Forwarded-Encrypted: i=1; AJvYcCXbSE29C8aWS+f+MctRknzg6ZKtqHI8bYkt3eQfUV+cBQeTqRLAPiYY9cbgYlquMb/JW9mVub/Tfs/QDUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvOnl0V0e1K30G3AARgHASJAnhaJwrS1u+RSdQVIHMx0ub3wOk
	tTDCmGMKImbjmsIWj9v+zSM9S2xPD8CaJjqgpmGWUGnhDlWtTz02DeaSWn+zE/8=
X-Gm-Gg: ASbGnctJ6AH9jEgwCGZR13/kVxYGwfztpBTAbD6x9mwXtBEZpaHiDF8Ng60Mi+mAv2u
	+s2oF1aFRn7jzPmLJWpIF/2YNnkXlDb1bydVKbhPfe8e/7r3V9OG1ou8bJ59iZoeSG7w5PBzqDp
	msZhyq1QKUsjkt3Fz3E52tbZ+8qx+f913mEsM859Sw58XR5y8TE2y9vc98a5kXW97c1iuGDqezq
	lYevY/3AwBUlXKWUcv2/7Rcpb3vO07mfUZzjbYa0WUIlq7l
X-Google-Smtp-Source: AGHT+IGL4E9j9A1tMS6SuUyiiajyBjok8IwHS0bLS9tymQ53Yae5HQb0IhaVfgk6fsEuOcpfD85mUQ==
X-Received: by 2002:a05:600c:1d2a:b0:431:3bf9:3ebb with SMTP id 5b1f17b1804b1-4362285f769mr38353035e9.24.1734028606518;
        Thu, 12 Dec 2024 10:36:46 -0800 (PST)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-436257178e3sm24651995e9.41.2024.12.12.10.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 10:36:46 -0800 (PST)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 12 Dec 2024 18:36:32 +0000
Subject: [PATCH v3 5/7] arm64: dts: broadcom: Rename bcm2712 interrupt
 controllers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-dt-bcm2712-fixes-v3-5-44a7f3390331@raspberrypi.com>
References: <20241212-dt-bcm2712-fixes-v3-0-44a7f3390331@raspberrypi.com>
In-Reply-To: <20241212-dt-bcm2712-fixes-v3-0-44a7f3390331@raspberrypi.com>
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
 Bartosz Golaszewski <brgl@bgdev.pl>, Thomas Gleixner <tglx@linutronix.de>, 
 Stefan Wahren <wahrenst@gmx.net>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, 
 linux-gpio@vger.kernel.org, Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

CHECK_DTBS produces errors on bcm2712-rpi-5-b.dtb and bcm2712-d-rpi-5-b.dtb
of:
intc@7d508380: $nodename:0: 'intc@7d508380' does not match '^interrupt-controller(@[0-9a-f,]+)*$'
        from schema $id: http://devicetree.org/schemas/interrupt-controller/brcm,l2-intc.yaml#
intc@7d508400: $nodename:0: 'intc@7d508400' does not match '^interrupt-controller(@[0-9a-f,]+)*$'
        from schema $id: http://devicetree.org/schemas/interrupt-controller/brcm,l2-intc.yaml#

Rename the nodes from intc to interrupt-controller.

Fixes: f66b382affd8 ("arm64: dts: broadcom: Add display pipeline support to BCM2712")
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
index 39305e0869ec..bd78af0211b6 100644
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

-- 
2.34.1


