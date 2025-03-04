Return-Path: <linux-kernel+bounces-545513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8E5A4EE0D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F83188E880
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD408259CAA;
	Tue,  4 Mar 2025 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="LGo3cuhA"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C995B77102;
	Tue,  4 Mar 2025 20:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741118787; cv=none; b=XUMRlsDZIDJWNQ5IS6HfEEmJyUgdl/9zfPDuzK6Kq4h62XpVC8nbzh9tiX8MYw2mpxZIyw/GIJATED7SC2q4eQzUx00zCENHchDWaEzd01jjpKyp+Brf/MpOCjI8SZMUyJ9867NcDA5lre9G7I37Z5rMXWFnRnClWTYkILSKij8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741118787; c=relaxed/simple;
	bh=8YfGuytvRA+WiZ8U62DQi02b42kFgx41p4zWhjiFA90=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MCwDGIyKUGpmzgFohNKRax/3pX02zVt+1riIMHjRhOqHN+MimAXH2Dsi4cung6sIuEasb9KKEkWJ+OyE+ENyPj+0AfxrwV9AZFHJfjnDKQwP8STm0C1LWXsbVrWUubvrVdXwcsKHSkmI92OPs5IK3ftHw+D1w7H99iHX+YSlA8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=LGo3cuhA; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741118762; x=1741723562; i=markus.elfring@web.de;
	bh=CLyLqQ9mG2OYA4h8XYSBVwHU4gZu0CSL953Y+TKJ5ew=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LGo3cuhAXykSeTsKONdUxTw39/NeJ+Qnf4CVYXkQRa1IhniSsZ7HZmEfUaQAj1GF
	 PHmPOBx23eFJqhVW3qg60CjUZxscRK6eUkCcsjAWk2++WZJ6mJt02tj5s0LnjNL3u
	 c3mvvkSzonq4DVidZZSi+yrd5Fdw9xqyctk+/xERDfzB/47pk8oTFt1HGZf+xMOL0
	 xC2p8x5aYURgGVWDdHgC807kMft1Duzbu/ewK/p8RIoOu6gaR/AIeVwKOpE+ji90u
	 FACNBn6oTR3lkdH0S671AKPDvjVooShoAdqmnenla2xMH162FqlG+WLwE5Pxiktoi
	 dGtw0OCpZCZXlOKkRw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.64]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MPKB5-1td59T1Lw5-00WJ26; Tue, 04
 Mar 2025 21:06:02 +0100
