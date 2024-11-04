Return-Path: <linux-kernel+bounces-394129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BD29BAAE3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC501C20A24
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 02:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79C414375A;
	Mon,  4 Nov 2024 02:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="I0gkvfMV"
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981224C6C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 02:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730687808; cv=none; b=ugwdkL9Hi/MpK6AuTyeWwuFIHOjjtqG4h/JIJrF6k9somf2zybs8kw8NDDZ4vatTOL9f7gymHFZqy+c0CKuQEEBK4Qxs53TMuFKZFtBRR4+6vgJ1lm1IYePEMz2f9qwtnTPFiEQscuAP3pjnwlnkxQWgJRWz0xiL5rpVSwgAMXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730687808; c=relaxed/simple;
	bh=LBnwjIu01qb3uMzu5oQLZ1sXef4WJoJ8ZJ5HXkRpTng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SzBUVT0f0nfRSyKmD7eetn5SI2A1yP9gUjCVWiSA/XgxaozNEm9iLgUu3d0U62T5WxVbtehf5lwd56bmjR6Xl+ahjCAymVbpFWCSX/Iq0JQP/WiJv7Fzac4MrkvxEbSNbflNuKFDlsXlm4jD82nlEfpgFCJTdOe4FbLZ9n2uFsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=I0gkvfMV; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1730687664;
	bh=LBnwjIu01qb3uMzu5oQLZ1sXef4WJoJ8ZJ5HXkRpTng=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=I0gkvfMVE/MguKNe6G+/LMNLVFqz7dkh0IDG0vDntK4CNMqCoz50Tqhzb3M0pX6yE
	 GsMB3HypNccbL/ypubSF6JPJFS7ckgk4c83b82I4kXeEhlwYuJQ9JJSgbhKj4ZgSzt
	 6AVc0wlL51Wy3m4xPQdNrps/E4wW0CWhuFCKwvFc=
X-QQ-mid: bizesmtp90t1730687661tfnba8nb
X-QQ-Originating-IP: zCt886bJnOZxcI98vSCU01cM2iwZOisAeH5BvJ3W5y4=
Received: from [10.20.6.66] ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 04 Nov 2024 10:34:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13360692648225194716
Message-ID: <E7AED86A89FD886F+263304da-0529-4b4c-9e23-ea2e5e3cef2c@uniontech.com>
Date: Mon, 4 Nov 2024 10:34:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/18] loongarch/crc32: expose CRC32 functions through
 lib
To: Eric Biggers <ebiggers@kernel.org>
Cc: ardb@kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, kernel@xen0n.name, chenhuacai@kernel.org,
 xry111@xry111.site, sparclinux@vger.kernel.org, x86@kernel.org
