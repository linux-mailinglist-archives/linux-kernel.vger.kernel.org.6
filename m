Return-Path: <linux-kernel+bounces-337102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0247984562
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4C61C227C5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEACD19F461;
	Tue, 24 Sep 2024 12:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="QuHHnZmK"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CEF1A7065;
	Tue, 24 Sep 2024 12:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179256; cv=none; b=GvXmHje94KnsUYxY7oxkhYzHAbCIRCbUJniJbkTcfvttZlVbDOjM1WEvOArSRboo9b2xGzKUoHmjfogpwOVs/aDaI50WisqDBrEqtWEFw1ys/UkKY9IboH68+Anjr5qwrCexDcIV7QyCVn9TPsXv3hyqrPcZd7cUVmM8vkR7Upk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179256; c=relaxed/simple;
	bh=pZtEHuroQ3lImXKIkOrOFDdvY//VNDZOb08qRCaADKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Na9Qa5FiV4A+wwxuSH7Zn875i/Md03GIA/oI4y0deVTvENnMP3E07VmN8M0jdJfM0n6dhuVG8E7/2g27os2RXOv+6abxAifB9tyWP0A/eekEKFgpqqh2LuGr/dxKuWGfrpNzkYJsHPvhM40ov2HIftDJ0bp9OEMLwWoxj8CfOUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=QuHHnZmK; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 8C7291FA77;
	Tue, 24 Sep 2024 14:00:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1727179252;
	bh=MtzPmwKAbHgGy1gd3FKq8h1DiCbQ/07mXflFH/Co0EI=; h=From:To:Subject;
	b=QuHHnZmKVQY5n7s6Q+0AzGHOI6IA0iLru/VoqtiemdMzB5ahuR0M8xe1QkgX7vY0a
	 P9R4jimwkU4NvCiCOwYUNI1p5+vEv38I0SPHhgk66XXZkOs+18QXZupHLHsLRkABrz
	 QIvlfu+f81Cq/R/HdsWsyXVdXYeli0wLD8B+6s4xOhYh0SZlvD0g7PobIFIRtQb8Ne
	 kF76nHT2TYS5Llvc5U1ZGvDioCM97qjQ1FiS1xqcaGHjeg5SsppYpU9Y7+sLoVSXFD
	 GwUuAWV29BqGl5H9pC/k9miEW4hQDTL4cX8EAOFcwe+bJaOfUgrmyTUy4PJugHElBl
	 EysIz7awfw57w==
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 2/3] arm64: dts: ti: k3-am62-verdin: add label to som adc node
Date: Tue, 24 Sep 2024 14:00:43 +0200
Message-Id: <20240924120044.130913-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240924120044.130913-1-francesco@dolcini.it>
References: <20240924120044.130913-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

Add a label to ti-ads1015 node to make it easier to reference it
from other nodes.

Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index 5bef31b8577b..7b63eb0287af 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -1219,11 +1219,12 @@ sensor@48 {
 		reg = <0x48>;
 	};
 
-	adc@49 {
+	verdin_som_adc: adc@49 {
 		compatible = "ti,ads1015";
 		reg = <0x49>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		#io-channel-cells = <1>;
 
 		/* Verdin PMIC_I2C (ADC_4 - ADC_3) */
 		channel@0 {
-- 
2.39.5


