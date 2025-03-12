Return-Path: <linux-kernel+bounces-557168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B9EA5D472
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 03:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 986E37A96E0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 02:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DECD18B46E;
	Wed, 12 Mar 2025 02:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="M5NPeYY2"
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567168633A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 02:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741747147; cv=none; b=lMhlROsg/9bQjk5fVlRLSvaOGjozGOq1TFGXfsythLXMIhSeiyw7B5U0AF4UyNcvRQl1Doy2fxzNdf5vfRLIqwfhjQKQA3z/eExcKQAJlhTg6ko277W2I5EM3jIBP3NYYgUUSkFK0niCw/dCmrP8Z9ynVqNukunZmyXQkj7JNWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741747147; c=relaxed/simple;
	bh=JGTUx+vZhgTcxc7A0OHnH+uACyGI2QXmhdI7qpfj7jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCNYOLFxYQgk1QSkaH5SI0amG1FSz5OceEXE1tluRk0tOerF9XNzOOvd3xeoQo7NIHvlvzGopsYLWjJdxUaF392d3SUuvSZMBkpEkAHSR2LOfqZYufSenDXYjqFRlTeHypkzZRHYs51UqT06rxI5B1ZN91ZKZP1ck3wavxm1vJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=M5NPeYY2; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1741747131;
	bh=JGTUx+vZhgTcxc7A0OHnH+uACyGI2QXmhdI7qpfj7jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=M5NPeYY2m02nzZEPe5+vuivUh59bHuLboOwIoIzhqiWc7pdol+Mna0vyVSo1itFXj
	 XWm7tN/HTwxdnmn1sOKiWXglHAcdXxiJfKA8bSgmvCYKxYIPJSOWdptJ8KcTe/FEb0
	 IbOu98Yo+R2OZJNlLwbx83319PTIdrQ8sJXKw7rU=
X-QQ-mid: bizesmtpip4t1741747118ts6o8v4
X-QQ-Originating-IP: o3nEVXIgqVr4Vy+SxGR5R++Os4Cd3eWOquCs/y6PuaI=
Received: from [IPV6:240e:668:120a::212:156] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 12 Mar 2025 10:38:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16522105991542044273
Message-ID: <D5778071F336E5F6+5c5fc5ae-1ef3-45e7-8b01-c1e496bcfd58@uniontech.com>
Date: Wed, 12 Mar 2025 10:38:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] LoongArch: Fix use of logical '&&' with constant operand
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name, yangtiezhu@loongson.cn, maobibo@loongson.cn,
 guoweikang.kernel@gmail.com, agordeev@linux.ibm.com, ast@kernel.org,
 usamaarif642@gmail.com, jiaxun.yang@flygoat.com, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, zhanjun@uniontech.com,
 niecheng1@uniontech.com, chenlinxuan@uniontech.com, donmor3000@hotmail.com,
 Wentao Guan <guanwentao@uniontech.com>
