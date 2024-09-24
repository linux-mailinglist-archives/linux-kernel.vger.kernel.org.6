Return-Path: <linux-kernel+bounces-337490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A7E984AB2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649C81C22E60
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD881AC458;
	Tue, 24 Sep 2024 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dIQ49qPd"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E424A49641;
	Tue, 24 Sep 2024 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727201322; cv=none; b=JEMZGibP/zQy2nqvGydu2C+MtyXdZiH3D9W7+FNanSE2qGBjRNGv7tMTlkSjEFFBTTmkDohjfNK7Bnx69BqOAamnSWHlSuyv1pghU9ApSTa0839Xse3Ks5dZFyV2k7QZM6eVOqv9GzzeMxMJ4fgfd2QyYRltaJrSyfih4VWeQMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727201322; c=relaxed/simple;
	bh=wPdDTvV/h91f3Lc+ckjUN4AuGHK+sw1cbD1YcA+w0LU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=fmApG+FHIbWxRZ8PnDWkOJk9Z0YVP0Exwxeki9AYzJr4aJiyfEbYXRJEEcrRWGchYcHQsWUc4BiKIj3wUEpm2EtXNzAP3XoS2yrqjsjwro6wQkghoWZ9OqZhFj6JkR06uWXQoETJ61mN6ruHbrRqgk2af03mAM2L3ZJUe7Py60k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dIQ49qPd; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727201299; x=1727806099; i=markus.elfring@web.de;
	bh=tb3KCJ7UtG4RaoStvN8TpIKynQN8TtiZMldU1UU/2uc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dIQ49qPdXiGGwS8BcWZzXMBgBmyPX8DxtkXO7j3X/B9OV83o0gASjKTG9YiEj2UH
	 MWKtWvahbOS6PePwO0nN7ceD/SgAzriTrtCtSV9Wrv9o7pZsdhtNQAWD7pzBtNHL1
	 l70vmLwL+q6JYVypVExC2YedZzlZDbun6gOdrpjVNaywlKXvz/jtywTX/TerAi8J6
	 eYJwWXfa774mSDWA2UQGbr0OKpPncAEwta67aBE0sHH1ycVgp1WhzzVuf4iBwTORR
	 7UGLE8HwZlwp7pLbV+JbdnF1FPvtsppoZrSVVA2yO2Ge3P15d3cmfqR2wkKjIkd9t
	 4fmW5nMGGn/QIMmHzw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MP3CA-1saYm71l2i-00T3fP; Tue, 24
 Sep 2024 20:08:19 +0200
Message-ID: <884f0a5d-e6d3-47dc-8a9e-201bb86b271f@web.de>
Date: Tue, 24 Sep 2024 20:08:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Roger Lu <roger.lu@mediatek.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] soc: mediatek: mtk-svs: Call of_node_put(np) only once in
 svs_get_subsys_device()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EG8pZS8okf7sA8Mkc7K62W2aLChHa5ZpPf6CfVkaDFvCwxohSu+
 zYb+1rHF+6cQPZ1oCupOCYZN9HPbD510gkzzjjrMt7XpghBiVpqyNNPOMrrnXmO3OmH2193
 7Hp4rYOeomZz5gO4PaChonxRPGKf5BBxo/0nW/epQvhCm537Ng1Qpss0EltYSI1Sa4JhwkJ
 L3NPCpxMnstcZDfv1XSrQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w/gSIH+UxEQ=;AxxBLvTjcfLw8tPDXdVfU6WnMQc
 WfTrgtp44ZqQUbExVQmLfQE1utxF3sgWyetgAwWF9JVmcGpu6a/Vi93645Lde5kL5hrkCf8KO
 b0e2VwszaT2JiQ3wwlxLG5Xuiy9NhPD9dl/TFQoZwRei9ZZatF451hqqwsxFOshYlScMTMD39
 EoO//7nZvAWX1if//Jh+KI7eC7m0i+soWbSI0/aYNnA2O7Uwch8SPVSs/haOj9YAJ13QaJhsj
 AQ4w+OEDGgyjwWAcJTMW+7VZTOUZaet4VmmljRJ7jBZ1W5pb3ADvCoNG0JHnRzyez/3d//6rf
 +ewmUwW4yZsgaLt5YJwYNqG7Arzo0p5snAbTeTao8COjE+9Q7iPGAUGDb+QxUQczGflVKf8pm
 kZmoU/0vGdP8tbqJlk0NmV8XPb5ytonAuITyTugwSdrxSVx7b+pd/66dr3ncHSnFa/zzgOXvh
 9h9+13sDYKoQZgEJBvXwNIhj5tYeaf4xJ6gsfxg1OTsu3ccSv7DkPi8st6ixdUFRx5FeaKEi7
 Uf2wx5NSP82TPbkSK7Bq8sZNzWfl1VixByGsGi5kCuB23CEjQbjfZfkoL/icdAs3BtMbRmoxr
 yiq0dSDWUQcJ5J103j7n+2qW5lhEA11VmqwGti4CI2WMkVPZ7Rkf7NbnSSyiXRFqKNWRCgEok
 HwNlwVogkfPPf4KI+m1NEmIH0PdJZrlvfbq82mjRcSR8ebqVIbueYwqFeUQjDDJGNO1FwSKad
 igf+xXKn+SOkFAdTTKH4QDPjV5F0WGU4p/wN/DRC03W4RDqTy+4FVnwMWSP9/u8IJwvEChhG7
 KRiJgS6KwGGiNpzDqYCNGisQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 24 Sep 2024 20:00:09 +0200

An of_node_put(np) call was immediately used after a pointer check
for a of_find_device_by_node() call in this function implementation.
Thus call such a function only once instead directly before the check.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/soc/mediatek/mtk-svs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs=
.c
index 9a91298c1253..7c349a94b45c 100644
=2D-- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -2133,14 +2133,12 @@ static struct device *svs_get_subsys_device(struct=
 svs_platform *svsp,
 	}

 	pdev =3D of_find_device_by_node(np);
+	of_node_put(np);
 	if (!pdev) {
-		of_node_put(np);
 		dev_err(svsp->dev, "cannot find pdev by %s\n", node_name);
 		return ERR_PTR(-ENXIO);
 	}

-	of_node_put(np);
-
 	return &pdev->dev;
 }

=2D-
2.46.1


