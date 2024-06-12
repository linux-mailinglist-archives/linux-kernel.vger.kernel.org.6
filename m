Return-Path: <linux-kernel+bounces-211135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82907904D92
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 685821C245F3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E9816D4EA;
	Wed, 12 Jun 2024 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TsSjxCoL"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624FB45948;
	Wed, 12 Jun 2024 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179556; cv=none; b=dqH60cebZKbjJ9sfwkt8BOCx7rwl/69bK1A3NeU0mYt7EOrUZZZy6954A8oesXvYV3Ipl5epLm84UELMMwGiOQJpHaPtA3Ia2gQzhZO63RrYw938ThGsx9apdViiC3bHifQSTmeQemPvLK/SbpObjNdeU2SXj+rHWWH1lDoZX1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179556; c=relaxed/simple;
	bh=+yD8zK9+XjLMtfwamhcjq/5dyPTnT6qCI6yk+j6NyTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UxfqyE9C3NYRRK/R3FvWv7hHQe4OMdoVMSvJzEIa/ENtaCyp6WxLnx1WOmOe4e2knqSyBlK2hkcQsJKb30Y88wzfni3JiuzDTildU4LR/RuPwWoO2i5POUp8GqcejwL5FCnqfiMlA1COO/xtwLSFDMvpZ29rWrzMFap60OST+PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TsSjxCoL; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D48471C0003;
	Wed, 12 Jun 2024 08:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718179552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i1K8B2o5VvOLQkzF58aU6k+CVJVSICxBTxdSF8PhKqU=;
	b=TsSjxCoLHStaX8mNGaMC7L1mRtC5V5APx+wWoSTsGJ+zithm6AdRY/MoGi0QB1eFPRNWio
	ai4YJEfnAiv7JMw7oDYbXWWpYu4ph8oD2DPzaF8Cfo5k2QfrZ+nFYRtykEH8t97N5Bk2g+
	E9E3mCQpOR8UqNvfO0LcRg/8y1doJTeEI3vXu46icE0sywj59TDy+TMu8zBfTdKPW97ay+
	KVJh9NR1BpiTowh8qsz88yjjgq06z0vLTeAYQ2BRJffG1m4MBx2bwZGVl7G+CVjuNwJXNs
	tylrk35vnIwlknmqGM43is03m4iecRR5AOaSG/eNocrm7ufbmf3/YyfuB0V0Sw==
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Date: Wed, 12 Jun 2024 10:02:31 +0200
Subject: [PATCH v2 1/6] riscv: dts: sophgo: Put sdhci compatible in dt of
 specific SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-sg2002-v2-1-19a585af6846@bootlin.com>
References: <20240612-sg2002-v2-0-19a585af6846@bootlin.com>
In-Reply-To: <20240612-sg2002-v2-0-19a585af6846@bootlin.com>
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

Remove SDHCI compatible for CV1800b from common dtsi file to put it in
the specific dtsi file of the CV1800b.
This commits aims at following the same guidelines as in the other nodes
of the CV18XX family.

Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
---
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 4 ++++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi  | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
index ec9530972ae2..b9cd51457b4c 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
@@ -25,3 +25,7 @@ &clint {
 &clk {
 	compatible = "sophgo,cv1800-clk";
 };
+
+&sdhci0 {
+	compatible = "sophgo,cv1800b-dwcmshc";
+};
diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index 891932ae470f..7247c7c3013c 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -288,7 +288,6 @@ uart4: serial@41c0000 {
 		};
 
 		sdhci0: mmc@4310000 {
-			compatible = "sophgo,cv1800b-dwcmshc";
 			reg = <0x4310000 0x1000>;
 			interrupts = <36 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk CLK_AXI4_SD0>,

-- 
2.45.2


