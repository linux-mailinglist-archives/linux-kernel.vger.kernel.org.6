Return-Path: <linux-kernel+bounces-359404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE12998C54
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2EC0B39AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42281CC179;
	Thu, 10 Oct 2024 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PM4ZNOoe"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F20E1CB32D;
	Thu, 10 Oct 2024 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572897; cv=none; b=eVsYnCCoieyEKD4FCcUiSnVJmhRBCBfu2whuPnfHMf0OXSjMTHAk6OYHgzGK9BuUUlsHcVgvRIo2/039dqHRbdG3Nwx+BCEFqHGvPmsPNKXFMeM57yyrjHDUpGp4+cttPEbs4XuV1+EX/ys9xK6ql0mGvtJ7HUX71aIHVmZn95U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572897; c=relaxed/simple;
	bh=6v+/RVGVcBLms3pLraZ2kUfatU1nG8QxLPIYz8M4Nig=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IsvPecEr07IQp4e9oNDRnQtGgHY/YeqkfTrbyYUKfYGXBry20qvUmEK/dZGJXbnUZ7JM8v1dVLPBawBKf/RP8LoWgyGOm70GvUHRd11Dtsgb6n8HU1yhnrPew5LBJJ38bqZYxK8OhAy1oOb+mptA6NW75tnghwv8A0v03Ndt6XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PM4ZNOoe; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 560621C0009;
	Thu, 10 Oct 2024 15:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728572886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T5Jus8ME/eIiTNM0qUOv+UNXq09uP1fqmQJwoOm6oNg=;
	b=PM4ZNOoejV4UsJG2CsGMeundur1sZSQEGQnDzkWGlGmQM4FGIoWgke5FcxwRI495/oGndI
	FXAYJ6a/2hrbv5uc3V3O5InjlKXo5VFlMBhX1lgkvnZlmPqa2bWS5PKdFPWvFtkf6Co5qL
	A0HkXSw4no0Hh3x26WYEYlDsqCtzaul4H/pt+xEkGnjLdwji+AndCI1J5hzLrTqlDuLKON
	MX6MpH+1HoFQZRdsEDKCrEMFKzqu6sXRZWlVN5UrU7YwHo/5wKVVnhpJAEYxEfe422e08k
	L54ZfNc/pzMQwz2DkvyZy63ccPDdEUYtOxFjPrS6/S0aNsywfiMej+8Z5vuiQw==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Subject: [PATCH v5 0/2] Add board support for Sipeed LicheeRV Nano
Date: Thu, 10 Oct 2024 17:07:05 +0200
Message-Id: <20241010-sg2002-v5-0-a0f2e582b932@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJntB2cC/3XOy2rDMBAF0F8JWtdFM6NnV/2P0oWeiaC1ih1MQ
 vC/V07BqXG7vELn3rmxMQ0ljezlcGNDmspYat+CfDqwcHL9MXUltsyQo+ASZDcekXPsLMWQIKI
 in1j7/DWkXC73orf3lk9lPNfheu+dYHndVUzQ8Y5i1gac4cLAq6/1/FH651A/l84fgLQB1oPwF
 ow1zv0D9AaAV8GTCclksQHLmRM+TlPAV4gNJiQfKatIXP+5pAA3AKyTRrqsjFD7JXosaW5XSA2
 6rLUNFIFs3EPxCwKsUDQYrU4BSbVCuYXzPH8DxNQ4idwBAAA=
X-Change-ID: 20240515-sg2002-93dce1d263be
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
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: thomas.bonnefille@bootlin.com

The LicheeRV Nano is a RISC-V SBC based on the Sophgo SG2002 chip. Adds
minimal device tree files for this board to make it boot to a basic
shell.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
Changes in v5:
- Add support for pinctrl
- Remove nodes for i2c0 and uart1
- Drop dt-bindings patch that are already applied
- Link to v4: https://lore.kernel.org/r/20240711-sg2002-v4-0-d97ec2367095@bootlin.com

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
Thomas Bonnefille (2):
      riscv: dts: sophgo: Add initial SG2002 SoC device tree
      riscv: dts: sophgo: Add LicheeRV Nano board device tree

 arch/riscv/boot/dts/sophgo/Makefile                |  1 +
 .../boot/dts/sophgo/sg2002-licheerv-nano-b.dts     | 95 ++++++++++++++++++++++
 arch/riscv/boot/dts/sophgo/sg2002.dtsi             | 42 ++++++++++
 3 files changed, 138 insertions(+)
---
base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
change-id: 20240515-sg2002-93dce1d263be

Best regards,
-- 
Thomas Bonnefille <thomas.bonnefille@bootlin.com>


