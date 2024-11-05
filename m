Return-Path: <linux-kernel+bounces-397158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DFD9BD77F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91751F23DC0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B249216212;
	Tue,  5 Nov 2024 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSbbvE0/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69F4216201;
	Tue,  5 Nov 2024 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730841531; cv=none; b=t7N8Olpkt3sGDtdEXHqrlKj3AHlVWa7vq5qhEHKb0QntWte2SRkAQ0yKUXAvQO2I7EeWZfLJcWDc298eziQN9OjrsgmVfkmd+hjDJGOBHvTyzcNgIVxXd8wQihafUxvlprQhLQ+9aOepEpWHdV8oTaz0qzj1TeWmk8GwL/2O6Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730841531; c=relaxed/simple;
	bh=Mggfy6UFGifZiD8v24Nk2yRnIHy9cWVERK7EVwoH540=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZFKO0vLdKahGubKwuRCUoxHG1XR9ucU+dAgUZgcXLAJlQWrSqQQDlQy4ocUt7c/wXfmJBrxPMmCYl6xMh9zXw34cgh6QN5fphGLIuDWYayG/h2LxdS6Z4Fp8au/3Zs/yQ//MeBDam2ATfQluwkfXjyauZpzjvurC59PyL41NWIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSbbvE0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E73C4CECF;
	Tue,  5 Nov 2024 21:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730841531;
	bh=Mggfy6UFGifZiD8v24Nk2yRnIHy9cWVERK7EVwoH540=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dSbbvE0/MJLi+MTyjeh/jTIxgGMBrMg7Uio/wlkfsa4ctlYN9aNJvXRw7xnyEC6S5
	 jqISww+Mnu7BtIsa0FaVvRb5LnJ6jlfpQsU/uGonByI5uR5rzZLjF8idnjogLK33pG
	 ZC6K276kvUaCS+PdxA9Kd/D2CfRdTzglI0MA42b2MXrrHgWyou+Iwoe9T1I0uko9Uz
	 EZnk7ZZwiIx9D+6hi36uI3VKnOtxLztmdAH1MxfREtCA3/07B3j7GE2HJoes0ugfxx
	 3FTKY+notdCWY6CSFMq1BB7yfVJ9pG7ReMYvayQRl60LlNZeRusKDqS6qhmDxdgjDg
	 uTbO0mFSxjMmg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 05 Nov 2024 15:18:39 -0600
Subject: [PATCH RESEND v2 1/2] arm64: dts: seattle: Update spi clock
 properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-dts-spi-fixes-v2-1-623501e5d1ca@kernel.org>
References: <20241105-dts-spi-fixes-v2-0-623501e5d1ca@kernel.org>
In-Reply-To: <20241105-dts-spi-fixes-v2-0-623501e5d1ca@kernel.org>
To: soc@kernel.org, Kuldeep Singh <singh.kuldeep87k@gmail.com>, 
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Tom Lendacky <thomas.lendacky@amd.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chanho Min <chanho.min@lge.com>, 
 Vladimir Zapolskiy <vz@mleia.com>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.15-dev

From: Kuldeep Singh <singh.kuldeep87k@gmail.com>

PL022 binding require two clocks to be defined but AMD seattle platform
does't comply with binding and define only one clock i.e apb_pclk.

Update spi clocks and clocks-names property by adding appropriate clock
reference to make it compliant with bindings.

CC: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Arnd, Please apply directly.
---
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
index 690020589d41..d3d931eb7677 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
@@ -123,8 +123,8 @@ spi0: spi@e1020000 {
 			reg = <0 0xe1020000 0 0x1000>;
 			spi-controller;
 			interrupts = <0 330 4>;
-			clocks = <&uartspiclk_100mhz>;
-			clock-names = "apb_pclk";
+			clocks = <&uartspiclk_100mhz>, <&uartspiclk_100mhz>;
+			clock-names = "sspclk", "apb_pclk";
 		};
 
 		spi1: spi@e1030000 {
@@ -133,8 +133,8 @@ spi1: spi@e1030000 {
 			reg = <0 0xe1030000 0 0x1000>;
 			spi-controller;
 			interrupts = <0 329 4>;
-			clocks = <&uartspiclk_100mhz>;
-			clock-names = "apb_pclk";
+			clocks = <&uartspiclk_100mhz>, <&uartspiclk_100mhz>;
+			clock-names = "sspclk", "apb_pclk";
 			num-cs = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;

-- 
2.45.2


