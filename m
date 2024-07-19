Return-Path: <linux-kernel+bounces-257072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FF59374BE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87C491C21161
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 08:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C93B83CDA;
	Fri, 19 Jul 2024 08:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bK4c++rl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22EF6BFC7;
	Fri, 19 Jul 2024 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721376492; cv=none; b=morQu4sHOAnYK2/vsCbAcsOdOi4TkXOTxe7uvYY6JpJb/qBa0TAW4vTODKSihXHZWDCRp146XZ1omwZJ+rG+gVxhkz18E6mSvzQpaYMv94eB9J1G0xDYcMoczT7V/lZ4xB8yk6N5cwyYg7vBLO+oNkzqKOCaJVeL2MN21UEwQY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721376492; c=relaxed/simple;
	bh=rzLwwkC/oer4IKZiroanbDLw+etqrVLhhYZwC5by1VY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c+N6VEyw/xX9de9mW+zsEtOmUK91eLWIjpO1JOFyAGHrJ27kUvXK4jeJVCdX6KeBaY16fRH56sWGhDuwedTbA2s5vv9ggmmt6GHE9tcdevrBEh1gR3tf4Dm0RJnV2TkgTO0MZdbeh24uNw89uLzf+iYLC8sjTmrjnDQRwrM6q08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bK4c++rl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DB45C4AF1A;
	Fri, 19 Jul 2024 08:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721376492;
	bh=rzLwwkC/oer4IKZiroanbDLw+etqrVLhhYZwC5by1VY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bK4c++rlrwKmhbDz1JVqLv44eQ+8wCkdo6aAiZslRXzkbkmdxXN+KGP8CheRAfnqI
	 tt3P4hJl6MAgNCa+nOudNB5wM/DpoPcSbxDGXP2PLwHlTLUI9X1fDRWUzDmJm5Vt0+
	 451oTGU3USBIk7fSjFbXxnpcQGRnrnXiMPw0nFtUDacs/6BRguAa+R2qnuqo8s9wVv
	 8HVraVrR7tUTfY0v9k0pfS1Vasa8LgXZdiGSA1Z0F/EaUEgLFPhkNgpbUHq4pzVH0R
	 NCl1V47G22MaSmx6Y01papYPzLC8gjCHBo8Izid5U4mfvfZgLlozZdkCUv0MNG5vkH
	 lxSL84s7g5pYA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5193EC3DA70;
	Fri, 19 Jul 2024 08:08:12 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 19 Jul 2024 16:08:14 +0800
Subject: [PATCH v3 6/6] arm64: dts: amlogic: a4: add ao secure node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-soc_info-v3-6-020a3b687c0c@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721376490; l=1080;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=Zl2TiQJDwOdSpUPv3WU4sx37kiV4xoQ/BADR59alPhc=;
 b=wBSeur+SAfT00QiwrwbLZOTSIXxAG7NltC82LZfXjKXJidhqBJYlznZHLPPm46UKO75KdMPV8
 64fpcWa2Q/uCH9GkFYeeIoMKN+9U/7o2E37yA6TO5myILPXOUqMx8rV
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
following information for board with Amlogic A4 SoC:
soc soc0: Amlogic A4 (A113L2) Revision 40:b (1:1) Detected.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
index 496c3a2bcf25..54d7a2d56ef6 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a4-common.dtsi
@@ -67,6 +67,14 @@ uart_b: serial@7a000 {
 				clock-names = "xtal", "pclk", "baud";
 				status = "disabled";
 			};
+
+			sec_ao: ao-secure@10220 {
+				compatible = "amlogic,a4-ao-secure",
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



