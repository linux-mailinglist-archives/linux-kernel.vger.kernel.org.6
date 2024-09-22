Return-Path: <linux-kernel+bounces-335127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6419297E151
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 13:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EFBB1F214CF
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 11:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7764193428;
	Sun, 22 Sep 2024 11:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="GuhGxIs/"
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F336019340F
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 11:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.65.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727004994; cv=none; b=OQTMR7v/2TRXyQbUHMs1r+D//7KcGLJm+uyowxJQgThjQ/7hs+CfHfiKcZ2VnxtvRRgzskCCESFqLs2Ah1+YJEc/3AY4Mqj0Vnt1UHdgMyJMTLtRcDglqpb/Og+GMkGEsgdGi4UuTLb/StmIMknJcOq2P1x8FgIDXcT2CIw5mYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727004994; c=relaxed/simple;
	bh=wSwMXDUk0CMJSoyKbJuVl55xP9f7TtdiyqNizvDru5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=ORdXQo88EqoAsacRWMAwPPOuUb13UIiE4Q0xTZ4TnXdfQKwbzlipugVCCAuAfEAu3HUdiphw22ImWkowZkt7UfXbYfM1QW5JUWOtqZl6aGp+kKgTSdb0WjP7cmPjW15o293sDK8pmcY61zKOIcniD3I5Ut4upA0nB7yivrxz5Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=GuhGxIs/; arc=none smtp.client-ip=114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1727004971;
	bh=wSwMXDUk0CMJSoyKbJuVl55xP9f7TtdiyqNizvDru5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=GuhGxIs/x7Rp1Kie1jeeXnf2W5YqqRbqiFBMxZ/3ArKHsnUjpQUXGSrhnXTt1+sOQ
	 1JF5pZ5StOSs5af8HBU9e530UkHSF0uaLNG4DVL6JAN9QGLdY26VRZJeIVqvL+fqOH
	 Aw9FLDBeYogbvbw89teDW478RISO5uhKbXXuh670=
X-QQ-mid: bizesmtpip2t1727004960twjh2gl
X-QQ-Originating-IP: evJ6brhtGEDhghmIHGjm0YwAeWipq7b0oOfrxkJMsyQ=
Received: from [IPV6:240e:36c:d18:fa00:e9bb:21 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 22 Sep 2024 19:35:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7041320832419217520
Message-ID: <547A4BE6C539CF1D+7751f3d3-43bd-4596-ad89-af541f2f40a6@uniontech.com>
Date: Sun, 22 Sep 2024 19:35:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 0/3] treewide: Correct the typo 'accelaration'
To: WangYuli <wangyuli@uniontech.com>
References: <7BF34BF48048052E+20240922111832.441807-1-wangyuli@uniontech.com>
From: WangYuli <wangyuli@uniontech.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <7BF34BF48048052E+20240922111832.441807-1-wangyuli@uniontech.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------l0v1gw03uIhLLBUUTRKFIFvI"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------l0v1gw03uIhLLBUUTRKFIFvI
Content-Type: multipart/mixed; boundary="------------4rHMFMuBIBM40FrI8H4KDV2W";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: linux-kernel@vger.kernel.org
Message-ID: <7751f3d3-43bd-4596-ad89-af541f2f40a6@uniontech.com>
Subject: Re: [PATCH 0/3] treewide: Correct the typo 'accelaration'
References: <7BF34BF48048052E+20240922111832.441807-1-wangyuli@uniontech.com>
In-Reply-To: <7BF34BF48048052E+20240922111832.441807-1-wangyuli@uniontech.com>

--------------4rHMFMuBIBM40FrI8H4KDV2W
Content-Type: multipart/mixed; boundary="------------KFPks9sPMaMXBantsjSdpqtR"

--------------KFPks9sPMaMXBantsjSdpqtR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

U29ycnkgYWJvdXQgdGhhdCxteSBlbWFpbCBjbGllbnQgbWVzc2VkIHVwIHRoZSBwYXRjaGVz
IGZvcm1hdHRpbmcuDQoNCkknbGwgc2VuZCBhIG5ldyBvbmUgd2l0aCBiZXR0ZXIgZm9ybWF0
dGluZyBpbiBhIG1pbnV0ZS4NCg0KLS0gDQpXYW5nWXVsaQ0K
--------------KFPks9sPMaMXBantsjSdpqtR
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

--------------KFPks9sPMaMXBantsjSdpqtR--

--------------4rHMFMuBIBM40FrI8H4KDV2W--

--------------l0v1gw03uIhLLBUUTRKFIFvI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZvABHwUDAAAAAAAKCRDF2h8wRvQL7qnk
APwK7InGO2L1ymThRF9xtLX7QuDzH3hXNdXeZ7/UhAB5JQD/cHMkLbS4q1OpHnOR7cZ6+dDz245h
TT05QVvw5MnGNw8=
=j9vU
-----END PGP SIGNATURE-----

--------------l0v1gw03uIhLLBUUTRKFIFvI--

