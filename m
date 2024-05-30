Return-Path: <linux-kernel+bounces-195706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCF38D5087
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038D3284318
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 17:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A796433C2;
	Thu, 30 May 2024 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="kClFoaZw"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7898645BF3;
	Thu, 30 May 2024 17:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717088849; cv=none; b=bMKvb37jwNeh0kwYeKRHRJ3VjSWI0YPzktYLhoNMlMVEJU/AMLntEfneubaIW8Z0jRFuUR6Fqk8THeFwjzMr63JlGS2eavNsKPwkkuiPNymJD0z5Qf7XqE2OpgXH2sC1s+nRie1U3M4i8kF/5VVo6Hm/77//xBoet9pjRpKn0E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717088849; c=relaxed/simple;
	bh=eaWBU/Gs0AVqYWKI7fIzfvj87upg7eVwzFYEt+kQATc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkyi7ISG5IH16PfTlFK1J7wzLNsLJYHOU/sWILcKv1DvyGHI26xxhqQ4UH7g98sTqDHzdPOvZt8NWLYkVrWkaGccIayQVsMd41sMXp+eRI6susUnR9T8g6/E2sGnem++YuPD12yWgrXz/+MOu0J/nduA53Up/kuO9Fd/VC25kNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=kClFoaZw; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1717088818; x=1717693618; i=w_armin@gmx.de;
	bh=eaWBU/Gs0AVqYWKI7fIzfvj87upg7eVwzFYEt+kQATc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kClFoaZweyHzYDbr0riKqN3XxIn8HiskIzI/mhgGAjaGiChxbjgcDOX2sC3splHX
	 CLZg9fwq/5e1IqQgTu26KL9nCZ8Ethx6qBEsYeBA7f3K1xHcM0aVOUHxYK3+hUITd
	 R2soy7QkCdM7/5f5DE/X0KL5BZiLBMSFpW/Vg0zQx2fcYBDC07PxYWHesSJhlilEN
	 25ldGgt/DusHjcYfY1B5sdLX2a2/qXBJLCma14NdbhjzWm/KoWst2miW8wxrA/eAN
	 nLbN3VI1YpI+ys9edGoaJUCPXHu7PcX/Vyi4/DXANa5Tht3m7QzGRLYMPFRTkfz3+
	 ODA+F9omcs0cr5GAnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MC30Z-1sKgO440gX-00CO0l; Thu, 30
 May 2024 19:06:58 +0200
Message-ID: <dd3ee875-f6be-40ec-a40e-0733de9b9981@gmx.de>
Date: Thu, 30 May 2024 19:06:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hwmon: Add support for SPD5118 compliant temperature
 sensors
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: Hristo Venev <hristo@venev.name>, =?UTF-8?Q?Ren=C3=A9_Rebe?=
 <rene@exactcode.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>
