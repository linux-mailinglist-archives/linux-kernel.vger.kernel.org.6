Return-Path: <linux-kernel+bounces-342863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E6D9893BD
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 10:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5CC31F21BDC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 08:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8171D13BC26;
	Sun, 29 Sep 2024 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="KcWF7fFq"
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939771E4B0
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 08:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.80.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727598293; cv=none; b=i7i/J4YdeWz0Kj2yEaqCKaLi3Dy26rMZpl9850s+7nlsJeY4LPqtfsLcEqFSeuBWh5NbhoRNy4wa+QsteQ6tkrx2PjelyF2YHSAtTYDynH37g1ckfRnOmAJxm7mBd0LUPS2UQ1RTciFPNoUaSueXddf3Ysi2f5i36zO/BhxrBrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727598293; c=relaxed/simple;
	bh=k6SppduUKU3JGg1fWi14sVMD3eTuD4vo9gOVOUpOICI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ECZ8xqoAXm4nRo8knrfgVNrsL9Y5ntpxf6HhQ3TAZQVEYJRl7VFPUk+kw+RTJHluX3ykqrBxE7b+OQ2n9sZb+Y4wS3ivyIuvrUj7fkVhP/zUstrfBFAXo8L7L+eLWZuQsWwdjH3dBZnKfgrGg7zJ5uhP/X2eLWiRef9eaqIvV/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=KcWF7fFq; arc=none smtp.client-ip=43.155.80.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1727598267;
	bh=k6SppduUKU3JGg1fWi14sVMD3eTuD4vo9gOVOUpOICI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=KcWF7fFqkAXH1HT9DhW88JfIdoGOaVh31+qMp5kJBxF954DH3nvaU/kelVNCwFEJM
	 Z2YLK8Ir76M7zVQ5GwUA5nVoeqgUbncuz2fxbHUZ85z8NkfzOqNDJQHSU2MWpO28M3
	 K33cv69aCKfr9GeLA0QbmZpxgL8BpnctvZ6s1bJ0=
X-QQ-mid: bizesmtp86t1727598259tqq2b3km
X-QQ-Originating-IP: qCmwn2P0eJXYEJvCqX9wDgoZtkhFe7MnmYNhiWlStS4=
Received: from [10.20.53.22] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 29 Sep 2024 16:24:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10790167505109477571
Message-ID: <20E3795420C6CF06+ececafaf-0a3b-4e3c-a56e-448f50c537c6@uniontech.com>
Date: Sun, 29 Sep 2024 16:24:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND.,v2] Bluetooth: btusb: Add MT7925 support for ID
 0x13d3:0x3608
To: linux-bluetooth@vger.kernel.org, bluez.test.bot@gmail.com
References: <34A24B6870318797+20240929074852.977045-1-wangyuli@uniontech.com>
 <66f90d4b.170a0220.288304.076c@mx.google.com>
Content-Language: en-US
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@gmail.com,
 matthias.bgg@gmail.com, hello@felixjara.me, wangyuli@uniontech.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, guanwentao@uniontech.com,
 zhanjun@uniontech.com, aaron.ma@canonical.com
From: WangYuli <wangyuli@uniontech.com>
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <66f90d4b.170a0220.288304.076c@mx.google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------kF4g1z672TtdiqJ02ivacGnm"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Njf/zTiR//7AUA0hqzRDl7/yymY8vIpo1vR3pVxXX6Q7JGpfj/7S2GgA
	2VrS/2oOzAbwhJyOlYsPvt4lIBcLp89tV+AhuW9x3ItFWSTxwEzVVS+L2ooS6l9MBu2EbGS
	dNcX/z0vlzyubZeq7bSLdi+j3GZcpWsMrmAEQpvzD4Kl9mrzFPO9D1OKSsROpyBCL3S7sOs
	eDUIOBgs24Oubyb2setAX50bKkx8bEW9pT8DnEmvJ2MKCbRvAoiJICix4w2h+4cPme1VgXd
	gAAAAniuK5AFSND+IIClCu6PW3+0VTe/L/Ffumpk+QslNXINB6oociOAIImVBSRr7cAro/2
	ao5WEz7oJqd5hRYnBgw/Gd3Pi+ActgxIhwZiRVcNXPryw0PgzWFCB952V7KXa/LPlyy8Xln
	VaPPhRNYbvJiCjo1lDI6+gUNpK0R18WZhPMciqCHijOSnkz+dw76HymDjAQkPOtUiC19Jde
	8n3yr3kc/vDVqZSCSGhsx9GI/5FF9NhxG/t8TRYMQ5o04LeKFzZBFvNc2XE4mm0O6aqZ2eT
	8eQ2eVS7Fyve2/gNnNNwBh6gB8lq6H/vjHp/5GzTUJhCg7vTgbBoI4rH7LZ2+A2kIlPwY3X
	0QO9opkS6kzle44EsLOaXgxZve5ZXgTWiUDxvr7seiXm+q3gJ0Vsssl0lcAnv3Pxx3vr+22
	5wWrn2BmaQpfQD+8jC6P9ytN5064RFWN/kKx04HuMpGQDiLFT/+pHvkh0lte65N3/s+npuQ
	/r3q+HLANYq1yVOy/suimqK1Beyvwsr8bf8P3nkVthydUwcbRafd9FEep5R9amGGmnH8zO7
	MtYo7coMIrERDrnV0ahx2zQUFf7K58e7leG7TRlVNJ9r9iYyunodDjjjDAmSh5lWWKdFk7p
	LDD6w+zgInAWlhrccsBggmQJsotCrfdv8f4mxN+Xprsm2hSahuKNT/nMdzOnqAtVDnqamsU
	3op832lMwsWkjVNZkyjXiARzCdv/cpk92C3Fg1pp6Ck3M9rXpP0XtPGiPoD0h5MdxDeg=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------kF4g1z672TtdiqJ02ivacGnm
