Return-Path: <linux-kernel+bounces-519103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C01A397EC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16A11628FC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E70D233D93;
	Tue, 18 Feb 2025 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="OsQxTKVs"
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A3C22E418
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872869; cv=none; b=u0uGdZ1aGUxAanAI4KtCPk4T6nlgzjgYGm+VNjez8NNr+8lg8QNtja6G59CPMf7rL7p3v/iiYFfkTS/E8kLB8VrxufTtmSYclku7tnrivr7tHVZTKR6zYSKZURfHPrqIq9sJ2sSCUs2G4wJrMREQdv2RHKJ/c3n9CQfgHBRwDoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872869; c=relaxed/simple;
	bh=NYX1wGo4tGNZhzV6p3SzRA+npL9/JL019CaJWMVPGes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iYBoJj8qng/R/yH6ocgUlwLddWGzJaXQcIgqua2hQIO1cuCaPmJvm/Jngag1roFsgP8cfj5aZjsdoohf3F5aCdA9Nm2bkL9NN9vmStiRoIhfFI8TyOnVrANnrrEJbxBwSTkOrdiaJamT+0as3NTfx/9YEqAE4ZnBsnECe8Q5NxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=OsQxTKVs; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1739872828;
	bh=NYX1wGo4tGNZhzV6p3SzRA+npL9/JL019CaJWMVPGes=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=OsQxTKVsi2Obb4JibaPJsO0JcZi/8KFEovA5iBIb9S2Mz0uR+0uhczNr5Ta7XN9Cn
	 FJApd+gfOBHxo3MDvlerPYDxW67GEDakYH0OhbpIHZukIxyeZ/QRtkYeO1P6Di4Rgf
	 RXAgJx9gnCKgwZxmB9MeaZBEkJle39SvQvSeY89E=
X-QQ-mid: bizesmtpip4t1739872784te9rvmv
X-QQ-Originating-IP: LDqbWWh1czoAS9WkznA4kM+E8+DiPzSSBSPjztSXJyU=
Received: from [IPV6:240e:668:120a::212:156] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Feb 2025 17:59:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11010149265810943925
Message-ID: <384039BA5C7B1C39+c85df660-ce0b-4c8e-bc34-e898775a951f@uniontech.com>
Date: Tue, 18 Feb 2025 17:59:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] LoongArch: acpi: Make parse_acpi_topology() return void
To: Wentao Guan <guanwentao@uniontech.com>, chenhuacai
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>
Cc: loongarch <loongarch@lists.linux.dev>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 yangtiezhu <yangtiezhu@loongson.cn>, maobibo <maobibo@loongson.cn>,
 =?UTF-8?B?5Y2g5L+K?= <zhanjun@uniontech.com>, =?UTF-8?B?6IGC6K+a?=
 <niecheng1@uniontech.com>, =?UTF-8?B?6ZmI6bqf6L2p?=
 <chenlinxuan@uniontech.com>