References: <20240529205204.81208-1-linux@roeck-us.net>
 <20240529205204.81208-3-linux@roeck-us.net>
 <fa79f3c2-666f-48b8-b39a-f598107b2293@gmx.de>
 <0dc7a7c6-a426-424a-8321-471569ee6835@roeck-us.net>
 <bd197671-4fef-4cdb-8472-b46151e9008b@roeck-us.net>
 <5b9e47cb-3d9a-4d12-9d48-fc03111a0240@gmx.de>
 <f0b2c682-ce43-426c-92f9-008256f08eff@roeck-us.net>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <f0b2c682-ce43-426c-92f9-008256f08eff@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MB6Iceh72pLeWW7gTfUXGLV5THTLNb6+8pLlsvweBdIRrJvZwv5
 1ogaC7ErGd5JtWlcMI0FcjN22P9NvuIiLeMLYj3P6UyzSE78TqIuwWON6L0b1RuKzd0Gugb
 +dI7PZXc0fPdxdiNedOEIhe1Prtcd2sle81UP/Zq4BZ3h33wuK2DzWBj0jBLTM8dkf9ub3X
 dckry6Re89HKZACTyuxhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:s/YkqP0Ujzo=;swc+mr3mQl7ygdI6UwHn9d70FnZ
 FMsnF99Sf1E0xVU2oigKnsnJExPhGh3wO4UOikooOMhNYNLdYqtljmNwPQE1q9kkKQgAb4Sog
 Hl+nndHSoCDCknDHEzHBRXU0rA0FY9LvuCGBu/eNJ3YA+sRkpfoODif9HQ6AJS0Sh0JTawluY
 F7FGvF2ke4/UQ/HI7KKe3xUrEHqF5uUg8mqWWCWiQBURrSGWm3wT7V1tuDHmap9qneI6RJg5J
 Qr88mXqwswGxprPsoajEPcwK3mBRCWgNSOOQov6xi3mouTihQNG+Du+6O7PyO5FD5JQxZj4pC
 fRE9oysM1Nua2qnH90icUVVBVTHSuBNf/o+mFI3KvMUSPqT3d8XQTewUJnerISJ1bAy9ZvrVE
 Sn66liUCe7YYyNw1StMjzPKiEteS728lSQAr0RuZALTAPLq2Yrcr5ecuFTWdv+eVBZ7kXSjzV
 vDJh5BqIa4NWrkBXvfu0xT7mKGlpImgddDT15Ivy+E4L1eJlWWzkuwr67EPNEqmht84f9f+8K
 1QPSJxzdP6kJHBOZrfSVQ37P4WLANUXYZVbzqnWY5pE0An7HnqnC/BBU1ejgsPdNffTchzHCz
 2HZjZWkWeGlUkRsRVMGo0nfsqVaNpa3NVJd375O8xzKo0kwAidDfxBmfwkRyCL9wXJ9Jj28BW
 6H3i73+1lZtaw+Aenl+TNA/jCVCGbpUX93TKcLugXBUqyxqhyl0gu3qxcj+knQ8533H7OI2yo
 zLT2RZwFrLopNSoHIO4oA/FFKW1I/NY3soteyXaTjFXBChczRQNGlhbTLoSnKpG8uCViTRc1d
 D9RQct+v4Ijgv8Tx4MZjNPlaXsiehsJwtN0a2QAazIyac=

Am 30.05.24 um 18:51 schrieb Guenter Roeck:

> Hi Armin,
>
> On 5/30/24 09:45, Armin Wolf wrote:
> [ ... ]
>>>
>> # i2cdump 1 0x51
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0 1=C2=A0 2=C2=A0 3=C2=A0 4=C2=A0 =
5=C2=A0 6=C2=A0 7=C2=A0 8=C2=A0 9=C2=A0 a=C2=A0 b=C2=A0 c=C2=A0 d=C2=A0 e=
=C2=A0 f 0123456789abcdef
>> 00: 51 18 0a 86 32 03 32 00 00 00 00 00 ff 3c 00 00 Q???2?2......<..
>> 10: 00 00 00 00 00 00 00 00 00 00 00 00 70 03 00 00 ............p?..
>> 20: 50 05 00 00 00 00 00 00 00 00 00 00 00 00 00 00 P?..............
>> 30: 00 c0 01 00 00 00 00 00 00 00 00 00 00 00 00 00 .??.............
>> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>> 80: 30 10 12 02 04 00 40 42 00 00 00 00 b2 12 0d 00 0????.@B....???.
>> 90: 00 00 00 00 a0 01 f2 03 7a 0d 00 00 00 00 80 3e ....????z?....?>
>> a0: 80 3e 80 3e 00 7d 80 bb 30 75 27 01 a0 00 82 00 ?>?>.}??0u'??.?.
>> b0: 00 00 00 00 00 00 d4 00 00 00 d4 00 00 00 d4 00 ......?...?...?.
>> c0: 00 00 d4 00 00 00 88 13 08 88 13 08 20 4e 20 10 ..?...?????? N ?
>> d0: 27 10 1a 41 28 10 27 10 c4 09 04 4c 1d 0c 00 00 '??A(?'????L??..
>> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>>
>
> Thanks a lot. This is again Montage Technology's M88SPD5118.
> What is your DDR module vendor ?
>
> Thanks,
> Guenter
>
Kingston Fury KF552C40BBK2-16, a 2x8GB DDR5 5200 kit.

Thanks,
Armin Wolf


