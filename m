Return-Path: <linux-kernel+bounces-350727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BFC9908B2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E572816FD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7AD1C3027;
	Fri,  4 Oct 2024 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="pPcbefJj"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98F510A24;
	Fri,  4 Oct 2024 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058131; cv=none; b=WeDc5LVOtSXGUHuNIQjFFs5tMHk3rObSF2CcRY3uaxC+Z61sZ4pFH2mE3N8k/VssZzZjhfsS4pUEch8MaZWEP2M2WtaUROQ1xRnleh8QyXmdlEw0cTJc5XN4qomy7OGitnqRXE7ZoZTHWYX2lvGeZN37jZEU5mtBiNst+J4Gc6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058131; c=relaxed/simple;
	bh=dGQ7Witn8O6kjYqDrprDqyRKEhDoof7f2lKcqEROOnA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=U+F0Zx2gxZMBRc6lVWMqD8BPPLx4Pc7lm8G85GC1Tp0oOw5t179IdAmHKOEl98TtML64M4LBFaRO8glnE9P4lrJqfzIsO44IKHNLShKM2TXZAlWdFJBl7d/WeFJPzPS+xj2654UTSnAjuzgW+Bjry/hHq5nLtcDuQ6TcbOHhl24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=pPcbefJj; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 96E6A20B47;
	Fri,  4 Oct 2024 18:08:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1728058126;
	bh=/Y0C0EEPQSM8rb7ufcWWlBjaRsWiR64xGnNPRTAiK5I=; h=From:To:Subject;
	b=pPcbefJjFcEgc5rUML4/Q1lhiX1XETfN8q2VyAwJ3nwPc7Qj9qEW8ECIgW9AO5vKe
	 EthhDim8IHHqam98EZubvyLxO53zLA24XtC0dFVDMgG9LlckSr2gZu8wHxmJJ34/Ou
	 GJbUi57GjUas2lT72AAOsUBjzynjs+ojF0zDZqGzJuGiC2rvZiz6Rx2Jvkja2PNN8o
	 /M0wRgtTwyOe/nEVjwtJzhtPUwHWj6IgJUuy+OHzWqaV7c8b1wS5v85QXX+S9X6Nwe
	 J0E+BWLYDCrYv11+SSrf3g1KuN1Ovtavg//kEEf/YcPnzK1X3mOV3pYzSoY62xgFX7
	 H0ll33Ix+Ff3g==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: arm: fsl: drop usage of Toradex SOMs compatible alone
Date: Fri,  4 Oct 2024 18:08:42 +0200
Message-Id: <20241004160842.110079-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

The Toradex SOMs cannot be used alone without a carrier board, so drop
the usage of its compatible alone.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index b39a7e031177..5f0e8e1cd6fb 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -296,7 +296,6 @@ properties:
               - technexion,imx6q-pico-pi      # TechNexion i.MX6Q Pico-Pi
               - technologic,imx6q-ts4900
               - technologic,imx6q-ts7970
-              - toradex,apalis_imx6q      # Apalis iMX6 Modules
               - udoo,imx6q-udoo           # Udoo i.MX6 Quad Board
               - uniwest,imx6q-evi         # Uniwest Evi
               - variscite,dt6customboard
@@ -488,7 +487,6 @@ properties:
               - technexion,imx6dl-pico-pi      # TechNexion i.MX6DL Pico-Pi
               - technologic,imx6dl-ts4900
               - technologic,imx6dl-ts7970
-              - toradex,colibri_imx6dl      # Colibri iMX6 Modules
               - udoo,imx6dl-udoo          # Udoo i.MX6 Dual-lite Board
               - vdl,lanmcu                # Van der Laan LANMCU board
               - wand,imx6dl-wandboard     # Wandboard i.MX6 Dual Lite Board
