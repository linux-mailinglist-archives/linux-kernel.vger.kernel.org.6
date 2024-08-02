Return-Path: <linux-kernel+bounces-272276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E583F94598E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 802FBB211E1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC741C2318;
	Fri,  2 Aug 2024 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="GLbaG3Pz"
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECAD3FBAD;
	Fri,  2 Aug 2024 08:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722586054; cv=none; b=K19dwlf+KGuL6zh+2iGVyhoEjiKeoG3jJpNXAscLV/yjoTlnp5c5972Kf6HFXuC7JZuo2c7JjrdRpT/+bcN3T1Hy1NVQTl1mrchhIUaBlwUIxkHRTiH42oLY8MYEv/3Okhjuwah9SQINiMdRGfPkieMS3Vccs1zC1TMr5YXguE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722586054; c=relaxed/simple;
	bh=ZmQwW/wDeR90OUcShfj1AaExlHjUr7arz/oq1GU52zU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P7QTvNfdDiAKmMfnwRFUnFfUcwQdkZvh7QZD4orzoy3VqKudwTnQZZw6zsDSGbD1Uq602SUFFf7a8migjGoMSM0gVdi0s3pLaKWnMCbl8qzpBmm7gsPaCKkLOce4DVo8XqA79gxh1L/Vdwhg8JAXf16MVe/C9t5sfiTLu8eDcFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=GLbaG3Pz; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722586051; x=1722845251;
	bh=iemyoq2lYHkRLjl5ZVLhpqkXKCDblZObCfWltrVdYyk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GLbaG3Pzs7YEM1ig3c/3IJyH77Nifrs8IWrnM2i76xNEyXtQD72MNVd2ijpvP20Ev
	 eckkc/H93v5KNXcBdU3ePBFYNOlWGF2GIf6JWZDXuK/mbu723+D6L1IkAtIRfACIn/
	 1IwVe+SMuTWK8CVgX8Lylk51QPHhIX6JDigmdF0BDhY6LVTtQ9Jokpoqzjt4jlc/Ig
	 Omo9HJHha9S0qSx6NU3LPiTnva4pPCNjFIqRJ8JFy3aMMALXq9arlIXMlN+hMwkcMe
	 bNmhkDrXKM5PbyL+brJBy8DNFl+ZqjkTJoHOQBCkFdelycArs62tlFRUQmZNVaPAgT
	 fE2VOd5t7rM3w==
Date: Fri, 02 Aug 2024 08:07:27 +0000
To: linux-kernel@vger.kernel.org
From: "Lin, Meng-Bo" <linmengbo06890@proton.me>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Stephan Gerhold <stephan@gerhold.net>, Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 1/2] dt-bindings: qcom: Document samsung,j3ltetw
Message-ID: <20240802080701.3643-2-linmengbo06890@proton.me>
In-Reply-To: <20240802080701.3643-1-linmengbo06890@proton.me>
References: <20240802080701.3643-1-linmengbo06890@proton.me>
Feedback-ID: 112742687:user:proton
X-Pm-Message-ID: 1862562a16d6a63aaafa332366fe9d2e56232e76
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Document samsung,j3ltetw bindings used in its device tree.

Signed-off-by: "Lin, Meng-Bo" <linmengbo06890@proton.me>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentatio=
n/devicetree/bindings/arm/qcom.yaml
index 4ef456cefd6c..c0529486810f 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -235,6 +235,7 @@ properties:
               - samsung,grandprimelte
               - samsung,gt510
               - samsung,gt58
+              - samsung,j3ltetw
               - samsung,j5
               - samsung,j5x
               - samsung,rossa
--=20
2.39.2



