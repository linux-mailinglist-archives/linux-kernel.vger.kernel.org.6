Return-Path: <linux-kernel+bounces-252264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED3B9310BD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05E21C21E67
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 08:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8441862AB;
	Mon, 15 Jul 2024 08:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCAWdA+P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EDA185E64;
	Mon, 15 Jul 2024 08:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721033961; cv=none; b=bDaRmCbJ/Ph9XNzwXsp3WTsMSNc2sqvtJ6382swzQMd0k/FgEeoiFAsl3PzImgyPWMdd9CgkTY5oCFBQmPnifaeyGJVBw2YF9a04GOO1S8a2KQP5YmhkDpsNLPBWGcCVy+wB4ulk3UgkYY8szYgBaYHqrERg+VdC5yrQY0dXZx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721033961; c=relaxed/simple;
	bh=MFLhWRcBfYxauByXZrf0VrJqa/KVcPGuygAHknweNJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=unxjpZnZ9WHPLIU4p+Hup/gRfeRy+9rL22krc3EMYgJBaf+kBNCv5LYStdRge55lYSX0uEgcWggv7m1YYLdIBklKoBzCWKjG/K+ijGnfKOwifOzK3/1yzR63MJqUH/ccEEYPjeY2GZiGC+7gJZAohBWoc/YjUoyjOez5QAb7vXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCAWdA+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73A6EC4AF15;
	Mon, 15 Jul 2024 08:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721033961;
	bh=MFLhWRcBfYxauByXZrf0VrJqa/KVcPGuygAHknweNJ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MCAWdA+Pw2khDsY8cpZH/+SCZ+Vga/vlxfBKHLymF8IyF285w3kpWuP34G/7iLvj6
	 GUuWPDz4TdrhoTgzwP9K4RwgEybrI5IQv5OuyQcslOu/ZaqVgfSFQmlCuBPBQNWYb3
	 jyKft2Tt98H13kfUKd7xcSW2TD8P98ct++KOQ9F/T08gdP53JKjwuY0sXJDLpdAf/d
	 uHyeCGZpThzA9I6fhaWN2Gm3FQIiTM+UptZea5Tu5a3J1BOlZ7X/h6HORFRQESBMlV
	 uaacAnnL/kOnqqnGEz+5SGbIf5ifYIKcWPxYZnBXC0tk280WefZOwfyEiI/0PhXeWX
	 EVLwSd2IDmEVg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697E8C3DA60;
	Mon, 15 Jul 2024 08:59:21 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Mon, 15 Jul 2024 16:59:21 +0800
Subject: [PATCH v2 3/6] arm64: dts: amlogic: s4: add ao secure node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240715-soc_info-v2-3-3836c8cc27a5@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721033959; l=1081;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=2wGt7OXk2HOANrWvEqv6pT1XbsycF6rOAmNwlp+ubQ8=;
 b=h+GpU/QdW7GMAG9UdNeZuCxebI1djgkzpnF/ceKZ3RnFm/hcE64XUa5MVuSGq22kpbpUU+CcJ
 odtHcn6SF/GDy3uWRCmaLM2thLVIaHdYQ4j6bzhFmOrEp477attMPCw
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
following information for board with Amlogic S4 SoC:
soc soc0: Amlogic S4 (S805X2) Revision 37:a (2:1) Detecte

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
index c11c947fa18c..957577d986c0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
@@ -763,6 +763,14 @@ reset: reset-controller@2000 {
 				#reset-cells = <1>;
 			};
 
+			sec_ao: ao-secure@10220 {
+				compatible = "amlogic,s4-ao-secure",
+					     "amlogic,meson-gx-ao-secure",
+					     "syscon";
+				reg = <0x0 0x10220 0x0 0x140>;
+				amlogic,has-chip-id;
+			};
+
 			ir: ir@84040 {
 				compatible = "amlogic,meson-s4-ir";
 				reg = <0x0 0x84040 0x0 0x30>;

-- 
2.37.1



