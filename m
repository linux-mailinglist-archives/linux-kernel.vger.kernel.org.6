Return-Path: <linux-kernel+bounces-543266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719DEA4D39A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9876B1897879
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAFF1F4734;
	Tue,  4 Mar 2025 06:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvR5k2Ej"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD2B17C7CA;
	Tue,  4 Mar 2025 06:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741068967; cv=none; b=JNbi7z+uhgvlFqBEkzyAEmXZClykjywinzyrrAgT9uJlX/2xXTh2FxLGLdO9MHrfUSk8dvAQWW8XUKkdywR3sH9T/dAQWi6vADdoGSi5VBHfOlalpF8Fldx2mvACgHiKIeiIs6LJOo2mfneWKFHEqXmfDnpZn9Uq1YKGDwZqNIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741068967; c=relaxed/simple;
	bh=2gdXNj/tlPSSHbBqSwyfbWrKXXsk+K7ZabA7kS1I4Hg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BA1HM6DsZ7RfndjGwLSLpdbc6xgufQUT0QbgWzfjsYAYdNhqLO/C+oGdfrVTnu7uFXMf1q3Q2ruADOqLBsjo0Z24t9PCffUpHmsheL+yH7hU86jCplrzln7qhX3U3aFwGc0X3K7YO1NN9FeypG6g5nM+tILxbThH5YFGycHrhF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvR5k2Ej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58A86C4CEE5;
	Tue,  4 Mar 2025 06:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741068966;
	bh=2gdXNj/tlPSSHbBqSwyfbWrKXXsk+K7ZabA7kS1I4Hg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=jvR5k2Ej9EovxXEKAhyAqt6wzfek6yiFgrKTjBC3H0dDoJryDUY1jMGaWZ9pzp/p6
	 FXOMUQEOmaCQyxIVLzaxgttKM/KSCqtauWJeY67mrhmyIvbHZycrWK60nri/yvcbCe
	 luMGxaHnVPzp/TAkMqdD/pe3LXZFq053P4pttHwE1C6OAHJUGKtA223k8RYfEIToEw
	 ARogIPObwntyvJphpVNcftNFkM1avQr7DflXHPw2GEaIDJgbCf/USf+d0t9CKBVDa9
	 W1Zj8qlvriJKwFVFijgYHUJPqXpRNPhcMZgqXAQfpeqbi0S7plPIyTzgPQYyWUn5KB
	 TorNk+UB0oTLQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FA6C021B8;
	Tue,  4 Mar 2025 06:16:06 +0000 (UTC)
From: Nayab Sayed via B4 Relay <devnull+nayabbasha.sayed.microchip.com@kernel.org>
Date: Tue, 04 Mar 2025 11:45:40 +0530
Subject: [PATCH] ARM: dts: microchip: sama7g5: add ADC hw trigger edge type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-sama7g5-hw-trigger-enable-v1-1-61b5618285f0@microchip.com>
X-B4-Tracking: v=1; b=H4sIAIuaxmcC/x3MwQqDMAyA4VeRnA1kreLwVYaHVGMNzG6ksgniu
 1s8fof/PyCLqWToqwNMfpr1kwoedQXjwikK6lQMjlxLnjxmXrmLLS5/3ExjFENJHN6CTxco+Km
 hxjGU/msy636/X8N5XiSpX5trAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Nayab Sayed <nayabbasha.sayed@microchip.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=922;
 i=nayabbasha.sayed@microchip.com; h=from:subject:message-id;
 bh=eJnQC/9attKgZIiaANkEiYWZpDq4uolpOBt4ZgepDmk=;
 b=owGbwMvMwCEmfMj/xNz7ei8ZT6slMaQfm7Uk+2f+9iV2N1Y/lzcXr1/UvOdZyYt864Dq3CtHD
 7Zsfq6/sqOUhUGMg0FWTJGle/P82YZFfzozf3KugJnDygQyhIGLUwAm0n6f4X9R9DI532kSk8oV
 Nsuqv5cwq2CamaXu0ay/qfTGKVGnWlZGhvnHVbi/xlzIq//9k28qi9XuJ+YfEvaLFTSdlV+z/rK
 gBBsA
X-Developer-Key: i=nayabbasha.sayed@microchip.com; a=openpgp;
 fpr=E108A58C09FB2280B0AB41DAE24318EF3B3861A3
X-Endpoint-Received: by B4 Relay for nayabbasha.sayed@microchip.com/default
 with auth_id=304
X-Original-From: Nayab Sayed <nayabbasha.sayed@microchip.com>
Reply-To: nayabbasha.sayed@microchip.com

From: Nayab Sayed <nayabbasha.sayed@microchip.com>

Set ADC trigger edge type property as interrupt edge rising value.

Signed-off-by: Nayab Sayed <nayabbasha.sayed@microchip.com>
---
 arch/arm/boot/dts/microchip/at91-sama7g5ek.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts b/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
index 0f5e6ad438dd..2543599013b1 100644
--- a/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama7g5ek.dts
@@ -137,6 +137,7 @@ &adc {
 	vref-supply = <&vddout25>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_mikrobus1_an_default &pinctrl_mikrobus2_an_default>;
+	atmel,trigger-edge-type = <IRQ_TYPE_EDGE_RISING>;
 	status = "okay";
 };
 

---
base-commit: 99fa936e8e4f117d62f229003c9799686f74cebc
change-id: 20250303-sama7g5-hw-trigger-enable-82b0b3d4042a

Best regards,
-- 
Nayab Sayed <nayabbasha.sayed@microchip.com>



