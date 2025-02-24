Return-Path: <linux-kernel+bounces-529227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C410A421F3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3460C189BE8B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D681250C1A;
	Mon, 24 Feb 2025 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpguweDd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A189136327;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405064; cv=none; b=OPMrL5Lnq90rGauuqRjtyHoPpIVu062sqDUuQtjcEzA+WffGvlg9c6M5B8S6beE8ggfX9n6R8IcOg9ldD8oZfyrb0c2Hfij8/+DsZ4S+PRcFyXp+tzTleInuE6r95LW6/Mlx6lrTpA6YTzsvta/ZWbqpa+Qwa2cyB3e64uGJdy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405064; c=relaxed/simple;
	bh=wRgNXeJ1Ayqgv2ycTvaPbaECbrRkwjK4JSom4J2mOQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gR7F7fVgv6oh9MAvQ6kMWjl3HTeAOiLM3WcILolePoBBEbOgV4vigRT1DBjCpZGwD8/wSsOP7ERumBzyFnTbElDg2T47n+pIUbyX6Ub1gBFLRwYgYHWlVstCRHiSNG72IEOupZDDYl6OlueUMGz8iBJYrKwqakwt2X1amnv1RL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpguweDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D657C4CEEA;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405064;
	bh=wRgNXeJ1Ayqgv2ycTvaPbaECbrRkwjK4JSom4J2mOQk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NpguweDd/TvRZcKLVI0z04YHV1XH+lfa8VN8A9HJuZKZc0HmLrc7ngHHCDjURRr/r
	 IjvSl3WYd1LLYqSS5k1LafWR3nu0fWahIB65cKEXzs6Q5jiHnbzhaqZ+0MA9pdp1HG
	 ce/EScfmF67lYz5awhh8wvoH/lW0eGkYmcUnqMhCFI5jOOKGh0riSVXF5YKBFQ4I+N
	 F3b+/7ZYqvjBSJv0maORKx0o69hYIdz3bxorngKLmuH8R5WMmdLs3Ze12J3XFQ8+t2
	 paRlXSUrbgEnDuCev48o1JT1vuB7gGYLjnqpTSCup7aKmt9b2PY7QDJ4QBfqHJYzwP
	 U5+/jelv2fSoQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33353C021A6;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Mon, 24 Feb 2025 14:50:53 +0100
Subject: [PATCH 03/14] dt-bindings: arm: fsl: Add GOcontroll Moduline
 Display
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250224-initial_display-v1-3-5ccbbf613543@gocontroll.com>
References: <20250224-initial_display-v1-0-5ccbbf613543@gocontroll.com>
In-Reply-To: <20250224-initial_display-v1-0-5ccbbf613543@gocontroll.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740405062; l=1177;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=scPD+OgNUAYsQVTxMgUj2Bfa1YhpGLs4x0xykI3n24k=;
 b=mYX3R22poxBhjhAZBjz4BDirZm2V7dy8Vnyk1tTLA7TnHBsc6hztIBhrUrX8dCAQ/CvcOVSaP
 rezkBfC/jvxAX36FpuRCqK/iIbM7tWJfZtXqCn1nfTENLh7RD4vW5Dz
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

Document the compatible strings for the Moduline Display controller.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index db781d31569811ca241b5bd9a32a0896f7d9c3b9..40b2734f0caf3c431f05d33637a6bed8312c9d10 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1099,6 +1099,7 @@ properties:
               - gateworks,imx8mp-gw74xx   # i.MX8MP Gateworks Board
               - gateworks,imx8mp-gw75xx-2x # i.MX8MP Gateworks Board
               - gateworks,imx8mp-gw82xx-2x # i.MX8MP Gateworks Board
+              - gocontroll,moduline-display # GOcontroll Moduline Display controller
               - skov,imx8mp-skov-revb-hdmi # SKOV i.MX8MP climate control without panel
               - skov,imx8mp-skov-revb-lt6 # SKOV i.MX8MP climate control with 7” panel
               - skov,imx8mp-skov-revb-mi1010ait-1cp1 # SKOV i.MX8MP climate control with 10.1" panel

-- 
2.48.1