References: <EEBE30D1ACFF646F+20250304105246.766404-1-wangyuli@uniontech.com>
 <CAAhV-H6zkq1KoLQSQgimEgHhdD=S--kHa9hmhfbxUS_6OOfSJQ@mail.gmail.com>
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
In-Reply-To: <CAAhV-H6zkq1KoLQSQgimEgHhdD=S--kHa9hmhfbxUS_6OOfSJQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------43mx7ySSAqJvNUBrybIdpW9f"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OBlwWD/GWDEo+KSp4P4Rv0uSsXk1a/wU/LKhQFQFriGhh9NU0Cr1GdEN
	XtWEUFogertcItfOelQwAUkG/vgjKhgmGt3UqeflN+pMao0UD683vI+Rz38iYhCxpJZXe1v
	jUC+OYsiy12TIt5sTgv6CufV6jkX7WFTj2owzfaGzp7h2i3x8K2dq769HMnquUznJaCCupR
	hYtdjycf9pwQGSKaxUZgbQQhLb5kUBqrX8t+voMx3G5DrvQZ6WATC7rJKFFFFLKbJy0fA4v
	TQqVTXP53ZNXoYzU+FKuveJ8tQwgrrwar1Nr5cfrCsMSROd8x/P1AZCybKcJ8gf82nJL699
	xq5VmQ3uOxUcBtpnhO+Xf26KVSaWbkZClVrFlj/8MImRb7I4Jw8QfAQKZcDO2mj67posd0S
	6L3YiCGw+UikE+V2IauW20NHLUx+O+sLnV3wr7iFVtvZKBo+Aay+82LONSKitYR1CNc9tJD
	y/KT0XBFBS1ZSeBBpE8/bWgly1bTm9et4J1U4jJr1NsGVPaVENOniH5r86eb4Z3u8Mz1Dyi
	OCtbHtd5yCuxFdcDxDhhHJUmdqkx6keYswdP0h8lWth+NnKgF40fXWstBSKpzIjpGQ6laDf
	08QJ5L9ROY6AisitgZt2wCrzEswoO4fGfX6q+K18pwmeEShhDJscYE1DpYr98oTyMVyz5F7
	16Gif/PxzokidK8sbi4468yK2LnyrLq71pUESLlkCpm5wsAqa5QCTQe0Oq76rJD701BZCQq
	mhuF8VEH/UBL9X2NzjuBPahFYvottlPHKQD6jocyhFSPzHzKu+tc3ic8B8oLBJiW33gOpbL
	DGKnGgaR+gCiRxEgGsihlTyoAKli6LGpAZgPf3aFqwEfzTIh3KrbSktnqjKFaUMFHInVpm5
	me4VxXru75iTGxmonuXY8MqU5yo1x1O67LqNc1yHnZx8A5dCZD+MYQGeVwSuKVBntGUQ2dU
	W3hoFz0MxJHGoQUJecQ8OYynyOKzPVA8kwKgVrBaN6YYfo3ObQvWdj7D9/ML7mE7Wg0Unl4
	jpBc83xR0HzjUUKJb3uP+v1i0Adto=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------43mx7ySSAqJvNUBrybIdpW9f
Content-Type: multipart/mixed; boundary="------------wJKrXM8GukpgPJYkT2vgJx9p";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name, yangtiezhu@loongson.cn, maobibo@loongson.cn,
 guoweikang.kernel@gmail.com, agordeev@linux.ibm.com, ast@kernel.org,
 usamaarif642@gmail.com, jiaxun.yang@flygoat.com, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, zhanjun@uniontech.com,
 niecheng1@uniontech.com, chenlinxuan@uniontech.com, donmor3000@hotmail.com,
 Wentao Guan <guanwentao@uniontech.com>
Message-ID: <5c5fc5ae-1ef3-45e7-8b01-c1e496bcfd58@uniontech.com>
Subject: Re: [PATCH] LoongArch: Fix use of logical '&&' with constant operand
References: <EEBE30D1ACFF646F+20250304105246.766404-1-wangyuli@uniontech.com>
 <CAAhV-H6zkq1KoLQSQgimEgHhdD=S--kHa9hmhfbxUS_6OOfSJQ@mail.gmail.com>
In-Reply-To: <CAAhV-H6zkq1KoLQSQgimEgHhdD=S--kHa9hmhfbxUS_6OOfSJQ@mail.gmail.com>

--------------wJKrXM8GukpgPJYkT2vgJx9p
Content-Type: multipart/mixed; boundary="------------mOZb0BEc7RosiYPOwaRq0lSa"