Message-ID: <15374d0b-ac50-4eae-8d94-c870a7c918e6@web.de>
Date: Tue, 4 Mar 2025 21:06:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH RESEND] irqchip/partitions: Fix exception handling in
 partition_create_desc()
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <15fa53e5-916f-dac8-87fb-9cb81021418c@web.de>
Content-Language: en-GB
In-Reply-To: <15fa53e5-916f-dac8-87fb-9cb81021418c@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DXfXVMh3BB0Y7aScUQseE1/ISmriUWWViY8FQyEhmx0RY1npwoy
 MwYFgnmqefCE3QPIq2MKXZZb5k6v9mbvYIwgem1BzFzoOf/0rd/6D59ILDFulKOnu8D8XiO
 6N41aBtg4CykvjvwMcihwaTxo/0IVBgd1Samxc2pU1XpyWoOmerpTtRUOVOID4F25lo17C1
 tXQiLf2HK9UblWPjTqyBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FTmyyT3rHvE=;fzyggJSmQzfEyN9pXi/rgdPINLF
 yaVsOEUccpvxrIG/+NeGb4m2FuNh3PHB0Ai9dAW5b0v/Keefjwfx+g4XhllV2eMNQLNiq7ia+
 WHnKHAvRM+OJDRAn1YL9bxvEDM8A412Q144ORpL6A07pCxprVHmL9EXsTRxJDrXvZN361JQkD
 zya0GGSSxTF7TJvKs2hafavg34TdxwEyou5eDDSs5gIRysSW23VQxORezCT8mDa9ixhmdUGM6
 o6iimqjovHU/xZiG5nmoWwRRSNtfTK3db8crULMfnNUrJSUr4aIFpI9vC1MTYp9A2xjq+5yS9
 zPtdffJU0+0CXSFEnZ26en6R009NSjrPHI6cw6KgAkZjq8DAKXRTqQmlwoMdAsoo1Qrgh4wXt
 myXsZzPwxUNBkBL0/cb0FQtZyI0qKt4QWvY50TNGJYh7G8rf6jmXTvg35MxPesGqTenK3+rLc
 kfmIhimaFeQJW+lBF5G0SLMGk7GKe1TYCHZOXqMxuChyjGv8Sq9WDimCew0p1yMSA1KNO4Slr
 IuH4ougC/8bGLW55C1ybSlXLKWEDo5gMykYq5p+QVjj1s08RYP9LdGa89eX/HOl5da41bOh13
 bhunuCANprpP78QL2EZq48euLJOgjlYiyv+/T8baN1Qf+tWBVz1udNJEJCCB0FW4YhaDz+GTt
 yr+MZ/3MTysQDJMmbhRUMBMgewK7+0h8N2gllC5HFSFaE9La4xv0OcpXBPZ42KvIrlMqsyKgm
 +3pODzwLVanl1wu53HaIKL3gRXi1F6kDO4M+mMviLy1kNoKTFfAYQBqVnKYCt1FwiCJPaq7yz
 /M/bCx+/yJqe18eeiBRigIDh7W+Vy3B+CPrcegkexGIoIAHQ8V0Wmbm57LvnVfKLvPrwSzVT6
 HPwu7Ckspc9U6ivLdv1bUBvWAqg3zFzbSeiNuLsR+37JgAcHxMA01xEtj1MIzago5lFnlm0pR
 Ulk0RUhjyGxJGR7+0P2qkzgPFCH6XepN1m1uVchW7QqJvpfwobTCeS8TNJa+CZiftiAFqUX1Q
 MblwmcXT6lggbYq/MF1bvuwViPaVtcHXZ6SNjbZ5j5HDRKJMHDeVkiSvJBe3R3qOUICRSeQpJ
 Q/XVnKDgblgMPL+9vy/RKD+aFkAnw4aqMojl0BFXEk4RQ1Dy86m5RQnZHSJKCJESWItghnjPe
 kSwrk8oDnA5NzJEcu+Kg4UK2PtVAsh9v28gtCS7ZLZBkQSVRozRzB0Fafv2n8FU2shwwOeG++
 MErNDWaI9ouifYey0RqpuGch+6P4X+gH3SdOdDf7u+S2PHNjgVKAPZEk21EvwhzEw/WVVe8oh
 c7MzYdzsxj857jXwCFKJgLApHivVVy937qXKTCQxxUAEjOLfSTi6+UuDDNcOn/X6EnMgr5bAG
 vd4xWuJEIEg7KcAN07OG7YYhs51t+Uy7u8m4pU1cEuh5WUqHcaY/7aKCraRB7wlJCzDh1m8vN
 XtVPykMbytJM7CXL0FxvOl6iQqQ4=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 19 Mar 2023 21:38:47 +0100

The label =E2=80=9Cout=E2=80=9D was used to jump to another pointer check =
despite of
the detail in the implementation of the function =E2=80=9Cpartition_create=
_desc=E2=80=9D
that it was determined already that a corresponding variable contained
still a null pointer.

* Thus use more appropriate labels instead.

* Delete a redundant check.


This issue was detected by using the Coccinelle software.

Fixes: 9e2c986cb460 ("irqchip: Add per-cpu interrupt partitioning library"=
)
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/irqchip/irq-partition-percpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-partition-percpu.c b/drivers/irqchip/irq-=
partition-percpu.c
index 8e76d2913e6b..80e1c73af87e 100644
=2D-- a/drivers/irqchip/irq-partition-percpu.c
+++ b/drivers/irqchip/irq-partition-percpu.c
@@ -212,21 +212,21 @@ struct partition_desc *partition_create_desc(struct =
fwnode_handle *fwnode,

 	d =3D irq_domain_create_linear(fwnode, nr_parts, &desc->ops, desc);
 	if (!d)
-		goto out;
+		goto free_desc;
 	desc->domain =3D d;

 	desc->bitmap =3D bitmap_zalloc(nr_parts, GFP_KERNEL);
 	if (WARN_ON(!desc->bitmap))
-		goto out;
+		goto remove_domain;

 	desc->chained_desc =3D irq_to_desc(chained_irq);
 	desc->nr_parts =3D nr_parts;
 	desc->parts =3D parts;

 	return desc;
-out:
-	if (d)
-		irq_domain_remove(d);
+remove_domain:
+	irq_domain_remove(d);
+free_desc:
 	kfree(desc);

 	return NULL;
=2D-
2.40.0


