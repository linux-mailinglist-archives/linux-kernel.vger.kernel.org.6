Return-Path: <linux-kernel+bounces-348041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6857998E1E3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05F8DB21AD1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACA51D1E66;
	Wed,  2 Oct 2024 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="u/iYR7hM"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72551D1314;
	Wed,  2 Oct 2024 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727891423; cv=none; b=ouDwOtQPDsmLYPMmTWgH5NtzxHWm2vuC4ttrtiqH5KJxGsyMPQ5ehltJ/FrCLtwYsuWRtgE3imgYjuuBzDRe1huB3g9zctiN+IpdBpGlIIMqrvrCxL8tmhMjlQlwvCLMf783Kr2Iw3rAZALe8MO/YWIrTXXvyeYV0Xl4Ly8IzRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727891423; c=relaxed/simple;
	bh=47fatvpcnYWQ4M+zQ3HnMj664dAgSz2QCPinIDp+9TI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Cz/Dzw2eoAPUIv+Y4g0GgfqW4SPFrR4rDCe6niNBKFpKnbxi2FaWOe/AF/qjkZjFFL/MnSt8LCovAiN/GdVPaWUpniBVpvLd2B+HYgHHfYQtmaRKTJhfXBqn5bo5fHsCLxDh9k6xHsLLb9H3HSJSl8IlVHLV+6FsZDDzb3rHzFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=u/iYR7hM; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727891404; x=1728496204; i=markus.elfring@web.de;
	bh=9+tbIUnTt4a/8am5hF5w0MAc7rkV/fOrFs8cjHSvbYI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=u/iYR7hMMebxvoYwiF1L95igZc507p5BErhiYs2j8q7Bq/tep83NiNhZjhBE2Dy4
	 klTxiSQBkFB8wQRVZXCrblDcHMuiZneC1O+dlCPtQpftaG16eE8tOUOdMz2W+5uvx
	 q3vEr3DuejOcLL0oX1Ilk4O9sA5M73xHv3zXZHSEGzkz0/AnXQgeEE1VTgDvJOGAY
	 EgJBp4lnCTKVyrDJCT4qIBj1gmncFdps6YJ965SYKHvd3RdBqY/SgJeivwoSIpQsE
	 VeDiNr5JNxY4rn9lFcmQTFg3/40h5aGjA2eQFe1OoCY/zQYFNge1q1G9XlYcXfXqk
	 wBv5vagR1Tl5CrjLPw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N9cLR-1rqf4D11Wv-014yJT; Wed, 02
 Oct 2024 19:50:04 +0200
Message-ID: <c8377398-8835-4e73-a253-03f61928974a@web.de>
Date: Wed, 2 Oct 2024 19:50:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] ARM: mvebu: Call of_node_put(cpu_config_np) only once in
 armada_370_coherency_init()
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Russell King <linux@armlinux.org.uk>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <ac69dd2e-b4e4-4f70-b6c4-476b92160270@web.de>
Content-Language: en-GB
In-Reply-To: <ac69dd2e-b4e4-4f70-b6c4-476b92160270@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m5vIIPSZoADKCbGY2A8GWNnm1j2VylPZVBy3RyMdeOdMcdDjJLo
 usJ4gCliqMBVSJ/JPUjtozGDs6qBWhn3NTAPzgwAi7Uv/oIVw9RDauKt+TMq2lDYjpnW82G
 WRpMn8f6wEeN+UVsGbzIv0Wohn74Dn23Z6JRAWpQCxdptvEQDykIRJuA3LiJ8wo2DrF503z
 xMOVwsRMUFzdCFLO1R79Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8v19PMwUCp4=;GH3azTOGEsKURqrbj1flHC8B34l
 ljxGUGDp5l4Cr97RI8oTtEsN0Wcvq9NGlvpzLtQco6aBMSuLJVcYyZtPeev9HiAoyMbENBbq+
 cqV5b/PWPZ7zgrjTv/zA9RDQybBi3+Cn8bi09mDuOo6J0FPcaIEEDHcM+u0JvW7oZZF/FTrL5
 +XJWnOYADaHeBFj8IQbDYEZBNEmmYJzl541mGFSaElJZy3twyt/dQ5Oaf7gJ7+CqMerUZbdkI
 CvLFYrqu4Fl4+4fd7qJx27D2T6DENjbw8E+1URtpCvoIahu1jVzI9IENuLmDcYyMT2Gaa1U7F
 fIEGQRHjmgiDZpaP9DNctsFivV/zydVSlO0WECTS4ySQAKpc8ORZpsZCW40lGa/A6cita63/N
 yCbqCS7g6b1y9wm4smU45HK23x5sMqqfqLMY0S1q6GE2/BfuSnjo0kEZuo1Yj9GAaFunVw7Co
 VWuXAMYu+H4K9Yh2nJzz7JH9riNCdsiU3lSJVcmTr6PMCJwEgnjlc5z1slmEr5BBb7wkjYLul
 4DgQpJHYTRIlaI/q9ZpZPKGxT5PhVRy0uemaZpLZqVnWXRTLAkVZ2Yz4Li7kxH3D1CBwZ8QOX
 cjMNtf6Bpmb+A/EeP1H8SyjUYjbRHU6+hmuH4wy4241mzfowVv/2zIL/860H43PG7L0mygjME
 8MHfcjyh8v4+8r9v4+jP2qxKtBdzy9q2MAsAEgUb59WNlCmPuxfu4v6IFvcnq/74l51S9TvDJ
 E+/+Vt2/pD6KgFfBFxespkZnx2t2AArT98lNLmj21CUMT5BSdLoZzcOU+pmRqThYzNcUo5WFj
 MaPekFFEjqkd7NGLtVdYZ02w==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 2 Oct 2024 19:02:28 +0200

An of_node_put(cpu_config_np) call was immediately used after a null
pointer check for an of_iomap() call in this function implementation.
Thus call such a function only once instead directly before the check.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/arm/mach-mvebu/coherency.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coheren=
cy.c
index a6b621ff0b87..262410ccc4bd 100644
=2D-- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -137,12 +137,9 @@ static void __init armada_370_coherency_init(struct d=
evice_node *np)
 		goto exit;

 	cpu_config_base =3D of_iomap(cpu_config_np, 0);
-	if (!cpu_config_base) {
-		of_node_put(cpu_config_np);
-		goto exit;
-	}
-
 	of_node_put(cpu_config_np);
+	if (!cpu_config_base)
+		goto exit;

 	cpuhp_setup_state_nocalls(CPUHP_AP_ARM_MVEBU_COHERENCY,
 				  "arm/mvebu/coherency:starting",
=2D-
2.46.1


