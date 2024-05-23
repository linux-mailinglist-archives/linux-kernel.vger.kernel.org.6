Return-Path: <linux-kernel+bounces-187907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9C18CDA63
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD1D1F21704
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 19:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CC68289E;
	Thu, 23 May 2024 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="jDxnH/WO"
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8790B662;
	Thu, 23 May 2024 19:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716491186; cv=none; b=Q0n3vhAvXmzEUhPJYBok9lqv3cAFawRp8g4L7g/NPBRvbdP7SWTcuNtyN5NU8DQ2+kxHyqtyvKyR5giDV8UG+1NBqLebpi+3XB0cUz/Wsvdy9zLP5o0IDzNp4mfniyAPbPBzW8JmDheoAGwSxcz4I0bHqN8iwi4QOrjKGbsseHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716491186; c=relaxed/simple;
	bh=LwMRjWBblHxb3Sq219BjxEbobPeNjcTYUBz+AtZHW5s=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=MonvjPzMoCkvnZIw6DdC6BtEQujzUCoCNBjL4+j7QXaEPf0QPbDCNnUyr3IXwwyZdQ3Y0Bqgf2Ljl9yKUsw0vn9RND5zVLybHgmpOv1Zr1RIesA+E9QMfcyaJK0ZDVqnMDBbBfNjpfpyNwhJDFV/QKt64crjM1I70ghmE1lPtAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=jDxnH/WO; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1716491168; x=1716750368;
	bh=nKVtgmNgCPvFw75ETX/ZyMKoiz86YChWiGXW6xRcOCA=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=jDxnH/WOznYscoYQtxSgB0KyFrCgko4jGpNbfRU1q6u9PW1fvjaq5ji1tAjO6zsNL
	 S7RENnVYq60wH3vazDTW6Nk18PoptOaJhkm7oEI63LkmUKp43csQUqYvJ+YnzvBqJA
	 lofoN1gpO3vfdrzHEbJWV7bD2JI9D+zWIhsWQFD+wKgH2ZALKDKhK3NUPpFvR1gSDg
	 2FMj32edjwrAfI/Uv+nECX3xxbh1byGyTWAAyH4ryJGAfbZfjMDY5XfX8V6ua1PuE/
	 2fiBcJDQjbKUXQDIriqkxsHOVesBTQuWgg+FmxedLmofS2rw/jnrdLmXwKir4dXkIi
	 kiNByXT99DRFA==
Date: Thu, 23 May 2024 19:06:04 +0000
To: Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: H Bell <dmoo_dv@protonmail.com>
Subject: [PATCH] RISC-V: add Star64 board devicetree
Message-ID: <IPHlm5mOKUzYfwGy0auyufx-oPkSrtQjUjiQLbtvspD69UPX9O98iB8P2mqM8ahNaerz0yUa009f4XABRniq7aj2PUp83hbRVVhhKmqT0Ss=@protonmail.com>
Feedback-ID: 106097379:user:proton
X-Pm-Message-ID: b780bb72757bb9f05bb140b9d649e489d2401f2e
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
Cc: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/starfive/Makefile         |  1 +
 .../dts/starfive/jh7110-pine64-star64.dts     | 62 +++++++++++++++++++
 2 files changed, 63 insertions(+)
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
index 000000000000..c70fffd51181
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+* Copyright (C) 2022 StarFive Technology Co., Ltd.
+* Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
+*/
+
+/dts-v1/;
+#include "jh7110-common.dtsi"
+
+/ {
+=09model =3D "Pine64 Star64";
+=09compatible =3D "pine64,star64", "starfive,jh7110";
+=09=09aliases {
+=09=09=09=09ethernet1 =3D &gmac1;
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
+=09status =3D "okay";
+=09starfive,tx-use-rgmii-clk;
+=09assigned-clocks =3D <&syscrg JH7110_SYSCLK_GMAC1_TX>;
+=09assigned-clock-parents =3D <&syscrg JH7110_SYSCLK_GMAC1_RMII_RTX>;
+
+=09mdio {
+=09=09#address-cells =3D <1>;
+=09=09#size-cells =3D <0>;
+=09=09compatible =3D "snps,dwmac-mdio";
+
+=09=09phy1: ethernet-phy@1 {
+=09=09=09reg =3D <0>;
+=09=09};
+=09};
+};
+
+&phy0 {
+=09motorcomm,tx-clk-adj-enabled;
+=09motorcomm,tx-clk-10-inverted;
+=09motorcomm,tx-clk-100-inverted;
+=09motorcomm,tx-clk-1000-inverted;
+=09motorcomm,rx-clk-drv-microamp =3D <2910>;
+=09motorcomm,rx-data-drv-microamp =3D <2910>;
+=09rx-internal-delay-ps =3D <1900>;=20
+=09tx-internal-delay-ps =3D <1500>;
+};
+
+&phy1 {
+=09motorcomm,tx-clk-adj-enabled;
+=09motorcomm,tx-clk-10-inverted;
+=09motorcomm,tx-clk-100-inverted;
+=09motorcomm,rx-clk-drv-microamp =3D <2910>;
+=09motorcomm,rx-data-drv-microamp =3D <2910>;
+=09rx-internal-delay-ps =3D <0>;
+=09tx-internal-delay-ps =3D <300>;
+};
--=20
2.44.0



