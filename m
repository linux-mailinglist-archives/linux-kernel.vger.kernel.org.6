Return-Path: <linux-kernel+bounces-348043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D998698E1E5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77AC01F23915
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166CF1D1E66;
	Wed,  2 Oct 2024 17:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="LWaYsaNM"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EBEDF60;
	Wed,  2 Oct 2024 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727891550; cv=none; b=ckaszaGVYslh3yZHkSTf+4SnHVi0yqaW5eh6Gs8bKIuy3BTJIU/HTvZHY33GxtARDePcF0G+KtH/1u6zhsVBoRxlISj8HSoC2+h3sd5zjvmiit5pTT87n7IreYwbr/P4N4qH1YFElVqqIeXfuKDsxgiOdCbQRnTo5NSeiUVL3cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727891550; c=relaxed/simple;
	bh=uTrw4SrryNvn6InxsyxZL+gbuPKxZ97X5bZokEw/nlc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=J6o9sXnRE8H320ysId3ShoP4PZ4HFGXTvGZBUzKceiGPQYLgYwKMOHu81Ya+oUg3CqQkAvwgmbD8fKYXsAaMNlR70v+KnjNyw0PIjsGb6Z63Dm55d6Tb/NigEgNEHpgQu+7OH96lHbx4rMItJK/RhAShljJRJ6hvJzpY0UXWFY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=LWaYsaNM; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727891539; x=1728496339; i=markus.elfring@web.de;
	bh=/4htlgmNOIpnL3ZWdVP9cxfcz3ccpDwRCvCU43T8BnQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LWaYsaNMcq4jZ1s+0EhhdiC3aoPFZhM6GA+Rg8FDDwQewqK7vV/DLMKg+GhPrMPW
	 F0lL5ZamNqbN3ceKIfB9tmxXt7vEeEYPibquiRpEZ/UUsDZ55BX9YKd65o2r2oOYw
	 diAVJRgcqmT2ZTZJxKaSBOrSItl3IonZe3bsCHEqRzKYxN02V3zLvztH6jN5pvyiM
	 dBYBdY0HuQ9IisQ+hTPKeQrXXR4lGwdG+yq2cYSIKNpji1TioYV8LA8HN7sQoUVNy
	 hJhERebgFXvrDlBWickeMY7AdyDrWbXjh0jLbyPtSn4kRl4BzA7CiClcA97wtheLq
	 HoWG2Oob+C3m+dIQIg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MyNwm-1rxVJX2IVY-00y7gA; Wed, 02
 Oct 2024 19:52:19 +0200
Message-ID: <49260a2e-a510-4d44-8644-38863abb16c1@web.de>
Date: Wed, 2 Oct 2024 19:52:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] ARM: mvebu: Use common of_node_put() code in
 mvebu_pm_suspend_init()
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
X-Provags-ID: V03:K1:p+/V3X4CFavE4EJSJaE3cOy/xoxIKY5G8O/fQp76zs5y1tvRTSo
 HUK0lzD3KoNgKrmrRqX9P/T1g0wlcTP+Hgx1+S4DpbbRdDU+ECiVM045amWciyUxr00DOU1
 Kvu4NajWFCqCwMr5L06zx9BIz0zHIk/uRnHM1ooEWQR6Bg/I4V1QD7vIa8/yjpGE4ZUmJZc
 gqqtP9psxjHMcNTREyxkA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7BtfUe1FrO8=;JBK5f6N/sPChrYT8tkbRCoIH6wW
 yPGl2ZrnA6ZPV5OQei2w2xG91JMJK5AE1uscDRcit3prmUbyQ10s/olPLZI13MkJXD7w3nUkH
 yaA8xNa9D6aIptjnx0OnRCtdKyC+K+F0+u9AcDkQbINk545rrbmcWufLMFQhOCF1sC7dSwckJ
 fNf+ndSig0hmJWS992xNX0WCPHlMoCBKRbvtyGDdSvnXB0rsXmDMCE/vm6U6eIQFbnzN1faC4
 pzFU53X/g4OB8xiQVqJ5f6sZ8GEx50WqkJoD/kgWvYaxf0XRJ+hrgWIqFPJdrSr6pUywpW4fi
 qdSO/oWFMIGpk6EU1rHqC+P6yhpAfOsOmIN7MHM4NJ6T7/MMjbzoLE3iZOebY85mikrM/xO0Z
 9H/hvHhLjcmY/6DpHXCDDpRYo9nMk0hVJ3CxqVDWFFj/cl+W62HUucLqHvbEJ8M+4P2moq4Xm
 33ZFa8kQ1X8jqHJ7HQSFEV5sUU8KxULh50ZvZubLsjqxthZeZi5E2IGrWj0XtcjKfpC7Ia948
 1B4fyrjc9mUUQbKBWyKD4q4xSj9na/5Gveu2e7d55TSeD/8AbWgBE5SDxafY7tEZ0Tbr/yYgk
 S096WHL2gDfc2J+sICSmojo5KMhu+pdW5Ku7YAsr8pkZVKHKn52Leba2wiEgBm9NtSwgIMURo
 QpdegMvR7wja9gAPnrcZ6qsxZtDlS0t/Mk6BXm5gsaympm+uhkc1gOM4Nt00oPw05yA+dw4fl
 DP7NDOL/rC+RBQHrDvV6r13ZOqMm5Bvz6ZHpqLtSGT4c2Hr5PGgIdv8SiO/HAkw0vZrgt8eq+
 sQkYA2IkQYWJ+j2//YxOGJVQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 2 Oct 2024 19:15:09 +0200

Add a local variable =E2=80=9Crc=E2=80=9D and a label so that a bit of exc=
eption handling
can be better reused at the end of this function implementation.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/arm/mach-mvebu/pm.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-mvebu/pm.c b/arch/arm/mach-mvebu/pm.c
index b149d9b77505..cd85f2c56836 100644
=2D-- a/arch/arm/mach-mvebu/pm.c
+++ b/arch/arm/mach-mvebu/pm.c
@@ -235,6 +235,7 @@ int __init mvebu_pm_suspend_init(void (*board_pm_enter=
)(void __iomem *sdram_reg,
 {
 	struct device_node *np;
 	struct resource res;
+	int rc;

 	np =3D of_find_compatible_node(NULL, NULL,
 				     "marvell,armada-xp-sdram-controller");
@@ -242,26 +243,26 @@ int __init mvebu_pm_suspend_init(void (*board_pm_ent=
er)(void __iomem *sdram_reg,
 		return -ENODEV;

 	if (of_address_to_resource(np, 0, &res)) {
-		of_node_put(np);
-		return -ENODEV;
+		rc =3D -ENODEV;
+		goto put_node;
 	}

 	if (!request_mem_region(res.start, resource_size(&res),
 				np->full_name)) {
-		of_node_put(np);
-		return -EBUSY;
+		rc =3D -EBUSY;
+		goto put_node;
 	}

 	sdram_ctrl =3D ioremap(res.start, resource_size(&res));
 	if (!sdram_ctrl) {
 		release_mem_region(res.start, resource_size(&res));
-		of_node_put(np);
-		return -ENOMEM;
+		rc =3D -ENOMEM;
+		goto put_node;
 	}

-	of_node_put(np);
-
 	mvebu_board_pm_enter =3D board_pm_enter;
-
-	return 0;
+	rc =3D 0;
+put_node:
+	of_node_put(np);
+	return rc;
 }
=2D-
2.46.1