References: <20241025191454.72616-7-ebiggers@kernel.org>
 <DA8BCDFFEACDA1C6+20241103133655.217375-1-wangyuli@uniontech.com>
 <20241103135730.GA813@quark.localdomain>
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
In-Reply-To: <20241103135730.GA813@quark.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------yPwlqMleUVPPs6iT7orBXJ4O"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MxHu/stL3hVPTyQKEN1I9xOGN+BWMXbxaMOS0j7W+ohxt+jGBkhBGwZ4
	mKISKoLBEd9DlDyAzvD8Xb+Ak/ELvHSM++rLK6y5TzF3Hf/17WFfm4pm9/k9mLloUcGW+NL
	8qZ+6cZzrdyjqSgcP1Xp/i5pEffVubQ2dMkyTuu3UHXF84Ui38G5dAI/uAmL5APJ4umWUjs
	JAlTTcK/ZnDz/dXBv4ZI87pL43bv608+HDpuFePggpjxgGa1kVYzobU5eUZ6LO/uv2RowEK
	uhKq8QAeAPI+IMf1b6aLSu6P/Fs/km10//7pfxHG6dA+7Km3UUBoxHlM6u2nyaXKFibw80s
	t4nTGxp0efQ3Pfm9Sz2/C3rkybvwsRFVPfwxyAn/VgcfSodJAMgcZKgqSNpASPGkZXP4lL/
	k3H1h1FOKBoqUmyu7jUmymrjsrywBPtV49f5MFmBnQwrkwKQHK2oaFRwHbmLcnsoIOHE8Z/
	deJsmZLHkJlnAaYVaPf54mh8UQNn52S4MGXd5Yk5vLu5eU3kZqeA32eOGldP7Mb0CmmSAS6
	gtMsyTXIALbDLKcwPkPsXrS6tqgYJTgEau2ZzAxsNWrQjl0sRSIrHUxJSdhmubmgeXccIdZ
	r1vHGhdkaGTJkGJqM22umnfJNPXVtOLMQ6X5hKtTi5BYe9LhRtqHfXvmVj4p1Vl5eT9hXi2
	3DIJkAQUebz9E3jx1FLgXjJMHocjcNcEVdhImvslnERXJE1DLgArhO3UEsYiCJtmJYfPDD2
	aS/b2i0B2kduRaSa48Cb0Of/cdn84PSGqXDObVcHjWZSBNvZ2dpru68Uwhr99TVEG4IGgF1
	9eOXjq5Z4MrGfy6pZlOmaz4wPAryxd9VvG7ei7E5Aki854L1tCLeSXuBZ3DcVwlhBgs7ZE8
	TEjRNHBoYPk7hwnmmTNksvuvkSlftSKfeFFGhvbMd9a4Kj8wnwhazWqvsD5X+cHxHbX2zIA
	QuFp0GZUngV4M0SsIHIumND1dfxBkdyInuyK4vGBQSxCdodYauHuTByUkblV8feBGpEUYBV
	78cet9pPs1EBpoInNb8RBGGAIOcBBODfCC27xPiQ==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------yPwlqMleUVPPs6iT7orBXJ4O
Content-Type: multipart/mixed; boundary="------------cIiC60yt0DtrRFabfn26CCc3";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: ardb@kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, kernel@xen0n.name, chenhuacai@kernel.org,
 xry111@xry111.site, sparclinux@vger.kernel.org, x86@kernel.org
Message-ID: <263304da-0529-4b4c-9e23-ea2e5e3cef2c@uniontech.com>
Subject: Re: [PATCH v2 06/18] loongarch/crc32: expose CRC32 functions through
 lib
References: <20241025191454.72616-7-ebiggers@kernel.org>
 <DA8BCDFFEACDA1C6+20241103133655.217375-1-wangyuli@uniontech.com>
 <20241103135730.GA813@quark.localdomain>
In-Reply-To: <20241103135730.GA813@quark.localdomain>

--------------cIiC60yt0DtrRFabfn26CCc3
Content-Type: multipart/mixed; boundary="------------YiihG54060SCpWIarDHBVU6V"

