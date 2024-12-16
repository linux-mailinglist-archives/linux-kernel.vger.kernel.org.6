Return-Path: <linux-kernel+bounces-446733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EFF9F288B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 03:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8A31885BD3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 02:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917FC42065;
	Mon, 16 Dec 2024 02:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="SVwj0Ozs"
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335231798C
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 02:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734317672; cv=none; b=lrG/jFpMf4hz/grfwe+YNvJFPHYLYcki8/1uiylSqMul/CBcXKmKzfh7TXfQa457KMNf8hAsEOnLfGCgrr4p1v2vD+UJKjypxYJ2cB/Svt9171LrhegOtBA8YPjYI0m+oAsAwuMxy1XF39jYdGqk18NaxB8FKaJKgFUSEKcRLCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734317672; c=relaxed/simple;
	bh=CLoBuJXGEm/zDCZap+soCSnvsXt+AntP751DuKilTRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iwChLsSU4zvAeOrU5CehErbsNTb7eJC3FMkuG4PACP/bqudyQYmFg6tIUSwg+4wxuE+FhDpO/mdednc+gtDwESPA5KBuqiSHyMs4zP0a+CzXvFSqLWPhurH8sPGhTb+ugCK7ai3JDY1he3TZj8ihRRvXbTtUKFLg+65+ZAhd0js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=SVwj0Ozs; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1734317597;
	bh=CLoBuJXGEm/zDCZap+soCSnvsXt+AntP751DuKilTRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=SVwj0OzsYwromMyMnOEgvaGoIbVyJhnPh69FHWzvn4CSB5maCIceJXf6GIz9t3C6r
	 yfzezuUzLbP4BP4qyxO5dXZFEeOrApMoY+N7vbEVkVjb+qxQL1gamUV/gkTS15EG31
	 0Sul8tFZyysGuLOF0KW4BHBWokJM7tjoOKmEPlRE=
X-QQ-mid: bizesmtpip4t1734317586tjp0jcg
X-QQ-Originating-IP: ZIVZBa/vHbFBnVHArMnk6uJwiV1kjPaopOprFHgnjgc=
Received: from [IPV6:240e:668:120a::206:15b] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 16 Dec 2024 10:53:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10692238767205106347
Message-ID: <9530467A5B20A41A+9201c703-5713-4f83-971c-0b5dbfd6c20d@uniontech.com>
Date: Mon, 16 Dec 2024 10:53:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] scripts/spelling.txt: add GPL-2.0+
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Colin Ian King <colin.i.king@gmail.com>, Yu Jiaoliang
 <yujiaoliang@vivo.com>, linux-kernel@vger.kernel.org
References: <20241215025104.70096-1-heinrich.schuchardt@canonical.com>
 <20241215025104.70096-3-heinrich.schuchardt@canonical.com>
Content-Language: en-US
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
In-Reply-To: <20241215025104.70096-3-heinrich.schuchardt@canonical.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------z9lpoiw2GQxJcfbTkA50S5hm"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N3tmGSw0vHb4R54eMa2nLPGcGsHcwY9uuNJ2Xlznb/vbSpjn6ChQEK6+
	HHQ/JNZTERTMnNM1cTPNnue+IP/2fYRtc9rQejl1PH0BpSzURWMJoD8eCMotwUwDFyyDrNq
	WVp7k4k8S0bnCWf4aYeJpX7Wd6JsU9vWgEJBTFED1go/yCk77qe43B08OV+jH6502LEuGzC
	Amxq1xgRXlCaq/hEAm2Ic8N9aL3Qm6Elrd/lZAzsGsnqMQDXpdU5XkTZrLEfiuLoXEUpdyE
	uqjAhSdQ42VOt8nTKN9Qum5AV8UyYllXasiTgmOtoVOV+Lr9fM9BiA7HDrr2/pWI4YjnRzx
	ASKseNdZ9vZxgph0qXjIeY66vlkjAKYA966abqzZYyFoWmeybfx5TdBnna0C/vjJX22zd+e
	w1ZJqtgsDURn3AityE5hRFpmepBQgRutA/703qVEzcbjBjfcUhJne8VeVWW017OU7AX8YO9
	BoeN4s+KA9OXyc1YKba+W3cHerX2BlE2KkXadq4uz5Yp5jUlvkIeU5d/NunFtYDB1DvS7po
	eH5oTG4qsTvSJdM441dCqQXZd68s7rNW6brhsVpEqgmucqBMBYup432F3aOPjxQi0uKLeaj
	RqhyjifCXLl/51ghe2xAEux831zekQQhK08G2OYe98eSWZ4au8RJMyCcLbDJMbBH56Rb6jX
	PzMSzbE2cy9nKN7Dy90vmxyX+4/NfHdOT383JZLHn8yavcK8deMeL8LhduzjOu4WyYeZl27
	DqodCkamf8V79Wzm+DSZh1oDQujSwLEIsjx1TSaBrCbxkMEjpNrMb2pv7buQlRv6HsJo0wH
	9oWKPUas3SkuFxSy2rHW+ptH9lecsSJJHH4fh+AIuMafbvBdBS5SuylXccdCr/wmtungHaB
	rouaoYvoFt9TesAe3xXZCvHHcn/s/PDVZaxLUtladsBLk/4FnymJDfHdatuXzhMa6muYzQz
	5yFCdeySUdT5p0HsDudAa/NA/g8NrIH/V7xTG1RKNs8rhyHAdd3vrWQZAGuv0c3fbR/K5K8
	2sKhCJeIXdDRzhK68p
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------z9lpoiw2GQxJcfbTkA50S5hm
Content-Type: multipart/mixed; boundary="------------R2XxZZdUm61cDF0rQg7onIzi";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Colin Ian King <colin.i.king@gmail.com>, Yu Jiaoliang
 <yujiaoliang@vivo.com>, linux-kernel@vger.kernel.org
