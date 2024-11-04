Return-Path: <linux-kernel+bounces-395168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D79499BB9CC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE3928204D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9F61C07F3;
	Mon,  4 Nov 2024 16:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oWBrESDj"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2E6208A7;
	Mon,  4 Nov 2024 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730736338; cv=none; b=eI4ma9n5LS8IGQG8h1Oaf1v6U+8W6RV7d8qX7d6FQc3aE+SfH6wzoaBpKcN62FWzeWzab7azN6FB0RVVlKjWjYrtOIpnsWeFfOsrUOsqenopWxqvHBuCWhDqmmLaidCnqoSQKnN3U6bmnlldN7Gp42iJb8gY007w6YffTJADfZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730736338; c=relaxed/simple;
	bh=OHtFV7tHDYv2kLL2ZzjwBTy+CA8ziyZqbKQx6QELXuo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j09IIxGQy4szQfZyZVvREntjLaPR6NIJSP8x3HD544f5eqFNwzlw+6odlj/5p1OZGXBHCYdZNNVuKP7Gu2tXG+k36SXaib3Ss8MsWFdalDLkbePcKXo98GE7aEKcZGs0dwqaDuKjMRm8/Ty0aBumMdoU7JkOYYpExQtf1+Y8xM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oWBrESDj; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D6E2460006;
	Mon,  4 Nov 2024 16:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730736335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bGXE4eDYjk2lR2ubbk00XXdKNVfRlNdbyZKN2+XEphI=;
	b=oWBrESDjrkJ+vex81zeexplceHDPwXDVOl6tJO1sOBfkZdIDzT7P+MMRlsRP9DbqB1hrSg
	Og3p5pVD7P1CtF7HDKs7Cf1Tey7iOj3vUaEr8cqMOXC4SkkKPp0Oeft+MWR+Ixmhs7BZv8
	Y3WvpiXl9jyw7LnvZj80kF//6X6izUlkrewdxYzwnTGeEnfoNp/gKC6POszbZRLpOnzu6h
	UvJYpqGa3LAlBke1UZic4dHZrV2joV6cRTjSBgKMTD80KAlurBItXgQ6nvYwuZYjfDurhJ
	KbHc3ZLihnhXfUYtjU6DT9jf9M4cp1yz5WltPqtSZQpTyMWsGFLXH5oAnNrO6A==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Rob Herring <robh@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Sebastian
 Hesselbarth <sebastian.hesselbarth@gmail.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: marvell: kirkwood: Fix at24 EEPROM node name
In-Reply-To: <CAL_JsqLLRSEaDv=Zm_LQH9cpgH2prh21+cmovgSR=pzQTuRtZQ@mail.gmail.com>
References: <20240910215914.823546-1-robh@kernel.org>
 <CAL_JsqLLRSEaDv=Zm_LQH9cpgH2prh21+cmovgSR=pzQTuRtZQ@mail.gmail.com>
Date: Mon, 04 Nov 2024 17:05:34 +0100
Message-ID: <878qtz9e7l.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: gregory.clement@bootlin.com

Hello Rob,

> On Tue, Sep 10, 2024 at 4:59=E2=80=AFPM Rob Herring (Arm) <robh@kernel.or=
g> wrote:
>>
>> at24.yaml defines the node name for at24 EEPROMs as 'eeprom'.
>>
>> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
>> ---
>>  arch/arm/boot/dts/marvell/kirkwood-openblocks_a7.dts | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Ping!
>
> Are Marvell platforms still maintained?

Actually I just applied it this morning, and was about to notify about
it.

Applied on mvebu/dt

Thanks,

Gregory

>
>>
>> diff --git a/arch/arm/boot/dts/marvell/kirkwood-openblocks_a7.dts b/arch=
/arm/boot/dts/marvell/kirkwood-openblocks_a7.dts
>> index 9c438f10f737..2bc4b68bd723 100644
>> --- a/arch/arm/boot/dts/marvell/kirkwood-openblocks_a7.dts
>> +++ b/arch/arm/boot/dts/marvell/kirkwood-openblocks_a7.dts
>> @@ -44,7 +44,7 @@ sata@80000 {
>>                 i2c@11100 {
>>                         status =3D "okay";
>>
>> -                       s24c02: s24c02@50 {
>> +                       s24c02: eeprom@50 {
>>                                 compatible =3D "atmel,24c02";
>>                                 reg =3D <0x50>;
>>                         };
>> --
>> 2.45.2
>>

--=20
Gr=C3=A9gory CLEMENT, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

