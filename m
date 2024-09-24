Return-Path: <linux-kernel+bounces-337069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8035B9844E6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13671B278CF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92811A76A6;
	Tue, 24 Sep 2024 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="hYqDPRjj"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA6B17ADE9;
	Tue, 24 Sep 2024 11:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727177714; cv=none; b=qMJ1dp5dX+oDRnJExcSS+EiMLsCLloCBl6usFU7iKzP+D2gZzi7/tt1dFASv0VRvWY9bHyjtQatj4QE8jp3i48m1367wNJ88LwARKU7IHsqDfABawEtNuYcDj6DywODR1aX7lQfaGZusJxgD3vz6DKrEUyp4S9Pe6ZlEEgy+5mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727177714; c=relaxed/simple;
	bh=dz/SludDC2pUK4X7YSuOpt9ecp3pGUsyl248hHckQec=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=JBUpBa/3xLMv8Bq3opr5kHBhyto2v6MdSj9q/LK6c97DXsHC23kxUWbfaM2yO7zfpnDf+FMGmzJ5sn7+o3WpEToapNVW2hhWHSm4YPeIYHWIL/oLp1vMXFRdi+XMrOs0RyunDzXUzqjJawtbfBAyteBh5A69L/XOsUSVcmcADHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=hYqDPRjj; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727177686; x=1727782486; i=markus.elfring@web.de;
	bh=qnJoj23YlAnI/8ta3vC+QQ5dYZyF2XfNfXgGjgBnawE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hYqDPRjjiO+n4HqUV+4+bTwNECR/EUp/+aqZJggZ61LMHbBUCjaaSN59TNRKJeEK
	 MQCsznIXLmUEkA6ZsYbAQ/0hFOIpS3JWDJfgmuhDx3jt483zYtP2igJ6kQCluhmkR
	 Q7GqyFqw4Lt+y/f/lbAkzua50HUc2J/smqQLmqLFeXiHFIGdcHoBGawd5JPxNMaVk
	 H3gmYAB9o9BUEQr5bTuNSqc5hDOEehtd+fNxNRlY2hozTeU45bPqDjwrZxgGkKaiW
	 rGCRq5blESrAQ0WJMSHwtzj+v67T+2QZcbmTg6kPT+ErHWk5PtKw+BiGn8KP7n6RR
	 xKwA4BVGqH3dgWimDg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjBVh-1sGiih1iGD-00dqHG; Tue, 24
 Sep 2024 13:34:46 +0200
Message-ID: <f9d7a026-a67a-4164-80f4-578b1fbf71ac@web.de>
Date: Tue, 24 Sep 2024 13:34:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: kernel-janitors@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] regulator: Call of_node_put() only once in
 rzg2l_usb_vbus_regulator_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mVjUISKgkQLPmyTzZOx6rE9jdjtSGH222JbkjvyMEtZ5f24wXY6
 75H08/RGE1N7fu9frCv0JxxJpelXRg2fb7xANUKhd4XLWt3yP8CjQveD4JkmsfX3xaXlVXj
 wVWX7DozmkNieO/kjSZ6sYX0y398Y2eYvA/lUrroU1ANNKZqMQcuAzlxmZbOhPruRiqD4T5
 qgF//XSw6briuBiNM/zhw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:e+unhALJO8s=;gAjz+6V2Is0hI7cWCScgWqSOyQm
 3EG/kXIARbHE58KeC4y39SHuZUd8iue1Mlw07HxXDjIlxiBFj+F3JR1KE2pMqYnZ/0UCTijSi
 4yPKIl1M9Hxn757+Q4jJJ6Fakb79mLdoinlgipExIVqFwC/8hhHCu1jEvw2tdCOGXu9BjAxtf
 YGMiH/kb/d4WOc1VX2K5ir35iMRDBGcJ0oYdrCqlLJhFclnB48ta/wHwhNmwLnaTzo5Vfonlb
 HCFdxLa+9ss/JMHzD5xwoiDiKF1NsdKyGAA9AnpT1Qf2w7yrAs6O/00hWavoS8J77L57s/vok
 2vG/jhxlM+hva2jizJnicFhWPyY25ubjdHKSYSL1rZXbNl2VEROE2fGBdGQI95uOkNHLdpU7y
 0uE2GskH6jPUizeaFOsxyQhRLhYwwYOWVMJj3W13DV2F+4vF6tCzJse0BL2RuKapKZ4pH4aa5
 /JYQd0EoHecK1FKHfhyibjdNTl5rRhIZ1gtltBorGoDKpVsYObYBiFUXo5rWf74NBJL5yxcCA
 ZzFe6BfcKzY0FZIWDalZu+rtQ6r4HRmOngFEq3Muwa3ThaJBIUearFDbVDF9/RZ7+s0yq8buh
 ZjmRT0XwE6pNm7hFIuvWlRQOGEDPWX4BSIClSxvVhGyN8G913GtHxGCAM/Lc9dQ5Ov/wGw7DO
 NculDzc6yD0f/p7wLVV2DR23JXTzzoTwog5+eifx4QC3FaCjnhtIOu+3ZnaJzXBuaPhQXzGW9
 ITZaZ/3CG1b4EjK5SDdmgX8JN1OYZiLYFstk/tySWRBDdVnsxqn15k4D8E5InKK3JXwi1OQt7
 iQ4uUiz8wGUUu1O+KIk4e0bA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 24 Sep 2024 13:21:52 +0200

An of_node_put(config.of_node) call was immediately used after a pointer
check for a devm_regulator_register() call in this function implementation=
.
Thus call such a function only once instead directly before the check.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/regulator/renesas-usb-vbus-regulator.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/renesas-usb-vbus-regulator.c b/drivers/regu=
lator/renesas-usb-vbus-regulator.c
index 4eceb6b54497..dec7cac5e8d5 100644
=2D-- a/drivers/regulator/renesas-usb-vbus-regulator.c
+++ b/drivers/regulator/renesas-usb-vbus-regulator.c
@@ -49,13 +49,10 @@ static int rzg2l_usb_vbus_regulator_probe(struct platf=
orm_device *pdev)
 		return dev_err_probe(dev, -ENODEV, "regulator node not found\n");

 	rdev =3D devm_regulator_register(dev, &rzg2l_usb_vbus_rdesc, &config);
-	if (IS_ERR(rdev)) {
-		of_node_put(config.of_node);
+	of_node_put(config.of_node);
+	if (IS_ERR(rdev))
 		return dev_err_probe(dev, PTR_ERR(rdev),
 				     "not able to register vbus regulator\n");
-	}
-
-	of_node_put(config.of_node);

 	return 0;
 }
=2D-
2.46.1


