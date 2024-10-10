Return-Path: <linux-kernel+bounces-359405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A696F998B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA7D292580
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57001CEAAD;
	Thu, 10 Oct 2024 15:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k+cy53q3"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6A23D3B8;
	Thu, 10 Oct 2024 15:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572898; cv=none; b=Vv0YuvAVG6f4vn1kY1i8+oz1FX+9+vRNkvdmiqsAJiyearslgzaT7axGp5JOvi7aYEIZy4fyxgngg3Gwyn0aJIST+lcSGi5xgC4Ea7yeHLuSJ2s2T0Qu/EL3ulHlKMP+dw2tyrMeLA+yhGdKpKlsUub6XWSirKzaMDQCkyWwYWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572898; c=relaxed/simple;
	bh=dLosNywBJ7Lee8nOYYUpr4AQkUC/E5LusguNX8FFw4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pAosjvsaBRU99+PuGNtaIx3HDd5TiME9mTCMA6+wwXnDv0Eu7a8jS3kr0iaKwvyGm1tDcyjviQJ+NATALEz3cvjMOUUrerP8oLcxhWL7eTwiYEhjWK9B7+1F0yiXescY5jPg/FPI8zhP4h4EAb6Deu3WC82FNeSZRrCbXQLZB7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k+cy53q3; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E519E1C0002;
	Thu, 10 Oct 2024 15:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728572887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fqdCRYpUpWtmxoATzqfKvQ7Vf09Tqe7FVeasQf33ud4=;
	b=k+cy53q35OLyFbTyFYBQ//jALk6PBH18DJpyH2sY3ts1iHjqaQpo12zEsbCxXiUG/YrsTu
	e4iFSkNCYc3b+NtEhgo0C4+71izV7bw2LqHhpvW9LJHDczV5nwSd0VYobDkIXfOHIZKr66
	/sskHOK9GXisLmywEEaCY86/oTE9j7mmp5h9fHsovbKW0hKWAxni5JWJsB0KHhPBkFsHuy
	BEr5Zy9aciD8Y8P8rO3+lb+bbEaM90ahS6hdgSSbOnaFFJzZTde/uPRXSyuW8Q2bq6Nh/g
	7kq5/3OUkQu4WKZtI78oJVe5asnlrkEo+c5T/DH+qGQqDr8B3gbt2K9AdtoxiA==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Thu, 10 Oct 2024 17:07:06 +0200
Subject: [PATCH v5 1/2] riscv: dts: sophgo: Add initial SG2002 SoC device
 tree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-sg2002-v5-1-a0f2e582b932@bootlin.com>
References: <20241010-sg2002-v5-0-a0f2e582b932@bootlin.com>
In-Reply-To: <20241010-sg2002-v5-0-a0f2e582b932@bootlin.com>
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

Add initial device tree for the SG2002 RISC-V SoC by SOPHGO.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
The commit adding the bindings for the compatible "sophgo,sg2002-clint"
has been applied to Daniel Lezcano git tree. This commit may trigger the
bots because of this missing binding.
---
 arch/riscv/boot/dts/sophgo/sg2002.dtsi | 42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2002.dtsi b/arch/riscv/boot/dts/sophgo/sg2002.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..242fde84443f0d6a2c8476666dfa3d72727071b1
--- /dev/null
+++ b/arch/riscv/boot/dts/sophgo/sg2002.dtsi
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2024 Thomas Bonnefille <thomas.bonnefille@bootlin.com>
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/pinctrl-sg2002.h>
+#include "cv18xx.dtsi"
+
+/ {
+	compatible = "sophgo,sg2002";
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x10000000>;
+	};
+
+	soc {
+		pinctrl: pinctrl@3008000 {
+			compatible = "sophgo,sg2002-pinctrl";
+			reg = <0x03001000 0x1000>,
+			      <0x05027000 0x1000>;
+			reg-names = "sys", "rtc";
+		};
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
2.47.0


