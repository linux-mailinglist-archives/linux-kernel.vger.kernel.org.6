Return-Path: <linux-kernel+bounces-520089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78175A3A587
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5061634CC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3761EB5F4;
	Tue, 18 Feb 2025 18:27:30 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEEF1EB5DB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903250; cv=none; b=Gz2b9veIv03ShTLMfy1A6Z3fwmWBYWghw1mo78juaZ3EDEYMc+yiuanNG6kkkUBNe/4QzLYq2y49vlZxBAfNnR8utWUlRk4YnLgBqOJ3hdE38ERTkfe+1dR0FJsRJJblfO/v/2zGDKVDTjsl0APn0X+UvOXLlhMO2YgksMCWNZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903250; c=relaxed/simple;
	bh=zNE/DNv8Rppeo9YS/X0VZcm7JvRezuQoHrQ8Y+6T7r0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pfR85G4x/NYN38qNBvqL6pCcdLjQcfyXh7jUm4taxiK/Omtx1BRgG/GLbIDxHgVWwKDKbk6/gUQplS536c+vT5DxvIN1X/njFaJ8VAnEO9W9khO58QXNbu4qhN/ikeMdsbO4liMoTUD0oT1iljLe2q2RkKP/19d9esULVn5Z6PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tkSIy-0006Bf-13; Tue, 18 Feb 2025 19:26:48 +0100
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tkSIx-001dVA-1V;
	Tue, 18 Feb 2025 19:26:47 +0100
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1tkSIx-00A9Hm-1B;
	Tue, 18 Feb 2025 19:26:47 +0100
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Tue, 18 Feb 2025 19:26:41 +0100
Subject: [PATCH v4 1/6] dt-bindings: clock: imx8m: document
 nominal/overdrive properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-imx8m-clk-v4-1-b7697dc2dcd0@pengutronix.de>
References: <20250218-imx8m-clk-v4-0-b7697dc2dcd0@pengutronix.de>
In-Reply-To: <20250218-imx8m-clk-v4-0-b7697dc2dcd0@pengutronix.de>
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Frank Li <Frank.li@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Abel Vesa <abel.vesa@linaro.org>, 
 Marek Vasut <marex@denx.de>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The imx8m-clock.yaml binding covers the clock controller inside all
of the i.MX8M Q/M/N/P SoCs. All of them have in common that they
support two operating modes: nominal and overdrive mode.

While the overdrive mode allows for higher frequencies for many IPs,
the nominal mode needs a lower SoC voltage, thereby reducing
heat generation and power usage.

As increasing clock rates beyond the maximum permitted by the supplied
SoC voltage can lead to difficult to debug issues, device tree consumers
would benefit from knowing what mode is active to enforce the clock rate
limits that come with it.

To facilitate this, extend the clock controller bindings with an
optional fsl,operating-mode property. This intentionally allows the
absence of the property, because there is no default suitable for all
boards:

For i.MX8M Mini and Nano, the kernel SoC DTSIs has assigned-clock-rates
that are all achievable in nominal mode. For i.MX8MP, there are some
rates only validated for overdrive mode.

But even for the i.MX8M Mini/Nano boards, we don't know what rates they
may configure at runtime, so it has not been possible so far to infer from
just the device tree what the mode is.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 Documentation/devicetree/bindings/clock/imx8m-clock.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
index c643d4a814786a1fc7e559140fe58911990f71bb..4fec558327027faa0a8d2a15699c03713da2deae 100644
--- a/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx8m-clock.yaml
@@ -43,6 +43,13 @@ properties:
       ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx8m-clock.h
       for the full list of i.MX8M clock IDs.
 
+  fsl,operating-mode:
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [nominal, overdrive]
+    description:
+      The operating mode of the SoC. This affects the maximum clock rates that
+      can safely be configured by the clock controller.
+
 required:
   - compatible
   - reg
@@ -109,6 +116,7 @@ examples:
                  <&clk_ext3>, <&clk_ext4>;
         clock-names = "osc_32k", "osc_24m", "clk_ext1", "clk_ext2",
                       "clk_ext3", "clk_ext4";
+        fsl,operating-mode = "nominal";
     };
 
   - |

-- 
2.39.5


