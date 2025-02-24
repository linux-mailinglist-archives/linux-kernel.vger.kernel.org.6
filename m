Return-Path: <linux-kernel+bounces-529225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAECA421F1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B16188EB5F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CE82505A4;
	Mon, 24 Feb 2025 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbHNcOUp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A255233735;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405064; cv=none; b=G44UrPD9cNrf997Z1sv1pOlWyvbBZeTc4qhUvwZs7eHIZZDzMPVR8wpCCyGTpfQvvYgNH2BjJpUoh7NTLUoh1JIhuQoohs0KNbG46QDv4v17o5B32sIvwa5EQGJnMLHbVF69eIXERQ+JF9mmiZHpwzOauUHzddnzNe77fqc3bYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405064; c=relaxed/simple;
	bh=0mZGCuRUu8bHqSrP5214OTRBF/zAooyQDahu/9GP8OI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZQQPEoX2WPeS9iCx3e+7+urKgKGbYRVtvrG9nhS9KNttoCsicZINMT7WfLORBtcz2mRcuRWJF5dMl7b6yP2wc0sFdseItX+Zdy0bD7zNEkGP3dTDky+ppHlMU4jQhd8rztVX+k2RzgE/hPU5LC2PcDGnQdW0KQNsLbQw2Rur5FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbHNcOUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2800AC4CEE8;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405064;
	bh=0mZGCuRUu8bHqSrP5214OTRBF/zAooyQDahu/9GP8OI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RbHNcOUpp0bNIuC0zRogKbb3rn7e0998K4wPPN7PYwTDJmbHl6xwpLzA6z5TtvF1n
	 PZEyRTaFmwm9tED4Hi03GxN0FCiZApo57Q+EApwspIRmNfk+vLnK5ucBjxj4t3AAMf
	 LOnbi1iNApjHQ1ecnj2kDCAZswQnTRfKqNATv9gW+FAwx/IqGecSqBzq+R7YyVyg7i
	 oTIMervG6gCgS5sbdnniFtar0p/Dmy5Ypl8F/wbXrEoMwqtdkzWQn7DmMMWMkU4Zcl
	 K6gwd4Tj3Y10n4wQb+IXBxIfby++Ih7u/Mbqb/9LMSXLKNnGCxBkCHbLvxYlU1UD53
	 ik2DFrcLenxKw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107DBC021B5;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Mon, 24 Feb 2025 14:50:51 +0100
Subject: [PATCH 01/14] dt-bindings: display: simple: add BOE AV101HDT-A10
 panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-initial_display-v1-1-5ccbbf613543@gocontroll.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740405062; l=1040;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=40zl28floi4M3jn7zLafA4I2SyrY1dnpQAFmoqwqXJY=;
 b=LLEVcADTtIeah3vQnwyqh6H6KYxyToPG8cRuzaIyjCyCSUvmauoZpOiqQDaZczem8xps+vaW1
 HGncx4sAL6dC7u+v73HIGHWpBAoE0EtsHLPn0l6slp4ol77GtQC/CPU
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

add a compatible string for the BOE AV101HDT-A10 10.1" LVDS panel

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index e3ee3a332bb7e1736a8d44773b0aef4873153be1..b0de4fd6f3d4129d10e07b46533bb551784d8d53 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -63,6 +63,8 @@ properties:
       - auo,t215hvn01
         # Shanghai AVIC Optoelectronics 7" 1024x600 color TFT-LCD panel
       - avic,tm070ddh03
+        # BOE AV101HDT-a10 10.1" 1280x720 LVDS panel
+      - boe,av101hdt-a10
         # BOE BP082WX1-100 8.2" WXGA (1280x800) LVDS panel
       - boe,bp082wx1-100
         # BOE BP101WX1-100 10.1" WXGA (1280x800) LVDS panel

-- 
2.48.1



