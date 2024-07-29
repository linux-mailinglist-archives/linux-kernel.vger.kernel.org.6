Return-Path: <linux-kernel+bounces-265205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D02893EDF8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457422815D3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC01786AE9;
	Mon, 29 Jul 2024 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wPDmQA33"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A3F7D3EC;
	Mon, 29 Jul 2024 07:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236819; cv=none; b=rosxD+OAplLvkGSrF5OXIKbPE0VAOJRZq/PG/BqAL7Cr6DJ3uJ3BL/wLMVcPyXk45ZpzkPlWAI0wMp/P3OJNxXBf+j/49m1uApXigLozvq9tDpqbQZuusCmrRZWe+fCyLam7dJ5nqtcEt4eTHELeFehItK7kf49QfJFzqNL2ue4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236819; c=relaxed/simple;
	bh=iGJ3QLxUBx3lWaj8smL6i5Dofs/yvFBxdgR2BHeTifY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NhObQ8jMU58iIBdPlDf/VyJgWlydPBlwGJwAvt83WGmD20OT8/fkliiWVopXnTlosYO+Wshu01GwrCu2qE/AjULB2pWIfcj1wxGgvWbZN6HTgCiP0OBS4NWBFBgykWknWNWJOeRHtLLxl5Mjhf0jzh5Eb4A+6LwVat9Wtu9eP2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wPDmQA33; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722236816; x=1753772816;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iGJ3QLxUBx3lWaj8smL6i5Dofs/yvFBxdgR2BHeTifY=;
  b=wPDmQA33SgAYI16FLJ83EtX8OMn/3iQGX8/dgx5YyFGjCQrpDaNHIhxU
   udAZ5oKca36zB/pWXiW3gDQyrX93Lh0N5mRXn2xzv8scxbgDm36mQ/8Bo
   mQBUHPkp1NdwH+zQv9SVnpWWJbeRPbULcfpuKmH9GLCNUyMa79ZEFmEu/
   VwQB3NQwR5a5uZKGUp6HMfcpWBnFQVKS1eI6UAhlL4tpIIJJpRdBtLkfH
   ubiEONUNZQxrYY2tUBnErDRUM2WVCiVW3s5CHyqV8yc1dY3mpjOIueMuV
   fPJm+k2EVRWihxs2keB3V0SIRi3WeTUH3uUpPcA2tyTyceyEDs0+XkxYX
   Q==;
X-CSE-ConnectionGUID: MnTnLLroRF2oCkj0nuokmg==
X-CSE-MsgGUID: 5TKxq8NwQEm1E1f6fiybtA==
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="32596747"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jul 2024 00:06:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jul 2024 00:06:28 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jul 2024 00:06:23 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <ychuang3@nuvoton.com>,
	<schung@nuvoton.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v6 02/27] dt-bindings: mfd: syscon: add microchip's sam9x7 sfr
Date: Mon, 29 Jul 2024 12:36:03 +0530
Message-ID: <20240729070603.1990265-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
References: <20240729065603.1986074-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add compatible for sam9x7 SoC's SFR.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
Changes in v6:

 - New patch in v6 as the syscon devices are moved to a new file
   upstream.
---
 .../devicetree/bindings/mfd/syscon.yaml       | 188 +++++++++---------
 1 file changed, 97 insertions(+), 91 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 9dc594ea3654..50392d091e70 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -120,97 +120,103 @@ select:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - al,alpine-sysfabric-service
