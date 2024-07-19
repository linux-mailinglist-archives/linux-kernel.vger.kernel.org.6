Return-Path: <linux-kernel+bounces-257070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613AB9374BD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C81228208A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1B679B8E;
	Fri, 19 Jul 2024 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLzj7WQj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB48459168;
	Fri, 19 Jul 2024 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721376492; cv=none; b=CyhqxANahxkxrQ15AKOZ129+OYK5XtRzdZT3G5Wwn5gxF8TtgwOdbghqZfUPBP9gY3ZZFNMbo4GlryD2+jQXawDBYY6kcrU7u62dgjU7G2EptCqUd2jVwkOES3LW7g9CTkICHE5YNEJCvG6KBrl3OeU1XucS5eWoVXepbBj8Sac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721376492; c=relaxed/simple;
	bh=wmZGgge85Q8CYqbZQFHFPVFmynDO5FkI+xVqMHo6QG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SGZwK/5Fw24N8MD44K3JtPsyEnnj94r06Mfo+oMSXG5yQ15SnvD9RiGeJJ0f66IsKb1MqE6wBEu81ifkG321/mbNFWJMumtJ3ssf5cWtUgvjoUMnDoA8flhNaJF9UoCJeDBLF1VoDjN9pYuFuLD2hLCzGjBQh0CqbxUoUuwMQLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLzj7WQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 474EDC4AF12;
	Fri, 19 Jul 2024 08:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721376492;
	bh=wmZGgge85Q8CYqbZQFHFPVFmynDO5FkI+xVqMHo6QG4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pLzj7WQjNFxr35yAbxw+FdPWFa4m0iJQvAX2HEzVgMxi5VuPjHf23dLYYvh3o/hjo
	 gNMnJIwaYFb4Lt9dgYym2fHTamJ0MdIuJ2QFP4rd5GrPNu4+ob9khb+WfRzHahuLix
	 tiNw8lJ7VTQ7iT36i3pAcb/gc6YfydX3I/uaRczxGr/OIeFn0uhaQyheB1IdFv+sYN
	 Dgn8b+JsNoSEJjun2G8nNVQnSUtPaCP/XziU9HsDZBvIWlx0EOegweCLjFtDkz5M1d
	 OdsIkw1ETFw91eEN+auxncpyVNqsK7jUN4LEArOqdokgNuRMEr5Iwwk9M26Y+wFMO9
	 VCuCTU5S6mB6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37528C49EA1;
	Fri, 19 Jul 2024 08:08:12 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 19 Jul 2024 16:08:12 +0800
Subject: [PATCH v3 4/6] arm64: dts: amlogic: c3: add ao secure node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-soc_info-v3-4-020a3b687c0c@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721376490; l=1017;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=pjY4KC1fe2AmkCqstiXeLGWqLV1HNwoDAqmTzk6+a3Q=;
 b=bHvTWmXiHBmU+q49ecwX8p35+C3jGobQtof8DP85hlGnRkXv2LjMfT+Em8C2wrK3eMTHFgotQ
 KBgYq+l995KBLx1N6T6+cu5uqyXrlucDI+hHazDtsGGVwRRVhBflH6G
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



