Return-Path: <linux-kernel+bounces-250262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B5592F5C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B472D1C2088B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F96148825;
	Fri, 12 Jul 2024 06:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vl0R4Mg3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF6013D628;
	Fri, 12 Jul 2024 06:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720767290; cv=none; b=okXdJicsvyGlUnZ16a29avXuBP6JNQfBFrrjyQQfuT+AH1uJ+VdjaUbJqsxqfYvMLcv4I+TKlYSB8NCL5Xm9RshjWPDjFK7RLzefpu6nzFczpwiOkMeu5BcmcJt2DkagXhdJucTdOQJU7s+GFFuDp42dmihjL5rUDz6/fLJt2K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720767290; c=relaxed/simple;
	bh=82EL7UtqOt5BKQ0zNdO4ISrbWoeY1ULwxbT03D2KIhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=riQn6KMSWCE8XyOEUXzHAQH0/P+I/FskAZH/h7a27Eg7XN33nVcUDvYt1DTiYoMDoDSvml8x6AadQ5SVsL3BNr8JxJAIUtCGMNfb3QwNpbxMwPApqi1NgTijsFD82dPFqLqjGwI3O+9El2Wojm5/fG63NFjQC3Gg2oB9jO/uEGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vl0R4Mg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C1ADC4AF12;
	Fri, 12 Jul 2024 06:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720767290;
	bh=82EL7UtqOt5BKQ0zNdO4ISrbWoeY1ULwxbT03D2KIhk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Vl0R4Mg3xR9HjWnhvLfaD92s1A+SNx3+oD3se7cZaq5T3Jf2XlcupZ3hTWqQ8Ci+r
	 m9ri8Cdj7BYk/nFKDDmknu2ydzLHzaJstRdGyKFvsSh5O/1WqURKVCFslj9kAHfnht
	 Bw43HhKG5r18iUF7pnxRwY/FCcZjacMDvjQWj/VxrmG2Fl/YBQYAMQRnWjaa+IoF5C
	 OzdECa1iNzO4A2snSNSgy+pOT8FtvJBgkmE81NKD2hahy9DK3KL9+Q1amxMUSyEk1u
	 JAETcSDNsAbn5Ct4In1+2kcDVlO6pXQsIW2KNoYUcF6GDxs2qgmP5TDKOW+BNxW7YD
	 KlfmdnY5Tu4Rg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3193AC3DA50;
	Fri, 12 Jul 2024 06:54:50 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 12 Jul 2024 14:54:49 +0800
Subject: [PATCH 4/5] arm64: dts: amlogic: t7: add ao secure node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240712-soc_info-v1-4-05ba95929d5a@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720767288; l=1006;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=e/+Wxh8VonbmvPjjJfR5Wewh1r5F0lbqTjlqgINIHco=;
 b=pdL9RfF8KxiT6JauuAiMOmdhs9iPi/+40gnKTUC4s7MzZZ+gOaU5Zu8fe0uOm8DY67HC57GUY
 HOLFmGIKeNABnrJgZHUrRDih7K975N2SnrwGaDfn/SFsO/kmWCopkK5
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
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
index c23efc6c7ac0..777935821c3f 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi
@@ -194,6 +194,12 @@ uart_a: serial@78000 {
 				interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
 			};
+
+			sec_ao: ao-secure@10220 {
+				compatible = "amlogic,meson-gx-ao-secure", "syscon";
+				reg = <0x0 0x10220 0x0 0x140>;
+				amlogic,has-chip-id;
+			};
 		};
 
 	};

-- 
2.37.1



