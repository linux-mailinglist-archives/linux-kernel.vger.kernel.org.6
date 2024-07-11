Return-Path: <linux-kernel+bounces-248928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F00692E3FD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E1AAB2220E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20AA158206;
	Thu, 11 Jul 2024 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aW6ayPAE"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C22152533;
	Thu, 11 Jul 2024 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692103; cv=none; b=nz/v+TRE7f08vkXh9qetDWrUDxMBGyJN/oeTI6bLZKsmhsILRZmnu8dJwih2ZVdZXqfIvg5VTkBJAzVEWDbEgqClQ4uHHCerjH1Rqgp3C0mPY1rrITlxgVWq2zeTqqcNAeF7h3U7DIykAXpmgkIdsWSIxfPp27vIC59/0FRDlig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692103; c=relaxed/simple;
	bh=6WeHPJnXxldGbw0Jee0LlKYVR3BaJR26GhzkSQqURkE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YIa8v6B6EHAT5idp3VyC/654YRejq7vF0ac3LASNi6njJxtjBukKA0Hqj6P8QTy91f2rqT7PTFmim3MlEbsxxcnDhacdPVjzT8j4nBs+7g14jmyQT/M0LMPt2D+71X7kwpwd0n9ScB3zyA2a34FenDkQM2HSz81Yi0xdGxfzMNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aW6ayPAE; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 95C19240005;
	Thu, 11 Jul 2024 10:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720692093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vlU1weA5VgH1E2dh8WVjvbQOwF4vjq6cd6VW9er2tWU=;
	b=aW6ayPAEcB36p23PxWi3enx40Cf7PVxlhwtg0QPdovqFdoVhiX0Sc6R2TbxcTWa6lvA1ew
	tTETtwTK402Xk++Y1z65U6RL62j9WxUL3FRSnHKlNzjU6WiyFgpNW2nungDtytJhn4iekr
	LTH10E9NP/NzscW8qLhNcjAt9+BnB03VJTUped7b9+/a4J4bPXgc/qHRu14xZiwJfMtUsM
	EWiGvFb+nzVGp8p8TYVPI8XGwWikjSRrnyRk+feDJ8AOOQuhEX1Y3eyswUUQ2Z3cS7Bvn+
	5O6952u+ecx67zqDewC4g0lP+wJqx1n+HZV8GrjXPDqLsqgpy425wlf+5FYLQA==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Subject: [PATCH v4 0/4] Add board support for Sipeed LicheeRV Nano
Date: Thu, 11 Jul 2024 12:01:27 +0200
Message-Id: <20240711-sg2002-v4-0-d97ec2367095@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHetj2YC/3XOy2rDMBAF0F8JWldFMyPr0VX/o2ShZyJorWAF0
 xD875VTSDBpl1fo3DtX1tJUUmNvuyub0lxaqWMP8mXHwtGNh8RL7JmhQCkGGHg7oBDILcWQIKI
 in1j/fJpSLt+3oo99z8fSznW63HpnWF+fKmbgglPM2oAzQhp497WeP8v4GurX2vkLkDbAepDeg
 rHGuX+A3gDwKngyIZksN2A9c8bHaQrEHWKHCclHyiqS0H8uKcANAOsGM7isjFTPS/RY0sLeIXX
 ostY2UASycQuXZfkBRCE45KMBAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
 Chao Wei <chao.wei@sophgo.com>, Conor Dooley <conor@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.0
X-GND-Sasl: thomas.bonnefille@bootlin.com

The LicheeRV Nano is a RISC-V SBC based on the Sophgo SG2002 chip. Adds
minimal device tree files for this board to make it boot to a basic
shell.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
Changes in v4:
- Add correct bindings configuration for SG2002 sdhci
- Drop commit "dt-bindings: timer: Add SOPHGO SG2002 clint" because it
  has already been merged in Daniel Lezcano git tree.
- Link to v3: https://lore.kernel.org/r/20240709-sg2002-v3-0-af779c3d139d@bootlin.com

Changes in v3:
- Remove /dts-v1/ directive from sg2002.dtsi file
- Add disable-wp property to sdhci node to avoid having a write
  protected SD card
- Drop changes in cv18xx.dtsi and cv1800b.dtsi
- Add fallback compatible to cv1800b in SDHCI node of sg2002.dtsi
- Link to v2: https://lore.kernel.org/r/20240612-sg2002-v2-0-19a585af6846@bootlin.com

Changes in v2:
- Add SDHCI support
- Change device tree name to match the Makefile
- Add oscillator frequency
- Add aliases to other UARTs
- Add aliases to GPIOs
- Move compatible for SDHCI from common DT to specific DT 
- Link to v1: https://lore.kernel.org/r/20240527-sg2002-v1-0-1b6cb38ce8f4@bootlin.com

---
Thomas Bonnefille (4):
      dt-bindings: interrupt-controller: Add SOPHGO SG2002 plic
      dt-bindings: riscv: Add Sipeed LicheeRV Nano board compatibles
      riscv: dts: sophgo: Add initial SG2002 SoC device tree
      riscv: dts: sophgo: Add LicheeRV Nano board device tree

 .../interrupt-controller/sifive,plic-1.0.0.yaml    |  1 +
 .../devicetree/bindings/riscv/sophgo.yaml          |  5 ++
 arch/riscv/boot/dts/sophgo/Makefile                |  1 +
 .../boot/dts/sophgo/sg2002-licheerv-nano-b.dts     | 54 ++++++++++++++++++++++
 arch/riscv/boot/dts/sophgo/sg2002.dtsi             | 32 +++++++++++++
 5 files changed, 93 insertions(+)
---
base-commit: d20f6b3d747c36889b7ce75ee369182af3decb6b
change-id: 20240515-sg2002-93dce1d263be

Best regards,
-- 
Thomas Bonnefille <thomas.bonnefille@bootlin.com>


