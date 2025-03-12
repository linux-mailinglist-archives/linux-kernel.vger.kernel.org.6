Return-Path: <linux-kernel+bounces-557672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D25A5DC3B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD99167D2F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23C6243376;
	Wed, 12 Mar 2025 12:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="jUEYxV89"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B0324061F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781119; cv=none; b=F/OFGECY26P5cyQ7AnLjJ9P3LxO728rlPt0u5Q9eTRRRgFjr2kX04DJj/iITwuJcohtfwyHdafNz8OgK7UVsXSHVHz0KYXq1TRElqRWtR2fdR4SH/ZYSd9mMfNruuClwMDwJV/EPF4++QP3yYBmbAyC33uMMj2qBC0hJ9txMwF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781119; c=relaxed/simple;
	bh=6cX5THqC6SB9r/MQ3znf5AsR5rUbbWbJXTQlgQ/Nqjw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gHH7tXm+pVQYLXQTule0S7nZ3Gwc4x8zgb0m+Mw9pfg45zanMYybvxSzXMpJoKxFYay40SNQsWBc7313CJyqhcWx44nsbmbe7tiawHmTLgRJKrRsatCEDIjXlsz28RZ75AMrdscHCrU4DSFwcNvHtPSh5PgUGiTURjZ034eAY/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=jUEYxV89; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39104c1cbbdso3281810f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 05:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1741781113; x=1742385913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jCeb1ULglGuh9XYKx2CHU6Na6xTURFvEBVoDxNzGMCs=;
        b=jUEYxV89keR7imtJY9IfCWeqsaVyYj00KMLe3E41pEckrOnNGETmtX+/sS1VKQgGOW
         x7Cv+0J8Y0trxcynk2C2HmIKvKwxSKvB7dfQkuay/EkhtamASXGos3go6mQZeK1D09iR
         SmsvtUq2dM8GL4lTKjBcBfaeikdlDIsUpuXlwK7DDMICBIGzxAzmuxQPJSx+X0/ek6qy
         2LbQwrxnhQmHVf9yM+9/Anc4f17x6xz8S3cBeRJ8SHEL1hhorEMrgveCu93e1g2eJWdn
         62oouNVNCGd6QeaJ6B+GRev7jD4umtSga29waY7nSQ1fvoOTgp58zC3EuRvNs/haqDJD
         u7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741781113; x=1742385913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCeb1ULglGuh9XYKx2CHU6Na6xTURFvEBVoDxNzGMCs=;
        b=qQoKnrZuFAu1e3WEpmtQtVA8o4b8EB14cFRfPJMcRTFBariKxMAkIqHfKJu9qkerPk
         ne3QGkbyBo6PKDgye4rx5L5fE54Nv+KpRjIKDBkdOKsgZ5m7grcqhtMQ4Ajzr/Q6862l
         ih3grJu4QhBzTfxARAKS5z6YGpPCT9qsZPDkTnWswv4F4VHbWxK9ereS0RjDpZxeDF8U
         oLcEqRufUem3wWQjec/XK0k+B6G1BQ8Yrhlpmtg60gAhZouKgl5vbPgsqYCI69y1cFZh
         704Bd0WnBX/oNwIIpLKYcJj96LtKyE5h60BSZ9id/a7kMKXgOiZNncWfTF+c0fVxkE12
         fsUA==
X-Forwarded-Encrypted: i=1; AJvYcCWuPjuFX6f1a5JpeW3pMEjTEQ47J88QmfYr9BmrEVQHKeDRmipMArkUflCJKXqXMM9KVlT1vX1gr8dFRDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+qs/g1bMs9ap7/NUnkwnIg6bd4yZtzJhm4OD+muLSNXQ27/IN
	QzfLMSop7A6uz0NK6WSO2lf4KfFZ93C90ruF/Q9DqTSjXNcXsrw/1Zbdepe4b3U=
X-Gm-Gg: ASbGncv2LiFZzTjmnlnqaREmZSqCMg+1A7vEqoq5flOVQdtSSBaMCp3AbbbCwJPXOVX
	Nh4kt1Z9Ewle1gwLhnN5eNrcOebLVWupPXTeb4WZKIxj3pUEATqaqrQi6e7Xw9FRJdsYh09XTxM
	GvuW3DAg9pdFV0Hp5ezxDnqoMVLJIwWDJqS2R1xOrP2lcYusBvfRhSqW8+ibcAjSmjRsLQkC8H8
	0P1gGtHbr0D8gYimdKoOn6Cda8vLZhL9NAGawqpmTUwEl/3B3MCVA2A+PdCI759PcTc/Ls2ZFPL
	tTTKCkoGEqHAYS3gXmOlcoRMULliyy/Deoyp3pHkRA0WsBCxeOpHmXHFQGsbGm89m6FMDdi68Tk
	qy6/kYSOU94RZKlhNHw==
X-Google-Smtp-Source: AGHT+IFI0x1QPiyLI3WY31duJJ6H2f4cFVzC4D17zbYy5/vSinoP4DDZ+b2H7r9wwYkgkoxL/ETrNw==
X-Received: by 2002:a5d:6da8:0:b0:390:e535:8770 with SMTP id ffacd0b85a97d-392640c841amr9041223f8f.14.1741781113576;
        Wed, 12 Mar 2025 05:05:13 -0700 (PDT)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfb799fsm20810608f8f.2.2025.03.12.05.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:05:13 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 12 Mar 2025 13:05:09 +0100
Subject: [PATCH v2 2/3] arm64: dts: qcom: qcm6490-fairphone-fp5: Add
 OCP96011 audio switch
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-fp5-pmic-glink-dp-v2-2-a55927749d77@fairphone.com>
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

Add a node for the OCP96011 on the board which is used to handle USB-C
analog audio switch and handles the SBU mux for DisplayPort-over-USB-C.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index ea9f5517e8a083e37c4b7432322bd6d18fea84a5..e0470be9142caa4bac4285a191725bbd60e706fa 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -750,7 +750,19 @@ vreg_l7p: ldo7 {
 	};
 
 	/* Pixelworks @ 26 */
-	/* FSA4480 USB audio switch @ 42 */
+
+	typec-mux@42 {
+		compatible = "ocs,ocp96011", "fcs,fsa4480";
+		reg = <0x42>;
+
+		interrupts-extended = <&tlmm 7 IRQ_TYPE_LEVEL_LOW>;
+
+		vcc-supply = <&vreg_bob>;
+
+		mode-switch;
+		orientation-switch;
+	};
+
 	/* AW86927FCR haptics @ 5a */
 };
 

-- 
2.48.1


