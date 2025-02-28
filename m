Return-Path: <linux-kernel+bounces-538778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56160A49D00
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670893B3C27
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1365E270EB9;
	Fri, 28 Feb 2025 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="xp7g9Akd"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F405F1AB6FF;
	Fri, 28 Feb 2025 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740755643; cv=none; b=QxY42wtbg1iCAnfe8GICRU79oyBB6FoO1cIEkXRjHQLg8aHyMls+wIs8WPHmyun1fEWpHmXhoumASNpp96yKQGp2H2l1OJefngJYz7rV2slm4vV7ET5m3sFS7Xb7oQ8QbEY7ViUeQd8GAbpslHwfnMokhOcSYEWdeqT6NMunws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740755643; c=relaxed/simple;
	bh=gJUYsLFsPpcsgciV6FLXmrklKNy+ro8VFbqQj5f6Ou0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2Op8r8fvuN8K8g1RWUlOonjx6kcPj8z8myBE2X91sghprkp7kX7Qi/r/UpvCn9YCjLnHh2IfcmgH1OhhQfPFKKAzXyQcd18hVSqd/mjLFDI2B8Zj1ibshJmlc6gwT2fVeney7H58gtlvq6wZsE5b13+X6GNUguRsVpuEzZQixY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=xp7g9Akd; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id CB11D1F9E6;
	Fri, 28 Feb 2025 16:13:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1740755639;
	bh=8hkgdWFIWdzAmzG1XT39OWbOtzfhpTHZ1x8VgAGml28=; h=From:To:Subject;
	b=xp7g9AkdCUGOL/OBKwOT8ObzgR/Ozld+LFZsNkm9VDEIpTmKfIDsVWWIADhdOyzD0
	 lwEFAj12Id4IcelTGGMr/KffVvHSVZiiAMe8MZPOXnglxVagQdgbJOfd4kzdlS2p+Z
	 cdzPOw4BG8Id5xruT8E/lscMvNIcZaZOWGjuWKuR53RBzTaxVCDzwl6iiZLDCeHCmT
	 oR07EypWlRcgMdBQ+56S7VHBcT33g0oQjOidlMEH6l8GLZg5Acav0HnA73G9/wc/pW
	 DnVIQI5ejMliWPDMLUHNZeSWrzBdH6PgVNtKdOCBUyi9gmSAvC+ytugIuL/6qjeTG0
	 s+7K7a8RVpNxA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Stefan Agner <stefan@agner.ch>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/4] dt-bindings: arm: fsl: drop usage of Toradex SOMs compatible alone
Date: Fri, 28 Feb 2025 16:13:49 +0100
Message-Id: <20250228151352.91768-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250228151352.91768-1-francesco@dolcini.it>
References: <20250228151352.91768-1-francesco@dolcini.it>
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
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
v2: added Reviewed-by
v1: https://lore.kernel.org/all/20241004160842.110079-1-francesco@dolcini.it/
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 0db2cbd7891f..fc566cce56c6 100644
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
@@ -490,7 +489,6 @@ properties:
               - technexion,imx6dl-pico-pi      # TechNexion i.MX6DL Pico-Pi
               - technologic,imx6dl-ts4900
               - technologic,imx6dl-ts7970
-              - toradex,colibri_imx6dl      # Colibri iMX6 Modules
               - udoo,imx6dl-udoo          # Udoo i.MX6 Dual-lite Board
               - vdl,lanmcu                # Van der Laan LANMCU board
               - wand,imx6dl-wandboard     # Wandboard i.MX6 Dual Lite Board
@@ -730,9 +728,6 @@ properties:
               - joz,jozacp                # JOZ Access Point
               - kontron,sl-imx6ull        # Kontron SL i.MX6ULL SoM
               - myir,imx6ull-mys-6ulx-eval # MYiR Tech iMX6ULL Evaluation Board
-              - toradex,colibri-imx6ull      # Colibri iMX6ULL Modules
-              - toradex,colibri-imx6ull-emmc # Colibri iMX6ULL 1GB (eMMC) Module
-              - toradex,colibri-imx6ull-wifi # Colibri iMX6ULL Wi-Fi / BT Modules
               - uni-t,uti260b             # UNI-T UTi260B Thermal Camera
           - const: fsl,imx6ull
 
@@ -891,8 +886,6 @@ properties:
               - technexion,imx7d-pico-hobbit  # TechNexion i.MX7D Pico-Hobbit
               - technexion,imx7d-pico-nymph   # TechNexion i.MX7D Pico-Nymph
               - technexion,imx7d-pico-pi      # TechNexion i.MX7D Pico-Pi
-              - toradex,colibri-imx7d         # Colibri iMX7D Module
-              - toradex,colibri-imx7d-emmc    # Colibri iMX7D 1GB (eMMC) Module
               - zii,imx7d-rmu2            # ZII RMU2 Board
               - zii,imx7d-rpu2            # ZII RPU2 Board
           - const: fsl,imx7d
@@ -962,9 +955,6 @@ properties:
               - innocomm,wb15-evk         # i.MX8MM Innocomm EVK board with WB15 SoM
               - kontron,imx8mm-sl         # i.MX8MM Kontron SL (N801X) SOM
               - kontron,imx8mm-osm-s      # i.MX8MM Kontron OSM-S (N802X) SOM
-              - toradex,verdin-imx8mm     # Verdin iMX8M Mini Modules
-              - toradex,verdin-imx8mm-nonwifi  # Verdin iMX8M Mini Modules without Wi-Fi / BT
-              - toradex,verdin-imx8mm-wifi  # Verdin iMX8M Mini Wi-Fi / BT Modules
               - prt,prt8mm                # i.MX8MM Protonic PRT8MM Board
           - const: fsl,imx8mm
 
@@ -1101,9 +1091,6 @@ properties:
               - skov,imx8mp-skov-revb-hdmi # SKOV i.MX8MP climate control without panel
               - skov,imx8mp-skov-revb-lt6 # SKOV i.MX8MP climate control with 7” panel
               - skov,imx8mp-skov-revb-mi1010ait-1cp1 # SKOV i.MX8MP climate control with 10.1" panel
-              - toradex,verdin-imx8mp     # Verdin iMX8M Plus Modules
-              - toradex,verdin-imx8mp-nonwifi  # Verdin iMX8M Plus Modules without Wi-Fi / BT
-              - toradex,verdin-imx8mp-wifi  # Verdin iMX8M Plus Wi-Fi / BT Modules
               - ysoft,imx8mp-iota2-lumpy  # Y Soft i.MX8MP IOTA2 Lumpy Board
           - const: fsl,imx8mp
 
@@ -1273,8 +1260,6 @@ properties:
           - enum:
               - fsl,imx8qm-mek           # i.MX8QM MEK Board
               - fsl,imx8qm-mek-revd      # i.MX8QM MEK Rev D Board
-              - toradex,apalis-imx8      # Apalis iMX8 Modules
-              - toradex,apalis-imx8-v1.1 # Apalis iMX8 V1.1 Modules
           - const: fsl,imx8qm
 
       - description: i.MX8QM Boards with Toradex Apalis iMX8 Modules
@@ -1435,7 +1420,6 @@ properties:
               - fsl,vf610-twr             # VF610 Tower Board
               - lwn,bk4                   # Liebherr BK4 controller
               - phytec,vf610-cosmic       # PHYTEC Cosmic/Cosmic+ Board
-              - toradex,vf610-colibri_vf61 # Colibri VF61 Modules
           - const: fsl,vf610
 
       - description: Toradex Colibri VF61 Module on Colibri Evaluation Board
-- 
2.39.5


