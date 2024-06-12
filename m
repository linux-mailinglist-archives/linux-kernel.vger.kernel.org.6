Return-Path: <linux-kernel+bounces-211134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC537904D90
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 789D22834B7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27B716D4D7;
	Wed, 12 Jun 2024 08:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MN8o7Vl2"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D644C63;
	Wed, 12 Jun 2024 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179556; cv=none; b=FBgK7kSTXQD+/CC4esgbNpN7sSUAr2PfdFAzNp6CEN5B1Gm43QnBZLB2S1HX6O8cIR/lnLTzJi1dIuURitwG3gAlpHlnclvEaqwRkfWM9ejEFjdKPPjw7kbLx6z1Mrv2Ds3HNy1m+GTfCapZa7I9LxigpqOz1djgpYJTjB+DfbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179556; c=relaxed/simple;
	bh=ILMmRiEWEHiNzb+Y3ER63eIFBqheUFPGk9Z0aGkOnD4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L7KM0pqPD/Vpak7eA2MR2QTn8SNJUhKEZzXEdRm7w2JaqQgwJOYvxMSxB0VM3//qGJytaWUMXGwLXHjCDtXVnSVeuDiGlhqgHGg762T3mY34ske8p/7BEculvibU2R6lUefovvhUHeNZmS89eqCftqvY6jw6N97P29sU2xsfs3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MN8o7Vl2; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A63491C0006;
	Wed, 12 Jun 2024 08:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718179551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sg5LM5Q0y/4zk083q4HytJVsSyW8T6Yex1MqFIcsA54=;
	b=MN8o7Vl2jEVH+2RAPqLd9I0ScNO9Bva28Ct0IBruzcfox3+rztCaK8yyf6TofSJgReNXLv
	H+8LGAUhaLjVHbQyLrxC5+Uj5rFyvzlAkBb9y5XUcEUlb7uCIFUqp6iPJCTVUhlUOSBoB+
	MtmpEQBKjVuWp7jW1sSd8O000nLD1akvx3BcimTRL1F7EViqNtVN0GHuu+k7hH6O5vg/8R
	bfh0u0Ri3yD6R43Z21+SogfFMycFFKQkSbTPb/QGpxAvXS8EzAm0GcgOjEgpy7+/f++Hcr
	Ac6udX2FM4oPh03LnFs7obSCBKvkOU6IwDTRi5Rpa7JPAm+Gy+5x67/mfNY8pg==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Subject: [PATCH v2 0/6] Add board support for Sipeed LicheeRV Nano
Date: Wed, 12 Jun 2024 10:02:30 +0200
Message-Id: <20240612-sg2002-v2-0-19a585af6846@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABZWaWYC/3XOTQrCMBAF4KtI1kYyk/6krryHuGiSaRvQRpJSl
 NK7m1ZQirh8w3yPN7FIwVFkx93EAo0uOt+ngPsdM13dt8SdTZmhwEzkkPPYohDIK2kNgcVCamL
 p+R6ocY+16HxJuXNx8OG59o6wXH8qRuCCS9uUCmolMgUn7f1wdf3B+NvS+QYoN6DSkOkKVKXq+
 g8oNwB0YbRUhlSTbcAyc8TvtALEB2KChFJb2RRWinIL53l+Acs6jc85AQAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
 Chao Wei <chao.wei@sophgo.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: thomas.bonnefille@bootlin.com

The LicheeRV Nano is a RISC-V SBC based on the Sophgo SG2002 chip. Adds
minimal device tree files for this board to make it boot to a basic
shell.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
Changes in v2:
- Add SDHCI support
- Change device tree name to match the Makefile
- Add oscillator frequency
- Add aliases to other UARTs
- Add aliases to GPIOs
- Move compatible for SDHCI from common DT to specific DT 
- Link to v1: https://lore.kernel.org/r/20240527-sg2002-v1-0-1b6cb38ce8f4@bootlin.com

---
Thomas Bonnefille (6):
      riscv: dts: sophgo: Put sdhci compatible in dt of specific SoC
      dt-bindings: interrupt-controller: Add SOPHGO SG2002 plic
      dt-bindings: timer: Add SOPHGO SG2002 clint
      dt-bindings: riscv: Add Sipeed LicheeRV Nano board compatibles
      riscv: dts: sophgo: Add initial SG2002 SoC device tree
      riscv: dts: sophgo: Add LicheeRV Nano board device tree

 .../interrupt-controller/sifive,plic-1.0.0.yaml    |  1 +
 .../devicetree/bindings/riscv/sophgo.yaml          |  5 ++
 .../devicetree/bindings/timer/sifive,clint.yaml    |  1 +
 arch/riscv/boot/dts/sophgo/Makefile                |  1 +
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi            |  4 ++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi             |  1 -
 .../boot/dts/sophgo/sg2002-licheerv-nano-b.dts     | 53 ++++++++++++++++++++++
 arch/riscv/boot/dts/sophgo/sg2002.dtsi             | 34 ++++++++++++++
 8 files changed, 99 insertions(+), 1 deletion(-)
---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240515-sg2002-93dce1d263be

Best regards,
-- 
Thomas Bonnefille <thomas.bonnefille@bootlin.com>


