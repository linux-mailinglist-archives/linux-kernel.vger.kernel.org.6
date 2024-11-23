Return-Path: <linux-kernel+bounces-419069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 192AE9D6925
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 13:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74569B20CE3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 12:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534091A256C;
	Sat, 23 Nov 2024 12:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0PLgn5L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A6218C002;
	Sat, 23 Nov 2024 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732366739; cv=none; b=dIB3PQeECvq5udoAnXEkwrnKcEGn5xii3ykCz1vLbuWVhvkRtA2jWMb5DDx52Nj3tDhH9+3sBJ0OFXzx9JAKYSlglzJTtW7uGYkl9g/AA2jlr5L9eCAs//Cy+tYx6RmLxWGuucTFmsn3UwI+M5bAUL99/nfTVxZH7YwppCXRmvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732366739; c=relaxed/simple;
	bh=Fv47p68wpt/Xf64OQ7Qc/POU5bqiVwR09vqaKyiQh1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=izo32yehKIhtXeX/Bk+3CGqCGfYcAOOSqwyoPGNDymQPRXxuKm19H9e6SmPw/SOsw+hn2JV+cmXNpnK0QhiDI2mUGPGytBwuLE3reTrp4/4hihW/QXt0WSmzq2o48T0rGz2x6pfBFW+LBLpwm24AwZIt8+EYdsaRFoAewqh5CbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0PLgn5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16068C4CED3;
	Sat, 23 Nov 2024 12:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732366739;
	bh=Fv47p68wpt/Xf64OQ7Qc/POU5bqiVwR09vqaKyiQh1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Q0PLgn5LdlNHbyByAYqrmuBlMbciWp8jwPG3asgp69PnwTEdk41fur3R0MAM+TO4W
	 3yYPVKzlOqQ1pYneBH7lD1DHdYRnbyWpW49ykFBJRTG5bXgPNPLszxM98gDKuCoznJ
	 G91tI4d0+hPYGz3FHwwokveHnpUS4YTXM6EhrsNuxyKQOEmLGPYV+S4nlK9nWiU0d9
	 FLtCtmU9GNYBbiko/IbjBmqNC09eijicR9RTgIdkm401+fbXLb899S9RlUuF+hgxJ0
	 xeo0N7K+ovuk9DvPLhLI1JwawzGGYVxxA9bv5ENSRzGHhgrUE/o5KchNS6Y+9Ftqlh
	 RGIDOhc3U8wAA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081F0E6ADFD;
	Sat, 23 Nov 2024 12:58:59 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maud_spierings.hotmail.com@kernel.org>
Date: Sat, 23 Nov 2024 13:58:55 +0100
Subject: [PATCH v2 3/4] arm64: dts: qcom: x1e80100-vivobook-s15: Add lid
 switch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241123-asus_qcom_display-v2-3-a0bff8576024@hotmail.com>
References: <20241123-asus_qcom_display-v2-0-a0bff8576024@hotmail.com>
In-Reply-To: <20241123-asus_qcom_display-v2-0-a0bff8576024@hotmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Maud Spierings <maud_spierings@hotmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732366736; l=1600;
 i=maud_spierings@hotmail.com; s=20241110; h=from:subject:message-id;
 bh=cDAfP1GXN5HoZNSLX9L4CXkyhwGzk7nNuUgFq5shRK8=;
 b=mZhyHT18WPVEJvfZGqpyMVPUQtx7mSQkX/lUI4RGOdnIZHikBcBw/YKSKINz9eXbWQ1P1P25q
 D2IJzN565vEAP2WACfJfCAy7pP0pzdxXpOZdCi7WnrX/KMRb427d55N
X-Developer-Key: i=maud_spierings@hotmail.com; a=ed25519;
 pk=CeFKVnZvRfX2QjB1DpdiAe2N+MEjwLEB9Yhx/OAcxRc=
X-Endpoint-Received: by B4 Relay for maud_spierings@hotmail.com/20241110
 with auth_id=273
X-Original-From: Maud Spierings <maud_spierings@hotmail.com>
Reply-To: maud_spierings@hotmail.com

From: Maud Spierings <maud_spierings@hotmail.com>

Add the lid switch for the Asus vivobook s15

Signed-off-by: Maud Spierings <maud_spierings@hotmail.com>
---
 .../boot/dts/qcom/x1e80100-asus-vivobook-s15.dts    | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
index dbc85aff50a95bfc2ac11528d1901979ec7b1501..d0bee4b6fc0be6fe40d335f4d50dde495853b315 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-asus-vivobook-s15.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
 #include "x1e80100.dtsi"
@@ -17,6 +18,20 @@ / {
 	compatible = "asus,vivobook-s15", "qcom,x1e80100";
 	chassis-type = "laptop";
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&hall_int_n_default>;
+		pinctrl-names = "default";
+
+		switch-lid {
+			gpios = <&tlmm 92 GPIO_ACTIVE_LOW>;
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_LID>;
+			wakeup-source;
+			wakeup-event-action = <EV_ACT_DEASSERTED>;
+		};
+	};
+
 	pmic-glink {
 		compatible = "qcom,x1e80100-pmic-glink",
 			     "qcom,sm8550-pmic-glink",
@@ -537,6 +552,12 @@ edp_reg_en: edp-reg-en-state {
 		bias-disable;
 	};
 
+	hall_int_n_default: hall-int-n-state {
+			pins = "gpio92";
+			function = "gpio";
+		bias-disable;
+	};
+
 	kybd_default: kybd-default-state {
 		pins = "gpio67";
 		function = "gpio";

-- 
2.47.0



