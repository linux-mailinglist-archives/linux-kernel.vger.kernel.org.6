Return-Path: <linux-kernel+bounces-188062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0278E8CDC6E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311501C23F37
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BE3127E2B;
	Thu, 23 May 2024 21:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="FuEBXsKZ"
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8EC128376;
	Thu, 23 May 2024 21:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716501353; cv=none; b=fIz4NYgZCm1QaTNweKR42T5pcEQLGo/rrLG6Bfx2m0XXWlJ496J9NXaCzpLJuACrn47vP+IW/qntQh/XFM//Bvag8+NVBByzQ7aqghFVOkwc+ZEx3dXd9MMN6erQnxBHUZvRRDmtN0j/h+kuXyyhSjBbd2pJvPLb4Szd3poHcmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716501353; c=relaxed/simple;
	bh=tCcsCjlTwKdqtbCnALVMqtV6Sm0kKj2mPnLSWIqGvNQ=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=HXv6gP3MA3y6lZtIL9UC56ookujyIjzPWYsMZvy/Tt5DgOFXTq8f/rssl1YJDjRr/00leKnlYIRGmMA74RwJgqt3mpPCF7QyXPlsZebWyPpT2M+OKrAKTvMGVVUJ5pLET2IAYfm4332dCPvVuZSoutkjmkGTzOQ+mpqi3BcUaUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=FuEBXsKZ; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1716501344; x=1716760544;
	bh=CdQtkbL7rZtxuy08orSqaz6hkhLm53eUyRt02+x9f9s=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=FuEBXsKZaynkzfG3KX4+IsWH286zWrcMgL8GC0kNoa0n6/Lda4YKEqx42p3kvpmbg
	 bPPvNaeA1IKzeC/CthceuPOMC6Uf1O3ph+Jw2FLiDaZ7xrXU6ycBb/OJol7Z48/VHZ
	 SLInoKcB7S7d8wiaDwVzv11UgKGJ8bVcAhrkqFuL7EgSxNuEOXy4BFayEpsYftCtPe
	 Mr0HP3bSz7gccx1Pnc5KKX4v0AOdCMhtrUHG4q8y6mUzfIXSwV2VUUJs6SIh3ZnV10
	 kWMhzvLEzNfxD+Jl1StffRryKICDz5C/pZ46ULXXtoeqHYvIfjHZR1g15wGOcJf1JX
	 UvM9z76oq51Ng==
Date: Thu, 23 May 2024 21:55:38 +0000
To: Emil Renner Berthing <kernel@esmil.dk>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Henry Bell <dmoo_dv@protonmail.com>
Subject: [PATCH 2/2 v2] RISC-V: add Star64 board devicetree
Message-ID: <3Rwq1VegQtSiNjWbBny27eDBw9sCw4cXHBe_3FgihJ1i3dGI6rMS8xI32f2syRXKoa-XZubm7fMr2SED1haIWWygYWJA9azHqRzV6JSmTVo=@protonmail.com>
Feedback-ID: 106097379:user:proton
X-Pm-Message-ID: ae9242ee3f43ecbe40ad82c9cffbc6db9208979f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The Pine64 Star64 is a development board based on the Starfive JH7110 SoC.
The board features:

- JH7110 SoC
- 4/8 GiB LPDDR4 DRAM
- AXP15060 PMIC
- 40 pin GPIO header
- 1x USB 3.0 host port
- 3x USB 2.0 host port
- 1x eMMC slot
- 1x MicroSD slot
- 1x QSPI Flash
- 2x 1Gbps Ethernet port
- 1x HDMI port
- 1x 4-lane DSI
- 1x 2-lane CSI
- 1x PCIe 2.0 x1 lane

Signed-off-by: Henry Bell <dmoo_dv@protonmail.com>
---

Changes since v1:

- Fix indentation and issues with field ordering
- Update Copyright
- Move from patch 1 to patch 2
---
 arch/riscv/boot/dts/starfive/Makefile         |  1 +
 .../dts/starfive/jh7110-pine64-star64.dts     | 61 +++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts

diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/st=
arfive/Makefile
index 2fa0cd7f31c3..7a163a7d6ba3 100644
--- a/arch/riscv/boot/dts/starfive/Makefile
+++ b/arch/riscv/boot/dts/starfive/Makefile
@@ -9,5 +9,6 @@ dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7100-beaglev-starlight.d=
tb
 dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7100-starfive-visionfive-v1.dtb
=20
 dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7110-milkv-mars.dtb
+dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7110-pine64-star64.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7110-starfive-visionfive-2-v1.2a.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) +=3D jh7110-starfive-visionfive-2-v1.3b.dtb
diff --git a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts b/arch/r=
iscv/boot/dts/starfive/jh7110-pine64-star64.dts
new file mode 100644
index 000000000000..fe7e5f3f7f23
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2024 Henry Bell <dmoo_dv@protonmail.com>
+ */
+
+/dts-v1/;
+#include "jh7110-common.dtsi"
+
+/ {
+=09model =3D "Pine64 Star64";
+=09compatible =3D "pine64,star64", "starfive,jh7110";
+=09=09aliases {
+=09=09=09ethernet1 =3D &gmac1;
+=09=09};
+};
+
+&gmac0 {
+=09starfive,tx-use-rgmii-clk;
+=09assigned-clocks =3D <&aoncrg JH7110_AONCLK_GMAC0_TX>;
+=09assigned-clock-parents =3D <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
+};
+
+&gmac1 {
+=09phy-handle =3D <&phy1>;
+=09phy-mode =3D "rgmii-id";
+=09starfive,tx-use-rgmii-clk;
+=09assigned-clocks =3D <&syscrg JH7110_SYSCLK_GMAC1_TX>;
+=09assigned-clock-parents =3D <&syscrg JH7110_SYSCLK_GMAC1_RMII_RTX>;
+=09status =3D "okay";
+
+=09mdio {
+=09=09#address-cells =3D <1>;
+=09=09#size-cells =3D <0>;
+=09=09compatible =3D "snps,dwmac-mdio";
+
+=09=09phy1: ethernet-phy@1 {
+=09=09=09reg =3D <1>;
+=09=09};
+=09};
+};
+
+&phy0 {
+=09rx-internal-delay-ps =3D <1900>;
+=09tx-internal-delay-ps =3D <1500>;
+=09motorcomm,rx-clk-drv-microamp =3D <2910>;
+=09motorcomm,rx-data-drv-microamp =3D <2910>;
+=09motorcomm,tx-clk-adj-enabled;
+=09motorcomm,tx-clk-10-inverted;
+=09motorcomm,tx-clk-100-inverted;
+=09motorcomm,tx-clk-1000-inverted;
+};
+
+&phy1 {
+=09rx-internal-delay-ps =3D <0>;
+=09tx-internal-delay-ps =3D <300>;
+=09motorcomm,rx-clk-drv-microamp =3D <2910>;
+=09motorcomm,rx-data-drv-microamp =3D <2910>;
+=09motorcomm,tx-clk-adj-enabled;
+=09motorcomm,tx-clk-10-inverted;
+=09motorcomm,tx-clk-100-inverted;
+};
--=20
2.44.0



