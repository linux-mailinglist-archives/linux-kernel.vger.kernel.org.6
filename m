Return-Path: <linux-kernel+bounces-557669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0940A5DC36
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CDBC18867F4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E98241C80;
	Wed, 12 Mar 2025 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="FZ44QeCw"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90902405E8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781116; cv=none; b=iCr0DotWhopKhtZN8N6ZxNtsmCHwXAKLrLmrWyJe/qyno1KVOfa6G7EUIKwnYE4y4fiIXAgJoIRLv6IzdvXqf556iKrpLJkRm/HSm+XlYCZqXlgihdsPuv5Fz0h2l5xwl4J3BS0LQ9RYHP/vix6SfThf/Lzv+KZ7dcMow7uSOco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781116; c=relaxed/simple;
	bh=6Z8X6RHd8C3NHYGxwGzCFDELK/zVbEGe0Z8d4epfTo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NWWqvgxCMWv38hujiLkimomDNdWSjRzM+Z64rnLe3iNuzaE+cjXBbml56RflKJJbOI/gHAhaHd3xCx31S3wAgtwv77GdbUOOMTH3ItR1i8mPM8g9HuG/fenpOC2m0kwyixw3twqrc9FoInlKnNa8hUcsjYwfS3AnKT/uFj+D4MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=FZ44QeCw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4394036c0efso39685575e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 05:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1741781113; x=1742385913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rT19q04YWqzOzVCaO2VhU1OaQyMp5mfkbmo3hw/vhFI=;
        b=FZ44QeCwGOt7PKoBakL/BgcRFx4cp6przkK2xd2NmgkTcQq+np7EZCy0mHoc0+YlCl
         x98C8u2K/MbxtRtmNLzLuaCGg8lGjUQeYdzpNQOgCtxMKqVDIhRKxXvqVOhoVxBpiS+o
         Pj7BdS360Xhb0kT5Gb2a6/qllMQc7zHrXRwPK2fTxwGjwWoBH8KHv/ocE3jZh8qvX9l/
         pEPfxa8sWiZhct7gJkYh9ihyCknKao1CD6Lc1JR3C5P58X4OkjN+OxxALG73B5DZf7gj
         auxXd73b171Ae2CpieqwM9KFM6NV8KIhQa+gebklGrQb/BkRvede1lO9V89OJqNBmD7c
         Ze1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741781113; x=1742385913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rT19q04YWqzOzVCaO2VhU1OaQyMp5mfkbmo3hw/vhFI=;
        b=UK9y3neZ6PMKki1RuQ5GGxUUhpC7uT7N8a/wDqhvoZUi8VFx8oHNNAj9lt1BI9brQ7
         blGPsD05Qgz12E6er3UyOLaq58sU41dNMX0FZ8uSJGea2+/aeaDCPgnc16uwc936QMpw
         c8XLSlZXYIzYvU4dm3FfjGrLf/N9BlLn+8AAvyJ4wuBIE/VpUuSDoU5snfUVZVVsdGSm
         wirGUK0VLj35lc+RI2OJl9Zd3beO8M0gNjEwxPMmpPQB/Tin1/ByC4mVYwpWyC+7tEfq
         3uJviNesKzi0GU1omveEFGB1Aqfjg14qAwQHMGa/MX7Z+pKPSwRqA75yb9L4qWVaQOVX
         h3IA==
X-Forwarded-Encrypted: i=1; AJvYcCWPRQIpaxPDcMosgzCMPYK7lNlfBG29fTGZwDBj/cnxbHpo4AZGJDCQDg267oivNRXvbh/g9o7kgcdA2Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/DO7j7Z99ts3p/l8MNW8nXAVAa16St4Pr9HoSzTcR5a6NlUos
	L7p5slRfLlfhhiOK+GY7IfeqOtA3pfgnE48DGfrKSeVeKi4OjLtOkepBb+q2uMM=
X-Gm-Gg: ASbGncvBPOu1P3yG6QccAbnYprY3pTHxD+1V800vN7W9A11gOfXv3SnhH5TKle2InVl
	h4ZT/sK9vQw0HlNSa5y+sLaYjdz/DhRTr+z0vpV5CAxge4YILbEw+JuTup6AmUOhvdUUw77bELR
	5hRIGI+u1wefe32i9KCkU4MBfX+0WEP3hZCZpoUDSl2oTZPuzooymEg+c6V0i5nlA44Kt9z4yn5
	dDcpzu70EZGOhdGYBuyQseUr+XvTlCfl3zfyS1Qxq84MkTzFxHL7QhE9W1tTK5GlU9q0MAtr7l1
	XO18aLBt0Aybyr6pT8IpBEae+dZvm242nMOK8wLnSy/A2NJwmwXGy8fcfMb7qtre+nG/gH2ij3n
	FiIxj6wulZf3nWJ2+UA==
X-Google-Smtp-Source: AGHT+IGkRTZCtf7vuRgbS6hY0wQsYQ9vTdgpUB3Kmnk95GhrVLIELJoSQ0jxjgLiiA9rJRSChQUnrg==
X-Received: by 2002:a05:6000:2ce:b0:391:39bd:a361 with SMTP id ffacd0b85a97d-39139bda97cmr16747680f8f.18.1741781112963;
        Wed, 12 Mar 2025 05:05:12 -0700 (PDT)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb799fsm20810608f8f.2.2025.03.12.05.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:05:12 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 12 Mar 2025 13:05:08 +0100
Subject: [PATCH v2 1/3] arm64: dts: qcom: qcm6490-fairphone-fp5: Add
 PTN36502 redriver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-fp5-pmic-glink-dp-v2-1-a55927749d77@fairphone.com>
References: <20250312-fp5-pmic-glink-dp-v2-0-a55927749d77@fairphone.com>
In-Reply-To: <20250312-fp5-pmic-glink-dp-v2-0-a55927749d77@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2

Add a node for the "Type-C USB 3.1 Gen 1 and DisplayPort v1.2 combo
redriver" found on this device.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 35 +++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index 0f1c83822f66f95b05d851a5d28b418ff048b09d..ea9f5517e8a083e37c4b7432322bd6d18fea84a5 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -166,6 +166,23 @@ vreg_oled_vci: regulator-oled-vci {
 		regulator-boot-on;
 	};
 
+	vreg_usb_redrive_1v8: regulator-usb-redrive-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "USB_REDRIVE_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		gpio = <&tlmm 61 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		vin-supply = <&vreg_bob>;
+
+		regulator-boot-on;
+
+		pinctrl-0 = <&usb_redrive_1v8_en_default>;
+		pinctrl-names = "default";
+	};
+
 	reserved-memory {
 		cont_splash_mem: cont-splash@e1000000 {
 			reg = <0x0 0xe1000000 0x0 0x2300000>;
@@ -747,7 +764,15 @@ &i2c2 {
 &i2c4 {
 	status = "okay";
 
-	/* PTN36502 USB redriver @ 1a */
+	typec-mux@1a {
+		compatible = "nxp,ptn36502";
+		reg = <0x1a>;
+
+		vdd18-supply = <&vreg_usb_redrive_1v8>;
+
+		retimer-switch;
+		orientation-switch;
+	};
 };
 
 &i2c9 {
@@ -1182,6 +1207,14 @@ sw_ctrl_default: sw-ctrl-default-state {
 		function = "gpio";
 		bias-pull-down;
 	};
+
+	usb_redrive_1v8_en_default: usb-redrive-1v8-en-default-state {
+		pins = "gpio61";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-high;
+	};
 };
 
 &uart5 {

-- 
2.48.1


