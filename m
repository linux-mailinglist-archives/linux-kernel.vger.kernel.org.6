Return-Path: <linux-kernel+bounces-529226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65ABA42212
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D975A1779C9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5869B2505C9;
	Mon, 24 Feb 2025 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9Yx9dn3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1F11A23AA;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405064; cv=none; b=uX/HA1M0SZYJDAa3kZv4Xy+vd5lM6yeQKiw4Chci8hDe2EuJkGecuiwUqhI3TrhPAeroLyGhZp7XeYob4Rw/4r5PbDfOr1IbcWbi0bp6JXVnhM3rTL2CxrfP7MECDQoZGVjySIq9CuUVq0HihrN55996ZAYzJdPcHrAFYKLSxgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405064; c=relaxed/simple;
	bh=VEEv6nk8vDex2BIMDGcyoeXhYWRBAy36ZB74OSyadLQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fSNf3L1Dp7lT8WywmERO0wGovItoooujZLDR758/TAFAvHcLC1DAheSc5HjfxY3qpRFZHZB3ngijskBgOFWxTd1y2flsm1eMy9jEf4OH9b4h6jxKat0isG9o5m0ttqwWqFs4pv7FbV/uUU5gEZmzA4bfe+S1U/cP+TwAQtb3NjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9Yx9dn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F3D8C4CED6;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405064;
	bh=VEEv6nk8vDex2BIMDGcyoeXhYWRBAy36ZB74OSyadLQ=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=q9Yx9dn33NrvPGC7k8HNZ+NZo16C87m+oyDcFCf2eKUUbUrZqGwJzOfEdR2cvjIgP
	 nNMwy72OFTvgFghGIoJWuVylQjcthKHFPLzunbqRcDwGT4E2MOLTO+5x/ydiPGVF9E
	 d57jhB99L5IWWLqedGGTI3Pz3qkrgMrNGJGM2Jg5+CUQq+0+xSG1Y2aJzfYF2HAnkN
	 FMDNUJA+oJeZSarnx8F2JYb3t+IZjuBy8q/t+fyevv5ZnClpaWEkZL1NuoDRz9rpkR
	 GHqIrCtwuBcc6GbDAgjhMSic3vrPxEq40l5W91O2S4uWDxu42xYbOoc2qY0FPLcnl0
	 e+Sdyz91dN5Gw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2531C021A4;
	Mon, 24 Feb 2025 13:51:03 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Subject: [PATCH 00/14] arm64: dts: freescale: Add support for the
 GOcontroll Moduline Display
Date: Mon, 24 Feb 2025 14:50:50 +0100
Message-Id: <20250224-initial_display-v1-0-5ccbbf613543@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADp5vGcC/x3M0QpAMBSH8VdZ59pqTkheRdKyg39p1iaRvLvl8
 nfxfQ8liZBEnXooyomE3WeUhaJptX4RDZdNbLg2zJWGxwG7jQ4pbPbWs22Zy1ZMIzXlKkSZcf3
 HfnjfD16CHDdhAAAA
X-Change-ID: 20250224-initial_display-fa82218e06e5
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Liu Ying <victor.liu@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740405062; l=2195;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=VEEv6nk8vDex2BIMDGcyoeXhYWRBAy36ZB74OSyadLQ=;
 b=fKWlALGDjjqxq4Z193T7Ci/ahYXLxryiGGIkZwxtx0yJxz7Sffnh3789/tCcMZcJS7qRSZ0SC
 OXfDAtd+vzFBxMyTIjw8WpoWUMc911QpWUXsBSVw5lsld0AipyD649U
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

Add inital support for 2 variants of the Moduline Display controller.
This system is powered by the Ka-Ro Electronics tx8p-ml81 COM, which
features an imx8mp SoC.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
Maud Spierings (14):
      dt-bindings: display: simple: add BOE AV101HDT-A10 panel
      dt-bindings: display: simple: Add BOE AV123Z7M-N17 panel
      dt-bindings: arm: fsl: Add GOcontroll Moduline Display
      dt-bindings: vendor-prefixes: add GOcontroll
      dt-bindings: trivial-devices: add GOcontroll Moduline IO modules
      arm64: dts: imx8mp: Add pinctrl config definitions
      drm/panel: simple: add BOE AV101HDT-A10 panel
      drm/panel: simple: Add BOE AV123Z7M-N17 panel
      MAINTAINERS: add maintainer for the Ka-Ro tx8p-ml81 COM module
      MAINTAINERS: add maintainer for the GOcontroll Moduline controllers
      arm64: dts: freescale: add Ka-Ro Electronics tx8p-ml81 COM
      arm64: dts: freescale: Add the GOcontroll Moduline Display baseboard
      arm64: dts: freescale: Add the BOE av101hdt-a10 variant of the Moduline Display
      arm64: dts: freescale: Add the BOE av123z7m-n17 variant of the Moduline Display

 Documentation/devicetree/bindings/arm/fsl.yaml     |   1 +
 .../panel/panel-simple-lvds-dual-ports.yaml        |   2 +
 .../bindings/display/panel/panel-simple.yaml       |   2 +
 .../devicetree/bindings/trivial-devices.yaml       |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |  12 +
 arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h     |  27 +
 ...tx8p-ml81-moduline-display-106-av101hdt-a10.dts |  60 +++
 ...tx8p-ml81-moduline-display-106-av123z7m-n17.dts | 133 +++++
 .../imx8mp-tx8p-ml81-moduline-display-106.dtsi     | 530 ++++++++++++++++++++
 .../arm64/boot/dts/freescale/imx8mp-tx8p-ml81.dtsi | 547 +++++++++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c               |  64 +++
 12 files changed, 1382 insertions(+)
---
base-commit: d4b0fd87ff0d4338b259dc79b2b3c6f7e70e8afa
change-id: 20250224-initial_display-fa82218e06e5

Best regards,
-- 
Maud Spierings <maudspierings@gocontroll.com>



