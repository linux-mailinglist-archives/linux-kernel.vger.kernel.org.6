Return-Path: <linux-kernel+bounces-573372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D4EA6D67A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B50BA3AC66F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06CF25D8FC;
	Mon, 24 Mar 2025 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="BQOc0eox"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68F325D8F9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 08:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742805673; cv=none; b=ooVaVAY0UgFdn6wfBI+Xv7uljcEEaijROOSc5zii2Zr/hP27jt4ykPQ4ygAQc9j/ioac1mkis3jdow7b76/5kY9fSq3mlhn2Y/d7t6jDAxAMEFzPEvDx2A8QAFOfjgLgtzISEI6DfrIIiTwKszSbtTwrqOOVeAybKQ8CdqSXeDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742805673; c=relaxed/simple;
	bh=AFOsIAC6SS0fPbzq7D7EjSpe/9E/6d/qhu5Xf6WqtyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uzJaa6ymDOiEKVQsuDZi8Cm3/bR8+BSxLCFcazS81MBWVNJZ9Utn5Us4MMe9p47hOQc+MD4sH1QRDE93hjomTWjSqx+cyb0ihQd1aOmvqvMYi9ya7CxmjLnh0OVlLffGCaRx9HarRaxtQIaJg30oA2AtxkTPF3qVeG9lz/0T84U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=BQOc0eox; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso697169166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 01:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1742805669; x=1743410469; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uqyxDkKBXP2Up3UhH96Dx8TXoOJgbv9o3SaMoIVWQrE=;
        b=BQOc0eoxoA4tl5p+pK+LyTEKozxCWGMFmUZJttxNB7EXcd/fD87YBvEC5EoYL2vJWm
         HqJI/UTP22aCeaVl1igHjzTiKxb2A9ntxdH3T80xYpl0pNrLARnaNBZlfJkaX0Zqw/G2
         aoC2OPFkt4yJdQsEleObm0TGqPUWa4591somJ2ggRKwzIz+IeTpz6OcIaa717Fxnsqbu
         HAaf5sDwcgxW4ED7KdUZ6V5sAYDSE7PacQdlUxkLpk2fQRm4xH4YKDj6oyze8grtT2gf
         ZUV4DsYLKBrRIMpuUpwqDe11Nl92a6XNE4saUkcMjZ30DTSWsi2W+UtI27HuTEfv09KO
         t66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742805669; x=1743410469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqyxDkKBXP2Up3UhH96Dx8TXoOJgbv9o3SaMoIVWQrE=;
        b=YeM7dJXNGjLLKwPYZ9fB88i3x+bSGA/USB3090yrNsHwQMTYw+LI+KI2FRrAtyVzIk
         k9U6gIIRPaf21u88NOmnWbwcWgOPQxWRGfnt/2K4EKYa0AT30U6UMlDfwCx7QnPTgn6+
         mMbX7CLdCcvzbpBTBTeXvfLlgm63roaM0rpkZW7G5FhvzbMd7EVDuJuyUzmJ65AedChV
         NUubU0Wq6l1coRE06JIJeh9XG+0TLsGNGpbT6hg8KA813PVhIljo1dkrJHvJo7BXsazd
         qPWnIXVvzgKvTp9HltDB1MdsEbI5LQR5U8aendGQPDVqriQfiCeiCRm3ZJinshFzfPI0
         bemg==
X-Forwarded-Encrypted: i=1; AJvYcCVshSkUPpq19z/EG63SEPnzTM3w/hIrs4WoY32i7qsZ3HCDKEgZL7oQ3jrT4A4InxJKCLY3iU94peegBUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWTDxwYiCriTKdQ4vLFLto8uarZJfpRvHRIKBHImbckWNqV+rO
	SKl1iynek5ToB1PC3BP+XNnwew9LJFFRXt9/Mfb5RPBljmn+scQUpDC+3qQ8I9w=
X-Gm-Gg: ASbGncvwLy/Dw4+qs5kg/UbTPWaQswoxt3uXF5svsxJ2+L0Wz1ZkcwpZ//D0nGloy7P
	mFABkjqhUgfaCHl9D3EWOM4Eojt0ZFZPqcrSBC4cknBOxJ6pAXlt+hlXWaXTJ1VQKNcxncTfex1
	FCDK+cibe7DOyCH8YuWuJF3njxfDysoS25PgEdbiUq6D739qqI0jllaigwTCR/X2RX983wfxsHU
	Pj1LSUS93H8i9l+o/MI4D/28E79X4i4ZEnHWyCCjUyltJE83qzUpmIzwPq+Ewqmp3gukg3w8N2I
	FRXuUkHOalK808gEFYsc97zXxfVd8e4Lk/0LLwgJU1fDZ2eRLSu38h7mHxuG4eQc1K96x6WUPh1
	qUY3UARbeZphrOU6i3g==
X-Google-Smtp-Source: AGHT+IEIbECex1u2sz3obxMBVg9MXWDK5ZdDdAZm5/qlaOXilZZG6R+6m05Bcoh0lt+nXYcl9z01hQ==
X-Received: by 2002:a17:907:d88:b0:ac1:e31e:de0a with SMTP id a640c23a62f3a-ac3f20f7101mr1341850266b.12.1742805669049;
        Mon, 24 Mar 2025 01:41:09 -0700 (PDT)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcd0dfb33sm5715937a12.68.2025.03.24.01.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 01:41:08 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Mon, 24 Mar 2025 09:41:04 +0100
Subject: [PATCH v2 4/4] arm64: dts: qcom: sm6350: Add video clock
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-sm6350-videocc-v2-4-cc22386433f4@fairphone.com>
References: <20250324-sm6350-videocc-v2-0-cc22386433f4@fairphone.com>
In-Reply-To: <20250324-sm6350-videocc-v2-0-cc22386433f4@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2

Add a node for the videocc found on the SM6350 SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 42f9d16c2fa6da66a8bb524a33c2687a1e4b40e0..4498d6dfd61a7e30a050a8654d54dae2d06c220c 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1952,6 +1952,20 @@ usb_1_dwc3_ss_out: endpoint {
 			};
 		};
 
+		videocc: clock-controller@aaf0000 {
+			compatible = "qcom,sm6350-videocc";
+			reg = <0x0 0x0aaf0000 0x0 0x10000>;
+			clocks = <&gcc GCC_VIDEO_AHB_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&sleep_clk>;
+			clock-names = "iface",
+				      "bi_tcxo",
+				      "sleep_clk";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		cci0: cci@ac4a000 {
 			compatible = "qcom,sm6350-cci", "qcom,msm8996-cci";
 			reg = <0x0 0x0ac4a000 0x0 0x1000>;

-- 
2.49.0


