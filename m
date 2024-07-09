Return-Path: <linux-kernel+bounces-245595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB12092B4BF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74D5528630C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28E315746B;
	Tue,  9 Jul 2024 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e9QnOj3P"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BDB156227;
	Tue,  9 Jul 2024 10:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519649; cv=none; b=H8/1ovfsB4ftQVSp5OUkj7vZJgrFaUD+uJfYqxZE+bo5TZHr5uJkrBynIvic9mWPHBQpQMKeyN5nhL9TSSVxSFkkGOJDSSDdhgzyvPMB2Yxwxi8O6suhY+KTSIPm/MZsNa1XqVjscuCJpmh2TCwZZPEg3pqM+UyEr/Umk6xDvH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519649; c=relaxed/simple;
	bh=1a+bTKnj8ApQ06Lj+M1ytV2aJqRaVFyoDB7EC0FNRvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VuHvVD3vPJKVJXeJouy5cODgRnVUW4PYUTj3Kb/wDqZkonwamcX69PirsqzsP2FTlDOpdcFcgrW17DSjplySUPB+3neBKPxm+DUVU7hOeidntY3J2khxGPmGW/Xi6V/H5tOV2periSl1MqhjR9fmMX061K2i9nNJNXl067oS7gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e9QnOj3P; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ADE6A4000B;
	Tue,  9 Jul 2024 10:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720519645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/w7M59pSBoTLmuYsPNPpvNrtu9Q1tqeATXTtEpzNo3U=;
	b=e9QnOj3P2IYvXdIHDZTu36nzAJe87gBXCwPaHQfNFGmy9EpRrVQ2tA1wQEmF3TJENmi8sk
	bhH+AlR4tjb+f55ctDBHyJH6d+iM0Q3C76AdNjtYkeSdafBJ+NDRoAsokyojmcrBRysW2v
	jPDhl5BnIEkdMncsgD9QUkdlJ859M76saCPzKBShiofsw6jrkc+wN35LXtqhmEkj24uWeU
	sK3C8qFjeQhoo2fjhaPR5TtMyVHg73QfEOui+9eO2mPhTZkCE0nVVOQTJ+ykUSZ8tduHUt
	JyGUWgWH8iqUvRHqTG4hS6F4dQsslkhbRFovwTmxUO6rbh/FwV6DnVudWd9dUQ==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Tue, 09 Jul 2024 12:07:19 +0200
Subject: [PATCH v3 4/5] riscv: dts: sophgo: Add initial SG2002 SoC device
 tree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-sg2002-v3-4-af779c3d139d@bootlin.com>
References: <20240709-sg2002-v3-0-af779c3d139d@bootlin.com>
In-Reply-To: <20240709-sg2002-v3-0-af779c3d139d@bootlin.com>
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
X-Mailer: b4 0.14.0
X-GND-Sasl: thomas.bonnefille@bootlin.com

Add initial device tree for the SG2002 RISC-V SoC by SOPHGO.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 arch/riscv/boot/dts/sophgo/sg2002.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2002.dtsi b/arch/riscv/boot/dts/sophgo/sg2002.dtsi
new file mode 100644
index 000000000000..4ca4e47a74e7
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
+	compatible = "sophgo,sg2002-dwcmshc", "sophgo,cv1800b-dwcmshc";
+};

-- 
2.45.2