Content-Type: multipart/mixed; boundary="------------rYgltaidC69xRNpWNvH7ciEI";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: linux-bluetooth@vger.kernel.org, bluez.test.bot@gmail.com
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@gmail.com,
 matthias.bgg@gmail.com, hello@felixjara.me, wangyuli@uniontech.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, guanwentao@uniontech.com,
 zhanjun@uniontech.com, aaron.ma@canonical.com
Message-ID: <ececafaf-0a3b-4e3c-a56e-448f50c537c6@uniontech.com>
Subject: Re: [RESEND.,v2] Bluetooth: btusb: Add MT7925 support for ID
 0x13d3:0x3608
References: <34A24B6870318797+20240929074852.977045-1-wangyuli@uniontech.com>
 <66f90d4b.170a0220.288304.076c@mx.google.com>
In-Reply-To: <66f90d4b.170a0220.288304.076c@mx.google.com>

--------------rYgltaidC69xRNpWNvH7ciEI
Content-Type: multipart/mixed; boundary="------------6qWSTeocB9KvF9FYwKm6wpSO"

--------------6qWSTeocB9KvF9FYwKm6wpSO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

Q291bGQgYW55b25lIHNoZWQgc29tZSBsaWdodCBvbiB3aGF0J3MgZ29pbmcgb24gaGVyZT8N
Cg0KSSdtIGFic29sdXRlbHkgY2VydGFpbiB0aGlzIHBhdGNoIGNhbiBiZSBtZXJnZWQgZGly
ZWN0bHkgaW50byB0aGUgDQpibHVldG9vdGgtbmV4dCBicmFuY2ggb2YgdGhlIGJsdWV0b290
aC1uZXh0IHJlcG9zaXRvcnkgDQooZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51
eC9rZXJuZWwvZ2l0L2JsdWV0b290aC9ibHVldG9vdGgtbmV4dC5naXQpLg0KDQpBbSBJIG1p
c3Npbmcgc29tZXRoaW5nLG9yIGlzIHRoZXJlIGEgcHJvYmxlbSB3aXRoIHRoZSBib3Q/DQoN
Ci0tDQoNCldhbmdZdWxpDQoNCg==
--------------6qWSTeocB9KvF9FYwKm6wpSO
Content-Type: application/pgp-keys; name="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSK
P+nX39DNIVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAx
FiEEa1GMzYeuKPkgqDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMB
AAAKCRDF2h8wRvQL7g0UAQCH3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfP
bwD/SrncJwwPAL4GiLPEC4XssV6FPUAY0rA68eNNI9cJLArOOARmgSyJEgorBgEE
AZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7VTL0dvPDofBTjFYDAQgHwngE
GBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIbDAAKCRDF2h8wRvQL
7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkUo9ERi7qS
/hbUdUgtitI89efbY0TVetgDsyeQiwU=3D
=3DBlkq
-----END PGP PUBLIC KEY BLOCK-----

--------------6qWSTeocB9KvF9FYwKm6wpSO--

--------------rYgltaidC69xRNpWNvH7ciEI--

--------------kF4g1z672TtdiqJ02ivacGnm
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZvkOsAUDAAAAAAAKCRDF2h8wRvQL7l5p
AP452q7stgt+BE9fX7228H8xu3pV4e4Es4TQ7QVlNHbdGgD9Hfse70UZkqnlcL/lazmRK3bXA6US
lVf4rYRPvYyTmgc=
=8FY7
-----END PGP SIGNATURE-----

--------------kF4g1z672TtdiqJ02ivacGnm--

