Return-Path: <linux-kernel+bounces-330025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8F1979895
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 21:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DC121C21BE2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 19:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A7B1CA68B;
	Sun, 15 Sep 2024 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="uqsqDBT9"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F54282E1;
	Sun, 15 Sep 2024 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726429896; cv=none; b=OGULrxWivImLvUtShK2fQZK1GNFGBIjhYJNIpTMbGO4To6+izo/955rkFcAiGGPqfOa37h4RQZSDM5i5mDuTBO0MdcbW+mahqQtMosM9skf7gUb0Knbx/bTD87xo5noJBlUWDFKUJM7EBl7eF6BOq7BEzdBoSi5k9ABn/Qs9yiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726429896; c=relaxed/simple;
	bh=0UuypVRhI3OYqySlH6DuHagYyvpkXcBM3mpY1WfV0Js=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=CuRWBC51JjpXPsAJGoMR4ipYjAd6yZLmESJWrBHq1aTbaEiEcEbjMjxG7wJIFsAMOwO6LBS82POT7W45QLemzbj3G1N/iYAhHLi05nmtWXv9Ja+mMRj0izpUxBeO0pj9Bzksmrg0KOZH1YTz12HpmvXeFRs8J7nsWPnlLA0c4lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=uqsqDBT9; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726429851; x=1727034651; i=markus.elfring@web.de;
	bh=JYhHe/vn52M+SkCr5mu76grpnTx9QsX8i1hOWvTC6qw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uqsqDBT9PS45+IJSlQLdK+rEv308QxsUemtfux6vEOwaLQZwEqhKFEtBhCkhcOeK
	 HrJloEZUUrVgyBIh73pu2wDSCkPHIEI7uxCZf3y+6RWpL8C7TcB3sFpqC8C8zBcbA
	 nrkN81u0jPxDYr7xuFbPiVX4frKBr9LTauz/FYMczuMLPfzbRNTYGbzgm+t3oaRM9
	 tj4uNbJ2QBuF1PiGr226S3M4eG08Pcmd5OOY5YvSMqAkHLHZZ6loXxmKVDqekY9CE
	 j0D3JoBqDc6DPLXBxHohzRnbgXeF1KxVirDMbGAkrxYS/l6XQXblMloDl1PYKzjil
	 3nb/xv3YmFdYb2czFw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MrwwJ-1sB2cA1svN-00nF9d; Sun, 15
 Sep 2024 21:50:51 +0200
Message-ID: <21094235-3f45-4a67-a463-7b4658b9ee06@web.de>
Date: Sun, 15 Sep 2024 21:50:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-sound@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Julia Lawall <julia.lawall@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ASoC: mc13783: Use scope-based resource management in
 mc13783_codec_probe()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8YcRWMoYMXQu0iX8DGLzi4zPscKNXsf0hnhAtSNPlyr1pewaRAo
 FpCmQ55xW8+q6EYrvYvprhZqk02h6bjNZug/78EwKIhTZoqzghOiJFlaSlUtx4GAXLTW9Rw
 my0rgVG7xNgZSN+4d0FpXLxhIZxcqPpcBwZiScVG51MpI92GR2JgEgOrUKqyFY+NTsYNYSC
 MwbWfuiJNMXsLhEEsd/+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zALt2tqVcDM=;ZlB0o1NW9IEIufwgYIBjd5n1976
 vfdKKtmoPxiugep87k4MmXunlgPc2ZCzqDekcXkGS6We3UFeJ6tFa/TEV9n3NXsp7rb3QZGfu
 oyIhS+miPE3YCMo55Z8umAd1tn7/J23tUjM6wJZb1p27MINLDtwi1zOmRKpPx997c3guUF+TC
 rhaRJsA0Vd4GKqZli7Iafv5ED4GP8j2asLqH7OZqtMh8aYeIouzqi6ktHLoDQlvHgfWkSL40O
 6QpS0O1kRszNJiJ6SgyedsM7s/5tGVrtTKvrPfPAazY8y0UdxZzg4e3owKM+OzFDde7Y+VP3e
 DymSo1FCfRC20QKM7sPDU2C23bZM/ekunugoLJyarcZi1nfVQjrT0hT4YeTOMS0YYD07E5Urf
 /0PHVwf9VP5Uf1ujOVcJAfdLScjLO+LeArftMqIRTiaVfhTbkl0xoCeKs7SdSA3Rerqhu3nrd
 epS1tcHxBEVDPQ1w7kPfqrI00j0UKsv3izWs0K8K8Cjapei4Ts6/38Ytz4S0PAGz4aQmQ0J65
 S/tOF6w4S86EHueGhIGvc61miyggyulpoUU/Rf6jfcrVqqocxpgh5rm9hRkQfO4b7Ttx3SaDL
 JDGEIMb1BbHbpYQ++cR7mal/sZfjt03DJUD2rGuCSAaB0n1wdxANxjbWgDhUZZSEBEq3zxquV
 DMHusUXdw3FF3Kagf5v+h9doIhmBm+q3dInf6em15Ni5vY8tbuK6nLcZEPipAFagB4wSWvU51
 PkZkBzT484MTu2z+CYhTyTu/RW6fr64VCG+hTnYKMFnYP+vjwNYnhC0xe/9o06OkwHfp8OoW3
 aKcNyRCs+X+XCcBne1Bq+N7A==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 15 Sep 2024 21:41:00 +0200

Scope-based resource management became supported also for another
programming interface by contributions of Jonathan Cameron on 2024-02-25.
See also the commit 9448e55d032d99af8e23487f51a542d51b2f1a48 ("of:
Add cleanup.h based auto release via __free(device_node) markings").

* Thus use the attribute =E2=80=9C__free(device_node)=E2=80=9D.

* Reduce the scope for the local variable =E2=80=9Cnp=E2=80=9D.

* Omit explicit of_node_put() calls accordingly.


This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 sound/soc/codecs/mc13783.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 086ac97e8386..ed894bfc6a1c 100644
=2D-- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -733,7 +733,6 @@ static int __init mc13783_codec_probe(struct platform_=
device *pdev)
 {
 	struct mc13783_priv *priv;
 	struct mc13xxx_codec_platform_data *pdata =3D pdev->dev.platform_data;
-	struct device_node *np;
 	int ret;

 	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -744,23 +743,18 @@ static int __init mc13783_codec_probe(struct platfor=
m_device *pdev)
 		priv->adc_ssi_port =3D pdata->adc_ssi_port;
 		priv->dac_ssi_port =3D pdata->dac_ssi_port;
 	} else {
-		np =3D of_get_child_by_name(pdev->dev.parent->of_node, "codec");
+		struct device_node *np __free(device_node)
+				       =3D of_get_child_by_name(pdev->dev.parent->of_node, "codec");
 		if (!np)
 			return -ENOSYS;

 		ret =3D of_property_read_u32(np, "adc-port", &priv->adc_ssi_port);
-		if (ret) {
-			of_node_put(np);
+		if (ret)
 			return ret;
-		}

 		ret =3D of_property_read_u32(np, "dac-port", &priv->dac_ssi_port);
-		if (ret) {
-			of_node_put(np);
+		if (ret)
 			return ret;
-		}
-
-		of_node_put(np);
 	}

 	dev_set_drvdata(&pdev->dev, priv);
=2D-
2.46.0