--------------mOZb0BEc7RosiYPOwaRq0lSa
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgSHVhY2FpLA0KDQpPbiAyMDI1LzMvNCAyMDowMCwgSHVhY2FpIENoZW4gd3JvdGU6DQo+
IEFyZSB5b3Uga2lkZGluZyBtZT8NCg0Kbm9wZQ0KDQo+IENPTkZJR19DTURMSU5FWzBdIGlz
IGEgY29uc3RhbnQgZm9yIGEgc3BlY2lmaWMNCj4gY29uZmlnIGJ1dCB0aGUgY29uZmlnIGlz
IHZhcmlhYmxlIGFjcm9zcyBidWlsZGluZ3MuIFNvIHRoZSAiY29uc3RhbnQiDQo+IGZvciBj
b21waWxlcnMgaXMgbm90IGFzICJjb25zdGFudCIgZm9yIHBlb3BsZS4NCg0KUGVyaGFwcyBJ
J20gbm90IGZ1bGx5IHVuZGVyc3RhbmRpbmcgeW91ciBwb2ludC4NCg0KIEZyb20gbXkgdmFu
dGFnZSBwb2ludCwgaXQgYXBwZWFycyB0aGF0IGFsbCB0aGF0J3MgbmVjZXNzYXJ5IGlzIHRv
IA0KYXNjZXJ0YWluIHdoZXRoZXIgQ09ORklHX0NNRExJTkVbMF0gaXMgYSBudWxsIHZhbHVl
Lg0KDQpHaXZlbiB0aGF0IHRoZSBBU0NJSSByZXByZXNlbnRhdGlvbiBvZiBOVUwgaXMgaW5k
ZWVkIDAsIHRoaXMgbWV0aG9kIG9mIA0KYm9vbGVhbiBjb2VyY2lvbiBmb2xsb3dlZCBieSBh
IGxvZ2ljYWwgY29uanVuY3Rpb24gd2l0aCB0aGUgYW50ZWNlZGVudCANCmJvb2xlYW4gdmFs
dWUgc2hvdWxkIG5vdCBpbXBpbmdlIHVwb24gdGhlIGludGVuZGVkIG9wZXJhdGlvbmFsaXR5
IG9mIA0KdGhpcyBsaW5lIG9mIGNvZGUsIGFuZCBpdCBmdXJ0aGVyIG9idmlhdGVzIGEgY29t
cGlsYXRpb24gd2FybmluZy4NCg0KVG8gYmUgcHJlY2lzZSwgYW1lbmRpbmcgISFDT05GSUdf
Q01ETElORVswXSB0byAoQ09ORklHX0NNRExJTkVbMF0gPT0gMCkgDQpvciBjb252ZXJ0aW5n
IHRoZSBsb2dpY2FsIEFORCB0byBhIGJpdHdpc2UgQU5EIG9wZXJhdGlvbiB3b3VsZCBhbHNv
IA0KbGlrZWx5IGVuZ2VuZGVyIGEgY29tbWVuc3VyYXRlIG91dGNvbWUuDQoNCkkgbWVyZWx5
IG9wdGVkIGZvciBvbmUgbW9kaWZpY2F0aW9uIHN0cmF0ZWd5IGFuZCBwYXRjaGVkIGl0Lg0K
DQo+IENvbXBpbGVyIHdhcm5pbmdzDQo+IHNob3VsZCBiZSBkb3VibGUtY2hlY2tlZCBieSBw
ZW9wbGUsIHJpZ2h0Pw0KDQpOYXR1cmFsbHkuDQoNCkNvbXBpbGVycyBhcmUsIGluIGVzc2Vu
Y2UsIGp1c3Qgc29waGlzdGljYXRlZCBzb2Z0d2FyZSBwcm9ncmFtcywgYW5kIGFyZSANCnN1
c2NlcHRpYmxlIHRvIG51bWVyb3VzIGltcGVyZmVjdGlvbnMuDQoNCk5vbmV0aGVsZXNzLCBm
b3IgdGhlIG1vc3QgcGFydCwgdGhlIHdhcm5pbmdzIGFuZCBlcnJvciByZXBvcnRzIHRoZXkg
DQpvdXRwdXQgYXJlIHR5cGljYWxseSBqdXN0aWZpZWQuDQoNCg0KVGhhbmtzLg0KDQotLSAN
Cll1bGkgV2FuZyoNCioNCg==
--------------mOZb0BEc7RosiYPOwaRq0lSa
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

--------------mOZb0BEc7RosiYPOwaRq0lSa--

--------------wJKrXM8GukpgPJYkT2vgJx9p--

--------------43mx7ySSAqJvNUBrybIdpW9f
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZ9DzrAUDAAAAAAAKCRDF2h8wRvQL7qwY
APwP10RAUyDie7MZZPCvj1sJSpidz/YYJnZdv6g+Z+JfOAEAmh+yBeL9UL+shsjO/SEjLVg0LhQm
SOZBZKb8XsD5Jwg=
=jOvR
-----END PGP SIGNATURE-----

--------------43mx7ySSAqJvNUBrybIdpW9f--

