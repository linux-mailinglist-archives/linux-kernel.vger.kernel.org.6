Return-Path: <linux-kernel+bounces-513817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25763A34EF8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4CD16D281
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B82E24A04C;
	Thu, 13 Feb 2025 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ulg/rzDW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EBC203703;
	Thu, 13 Feb 2025 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739477056; cv=none; b=U85iZoHhO0uZwip8VwD1OotMqGMEslTG2bqECqymYYQ2/JJE8nPPgPaFwtgQc7WqR16mYtLaC28E+yKPVLU9MGCZXCF2v1NMEvP/6GM6ExJ6U3vpSSb6ukgvIpqEv2V/xw8SooJGwWsIrtPIxpbu6btXckYCd/kVu4IjA19LxpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739477056; c=relaxed/simple;
	bh=fZ9g4z7iJBs0CfgSH7MAc1CKB24UVVzf/LWilt9EvvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=figgB2uG4Uezfg+Nu/K1aQUz/6BTAD9oilmUJbR71g3AePfsU47/qcXdbzfR/XXuoQXRtKpyRVRyw50F6LG64tAWldo3dH7mDITNXcUc0pk2EyGUF3kSfelPyolqHz+q1iJnsm2P/3DGSw+q4sdpPTGxy4ky2roKqAnQuUvjbVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ulg/rzDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A8EC4CED1;
	Thu, 13 Feb 2025 20:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739477055;
	bh=fZ9g4z7iJBs0CfgSH7MAc1CKB24UVVzf/LWilt9EvvQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Ulg/rzDWtr+ncf8DLmyiSNeilp2TbJIlkWq6GE55T0Yg7zZCAQ5oTfnybJLTqW/7B
	 IoUzKxEEN/xrJMjfU3TUICXKI3TAO8EwKFdsA3aJQdqXjo2ChVM48ReJo3zRFWJAnp
	 XaQ35ckVJkFFyx2liIkEaQo1dceJKzdsrPQLfuwp88yz5UkxCyLcWFkiDMBFJVM4c1
	 UWnkoG632dYFPaA+C9GD6F649NEvoxSLeIeMutnYiea3AJvNGPgrXjD3z/46dFCYro
	 QSdkvdcao/baIfy3u4IKlGMVbCXVVbP1KW9eYqUM01ifPdkERsHd+Hvotzb745g/pf
	 qCCbRaerQtrwQ==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] riscv: dts: starfive: remove non-existent dac from jh7110
Date: Thu, 13 Feb 2025 20:03:52 +0000
Message-ID: <20250213-tidy-dollop-cbfc8fc7dc91@spud>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1249; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=YaSz6TVHGRo6Wy0JnL9W0K4x8SDhrDVeJ8YpmvuOuck=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOnrAtT3P9cwuWpnmnZP0bH9k67P5aZjEWXHeZ9NuV2ow faKf/vGjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAExkzmZGhhdfLhTWqhhsyxd/ uey9htz85itpH3vrZjreXcXzVduoR4Lhv8OrD1fuOHiJfG2NtBHPMz17O8f48XzTA/M3fSlg1P0 oxAsA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The jh7110 boards do not have a Rohm DAC on them as far as I
can tell, and they certainly do not have a dh2228fv, as this device does
not actually exist! Remove the dac nodes from the devicetrees as it is
not acceptable to pretend to have a device on a board in order to bind
the spidev driver in Linux.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Emil Renner Berthing <kernel@esmil.dk>
CC: Conor Dooley <conor@kernel.org>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: linux-riscv@lists.infradead.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index dd2eefc295e5..c2f70f5e2918 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -350,12 +350,6 @@ &pwm {
 &spi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi0_pins>;
-
-	spi_dev0: spi@0 {
-		compatible = "rohm,dh2228fv";
-		reg = <0>;
-		spi-max-frequency = <10000000>;
-	};
 };
 
 &syscrg {
-- 
2.45.2


