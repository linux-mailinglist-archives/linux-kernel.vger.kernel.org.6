Return-Path: <linux-kernel+bounces-410660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0119CDE95
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 13:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584A41F2388B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 12:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A971BC9E6;
	Fri, 15 Nov 2024 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="VDNS5mud"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8B11B6CE3;
	Fri, 15 Nov 2024 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731674783; cv=none; b=c2YagYFSQ7e3zVdrmr9ELUullnHQXrCyP1SUsQm9oLRoAkUqi/FiUC4J4Sdk9QOE9uAIU/VaVEOq8In8wAYV0bNPnu4/J/chb67ypso0W/LVbir5dNZeysi7Vrw1CFEYyyB8F5CX/7o/9AqMukXKbdPYF+Vorj9BD0ameh/WxHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731674783; c=relaxed/simple;
	bh=QVuaUSvmy/mhWm+lc29DRjWFrc2PsNoMAp2YQuh1c/s=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Or+c37eVlwv7jjQCyxbJGsahm5E41o71MsRdtrCB9tpj5B+uurALPVsYQY7+JFhFr28V8JFDsTS6kb2yzQ/zH9N0+TW5XHuHGny53GCK/yisj6Imc8/ljGIgkhlEI0dV0Y/Nro08qMeZ5wu2A16xXiuTtPevTlfu54OoRSVdaDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=VDNS5mud; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1731674762; x=1732279562; i=markus.elfring@web.de;
	bh=b1h073xk2VbAnT3Phba46TVvE1MlsVQw4HAW0gXyXlc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VDNS5mudP2zKJjiJVyDVjin6mZYo9d50ORfgWfpSmTeqz2S60cy6qDedarZB8lFE
	 T2DwR0RCPM+OgCy9iiy3R9eTjHP3cU6dO4WhaMjPcdBeOrJP6VNFLVigxhFe8K02V
	 waW7UX7xSDLtYoyIPdbXJIXil2EPNAYMDfBce3Siu5HTF6ddT0OnpWyr3/1aygyGB
	 IZdXW0mGsOARBZ9FRUpqjPv1zw93aBIJ9/taV0kSbClvzwCNzZNwvLB1kbOLjJ9Um
	 9/aXr+cVvcdvgils+h6Df5FYeAur/AJVQICyfdqr4Mk1tnpVKeUHppc2401IvLNpi
	 9gFmKYZKJCWc6n7s/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnG2Q-1tbP6k2ebU-00qZyC; Fri, 15
 Nov 2024 13:46:02 +0100