Message-ID: <9201c703-5713-4f83-971c-0b5dbfd6c20d@uniontech.com>
Subject: Re: [PATCH 2/2] scripts/spelling.txt: add GPL-2.0+
References: <20241215025104.70096-1-heinrich.schuchardt@canonical.com>
 <20241215025104.70096-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241215025104.70096-3-heinrich.schuchardt@canonical.com>

--------------R2XxZZdUm61cDF0rQg7onIzi
Content-Type: multipart/mixed; boundary="------------SK1A4vYGZGsxN4huhTaOxoO1"

--------------SK1A4vYGZGsxN4huhTaOxoO1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAyNC8xMi8xNSAxMDo1MSwgSGVpbnJpY2ggU2NodWNoYXJkdCB3cm90ZToNCg0KPiBU
aGUgY29ycmVjdCBTUERYIGlkZW50aWZpZXIgZm9yIHRoZSAnR05VIEdlbmVyYWwgUHVibGlj
IExpY2Vuc2UgdjIuMCBvcg0KPiBsYXRlcicgaXMgR1BMLTIuMC1vci1sYXRlci4NCj4NCj4g
TGluazogaHR0cHM6Ly9zcGR4Lm9yZy9saWNlbnNlcy9HUEwtMi4wLW9yLWxhdGVyLmh0bWwN
Cj4gU2lnbmVkLW9mZi1ieTogSGVpbnJpY2ggU2NodWNoYXJkdCA8aGVpbnJpY2guc2NodWNo
YXJkdEBjYW5vbmljYWwuY29tPg0KPiAtLS0NCj4gICBzY3JpcHRzL3NwZWxsaW5nLnR4dCB8
IDEgKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPg0KPiBkaWZmIC0t
Z2l0IGEvc2NyaXB0cy9zcGVsbGluZy50eHQgYi9zY3JpcHRzL3NwZWxsaW5nLnR4dA0KPiBp
bmRleCAyZGVjYzUwZjVhNmUuLjhjYzU5ZWU2ODkyOCAxMDA2NDQNCj4gLS0tIGEvc2NyaXB0
cy9zcGVsbGluZy50eHQNCj4gKysrIGIvc2NyaXB0cy9zcGVsbGluZy50eHQNCg0KVGhpcyBp
c24ndCBhIHR5cG8uDQoNClVzaW5nIHNwZWxsaW5nLnR4dCB0byBjaGVjayB0aGlzIGlzbid0
IHRoZSByaWdodCBhcHByb2FjaC4NCg0KDQpUaGFua3MsDQotLSANCldhbmdZdWxpDQo=
--------------SK1A4vYGZGsxN4huhTaOxoO1
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

--------------SK1A4vYGZGsxN4huhTaOxoO1--

--------------R2XxZZdUm61cDF0rQg7onIzi--

--------------z9lpoiw2GQxJcfbTkA50S5hm
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZ1+WDwUDAAAAAAAKCRDF2h8wRvQL7mA6
AQDCOzjsbL9qWvq6B0RF9rb0fMud8XsrWOF+24tqwKocmQD9GToA3iBEpSwGUmtTLMN0RBuFtI/Q
gHxcwcLFOHnqKAg=
=9Hwc
-----END PGP SIGNATURE-----

--------------z9lpoiw2GQxJcfbTkA50S5hm--


