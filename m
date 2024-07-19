Return-Path: <linux-kernel+bounces-257071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 261FE9374BF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76FB282315
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAF084037;
	Fri, 19 Jul 2024 08:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MO8yXfip"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D1869D31;
	Fri, 19 Jul 2024 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721376492; cv=none; b=ZTlC0yr8JyeFgynJJ0L3UcsMdP3/Z3OxdzOe+uYCW+H4Qo+4GeM2vpqg+KhlsAEgpQHa3NgT4Vrp4GucjTxlWcd6KuHmXhzAbe/6Y9I9on7dBbNqR1id6OMHRcV6Wrihd31oMC72chDfNcr270byxFSeXtfb2c3wXf+f0w3HfWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721376492; c=relaxed/simple;
	bh=4MDbIzbgcDxHoNJ3qQdw4vdK4aOodPlMv8exrJKFJK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n+aYgmYcGkqdvGCoIRvzx8tlu7nJlwVDeMjVyW+SId9QPDnQ7r49PEX7kncJ8wmz+rQhO7/uDuyh4ZwisIce3psZrrFr50UoZsSHyXnXTzjVJlitfuZA/0yaxWvgc24ZJ1z2TVnOE4A99NoH72hm3LYOUZZhIVRvugyWTJsrk5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MO8yXfip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52ED2C4AF16;
	Fri, 19 Jul 2024 08:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721376492;
	bh=4MDbIzbgcDxHoNJ3qQdw4vdK4aOodPlMv8exrJKFJK0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MO8yXfipLHFrNtLYjbaf9lQWunBqXUtGNJ75Voo67WlxuhKiHTcASgtN5JrHC5t50
	 na943o1s4dHa0TP3lEaEJZn5oorpq8yvv6JNM2g9NItxhcRCicNaVkm45aUc5l+Xth
	 o0eA6hVQYUnQrJgzDiPCGiV2tED8+n4zoPTPURzRmMN1uPzQXmVQxRo0ut0WZDFlSB
	 Y7Syz2qdl0HiMlNngF40GhxBsDfPyBckOtGkVOHdvD7bxXX2ckFUbu0oYvWJ+fiQlY
	 O20wDwWEk1XyUaF5EvpPqQJL2YsxvARbZin1EbqZl8yh05im9TLwktFu+zFqdSJg9H
	 ptxbohn3Fe/Cw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E89C3DA7E;
	Fri, 19 Jul 2024 08:08:12 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 19 Jul 2024 16:08:13 +0800
Subject: [PATCH v3 5/6] arm64: dts: amlogic: t7: add ao secure node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-soc_info-v3-5-020a3b687c0c@amlogic.com>
References: <20240719-soc_info-v3-0-020a3b687c0c@amlogic.com>
In-Reply-To: <20240719-soc_info-v3-0-020a3b687c0c@amlogic.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721376490; l=1056;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=X8apXJPtSL4pC+EPOExwu5CekUwHZ9o11FW6DgwjmrM=;
 b=3JFRpb+37yakNpqi576ecStgHlK3dSYpZKqSqVkN/MTunWTuIFGZ/JRJsibj7DnJ+vegL9RAb
 bJvhzMen/p8Dx/7ldGQpzIiEYGnVB3quKLVAHf0RXOlviF+abDl4GvI
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
following information for board with Amlogic T7 SoC:
soc soc0: Amlogic T7 (A311D2) Revision 36:c (1:1) Detected.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
index c23efc6c7ac0..ec743cad57db 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
@@ -194,6 +194,14 @@ uart_a: serial@78000 {
 				interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
 			};
+
+			sec_ao: ao-secure@10220 {
+				compatible = "amlogic,t7-ao-secure",
+					     "amlogic,meson-gx-ao-secure",
+					     "syscon";
+				reg = <0x0 0x10220 0x0 0x140>;
+				amlogic,has-chip-id;
+			};
 		};
 
 	};

-- 
2.37.1



