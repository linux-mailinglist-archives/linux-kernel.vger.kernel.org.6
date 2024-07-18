Return-Path: <linux-kernel+bounces-256330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AEE934C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2F92832EF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 11:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FFF13A89B;
	Thu, 18 Jul 2024 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="X4wfE2Bi"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32BC12F375
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 11:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721302152; cv=none; b=TnQ/T0KSMJMJbOwYrXsLDOuVtf9sJ7nLB/127hPrLFKj5fOvuL1hEjcTO2w3oCfHFGqYqEyM/+zavbvoSAVZXNuK2aShXw1fEVN/UQ4Hlcxd/sQO8j+Dfy4IxPNxO/X3g3T0NLQ8cnyGCxpd5J2LZcZkweP1XbGHE6/N/cXf2k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721302152; c=relaxed/simple;
	bh=bn3VgzhSAEhdQZg1IslFXJCq1k/bK2Pb74+mWuAsJU0=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ArUMS85Gzpcm9oesVOUaRFah2E4beUvF6qIct1UNIUd4NN0iOiozPa8ORKy0HD4kBoBE86QtPwLudBimsP8f5banAVqt0WXdq+z3XNEVZhqAa6NLaCio+fO6tiQAJe1Bru4NQjRB8nu2mn6TnMmftdfcYtw9xXKHNqAAGEXRkCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=X4wfE2Bi; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1721302135; x=1721561335;
	bh=YqXULOXBiO6I3qT5sax6NUnclYLueA776MI/l1Vr56Q=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=X4wfE2BijqzkxfnMuWJq8fjSDZuM1mIFHPbLCCUPXd9KcRwbD99Iqvu5C0VgCmVdE
	 TBLQu/f9hZzXZetGurwqZxNeMueIlWQB2w3wBaeakrk2C/EfLrFvM/ME+XdCBv3C+V
	 RzUdd6z9Ni+SJD99wJ2/qQQ1IBSAVqkCm1GhCEtTomn5WyjHZwQYbC7XmnI4HRc9u4
	 EAz/9YyIo6fDVOzX4leGWV9d2jQ9/kd5X6w1E0I+iZejIJBg4+lYkecZ2Rf7eCS6ap
	 vekE6RH1zFQO5WQqrMPBkEJHzSsPwIjX+uu2DiiW1VHZjatkUq/+BlLhXTeiwQVZJ0
	 2sQ6EOyVsSMrw==
Date: Thu, 18 Jul 2024 11:28:49 +0000
To: linux-kernel@vger.kernel.org
From: "Lin, Meng-Bo" <linmengbo06890@proton.me>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v2] arm64: dts: qcom: msm8916-samsung-grandmax: Add touchscreen
Message-ID: <20240718112454.6095-1-linmengbo06890@proton.me>
Feedback-ID: 112742687:user:proton
X-Pm-Message-ID: 15df56a09ed5c9d39528bdaaa65da8cabf4df811
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Grand Max uses an Imagis IST3038 touchscreen that is connected to
blsp_i2c5. Add it to the device tree.

Signed-off-by: "Lin, Meng-Bo" <linmengbo06890@proton.me>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v2: Fix comments for &reg_touch_key
---
 .../dts/qcom/msm8916-samsung-grandmax.dts     | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts b/arch/a=
rm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
index 135df1739dbd..5ddb69bf8e78 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
@@ -47,12 +47,34 @@ &battery {
 =09constant-charge-voltage-max-microvolt =3D <4400000>;
 };
=20
+&blsp_i2c5 {
+=09status =3D "okay";
+
+=09touchscreen@50 {
+=09=09compatible =3D "imagis,ist3038";
+=09=09reg =3D <0x50>;
+
+=09=09interrupts-extended =3D <&tlmm 13 IRQ_TYPE_EDGE_FALLING>;
+
+=09=09touchscreen-size-x =3D <720>;
+=09=09touchscreen-size-y =3D <1280>;
+
+=09=09vdd-supply =3D <&reg_vdd_tsp_a>;
+=09=09vddio-supply =3D <&pm8916_l6>;
+
+=09=09pinctrl-0 =3D <&ts_int_default>;
+=09=09pinctrl-names =3D "default";
+
+=09=09linux,keycodes =3D <KEY_APPSELECT KEY_BACK>;
+=09};
+};
+
 &reg_motor_vdd {
 =09gpio =3D <&tlmm 72 GPIO_ACTIVE_HIGH>;
 };
=20
 &reg_touch_key {
-=09status =3D "disabled";
+=09status =3D "disabled"; /* Using Imagis touch key */
 };
=20
 &sound {
--=20
2.39.2