--------------YiihG54060SCpWIarDHBVU6V
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPbiAyMDI0LzExLzMgMjE6NTcsIEVyaWMgQmlnZ2VycyB3cm90ZToNCj4gT24gU3VuLCBO
b3YgMDMsIDIwMjQgYXQgMDk6MzY6NTVQTSArMDgwMCwgV2FuZ1l1bGkgd3JvdGU6DQo+PiBF
dmVuIHRob3VnaCB0aGUgbmFycm93ZXIgQ1JDIGluc3RydWN0aW9ucyBkb2Vzbid0IHJlcXVp
cmUgR1JMRU49NjQsIHRoZXkgc3RpbGwgKmFyZW4ndCogcGFydCBvZiBMQTMyIChMb29uZ0Fy
Y2ggcmVmZXJlbmNlIG1hbnVhbCB2MS4xMCwgVm9sdW1lIDEsIFRhYmxlIDItMSkuDQo+PiBM
aW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMGE3ZDBhOWUtYzU2ZS00ZWUyLWE4
M2ItMDAxNjRhNDUwYWJlQHhlbjBuLm5hbWUvDQo+Pg0KPj4gVGhlcmVmb3JlLCB3ZSBjb3Vs
ZCBub3QgZGlyZWN0bHkgYWRkIEFSQ0hfSEFTX0NSQzMyIHRvIGNvbmZpZyBMT09OR0FSQ0gu
DQo+Pg0KPiBUaGVyZSdzIHN0aWxsIGEgcnVudGltZSBDUFUgZmVhdHVyZSBjaGVjayBvZiBj
cHVfaGFzKENQVV9GRUFUVVJFX0NSQzMyKS4NCj4gU2VlIGFyY2gvbG9vbmdhcmNoL2xpYi9j
cmMzMi1sb29uZ2FyY2guYy4gIFNvIGl0J3MgdGhlIHNhbWUgYXMgYmVmb3JlLg0KPiBBUkNI
X0hBU19DUkMzMiBqdXN0IG1lYW5zIHRoYXQgdGhlIGZpbGUgd2lsbCBiZSBjb21waWxlZC4N
Cj4NCj4gSWYgeW91J3JlIHRyeWluZyB0byBzYXkgdGhhdCB5b3UgdGhpbmsgdGhpcyBmaWxl
IHNob3VsZCBiZSBidWlsdCBvbmx5IHdoZW4NCj4gQ09ORklHXzY0QklUPXksIHRoZW4gdGhh
dCB3b3VsZCBiZSBhbiBleGlzdGluZyBidWcgc2luY2UgdGhlIGV4aXN0aW5nIGZpbGUNCj4g
YXJjaC9sb29uZ2FyY2gvY3J5cHRvL2NyYzMyLWxvb25nYXJjaC5jIHdhcyBidWlsdCBmb3Ig
Ym90aCAzMi1iaXQgYW5kIDY0LWJpdC4NCj4gQnV0IGlmIHlvdSB0aGluayB0aGlzIGlzIGEg
YnVnLCBJIGNhbiBmaXggdGhpcyB0b28uDQo+DQo+IC0gRXJpYw0KPg0KDQpBY3R1YWxseSwg
bXkgb3JpZ2luYWxseSBtZWFuIGlzIHRoYXQgZGlyZWN0bHkgZGVjbGFyaW5nIExvb25nQXJj
aCANCkFSQ0hfSEFTX0NSQzMyIHdpdGhvdXQgZGlzdGluZ3Vpc2hpbmcgYmV0d2VlbiAzMi1i
aXQgYW5kIDY0LWJpdCBtaWdodCANCm1pc2xlYWQgdGhvc2UgcmVhZGluZyB0aGUgY29kZS4g
QW5kIGl0J3Mgbm90IHJpZ29yb3VzLg0KSG93ZXZlciwgYWNjb3JkaW5nIHRvIEh1YWNhaSBD
aGVuJ3MgcmVjZW50IHJlcGx5LCB0aGVyZSBhcmUgbWFueSBzaW1pbGFyIA0KaXNzdWVzIGFu
ZCB0aGV5IHdvbid0IGNhdXNlIGJ1aWxkIGVycm9ycyBmb3Igbm93Lg0KTGluazogDQpodHRw
czovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FBaFYtSDVLYVhCci1UZHBEYkp3Y3JfTDBfbWJT
dz00SjMwdXdRMnhuMllEcz1IZzJRQG1haWwuZ21haWwuY29tLw0KU28sIHRoaXMgY2hhbmdl
IHNob3VsZCBiZSBmaW5lIGZvciBub3cuDQoNClJldmlld2VkLWJ5OiBXYW5nWXVsaSA8d2Fu
Z3l1bGlAdW5pb250ZWNoLmNvbT4NCg0KVGhhbmtzLA0KLS0gDQpXYW5nWXVsaQ0K
--------------YiihG54060SCpWIarDHBVU6V
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

--------------YiihG54060SCpWIarDHBVU6V--

--------------cIiC60yt0DtrRFabfn26CCc3--

--------------yPwlqMleUVPPs6iT7orBXJ4O
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZygyqgUDAAAAAAAKCRDF2h8wRvQL7u9/
AQCzme1hyYUbPe1s4tK4FtfJbQ1qS/eQ5ZNWEjUnEivrLwEA0UMghFUFO/92QNK3/a3a7O8QrCGS
Ov5jILXFpAVfTgw=
=fG9N
-----END PGP SIGNATURE-----

--------------yPwlqMleUVPPs6iT7orBXJ4O--

