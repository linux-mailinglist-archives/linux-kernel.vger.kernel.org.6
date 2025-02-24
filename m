Return-Path: <linux-kernel+bounces-529228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9990EA421F2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7915188EC3F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585832505B8;
	Mon, 24 Feb 2025 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivFrPTIo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1503F9D2;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405064; cv=none; b=LCP71wD9eBVtjjjf1zGKuBEGlFV4oLPjBo+wREkpV1L0ynZWRgqBseQ1MuQ9nZEjRvMOQUI00gpSW0imH7++RZltMaPJ9yY0/Ts3uvoz1VWDyETOc2kNqPCAOiiTEZNmfXQCfpLeGv/HnHJT3auBtwiCkU8Y8NYSUiaJOr9MssE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405064; c=relaxed/simple;
	bh=/vcUz/dJIjBAyqn82A3hvWQEy6CgqiDA7ZT2R+OIAHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OuOaAcTVNdgPAMvCoRCM3rXHny1WNBj+OJlDZn0b8WlW/lo3ib6fgslC3yk/2T+jYohZmvWSwRwnDUG7uvPRSyHlOGpHFl3qA8dxmPWGn38xwijDOykdX+iz2eo8L13i/UzCsy52NdVwE81AOAzd1dX5fi07pSNXLtuHmSwK/sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivFrPTIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32E64C4CEE9;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405064;
	bh=/vcUz/dJIjBAyqn82A3hvWQEy6CgqiDA7ZT2R+OIAHo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ivFrPTIogTUY3wJZiqJqBU4NciXguOa7biy2njhHYjVf21Lk5zAe1enynq48azlNl
	 lPlOoc+ixbTev7hxBIpcKyNRBFqeAbeVqg+g0nBx2veOowJoLWfkSLsZHox7+iyBZS
	 H9QoLK3RZmfb+U3FuiN9tfCBXzd73Flk25f2lV+tAf2gGnu7FqM4E1au/xEA5+g0M+
	 1yhJICvVLTzEOXeahu1kbTMaDiDA5eKwizhq3XWhMfcYdwmVfheNJ2p87URc9r6p+L
	 N9bVk1plt4Ot8uVY+jKh+fLGtXvzSdSAKl2T2nOyMwGNFqwpjvwaTLGkjLWkvT+xSA
	 m9S+PyZKccbNg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208ACC021BB;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Mon, 24 Feb 2025 14:50:52 +0100
Subject: [PATCH 02/14] dt-bindings: display: simple: Add BOE AV123Z7M-N17
 panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-initial_display-v1-2-5ccbbf613543@gocontroll.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740405062; l=1145;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=CUdxnBhmE0c15sBOxDGAJvFl6x2ngU8cBR/mW9XP/q0=;
 b=8ODcB0rUC2FCMlYWpOJd40nb/Ts7PTLBk3WgfwZYrREBCT9OYN3uqwTLDOGws29fxvE0EzHex
 RXcCodSY0drAfkStA7xPS7yPaM2UY1fNlqnwhS988Y/biTviyJFkBbb
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

Add support for the BOE AV123Z7M-N17 12.3" LVDS panel.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 .../devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml
index e80fc7006984e052b4f7c0007679ee0e228d9989..548f5ac14500a7f8c3e0e5df7db9e19f5af40eb8 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml
@@ -40,6 +40,8 @@ properties:
       - auo,g185han01
         # AU Optronics Corporation 19.0" (1280x1024) TFT LCD panel
       - auo,g190ean01
+        # BOE AV123Z7M-N17 12.3" (1920x720) LVDS TFT LCD panel
+      - boe,av123z7m-n17
         # Kaohsiung Opto-Electronics Inc. 10.1" WUXGA (1920 x 1200) LVDS TFT LCD panel
       - koe,tx26d202vm0bwa
         # Lincoln Technology Solutions, LCD185-101CT 10.1" TFT 1920x1200

-- 
2.48.1