Message-ID: <945b113c-516d-4d35-9d45-224c03a344e4@web.de>
Date: Fri, 15 Nov 2024 13:45:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-hwmon@vger.kernel.org, openbmc@lists.ozlabs.org,
 Avi Fishman <avifishman70@gmail.com>, Benjamin Fair
 <benjaminfair@google.com>, =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?=
 <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 Nancy Yuen <yuenn@google.com>, Patrick Venture <venture@google.com>,
 Tali Perry <tali.perry1@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Rosen Penev <rosenp@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] hwmon: (npcm750-pwm-fan) Use
 devm_platform_ioremap_resource_byname() in npcm7xx_pwm_fan_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zvtwJmbmg0PXPGIXT71pqkzzYsC/7bRRW3nuOzd86p4fLSesLTs
 QPiqTagiHgD0mYjEBLnYpdkUStiSMnevQewINmsgsF01CLSYBdfMH/jnmx8vB/LDe/riTmO
 Z56lzISgaxu6TLOrz7gR5UYJoTPj2liwjhQQiOjnzup3/ipTdYWHoF24Ibfb6l3Abppy0vc
 VPbC9+kojGVxcwGdRmqxA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w0BWDFwVXKE=;TH57WovQEGADRNMK/dam/KRqdb/
 VvAmLQqZ0QL4arsIs7geyZK7Jz0SDQAFmG5Esva37z4HwcBhiydEIf56cTfktZZ1+kzGC3PQf
 exKqHbRRVwEv01A36q7oKclIzAaVLWjgWUsnRQKfYHwKEQm22TKBuLv9vpcbZBju+csfZKT2K
 zkgSk9pCc3qfagjckZY20HjORz6uQ3itUsW+sPeIxCb2SZ61LJQXOtnue4uMghZy5fZgpNNvu
 rvp1+omVKRyeiLEIm1zbzQkpwLUI2lPRJCaQuvRDsn6p8WFH00BVte3dZIxqNqugQVSQgzxcG
 5eSksRPG1cgEjUVrJPo6JCTzgDuqktunt4R8ZZThJ5RbmWPCWvTiqu4+Na4h11HoEL92vmT68
 OiOx3Wl6G1twIQbT5sNRcIYqjev08sQaxDTD99rhEqWc05Il/3U8TIRPqn26j+qqaWoSJgdZT
 pfAHh4553bGrZcg+ul5GqUv+NWnb2355S1z5oiKTidu0ftEZ9mm06UfW4kenAyxNgToO/DHKh
 7LsXkgoGsrvAftYoV/ZnPwju30hHRh83ZeZ4BudFhrdsaQpOeWsq9/DwiEFrEtYb6wuMq1hK5
 WS/FZm+Ykie4g+iFoASJfRRG5h79xThbETvVgSdNbMLlbWCrfWQj/0RGnnjsGrzeGz73UA+6T
 Rxk9xJdjUWIWn8l0zTGIoo3YjNRBfRwmPiYFL3rdW57Ahl213tejPJkX+eguof886FBLf2vUv
 DkScdqHKJmTfLqSbdM74XcMcIFLmfqsgk9nx5arK7bod1L1heDzyxXwytRJI5ZYXVxnM1CgA4
 uMFv6IBQn2D6S0WwJqFGDKekUcjeB3tN7Pa65Gri4xa2W7N3/kYFO1F6pCYAgE+8Ziz1Lz4kA
 lVml/srN8D92tr/9g9glcLElPTANnmh1aPrHeurhRJNmsjsa4Q1X2G3mY

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 15 Nov 2024 13:30:58 +0100

* Reuse existing functionality from devm_platform_ioremap_resource_byname(=
)
  instead of keeping duplicate source code.

  This issue was transformed by using the Coccinelle software.

* Omit the local variable =E2=80=9Cres=E2=80=9D which became unnecessary
  with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/hwmon/npcm750-pwm-fan.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-f=
an.c
index db3b551828eb..d66edb184bca 100644
=2D-- a/drivers/hwmon/npcm750-pwm-fan.c
+++ b/drivers/hwmon/npcm750-pwm-fan.c
@@ -929,7 +929,6 @@ static int npcm7xx_pwm_fan_probe(struct platform_devic=
e *pdev)
 	struct device *dev =3D &pdev->dev;
 	struct device_node *np;
 	struct npcm7xx_pwm_fan_data *data;
-	struct resource *res;
 	struct device *hwmon;
 	char name[20];
 	int ret, cnt;
@@ -948,14 +947,7 @@ static int npcm7xx_pwm_fan_probe(struct platform_devi=
ce *pdev)

 	data->pwm_modules =3D data->info->pwm_max_channel / NPCM7XX_PWM_MAX_CHN_=
NUM_IN_A_MODULE;

-	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "pwm");
-	if (!res) {
-		dev_err(dev, "pwm resource not found\n");
-		return -ENODEV;
-	}
-
-	data->pwm_base =3D devm_ioremap_resource(dev, res);
-	dev_dbg(dev, "pwm base resource is %pR\n", res);
+	data->pwm_base =3D devm_platform_ioremap_resource_byname(pdev, "pwm");
 	if (IS_ERR(data->pwm_base))
 		return PTR_ERR(data->pwm_base);

@@ -965,14 +957,7 @@ static int npcm7xx_pwm_fan_probe(struct platform_devi=
ce *pdev)
 		return PTR_ERR(data->pwm_clk);
 	}

-	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "fan");
-	if (!res) {
-		dev_err(dev, "fan resource not found\n");
-		return -ENODEV;
-	}
-
-	data->fan_base =3D devm_ioremap_resource(dev, res);
-	dev_dbg(dev, "fan base resource is %pR\n", res);
+	data->fan_base =3D devm_platform_ioremap_resource_byname(pdev, "fan");
 	if (IS_ERR(data->fan_base))
 		return PTR_ERR(data->fan_base);

=2D-
2.47.0


