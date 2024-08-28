Return-Path: <linux-kernel+bounces-305468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400D1962F35
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98DCAB22F23
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357181AB519;
	Wed, 28 Aug 2024 18:01:30 +0000 (UTC)
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6A81AAE02;
	Wed, 28 Aug 2024 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868089; cv=none; b=ISNqqrc6u5D/OebryEix4sZNB5uBm7oOq63dFhzje01kITAiIU9Em6oboQBBFtsDMtQtglGNUmEzG76esNbMyyeQDiPM7Y7axNQtFZQqEGt90mEJ7M2/Gvjp37KGA1P1L/mtzb73rxK7ZyL4uH88jcj3YwSrijzX0qD/dzXXPek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868089; c=relaxed/simple;
	bh=EjfuYfaMC3g1Z5btZkNuPB0VpW1sNf0w6vjQ7NT/t04=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=N0UGXYkGa08Ayh0F+zziW0mmNK/lTujQzFD7c4Yz2R+ma7Tz8T6+CoYWNLEFJfNC5oXHvr20xhSWlfjwGKllmb90cjWZdmepgah1tEgVTKRPjLFhWSs9pVWLkDv7onY3XoGHUvDJIsIZGHBb77RZRoOHrlu0XHTUHQLyHTtvGNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1sjMbG-005gbd-0p;
	Wed, 28 Aug 2024 17:36:54 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 1/2 v2] dt-bindings: arm: fsl: rename gw7905 to gw75xx
Date: Wed, 28 Aug 2024 10:36:50 -0700
Message-Id: <20240828173651.4053753-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The GW7905 was renamed to GW7500 before production release.

While we typically do not change compatibles, the GW7905 was never
released before its product name was changed to a GW7500.

The use the the 'xx' wildcard is to denote the fact that this
device-tree can support range of board models from GW7500 to GW7599 as
has been done historically with the Gateworks baseboards to support
various build customizatoins based on the same PCB.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v2:
 - collected tags
 - added to commit log reason for non-standard rename
 - added to commit log reason for a-typical wildcard (xx) in model name
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 80747d79418a..f174cbfe2af7 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -939,8 +939,8 @@ properties:
               - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK Board
               - fsl,imx8mm-evk            # i.MX8MM EVK Board
               - fsl,imx8mm-evkb           # i.MX8MM EVKB Board
+              - gateworks,imx8mm-gw75xx-0x # i.MX8MM Gateworks Board
               - gateworks,imx8mm-gw7904
-              - gateworks,imx8mm-gw7905-0x # i.MX8MM Gateworks Board
               - gw,imx8mm-gw71xx-0x       # i.MX8MM Gateworks Development Kit
               - gw,imx8mm-gw72xx-0x       # i.MX8MM Gateworks Development Kit
               - gw,imx8mm-gw73xx-0x       # i.MX8MM Gateworks Development Kit
@@ -1082,7 +1082,7 @@ properties:
               - gateworks,imx8mp-gw72xx-2x # i.MX8MP Gateworks Board
               - gateworks,imx8mp-gw73xx-2x # i.MX8MP Gateworks Board
               - gateworks,imx8mp-gw74xx   # i.MX8MP Gateworks Board
-              - gateworks,imx8mp-gw7905-2x # i.MX8MP Gateworks Board
+              - gateworks,imx8mp-gw75xx-2x # i.MX8MP Gateworks Board
               - skov,imx8mp-skov-revb-hdmi # SKOV i.MX8MP climate control without panel
               - skov,imx8mp-skov-revb-lt6 # SKOV i.MX8MP climate control with 7” panel
               - skov,imx8mp-skov-revb-mi1010ait-1cp1 # SKOV i.MX8MP climate control with 10.1" panel
-- 
2.25.1


