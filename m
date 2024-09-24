Return-Path: <linux-kernel+bounces-337079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CCC9844FF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED361C230EC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4741A4F3A;
	Tue, 24 Sep 2024 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="QLK+OCrg"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159D2154C0E;
	Tue, 24 Sep 2024 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727178061; cv=none; b=JoqubDc+8Z2n8B+NPik17Y+FyMdHdKxpbbLkeq/AZTzHD02rxpG8dpNWmRMFCtVPRvhWAYNsur8RG4GSMQk0dOqNQg1OhASErkdbmOCZp1o7zUcsBda1DI78bFOYBvaSbnNXBoQw/cljghLZa64oR68Pc28aWAp4jHj5nbKRoqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727178061; c=relaxed/simple;
	bh=pM19rn2HeJo3jteCfwus4X9bbS79/Zs6RBwgmzIjx4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=io4tiBPD6OM6X3a6qDOc8UIiGGc0Bcx5xQDk0K/FzWEu9SSfOZ/LieWVBb4NZTecA/Ytq2KIy3BnKPxONi3L4YdF23NDfWO1Q5OSbRxzBw3V07FBM004K503HSndYqEmHAb/8kt0dC2hjDqllpc1clIQ9Tu4/+kJE4Ad2TWoKDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=QLK+OCrg; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id F2CDE1FA77;
	Tue, 24 Sep 2024 13:40:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1727178058;
	bh=z2p++X4y/QMUmYwO6u5MfaLXhITN3ZVhMINRc4eZg+4=; h=From:To:Subject;
	b=QLK+OCrgz012ZgzfdDn1Igv07wj8JNZRy9DVe3sg9uSDmnjOwknHt6gPXUL7Bz3rT
	 PN+hdnp/zh5kXOQ0CwhQahkL/Wf9/E3q5vOinV+1v7xDlFdupnw22H5+f/WAsaODTP
	 70wrDpIAc0o4/jRCNVq0iobFhGXIvZG1QPIMSppTeZ6+SIzSpOINRVBOB3LnHvH+04
	 fsIKXzCzyitX9NmJ3UgMZdgABsoIuVD+oaSVOzkTk3g4fgMJH+Y5SPhGModEHMyXc1
	 XNiWJtFnkprTT/i+1AOGY+dGl+lPPlF/cjVhlSzqFhOwLcP5lqC5Cfh0rRgVe9W0Vt
	 3Z4oyn2Hw+3vA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 1/3] dt-bindings: arm: freescale: Add verdin imx8mp ivy board
Date: Tue, 24 Sep 2024 13:40:51 +0200
Message-Id: <20240924114053.127737-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240924114053.127737-1-francesco@dolcini.it>
References: <20240924114053.127737-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

Add Toradex Verdin Ivy carrier board support.

https://www.toradex.com/products/carrier-board/ivy-carrier-board

Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index b39a7e031177..7413759ed240 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1137,6 +1137,7 @@ properties:
           - enum:
               - toradex,verdin-imx8mp-nonwifi-dahlia # Verdin iMX8M Plus Module on Dahlia
               - toradex,verdin-imx8mp-nonwifi-dev    # Verdin iMX8M Plus Module on Verdin Development Board
+              - toradex,verdin-imx8mp-nonwifi-ivy    # Verdin iMX8M Plus Module on Ivy
               - toradex,verdin-imx8mp-nonwifi-mallow # Verdin iMX8M Plus Module on Mallow
               - toradex,verdin-imx8mp-nonwifi-yavia  # Verdin iMX8M Plus Module on Yavia
           - const: toradex,verdin-imx8mp-nonwifi     # Verdin iMX8M Plus Module without Wi-Fi / BT
@@ -1148,6 +1149,7 @@ properties:
           - enum:
               - toradex,verdin-imx8mp-wifi-dahlia # Verdin iMX8M Plus Wi-Fi / BT Module on Dahlia
               - toradex,verdin-imx8mp-wifi-dev    # Verdin iMX8M Plus Wi-Fi / BT M. on Verdin Development B.
+              - toradex,verdin-imx8mp-wifi-ivy    # Verdin iMX8M Plus Wi-Fi / BT Module on Ivy
               - toradex,verdin-imx8mp-wifi-mallow # Verdin iMX8M Plus Wi-Fi / BT Module on Mallow
               - toradex,verdin-imx8mp-wifi-yavia  # Verdin iMX8M Plus Wi-Fi / BT Module on Yavia
           - const: toradex,verdin-imx8mp-wifi     # Verdin iMX8M Plus Wi-Fi / BT Module
-- 
2.39.5