References: <C832CAEC20DE4FC4+20250218094027.482396-1-wangyuli@uniontech.com>
 <tencent_46D6C2824357C42E11A3C9CD@qq.com>
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
In-Reply-To: <tencent_46D6C2824357C42E11A3C9CD@qq.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------acInEYS23tGt8yIu3XWP7RJu"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OLsBWtCIHsg6uLoDuAvuQFED+yaXYbWFSoJnOFZdodZuCnPYRVHCOFME
	LM2mWqo8ketLTZKLt1Jut4eQKo/RRbmhRLVSxXXUfzNm2qEOub+st+SxE+jRwhlM0Ba+s9K
	HwpfhhacXyF6/ms3avIGHGKZwu6mcvscDKFZrNzhQvh6vd+F24rD562FOTXfBeXGGVGgUQO
	V9TiMF3jhHy1F50NG2eLt32Z4gEl33Lo/Et52EmwXxggK44iaCQeawaukpMC/tKs5uZzvK9
	s2+vs4gyuHLX32UlR7tjYj5LRjKFlJVaHZAzHGZ12jD50Sb9MTnSp4mCvRUhuypav27tzkO
	0qFPQQ3OyQtiInlIGcun7UPIzsRHhJEHEHfAlLr1sjzZznAtKYsuu4BQLSI+afxafnIyC6i
	NbxEFw7o1DHMHft0fLsWQJzSV9abZqrnpSHWQjK15Tq1PLIb4HfuV2nQQH3HK+zQA82j9AV
	LJZyiK/ZRBYfRTOiiwsWP/4v8nzoRmu4KMmjaJ7Ud025srg6wQt9T9QgksOvsostM2ubp3B
	FQh1XaySLQ8rAYkFySnYih9iWOTEGTyr3M1gqfxjnr2EbBWO4kZD1oR+M7JgPrMRLw7hoPA
	aQ2LpnqUo2ngxWxlrrmxyAix5SNPaEu8cdsbB3/dmo9vFomFeuL99GISgOUHHF0RdGt+0ke
	bVGwcCYcngbdW163RVD4r0TstVexk3fQQiCFSkALDow0hyFxF9i3UFzNO7B4PWX7IspM7N1
	ncU+QPCCp8AatPLLLfPPxoUOOmAKbuo8iInlG91RhM3McXZW9ZNw6ckDL3ioUDf61CjXiEO
	E9AVjAS21hnQyGXUyRMUTa3lAvJHVKYLU2QL5m4Kt9BGVg96miSMdN6ogxAhfbBkprWn+Qb
	tLkDQMZe8ums5lkddg3hRvdx0QpPqb1p8lKOhAr80v7py/s2B9z9k1+WqMP+IYMG2DWjmwc
	Kf5t1Ax0KCtZkOVWetHIoaAtIAeZfk1GFf98ad01TXr5R9her3jobUNRNvr8h4LI1AkMMQn
	pVJ6I47c+n5uSg9O4yNzuWUlcyYA+oS49PpPooKgUdAhpuXrgMNZAFo/LyyFw=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------acInEYS23tGt8yIu3XWP7RJu
Content-Type: multipart/mixed; boundary="------------odl10bMVBgOO7pTAtEoBstzM";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: Wentao Guan <guanwentao@uniontech.com>, chenhuacai
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>
Cc: loongarch <loongarch@lists.linux.dev>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 yangtiezhu <yangtiezhu@loongson.cn>, maobibo <maobibo@loongson.cn>,
 =?UTF-8?B?5Y2g5L+K?= <zhanjun@uniontech.com>, =?UTF-8?B?6IGC6K+a?=
 <niecheng1@uniontech.com>, =?UTF-8?B?6ZmI6bqf6L2p?=
 <chenlinxuan@uniontech.com>
Message-ID: <c85df660-ce0b-4c8e-bc34-e898775a951f@uniontech.com>
Subject: Re: [PATCH] LoongArch: acpi: Make parse_acpi_topology() return void
References: <C832CAEC20DE4FC4+20250218094027.482396-1-wangyuli@uniontech.com>
 <tencent_46D6C2824357C42E11A3C9CD@qq.com>
In-Reply-To: <tencent_46D6C2824357C42E11A3C9CD@qq.com>

--------------odl10bMVBgOO7pTAtEoBstzM
Content-Type: multipart/mixed; boundary="------------ESD1ckMuonMqTCSGfFhE03Oy"

--------------ESD1ckMuonMqTCSGfFhE03Oy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

djINCg==
--------------ESD1ckMuonMqTCSGfFhE03Oy
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

--------------ESD1ckMuonMqTCSGfFhE03Oy--

--------------odl10bMVBgOO7pTAtEoBstzM--

--------------acInEYS23tGt8yIu3XWP7RJu
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZ7RaDgUDAAAAAAAKCRDF2h8wRvQL7lt8
AP9mgdczpw03elESqO9o29lOI2P70yRIHBTOPK0wZZfqbwEA3+lfRN/VBo1zKZB3z0GCkJ/VIrlA
8CezrJW3fdmSkgk=
=4+xs
-----END PGP SIGNATURE-----

--------------acInEYS23tGt8yIu3XWP7RJu--

