Return-Path: <linux-kernel+bounces-546478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4DCA4FB21
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91EDB16AFE7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8E5207673;
	Wed,  5 Mar 2025 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhkzWp9u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D927F206F1D;
	Wed,  5 Mar 2025 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168979; cv=none; b=O3OA93g/+qm0Tj8FsYlWPYMbs7mPDS/4XRfaTdcV7H84msk9BjzpkoOmRwnSsn8DLoQb4v6jf4u98YaVZCO7ahCW0YlweGT/HSxl33s0oUe6PhC0mdvXq6mwxYU6bRDL4/NOgz14rZebrH1AH9nMOf9Q1HSnKPS9fJiJz5e9itU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168979; c=relaxed/simple;
	bh=qch7huQ3IX9eDJtDp+CrMjmAYNzCX1pjwyDdnZ1GCVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O8CLdzgzMFMYhJjpkN09CHO5iAhjBKJnKoympp99OUdIl+UOvmevTvZ035BfAWcPvU/jSsp+edzEoI5Ibyj4ZSylVsDhgEdmee+xcmBXgqxe4FWMY2+4Cv8XI7EL17+gjzckCIp1IjEELKP0jAJIj0eRSLUeXQ6extsZQdgmQVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhkzWp9u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73786C4CEF2;
	Wed,  5 Mar 2025 10:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741168979;
	bh=qch7huQ3IX9eDJtDp+CrMjmAYNzCX1pjwyDdnZ1GCVg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AhkzWp9ua1HWcqtPPxpbXBW3gcazCitDXxmBOabSxJmBRTdowWbdesbo++NyMGK8K
	 U64gZ8f0qUhws4DU4cN0D7/spPo8gApfdv8NnsOgSJFz5noc1tsm5mTtVGBOJZMnbZ
	 C083xr4rNWouSy/e9hW6ueR9g7fsBufH64sb6qbRjntSWacc9pA+t9GcDDlsDF9Sbz
	 M1baqtHTBH+yLpDVXL5DFy+PFKDA1ihXCRCnhko0NAlCEmzFh78XhvhFIu+mfkhUrj
	 GxEXCP1tbbE8ja9jJssnXdIbt1rvyJXVl1MWXssjBg87K0TBl9q5bHVSrbcdfqHM6s
	 rFtLBn54wU4wA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66706C282D9;
	Wed,  5 Mar 2025 10:02:59 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Wed, 05 Mar 2025 18:02:58 +0800
Subject: [PATCH v3 3/4] arm64: dts: Add gpio_intc node for Amlogic A4 SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-irqchip-gpio-a4-a5-v3-3-1eec70352fea@amlogic.com>
References: <20250305-irqchip-gpio-a4-a5-v3-0-1eec70352fea@amlogic.com>
In-Reply-To: <20250305-irqchip-gpio-a4-a5-v3-0-1eec70352fea@amlogic.com>
To: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741168977; l=1190;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=QC+CPrCwcCU8cBlAO137f57knOzl0UVfLJyIMFfXkFY=;
 b=PoBdOcPfugu3ByNyFY44yiXXXPnNKK9QME23lhCHLCeELEF91iF0e9U6ZrDk1ZLY/CUMvRWcA
 Hk34oEI7ZSYDG/67Yf+lU0iZLcEbIT4NA2nduVlP9V2NV/p3a8TFN0g
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add GPIO interrupt controller device.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
index efba8565af3c..fa80fa365f13 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-a4.dtsi
@@ -51,6 +51,25 @@ pwrc: power-controller {
 };
 
 &apb {
+	gpio_intc: interrupt-controller@4080 {
+		compatible = "amlogic,a4-gpio-intc",
+			     "amlogic,meson-gpio-intc";
+		reg = <0x0 0x4080 0x0 0x20>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		amlogic,channel-interrupts =
+			<10 11 12 13 14 15 16 17 18 19 20 21>;
+	};
+
+	gpio_ao_intc: interrupt-controller@8e72c {
+		compatible = "amlogic,a4-gpio-ao-intc",
+			     "amlogic,meson-gpio-intc";
+		reg = <0x0 0x8e72c 0x0 0x0c>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		amlogic,channel-interrupts = <140 141>;
+	};
+
 	periphs_pinctrl: pinctrl {
 		compatible = "amlogic,pinctrl-a4";
 		#address-cells = <2>;

-- 
2.37.1



