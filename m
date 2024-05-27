Return-Path: <linux-kernel+bounces-190426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 642B48CFE18
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19931F23321
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D7E13BAC2;
	Mon, 27 May 2024 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m0fCSB+5"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CB313AD30;
	Mon, 27 May 2024 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716805714; cv=none; b=MiQl5bE8J1XC9xK/sq5R88ouvKKJTEX2Srs7knMJIr4Vj3YhSuUjB5HHXLq/IM5NKviWCYpL4mKldYSkfpyHGxmPkxEYmTCNFCrFROLyP5jtud6J/xrvdIIXlhtWAXHeTrppHNzcx5bJmnqfh2ArDZY4bbyVqghn3oerMxJzOoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716805714; c=relaxed/simple;
	bh=VxDkjXax1dNEcf7FIhYKk/a3hDYgRDjG3ul+ExcRflg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kE1GqcuAPGNvGzyAIhANqb0A0hfAhkwzze0X5iT/jBiIFZmrGBL7rtxpO3P3rLYCJqiXSt4i4oUws2EFFZCM5E78qh9rrYdDx528/O7X+rEiuY3BXdSBETOh40QVUj4hxX9rtD8FVyFaCMKmP5NT3VJJg08rmNaPFxqk2kMqfzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m0fCSB+5; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0939820002;
	Mon, 27 May 2024 10:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716805703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o2JkCu5S8+OBPOsITVx8O3C/4guU5WMG69zDVPIwu8s=;
	b=m0fCSB+5uL85vkJ+q/iodGnOf8HDGMxdrM8GTeoFslZS+5ZQ6MO+5IdHC0pgV4lfsaBm/x
	iYYNu/81TzADxnuR7Sjmy4/GA5JS9ihaSb50RC9p8dCVw98viVHcWYRdROQ6y8LqII3ZoK
	hxyoYSgK/eiYgPLpDNzKcKO0BmdKET8ennbKZKF6q9n5KrTktskQh08da003Ws2OOsYNiW
	Fn6qXKMqdpl/+HyOHRt5iWLXCP34pEM4HyI18AuyEv+u78+9/D9kWVINziq5cmBHo/U0sD
	hMR54ARBgjb/LEIa4pO37/4RQv3kbew0sSp1tZDhAtvMM896vEfggf1HrdSMBw==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Subject: [PATCH 0/5] Add board support for Sipeed LicheeRV Nano
Date: Mon, 27 May 2024 12:28:16 +0200
Message-Id: <20240527-sg2002-v1-0-1b6cb38ce8f4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEBgVGYC/2WMwQ6CMBAFf4X0bE23BW09+R+GQ0sX2EQpaQnRE
 P7dgificV7ezMISRsLEbsXCIs6UKAwZ4FSwprdDh5x8ZiaFLEUFFU+dFEJyo3yD4OVFOWT5PEZ
 s6b2HHnXmntIU4mfvzrCtf4kZuODKt1cNVotSw92FMD1pODfhtTV/glQHwTgonQFttLUHoV7X9
 Qv+G/9/zwAAAA==
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
Thomas Bonnefille (5):
      dt-bindings: interrupt-controller: Add SOPHGO SG2002 plic
      dt-bindings: timer: Add SOPHGO SG2002 clint
      dt-bindings: riscv: Add Sipeed LicheeRV Nano board compatibles
      riscv: dts: sophgo: Add initial SG2002 SoC device tree
      riscv: dts: sophgo: Add LicheeRV Nano board device tree

 .../interrupt-controller/sifive,plic-1.0.0.yaml    |  1 +
 .../devicetree/bindings/riscv/sophgo.yaml          |  4 +++
 .../devicetree/bindings/timer/sifive,clint.yaml    |  1 +
 arch/riscv/boot/dts/sophgo/Makefile                |  1 +
 .../boot/dts/sophgo/sg2002-lichee-rv-nano.dts      | 25 ++++++++++++++++++
 arch/riscv/boot/dts/sophgo/sg2002.dtsi             | 30 ++++++++++++++++++++++
 6 files changed, 62 insertions(+)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240515-sg2002-93dce1d263be

Best regards,
-- 
Thomas Bonnefille <thomas.bonnefille@bootlin.com>


