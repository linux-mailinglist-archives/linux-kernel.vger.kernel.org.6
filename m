Return-Path: <linux-kernel+bounces-327533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 448EF977734
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 05:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00A11F2502C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 03:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3561B12E7;
	Fri, 13 Sep 2024 03:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="DxsxGXm4"
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A761A76C3
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 03:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726197110; cv=none; b=WrtgTp+Sj6LTjNqXaaZgHkns+orq3zW01FlqD8dubGyBJmfBbnALyiY5w9qJpV1ESOhU+EzZBhdY0RxPkn/C4U/D+PfKo405XcHu+8dykO2SNDEz7widQEHf3J3pEPy7tgiuGnM7kZuLWenxi2ntQeAcr1YJZ7wjI8s2/BXXEAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726197110; c=relaxed/simple;
	bh=Ma3uZ5OETrMHsn+zJGEpaDuF5aYUvfYrDIXjcedBAMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=USNKgROSsfgnzTE25f+zVod0eUIGN/X34vAcedWj/Ie+gxsOb6wmIKBdoIPInshSacxulLDqQSiH1CWib5hlRuEljD/y1ap1U2iFI21sj8JXq58pc8s755jD7D1BACXFQQAn+hSdD/TEc226vFW8M1SwyY0qRvtWySGI34adf2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=DxsxGXm4; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726197098;
	bh=Ma3uZ5OETrMHsn+zJGEpaDuF5aYUvfYrDIXjcedBAMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=DxsxGXm4WQGZCLETBKESx9aGHmTIhxZXvhvll5w1GuMqf3uKkNEUc0YlgtLRxMnvd
	 rJgoKHSiZPyTAt1VFRRIANkMXw8UpSPBJ1VbNfzDxiFdbjCUABHGqwOcCVobkQ3UeI
	 N6qmJ9RLj56Ye0QOZCiogVLixp56zO8bEwE8+7ag=
X-QQ-mid: bizesmtpip2t1726197094tr61807
X-QQ-Originating-IP: 54MpHY6GFmcQo7Vhx4JOqsEb5nBTNBqoS74Ioaz1ZKg=
Received: from [IPV6:240e:36c:d2e:d900:4ac4:d8 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Sep 2024 11:11:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8387889725699655936
Message-ID: <FEFED0A013D97FF5+73cafd43-8748-41a3-b6c3-c36a1a883da8@uniontech.com>
Date: Fri, 13 Sep 2024 11:11:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND. PATCH] riscv: Use '%u' to format the output of 'cpu'
To: Charlie Jenkins <charlie@rivosinc.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 samuel.holland@sifive.com, conor.dooley@microchip.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 atish.patra@wdc.com, anup@brainfault.org, guanwentao@uniontech.com,
 zhanjun@uniontech.com
References: <E4CA32D7942C8637+20240912134946.163833-1-wangyuli@uniontech.com>
 <ZuNRIrfLgkWUsZri@ghost>
From: WangYuli <wangyuli@uniontech.com>
Content-Language: en-US
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <ZuNRIrfLgkWUsZri@ghost>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------iDHKh5WP4i44OsgTAtuWGTiF"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------iDHKh5WP4i44OsgTAtuWGTiF
Content-Type: multipart/mixed; boundary="------------DbGAGeSM6zmKTL5F5P5zBnkv";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: Charlie Jenkins <charlie@rivosinc.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 samuel.holland@sifive.com, conor.dooley@microchip.com,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 atish.patra@wdc.com, anup@brainfault.org, guanwentao@uniontech.com,
 zhanjun@uniontech.com
Message-ID: <73cafd43-8748-41a3-b6c3-c36a1a883da8@uniontech.com>
Subject: Re: [RESEND. PATCH] riscv: Use '%u' to format the output of 'cpu'
References: <E4CA32D7942C8637+20240912134946.163833-1-wangyuli@uniontech.com>
 <ZuNRIrfLgkWUsZri@ghost>
In-Reply-To: <ZuNRIrfLgkWUsZri@ghost>

--------------DbGAGeSM6zmKTL5F5P5zBnkv
Content-Type: multipart/mixed; boundary="------------0bxoYvz0F2tXUjoZY00vq8FC"

--------------0bxoYvz0F2tXUjoZY00vq8FC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPbiAyMDI0LzkvMTMgMDQ6MzcsIENoYXJsaWUgSmVua2lucyB3cm90ZToNCj4gVGhhbmtz
IQ0KPg0KPiBSZXZpZXdlZC1ieTogQ2hhcmxpZSBKZW5raW5zIDxjaGFybGllQHJpdm9zaW5j
LmNvbT4NCj4gVGVzdGVkLWJ5OiBDaGFybGllIEplbmtpbnMgPGNoYXJsaWVAcml2b3NpbmMu
Y29tPg0KPg0KVGhhbmsgTWFjaWVqIFcuIFJvenlja2kgZm9yIGhpcyB2YWx1YWJsZSBpbnB1
dC4NCg0KSSBoYXZlIHJldmlzZWQgdGhlIGNvbW1pdCBtc2cgKG9ubHkpIGFuZCByZXNlbnQg
YSBwYXRjaCB2Miwgd2l0aCB5b3VyIA0KUmV2aWV3ZWQtYnkgYW5kIFRlc3RlZC1ieS4NCg0K
TGluazogDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvRjVGREE3MTIzMTgzRUQ5Nisy
MDI0MDkxMzAzMDI1Mi44NTc0ODItMS13YW5neXVsaUB1bmlvbnRlY2guY29tLw0KDQpUaGFu
a3MsDQotLSANCldhbmdZdWxpDQo=
--------------0bxoYvz0F2tXUjoZY00vq8FC
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

--------------0bxoYvz0F2tXUjoZY00vq8FC--

--------------DbGAGeSM6zmKTL5F5P5zBnkv--

--------------iDHKh5WP4i44OsgTAtuWGTiF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZuOtYwUDAAAAAAAKCRDF2h8wRvQL7k2D
AQDA357oztfvnEUfSImIhqwOuzeMUn+espwS90OtZv1B2QD/RC8vfBTQOCkWleXhBsBqahvSWsgj
zkCvupKmsoY2iAw=
=GGFB
-----END PGP SIGNATURE-----

--------------iDHKh5WP4i44OsgTAtuWGTiF--


