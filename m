Return-Path: <linux-kernel+bounces-248931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A86AB92E401
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4231BB23C54
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2B4158DBE;
	Thu, 11 Jul 2024 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HnfizYzz"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667091581EA;
	Thu, 11 Jul 2024 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692105; cv=none; b=tCPBbunkvEUL9HfRx7zEmUDAUjYkC2c8nsLvMBY6qa4qzrqD1bciP6AA8jD9O4cerY1J5fhYl9dLPp0MoOg7DkTzdKNyAo8a9QjyIrQVQbMMF0AQ4S3qKPhVJRxgDG2nUmYkTDjtT+SVUA30wdgtZ6S6smE/PdTls8wtrX4+fMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692105; c=relaxed/simple;
	bh=gC84RJ8h2bYZEQbPbgRWN83u3kUOLEVOu1SVtb/IzV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IhZs6YP5NsKLJxeAv5f7mVzYVcKvrfFWUHuIVnYWNxDm2Dq2znGKO3At0apKetoa1LucwpK/CcjvhVSi20/LlrblU2vyX/pNqouPUEscHBcEOP4HL+T10k6FHVuKVsmY+i4P/KUKoKWbXEGuA6sG7vPaiFvE4Q4lsuGH8ANUa/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HnfizYzz; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 574C7240007;
	Thu, 11 Jul 2024 10:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720692096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BPkEiyyZXaXaWAKf4yoZh+8s32yqaBI0vrIZ56akVFE=;
	b=HnfizYzzYdSlmjzV8cvPB598TUaOqyEyaPnDoVpZ/W9wwSXPE9IoBNuELZtaBgF3fUhJ8K
	54cANzKBnZZUh/Eb74GZfRDNH1S+VyNM3Vu25YJJILZMWrjdTsO8b5pth58NrZwga0YMD4
	2W2nVt05Wpng6eORsmbwkZGqBDcbq0G9PQ/catMcaDFKXVxrM9/mArCymKTxl247Zc4GVb
	mXnJh4QQvhjFawGjE/pzjndIlJiyJkE8P5HIKzZ2LzgBeMfy17AqlMwRzftwdU/vM1E0DV
	IWzgtnJtSY/7ZEzSZZ2/KMoxRld9l7Srl0zgTqA+/cCLqrSVBC8svkU/ZJasiw==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Thu, 11 Jul 2024 12:01:30 +0200
Subject: [PATCH v4 3/4] riscv: dts: sophgo: Add initial SG2002 SoC device
 tree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-sg2002-v4-3-d97ec2367095@bootlin.com>
References: <20240711-sg2002-v4-0-d97ec2367095@bootlin.com>
In-Reply-To: <20240711-sg2002-v4-0-d97ec2367095@bootlin.com>
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
X-Mailer: b4 0.14.0
X-GND-Sasl: thomas.bonnefille@bootlin.com

Add initial device tree for the SG2002 RISC-V SoC by SOPHGO.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
The commit adding the bindings for the compatible "sophgo,sg2002-clint"
has been applied to Daniel Lezcano git tree. This commit may trigger the
bots because of this missing binding.
---
 arch/riscv/boot/dts/sophgo/sg2002.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2002.dtsi b/arch/riscv/boot/dts/sophgo/sg2002.dtsi
new file mode 100644
index 000000000000..22eb99d1abf7
--- /dev/null
+++ b/arch/riscv/boot/dts/sophgo/sg2002.dtsi
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2024 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "cv18xx.dtsi"
+
+/ {
+	compatible = "sophgo,sg2002";
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>;
+	};
+};
+
+&plic {
+	compatible = "sophgo,sg2002-plic", "thead,c900-plic";
+};
+
+&clint {
+	compatible = "sophgo,sg2002-clint", "thead,c900-clint";
+};
+
+&clk {
+	compatible = "sophgo,sg2000-clk";
+};
+
+&sdhci0 {
+	compatible = "sophgo,sg2002-dwcmshc";
+};

-- 
2.45.2


