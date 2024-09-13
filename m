Return-Path: <linux-kernel+bounces-327520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AA1977716
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 04:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DCA284E1B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 02:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844681B12D8;
	Fri, 13 Sep 2024 02:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="WV/8S7+T"
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9919E40C03
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 02:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726195917; cv=none; b=RNnPGQ6XkyLpcDR+b18s6i6QvtLuZ4BiCwODkajrO/YT0bFHSZVPaKoBEspqjNu9dc7coGF1Tk4LkQ4MSvZy9Es/bZolwqnr3qNSMfFGbXU0+uhz4trB1Fh1Q9ccNUGDQy2EwISNzeifSSttJN/ofQ5S0vtVcr0F/i6ptC8t9Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726195917; c=relaxed/simple;
	bh=LET1BQ0Xn4Tfvm+vfRy4bftcZN0ArP5ewrmZ8L4dqYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qsUT0ptiPhF7PeI3HNqIZ9qyPqtKHVXsa70X8r6I3Hn1rcq9ZnOymNLVV1lBWha6MvctFeGUtqgJkU07aYRQtwInEORof0LOGK2Q1kvMY8wCIJK9T7Jxe38pbp4VLRCKD3WZEWumyooxprXXzjE/nwsGHbDGs0+chu2HwNiBHeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=WV/8S7+T; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726195907;
	bh=LET1BQ0Xn4Tfvm+vfRy4bftcZN0ArP5ewrmZ8L4dqYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=WV/8S7+TcW74jGiEQus1VxB0290v42CC/6Uib3OgSEleN9tMk1aPJv2lgGufH4Yt1
	 5C5EA8FKc1gtiCXFm+r40CnpkdBou0rFulJqpdRjczh9HCOlhuYZXdKNfcVk1TS1jP
	 Pzcqv6dYJeBht1XqxHeKHvPg4gdWf1UWajUETWrE=
X-QQ-mid: bizesmtpip2t1726195904tnlmeop
X-QQ-Originating-IP: SvkltPouCzgQMW+h9Abq/NT5VbFnlznpZKK/5Glp6uY=
Received: from [IPV6:240e:36c:d2e:d900:4ac4:d8 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Sep 2024 10:51:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7572236675390096387
Message-ID: <933241F284D0194F+9840ef64-2285-4378-9a8a-393253530535@uniontech.com>
Date: Fri, 13 Sep 2024 10:51:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND. PATCH] riscv: Use '%u' to format the output of 'cpu'
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: paul.walmsley@sifive.com, Palmer Dabbelt <palmer@dabbelt.com>,
 aou@eecs.berkeley.edu, samuel.holland@sifive.com,
 conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, atish.patra@wdc.com, anup@brainfault.org,
 guanwentao@uniontech.com, zhanjun@uniontech.com
References: <E4CA32D7942C8637+20240912134946.163833-1-wangyuli@uniontech.com>
 <alpine.DEB.2.21.2409122309090.40372@angie.orcam.me.uk>
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
In-Reply-To: <alpine.DEB.2.21.2409122309090.40372@angie.orcam.me.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------6403Jj0Wn65v0w3LhfzdauCG"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------6403Jj0Wn65v0w3LhfzdauCG
Content-Type: multipart/mixed; boundary="------------uBhyMPZVGE5D0qKkF2xBZ8AB";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: paul.walmsley@sifive.com, Palmer Dabbelt <palmer@dabbelt.com>,
 aou@eecs.berkeley.edu, samuel.holland@sifive.com,
 conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, atish.patra@wdc.com, anup@brainfault.org,
 guanwentao@uniontech.com, zhanjun@uniontech.com
Message-ID: <9840ef64-2285-4378-9a8a-393253530535@uniontech.com>
Subject: Re: [RESEND. PATCH] riscv: Use '%u' to format the output of 'cpu'
References: <E4CA32D7942C8637+20240912134946.163833-1-wangyuli@uniontech.com>
 <alpine.DEB.2.21.2409122309090.40372@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2409122309090.40372@angie.orcam.me.uk>

--------------uBhyMPZVGE5D0qKkF2xBZ8AB
Content-Type: multipart/mixed; boundary="------------SisB9iXFPKTnCULnAVX9pEYA"

--------------SisB9iXFPKTnCULnAVX9pEYA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAyNC85LzEzIDA2OjEyLCBNYWNpZWogVy4gUm96eWNraSB3cm90ZToNCg0KPiAgIE5C
IHRoZSBwcm9wZXIgSVNPIEMgYW5kIFBPU0lYIHRlcm0gZm9yIGAldScsIGAlZCcsIGV0Yy4g
aXMgImNvbnZlcnNpb24NCj4gc3BlY2lmaWVyIiByYXRoZXIgdGhhbiAicGxhY2Vob2xkZXIi
Lg0KDQpUaGFua3MgZm9yIHBvaW50aW5nIHRoYXQgb3V0Lg0KDQoiY29udmVyc2lvbiBzcGVj
aWZpZXIiIGlzIG11Y2ggYmV0dGVyIGFuZCBtb3JlIHByb2Zlc3Npb25hbC4NCg0KPg0KPiAg
ICBNYWNpZWoNCj4NClRoYW5rcywNCi0tIA0KV2FuZ1l1bGkNCg==
--------------SisB9iXFPKTnCULnAVX9pEYA
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

--------------SisB9iXFPKTnCULnAVX9pEYA--

--------------uBhyMPZVGE5D0qKkF2xBZ8AB--

--------------6403Jj0Wn65v0w3LhfzdauCG
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZuOovgUDAAAAAAAKCRDF2h8wRvQL7kk6
AP9l7NduOUZtfTUmyyvWcFLpQ6+CRIC9rlQ4ygDDeqN9NgEA87PvCwvlUa62DwV3Cn3S9yYDJ1wH
mXySRMyqa5NWnAw=
=X+P6
-----END PGP SIGNATURE-----

--------------6403Jj0Wn65v0w3LhfzdauCG--

