Return-Path: <linux-kernel+bounces-252263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0BF9310BC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D0C1F2112A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830421862A9;
	Mon, 15 Jul 2024 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0BxBChq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B37185E5D;
	Mon, 15 Jul 2024 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721033961; cv=none; b=JHOpq3nDbdNYceL/4QgtdbynHRUEzZTPrSTV830LBevb3hLj690P0ouO6Wdu7WqXv48WjG83jWFCjIG8FTq+3qqSl9wvgX9G1uM3mDNEG0da4IYfa8w1RHRY/IM41QM3f9wGf/eyYugp8m9aqZUK5wK2UYQF7DwzVFPwChgEA1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721033961; c=relaxed/simple;
	bh=wmZGgge85Q8CYqbZQFHFPVFmynDO5FkI+xVqMHo6QG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BiYn/AVttep91Cq2JEOIgoWnxL1pmAT8Ng54yCULaCntstKHBhZEWbgToLZmxmm8hvWBEbLBDzqvA8SDkhz/WhBwMDCZI1OUlKUlLfj+S2KGXB9HB19+/Jdo9I12MiGoQmSKpy98z4pTXTNDPitmgZfDnGmm7/AJoApFtZDh2S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0BxBChq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8327BC4AF1A;
	Mon, 15 Jul 2024 08:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721033961;
	bh=wmZGgge85Q8CYqbZQFHFPVFmynDO5FkI+xVqMHo6QG4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=C0BxBChq6OdgSVELJx0/VsmZk5XhTBkhcGqw+ch1dN2vWA3sbi3fNk9Cvpa63oIac
	 IFjzexFRH60a52CyibxiuLY1nza5+IQ39ihe3F1LjibQQ2Xb+74pbKJ///j6kjktH3
	 KHfER/vOZLsY5mxkahTV6/BG4EyxZLyjuCj1oq88Ek93JBFhikQIrDTbKyKBdkKiJv
	 D99nFD7q4uZqNrMgJ5qJXHzJXyJ5stRIqFH+5fgF0OAGVXWzY/bImHNyTtp+w6dJAm
	 j/gjTETgRWD5Wjh5Drwevk4Zz485Pj/qrNacpmD/WhkwTqy+bOj7AQOcK/HJJFD4WV
	 Ot/fCWFA6deqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76434C3DA5D;
	Mon, 15 Jul 2024 08:59:21 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Mon, 15 Jul 2024 16:59:22 +0800
Subject: [PATCH v2 4/6] arm64: dts: amlogic: c3: add ao secure node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-soc_info-v2-4-3836c8cc27a5@amlogic.com>
References: <20240715-soc_info-v2-0-3836c8cc27a5@amlogic.com>
In-Reply-To: <20240715-soc_info-v2-0-3836c8cc27a5@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721033959; l=1017;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=pjY4KC1fe2AmkCqstiXeLGWqLV1HNwoDAqmTzk6+a3Q=;
 b=RII61pRiQ3eExWxOca40zgebKBhZyKovGqTyN7yz7Oqslr65rO7JHjZphrFnJvc3S1RUj7Sfy
 s/b2ehfaew6AVBqMQ7oME0iNuGj9yYTyKs3zsFc7b7/s9LSx86kh3ot
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
 arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
index f8fb060c49ae..c913dd409e64 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
@@ -129,6 +129,13 @@ uart_b: serial@7a000 {
 				clock-names = "xtal", "pclk", "baud";
 			};
 
+			sec_ao: ao-secure@10220 {
+				compatible = "amlogic,c3-ao-secure",
+					     "amlogic,meson-gx-ao-secure",
+					     "syscon";
+				reg = <0x0 0x10220 0x0 0x140>;
+				amlogic,has-chip-id;
+			};
 		};
 	};
 };

-- 
2.37.1