@@ -718,9 +716,6 @@ properties:
               - joz,jozacp                # JOZ Access Point
               - kontron,sl-imx6ull        # Kontron SL i.MX6ULL SoM
               - myir,imx6ull-mys-6ulx-eval # MYiR Tech iMX6ULL Evaluation Board
-              - toradex,colibri-imx6ull      # Colibri iMX6ULL Modules
-              - toradex,colibri-imx6ull-emmc # Colibri iMX6ULL 1GB (eMMC) Module
-              - toradex,colibri-imx6ull-wifi # Colibri iMX6ULL Wi-Fi / BT Modules
               - uni-t,uti260b             # UNI-T UTi260B Thermal Camera
           - const: fsl,imx6ull
 
@@ -879,8 +874,6 @@ properties:
               - technexion,imx7d-pico-hobbit  # TechNexion i.MX7D Pico-Hobbit
               - technexion,imx7d-pico-nymph   # TechNexion i.MX7D Pico-Nymph
               - technexion,imx7d-pico-pi      # TechNexion i.MX7D Pico-Pi
-              - toradex,colibri-imx7d         # Colibri iMX7D Module
-              - toradex,colibri-imx7d-emmc    # Colibri iMX7D 1GB (eMMC) Module
               - zii,imx7d-rmu2            # ZII RMU2 Board
               - zii,imx7d-rpu2            # ZII RPU2 Board
           - const: fsl,imx7d
@@ -950,9 +943,6 @@ properties:
               - innocomm,wb15-evk         # i.MX8MM Innocomm EVK board with WB15 SoM
               - kontron,imx8mm-sl         # i.MX8MM Kontron SL (N801X) SOM
               - kontron,imx8mm-osm-s      # i.MX8MM Kontron OSM-S (N802X) SOM
-              - toradex,verdin-imx8mm     # Verdin iMX8M Mini Modules
-              - toradex,verdin-imx8mm-nonwifi  # Verdin iMX8M Mini Modules without Wi-Fi / BT
-              - toradex,verdin-imx8mm-wifi  # Verdin iMX8M Mini Wi-Fi / BT Modules
               - prt,prt8mm                # i.MX8MM Protonic PRT8MM Board
           - const: fsl,imx8mm
 
@@ -1085,9 +1075,6 @@ properties:
               - skov,imx8mp-skov-revb-hdmi # SKOV i.MX8MP climate control without panel
               - skov,imx8mp-skov-revb-lt6 # SKOV i.MX8MP climate control with 7” panel
               - skov,imx8mp-skov-revb-mi1010ait-1cp1 # SKOV i.MX8MP climate control with 10.1" panel
-              - toradex,verdin-imx8mp     # Verdin iMX8M Plus Modules
-              - toradex,verdin-imx8mp-nonwifi  # Verdin iMX8M Plus Modules without Wi-Fi / BT
-              - toradex,verdin-imx8mp-wifi  # Verdin iMX8M Plus Wi-Fi / BT Modules
           - const: fsl,imx8mp
 
       - description: Avnet (MSC Branded) Boards with SM2S i.MX8M Plus Modules
@@ -1223,8 +1210,6 @@ properties:
         items:
           - enum:
               - fsl,imx8qm-mek           # i.MX8QM MEK Board
-              - toradex,apalis-imx8      # Apalis iMX8 Modules
-              - toradex,apalis-imx8-v1.1 # Apalis iMX8 V1.1 Modules
           - const: fsl,imx8qm
 
       - description: i.MX8QM Boards with Toradex Apalis iMX8 Modules
@@ -1384,7 +1369,6 @@ properties:
               - fsl,vf610-twr             # VF610 Tower Board
               - lwn,bk4                   # Liebherr BK4 controller
               - phytec,vf610-cosmic       # PHYTEC Cosmic/Cosmic+ Board
-              - toradex,vf610-colibri_vf61 # Colibri VF61 Modules
           - const: fsl,vf610
 
       - description: Toradex Colibri VF61 Module on Colibri Evaluation Board
-- 
2.39.5


