Return-Path: <linux-kernel+bounces-186757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276188CC8AB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 00:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA5621F225C6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 22:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3BE1411D8;
	Wed, 22 May 2024 22:01:17 +0000 (UTC)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB51C23CB;
	Wed, 22 May 2024 22:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716415276; cv=none; b=h5vihonJbYfevDfYemZOV0zIr1odOpW5ccv2hE41bJne9d5HjIE4ftxDIkWYTCW8hImTgYtmJuKrTVsSTTbhP0+8jI4ulbQ95MNhg7aoxTsa0J0PuhDzK6dFBtSDI7Fjkc3BR8hmPoF08kVZef1Br4Rt7gQbJl9LiEgDac3VKRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716415276; c=relaxed/simple;
	bh=ZGJrvuyD1hpkeylaVYvTVMsT2k63HLWpXPMkzbnhvwA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=KMBjWeP8iOBI0nspzD2U2w/GvOI0HzVSr9I5xCCQs1wpYkWCmHr9E6dH3Yi8U6nYz7HQ/7Vnk5MMAsDSaw8gO3d9IBQhYfWMxfVtp+IZx89J5f/7fRP2hXeY2l2Nry/+LCsRPdionXQmuAhV6AY1GUF5ggtXuzY66liS1byU0uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1s9tfO-00AwiR-8Q;
	Wed, 22 May 2024 21:38:34 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Tim Harvey <tharvey@gateworks.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: freescale: imx8mp-venice-gw73xx-2x: fix BT shutdown GPIO
Date: Wed, 22 May 2024 14:38:28 -0700
Message-Id: <20240522213828.3745882-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the invalid BT shutdown GPIO (gpio1_io3 not gpio4_io16)

Fixes: 716ced308234 ("arm64: dts: freescale: Add imx8mp-venice-gw73xx-2x")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi
index dec57fad6828..e2b5e7ac3e46 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi
@@ -219,7 +219,7 @@ &uart3 {
 
 	bluetooth {
 		compatible = "brcm,bcm4330-bt";
-		shutdown-gpios = <&gpio4 16 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios = <&gpio1 3 GPIO_ACTIVE_HIGH>;
 	};
 };
 
-- 
2.25.1


