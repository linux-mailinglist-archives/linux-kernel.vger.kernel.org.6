Return-Path: <linux-kernel+bounces-250260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F3692F5C5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A421C21257
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD6A13E03A;
	Fri, 12 Jul 2024 06:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6sRShau"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924F913D606;
	Fri, 12 Jul 2024 06:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720767290; cv=none; b=XvLsP3+LkFnDdsHwtDpjBP4hEIB0UArgvsqsVxOJsY2vNaQsJUOTymuZt4s0Mrpo27sh5CShXf2A/OdwQV6pcTKZHHKAuU8PydtFv8PZDKATJDh5exAEYyli1uBT3Ag4qNFWIoY2bbIme8Nh7E7006mzrGBsrWLVub8NF4oPgKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720767290; c=relaxed/simple;
	bh=AU9KTXadbxI8oIBrYquNcFFE218xKds4EJiKkSzo9PE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U80D17WbgX9kyp8TY5bIbrghLoikXNwribKNk5e40CysToRgRgwZvLTAOeUWHG3pngli7UaK852Zq2g3QMIMb7lwV1W2/y4HG6YURXj/hPd/bCBplk38jkEAPLMrfimBI4UTN33rKPghUq8tH6+kdWqTJjdd1qqNmpC72G0eP60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6sRShau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37B2FC4AF0B;
	Fri, 12 Jul 2024 06:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720767290;
	bh=AU9KTXadbxI8oIBrYquNcFFE218xKds4EJiKkSzo9PE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=d6sRShauuPv/QMI0alTwT7hy2a2fUGv5+9Qa7jbvCjMe1BO5Yxyey6XiaIxUEcE3k
	 VDAp9AR8L8ntFg1ceGUZjR+szaBnkraoEFNht1mgm47J9SixnA1Vf9LjsFbszIp/0z
	 608aa+bJM3DicBahLXQ/pDtPwNZEj+t0vwnKwZ4BpXQ9//LJcR6U9tSy8NQfIEE2ih
	 /KBvpXaJBze3oVfjNYT45M/1EOylA2SrEgTsu/GNavrQpKwG4v6uI2fRDcxOzM5mek
	 B/yCvyrH58/mXFQFfGjhirJYZAtVaUMB+FLFT/fOlDOE/NgHtrwqy8GtR3GpJJaoOQ
	 BMQSE5h6BlMOA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2225BC3DA52;
	Fri, 12 Jul 2024 06:54:50 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 12 Jul 2024 14:54:48 +0800
Subject: [PATCH 3/5] arm64: dts: amlogic: c3: add ao secure node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240712-soc_info-v1-3-05ba95929d5a@amlogic.com>
References: <20240712-soc_info-v1-0-05ba95929d5a@amlogic.com>
In-Reply-To: <20240712-soc_info-v1-0-05ba95929d5a@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720767288; l=967;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=Vo92QkR7KttBJIDyNMyI82sWcd31gahBSNFC4bI9l+Q=;
 b=65es6tnxvyljk4Wr5boKxighjBwUeJysMTyc7FjzOhbQ0iyt56Mynu3k2WDIhJul2JJWVjDDf
 mWLWufJGuw4BR9YMOafe5KQesRryXb+FbSh/OgoxIug5MN1Msq//SE+
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add node for board info registers, which allows getting SoC family and
board revision.

For example, with MESON_GX_SOCINFO config enabled we can get the
following information for board with Amlogic C3 SoC:
soc soc0: Amlogic C3 (C308L) Revision 3d:a (1:1) Detected

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
index f8fb060c49ae..d6a94c828fd8 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
@@ -129,6 +129,11 @@ uart_b: serial@7a000 {
 				clock-names = "xtal", "pclk", "baud";
 			};
 
+			sec_ao: ao-secure@10220 {
+				compatible = "amlogic,meson-gx-ao-secure", "syscon";
+				reg = <0x0 0x10220 0x0 0x140>;
+				amlogic,has-chip-id;
+			};
 		};
 	};
 };

-- 
2.37.1



