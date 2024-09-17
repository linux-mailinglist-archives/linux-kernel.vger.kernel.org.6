Return-Path: <linux-kernel+bounces-331732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCAC97B09F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EF9BB28023
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B37173331;
	Tue, 17 Sep 2024 13:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QdiBXc6b"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128DB14D444;
	Tue, 17 Sep 2024 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726578690; cv=none; b=DruKSpR0fjLVlhtjchFB2fmqusHsZFrGMd04SUS+GQ9BcVUri9S1Sf9oW72McjvSodRzxpo4oQZCnhj/BuWZcgnENi59Xl58XLkebY7oKRt3OYVk98RTf7ESnVZgcaQvpl2rp9/yeMZhQPCvFKCdlQ2ngy4K8X4GlGt7C9qhjyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726578690; c=relaxed/simple;
	bh=6Ke2LO7s4ZzmToKebEatmGWtotLu0wOhxrNMZgnJtPM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=JEZY3okqEpaN35VUS7FZ/yaofD5l4KP50T/nXa4Qe2Xn9V1zJWsP2PfNii5Bu8w2lo0uP5R7ESqKZxMQgkWeOYVMW0FMmVnkqh2Rsy/CxysJHl0B7hZ0tQQMeAm5kOwun1vf2Eh8zmbcXumKf/cAmmqVhNg5pAa2wn+mzCOL5co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=QdiBXc6b; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726578637; x=1727183437; i=markus.elfring@web.de;
	bh=J6JjhpLStxd4n+dG1pBrTv7bWU/OYj2EwD1A9TDg+Uo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QdiBXc6bBeQKfjStchkZf+tdKyVhFizxZlMo17Kmn9/mDeCUp+4EersR6DLPnfjx
	 0TCEuMjNlN+eSx4Ux3i3B58va+a7Ejc2259jXqIPQXZogNxv8VCAq8QdQlFu1TpFz
	 hD/wJD6RRzs8yImVIl76WKzKTYJW8zNsU5voJWZonYnb1DUHv+B+UjCNMGvZ4aa5n
	 ZhoG5LdjjWnZojIyX+qmwC6gKjXFj9y7XMsvX9VcWzlEPY5ZCkXMSWBQyvyS9OAdD
	 /f80A6T3Z7z22Z6wBlNkBVsTYdH20wswktEvj4qo8ZO6SuXWgS69IA8DMKRtSqQuv
	 G+0Lr4p8UHrAH5QHMA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1rPI-1soL363S2q-00EsWt; Tue, 17
 Sep 2024 15:10:36 +0200
Message-ID: <79d31fe5-6ec1-4e40-be5f-85e1f61811c1@web.de>
Date: Tue, 17 Sep 2024 15:10:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-clk@vger.kernel.org, David Lechner <david@lechnology.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Nishka Dasgupta <nishkadg.linux@gmail.com>, Stephen Boyd <sboyd@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] clk: davinci: Use common error handling code in
 of_davinci_pll_init()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WOVzW7HcSsZRvtHPLh/BFCBgt2D5JVmVJu8CtJercp308RlgUaD
 InUVNi+WfMaTRaGx2Lls9emimQOZRpOgoi/OxQbj+VlC+Frt+/c5LxA8yY+O6xxpuIwwrSH
 M79qZG65N2HhX+ZTf8JvBaFwm6fSM188aKSOOeDT3p4xdmxskLXxORkVVXNbDa4bkcr/e69
 E47GHZAnv4xzhIub1fZ7A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yuBg0OJDkpA=;NVABBst3JDN/DTznxHGOmRkwHbE
 1Ych8FIXAMu3Av8IH/n/WR4tQtVhHlzpoUuhCjfgd1GHy1mS+sthPVBeGwZ7Jf498wSsW3hl4
 sNTnhPcT+utXJsyzsAU2s4etVCVmlZ6eEnza1yzs9g6Cwuv5ZTQ6KITM0TWWKOcJZIDlFc9qf
 x2BQK7yt/HduNmkTGPoJmfU/RY3ZY57U4ITWKYSJxf+UuzCS4T+Pi0UsfCaCSt2z0eaLyZFX3
 SEyiSEDiDUtIcVTvDbHWJgCUx38XHxlY0yEB+h6W7/J7QS6E0socqYDq2IjjyICZC4XqR06cm
 a8GdaMOlVsK8aLY4c6RsCdmA7G1FzOBAthgx+ybUEdhAXEH9M0kXS/rUHomsiG3ktZ0d2mht/
 R8+z/JueY3V1SvJ0yZy/KENC7vutrePmP5FMo3lcuw87bI79431zV4vRWLRX25nfbF7cd4Lht
 ior4K6WysY3NVxulgE7SkbzEJp/AgbkYiZ/VCGvmtap144VbMIPljv0z+Q7WVmVdKNILRLLjH
 9ckTt5/BvsBmjJQim5jrEJZHSSESphx7w1HXhjVyvbl4Im6XnyQMnaApob+EVsvgR2OOVLfDh
 dFdRsscPkJ+pydX270RVdQ8ZboLoCS3bLYM2OAhSC+vFmSGg/XUpxsBKaxAVSrDPEB7vpXnXj
 Z40hnZi09qlZSsl4omRYEyG1+S8nyNhXBwVbuQoaNeNm8WWySxKp+aRxEJzEmAMDBEFK0mwtB
 sDM9KavAoqljR579t9LwKVeJGg3nIF1EUlNcje2U9PuEhwhkuYlJ9jJXfsSaH19XeECNWcPX8
 3FaZJ5gUPn2+dpGF0b07cdZw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 17 Sep 2024 15:00:53 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function implementation.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/clk/davinci/pll.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index 5bbbb3a66477..eb79424f216d 100644
=2D-- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -777,16 +777,13 @@ int of_davinci_pll_init(struct device *dev, struct d=
evice_node *node,
 		int i;

 		clk_data =3D kzalloc(sizeof(*clk_data), GFP_KERNEL);
-		if (!clk_data) {
-			of_node_put(child);
-			return -ENOMEM;
-		}
+		if (!clk_data)
+			goto put_node;

 		clks =3D kmalloc_array(n_clks, sizeof(*clks), GFP_KERNEL);
 		if (!clks) {
 			kfree(clk_data);
-			of_node_put(child);
-			return -ENOMEM;
+			goto put_node;
 		}

 		clk_data->clks =3D clks;
@@ -838,6 +835,10 @@ int of_davinci_pll_init(struct device *dev, struct de=
vice_node *node,
 	of_node_put(child);

 	return 0;
+
+put_node:
+	of_node_put(child);
+	return -ENOMEM;
 }

 static struct davinci_pll_platform_data *davinci_pll_get_pdata(struct dev=
ice *dev)
=2D-
2.46.0