-          - allwinner,sun8i-a83t-system-controller
-          - allwinner,sun8i-h3-system-controller
-          - allwinner,sun8i-v3s-system-controller
-          - allwinner,sun50i-a64-system-controller
-          - altr,l3regs
-          - altr,sdr-ctl
-          - amd,pensando-elba-syscon
-          - amlogic,meson-mx-assist
-          - amlogic,meson-mx-bootrom
-          - amlogic,meson8-analog-top
-          - amlogic,meson8b-analog-top
-          - amlogic,meson8-pmu
-          - amlogic,meson8b-pmu
-          - apm,merlin-poweroff-mailbox
-          - apm,mustang-poweroff-mailbox
-          - apm,xgene-csw
-          - apm,xgene-efuse
-          - apm,xgene-mcb
-          - apm,xgene-rb
-          - apm,xgene-scu
-          - atmel,sama5d2-sfrbu
-          - atmel,sama5d3-nfc-io
-          - atmel,sama5d3-sfrbu
-          - atmel,sama5d4-sfrbu
-          - axis,artpec6-syscon
-          - brcm,cru-clkset
-          - brcm,sr-cdru
-          - brcm,sr-mhb
-          - cirrus,ep7209-syscon1
-          - cirrus,ep7209-syscon2
-          - cirrus,ep7209-syscon3
-          - cnxt,cx92755-uc
-          - freecom,fsg-cs2-system-controller
-          - fsl,imx93-aonmix-ns-syscfg
-          - fsl,imx93-wakeupmix-syscfg
-          - fsl,ls1088a-reset
-          - fsl,vf610-anatop
-          - fsl,vf610-mscm-cpucfg
-          - hisilicon,dsa-subctrl
-          - hisilicon,hi6220-sramctrl
-          - hisilicon,hip04-ppe
-          - hisilicon,pcie-sas-subctrl
-          - hisilicon,peri-subctrl
-          - hpe,gxp-sysreg
-          - loongson,ls1b-syscon
-          - loongson,ls1c-syscon
-          - lsi,axxia-syscon
-          - marvell,armada-3700-cpu-misc
-          - marvell,armada-3700-nb-pm
-          - marvell,armada-3700-avs
-          - marvell,armada-3700-usb2-host-misc
-          - marvell,dove-global-config
-          - mediatek,mt2701-pctl-a-syscfg
-          - mediatek,mt2712-pctl-a-syscfg
-          - mediatek,mt6397-pctl-pmic-syscfg
-          - mediatek,mt8135-pctl-a-syscfg
-          - mediatek,mt8135-pctl-b-syscfg
-          - mediatek,mt8173-pctl-a-syscfg
-          - mediatek,mt8365-syscfg
-          - microchip,lan966x-cpu-syscon
-          - microchip,sam9x60-sfr
-          - microchip,sama7g5-ddr3phy
-          - mscc,ocelot-cpu-syscon
-          - mstar,msc313-pmsleep
-          - nuvoton,ma35d1-sys
-          - nuvoton,wpcm450-shm
-          - rockchip,px30-qos
-          - rockchip,rk3036-qos
-          - rockchip,rk3066-qos
-          - rockchip,rk3128-qos
-          - rockchip,rk3228-qos
-          - rockchip,rk3288-qos
-          - rockchip,rk3368-qos
-          - rockchip,rk3399-qos
-          - rockchip,rk3568-qos
-          - rockchip,rk3588-qos
-          - rockchip,rv1126-qos
-          - st,spear1340-misc
-          - stericsson,nomadik-pmu
-          - starfive,jh7100-sysmain
-          - ti,am62-opp-efuse-table
-          - ti,am62-usb-phy-ctrl
-          - ti,am625-dss-oldi-io-ctrl
-          - ti,am62p-cpsw-mac-efuse
-          - ti,am654-dss-oldi-io-ctrl
-          - ti,j784s4-pcie-ctrl
-          - ti,keystone-pllctrl
-      - const: syscon
+    oneOf:
+      - items:
+          - enum:
+              - al,alpine-sysfabric-service
+              - allwinner,sun8i-a83t-system-controller
+              - allwinner,sun8i-h3-system-controller
+              - allwinner,sun8i-v3s-system-controller
+              - allwinner,sun50i-a64-system-controller
+              - altr,l3regs
+              - altr,sdr-ctl
+              - amd,pensando-elba-syscon
+              - amlogic,meson-mx-assist
+              - amlogic,meson-mx-bootrom
+              - amlogic,meson8-analog-top
+              - amlogic,meson8b-analog-top
+              - amlogic,meson8-pmu
+              - amlogic,meson8b-pmu
+              - apm,merlin-poweroff-mailbox
+              - apm,mustang-poweroff-mailbox
+              - apm,xgene-csw
+              - apm,xgene-efuse
+              - apm,xgene-mcb
+              - apm,xgene-rb
+              - apm,xgene-scu
+              - atmel,sama5d2-sfrbu
+              - atmel,sama5d3-nfc-io
+              - atmel,sama5d3-sfrbu
+              - atmel,sama5d4-sfrbu
+              - axis,artpec6-syscon
+              - brcm,cru-clkset
+              - brcm,sr-cdru
+              - brcm,sr-mhb
+              - cirrus,ep7209-syscon1
+              - cirrus,ep7209-syscon2
+              - cirrus,ep7209-syscon3
+              - cnxt,cx92755-uc
+              - freecom,fsg-cs2-system-controller
+              - fsl,imx93-aonmix-ns-syscfg
+              - fsl,imx93-wakeupmix-syscfg
+              - fsl,ls1088a-reset
+              - fsl,vf610-anatop
+              - fsl,vf610-mscm-cpucfg
+              - hisilicon,dsa-subctrl
+              - hisilicon,hi6220-sramctrl
+              - hisilicon,hip04-ppe
+              - hisilicon,pcie-sas-subctrl
+              - hisilicon,peri-subctrl
+              - hpe,gxp-sysreg
+              - loongson,ls1b-syscon
+              - loongson,ls1c-syscon
+              - lsi,axxia-syscon
+              - marvell,armada-3700-cpu-misc
+              - marvell,armada-3700-nb-pm
+              - marvell,armada-3700-avs
+              - marvell,armada-3700-usb2-host-misc
+              - marvell,dove-global-config
+              - mediatek,mt2701-pctl-a-syscfg
+              - mediatek,mt2712-pctl-a-syscfg
+              - mediatek,mt6397-pctl-pmic-syscfg
+              - mediatek,mt8135-pctl-a-syscfg
+              - mediatek,mt8135-pctl-b-syscfg
+              - mediatek,mt8173-pctl-a-syscfg
+              - mediatek,mt8365-syscfg
+              - microchip,lan966x-cpu-syscon
+              - microchip,sam9x60-sfr
+              - microchip,sam9x7-sfr
+              - microchip,sama7g5-ddr3phy
+              - mscc,ocelot-cpu-syscon
+              - mstar,msc313-pmsleep
+              - nuvoton,ma35d1-sys
+              - nuvoton,wpcm450-shm
+              - rockchip,px30-qos
+              - rockchip,rk3036-qos
+              - rockchip,rk3066-qos
+              - rockchip,rk3128-qos
+              - rockchip,rk3228-qos
+              - rockchip,rk3288-qos
+              - rockchip,rk3368-qos
+              - rockchip,rk3399-qos
+              - rockchip,rk3568-qos
+              - rockchip,rk3588-qos
+              - rockchip,rv1126-qos
+              - st,spear1340-misc
+              - stericsson,nomadik-pmu
+              - starfive,jh7100-sysmain
+              - ti,am62-opp-efuse-table
+              - ti,am62-usb-phy-ctrl
+              - ti,am625-dss-oldi-io-ctrl
+              - ti,am62p-cpsw-mac-efuse
+              - ti,am654-dss-oldi-io-ctrl
+              - ti,j784s4-pcie-ctrl
+              - ti,keystone-pllctrl
+          - const: syscon
+      - items:
+          - const: microchip,sam9x7-sfr
+          - const: microchip,sam9x60-sfr
+          - const: syscon
 
   reg:
     maxItems: 1
-- 
2.25.1


