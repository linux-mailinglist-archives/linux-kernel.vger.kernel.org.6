Return-Path: <linux-kernel+bounces-561498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D87A612AD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0C2188D952
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 13:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2C61FFC72;
	Fri, 14 Mar 2025 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cutebit.org header.i=@cutebit.org header.b="jKqTWJyd"
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DADF4ED;
	Fri, 14 Mar 2025 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.8.165.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741959087; cv=none; b=UKxbZ9R8SCtvvUm66zgA5+SpwTNAP21LFoTQUp2t7UW0XsaB6lkNy4HRZ1OisueIKxdY6XSRHV3x9ZBGg3eMqucskbbtbmxJK3r+vKJrl8hgpE5hrI5oIsKpW5vURS9Nd9BUcyD5nlKIqy+DwBjhmn45Qn2w13ApmG5gg3dbRmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741959087; c=relaxed/simple;
	bh=UATdpA7cgBWM5CfhL0BSNAFRMNZeQJf0RDSodrMiFm8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mw+qAguWniGKgaO/P5t64d3VaaJrzpmw4QXo3UerUHUgm1djM+CYJO1yANxxvSSStLC4XFB10m2lDyTXBJitmxYalMhXGeYCNk0oeNTShywG5uk3z4NOqILjx7pVBxx7TEo9345sN8Sa+8w1osfevO9u4BFSa8Ce4+wDyz6+8So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cutebit.org; spf=pass smtp.mailfrom=cutebit.org; dkim=pass (1024-bit key) header.d=cutebit.org header.i=@cutebit.org header.b=jKqTWJyd; arc=none smtp.client-ip=185.8.165.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cutebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cutebit.org
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
	t=1741958603; bh=ZHlFpUcnqM8kwtMsWbJUG26ffc8HSmguvMRTzaq18qo=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=jKqTWJydfegfYVUU3CI43+xEXTTX0q0K+BAe7HdFbCdxYFM7FE9x0XVzalHsIuBd2
	 ryokhFgSViug4ZiAremjxKHXTgDkao/2LXpqjFPGSzxRaEZ8iN/88ISYnRpLtnt3jt
	 k3XKi7vuXCj9nqxTQIzpAAq5CyutQ4yrSJrz1SU0=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH v3 17/20] ASoC: dt-bindings: tas2770: add flags for SDOUT
 pulldown and zero-fill
From: =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
In-Reply-To: <20250312125832.GA359842-robh@kernel.org>
Date: Fri, 14 Mar 2025 14:23:11 +0100
Cc: James Calligeros <jcalligeros99@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Shenghao Ding <shenghao-ding@ti.com>,
 Kevin Lu <kevin-lu@ti.com>,
 Baojun Xu <baojun.xu@ti.com>,
 Dan Murphy <dmurphy@ti.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Shi Fu <shifu0704@thundersoft.com>,
 Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Hector Martin <marcan@marcan.st>,
 linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 asahi@lists.linux.dev,
 linux-hwmon@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BDE96592-9DE8-407C-8FB9-B84B492D7951@cutebit.org>
References: <20250227-apple-codec-changes-v3-0-cbb130030acf@gmail.com>
 <CAHgNfTxS1Q4PPsw520-J4Yn6xg+QZOYFkYhg5yv-uZFu5waN_g@mail.gmail.com>
 <20250307205156.GA583954-robh@kernel.org> <5996925.DvuYhMxLoT@setsuna>
 <20250312125832.GA359842-robh@kernel.org>
To: Rob Herring <robh@kernel.org>

Hi Rob, James,

> On 12. 3. 2025, at 13:58, Rob Herring <robh@kernel.org> wrote:
>=20
> On Mon, Mar 10, 2025 at 07:30:07PM +1000, James Calligeros wrote:
>> On Sat, Mar 8, 2025 at 6:51=E2=80=AFAM Rob Herring <robh@kernel.org> =
wrote:
>>> How would it work when you need a mask? "dai-tdm-slot-tx-mask" is
>>> enough?
>>=20
>> The existing TX/RX slot masks are used to control which slots the =
codec
>> is operating on, AIUI. I don't know if it makes sense to alter how =
codecs
>> deal with this. Could we combine the suggested dai-tdm-slot-tx-idle
>> with an optional dai-tdm-slot-tx-idle-mask property? =46rom the =
machine
>> driver's perspective, the API would then be similar to the existing
>> set_tdm_slot ops. The current downstream macaudio machine driver =
builds
>> its links by allowing multiple codecs and CPUs to be linked to a DAI,
>> like so:
>=20
> Wouldn't the NOT of dai-tdm-slot-tx-mask be the idle mask?
>=20
> Don't think about the Linux APIs here. The DT is separate. So think in=20=

> terms of what you need to describe the TDM timing/waveform.
>=20
>>=20
>> dai-link@0 {
>> cpu {
>> sound-dai =3D <&cpu0>, <&cpu1>;
>> };
>> codec {
>> sound-dai =3D <&speaker0>,
>>  ...,
>>  <&speaker6>;
>> };
>> };
>>=20
>> In this case, the codec-specific mask property was added so that a =
mask
>> could be applied to a specific codec rather than the whole dai, =
however
>> from upstream drivers tt looks like the way this should be handled is =
to
>> have "dai-tdm-slot-tx-idle-mask-n" properties at the dai level, then =
have
>> the machine driver set the mask for the appropriate codec during =
setup. So
>> for macaudio, assuming speaker5 requires this zerofill mask, we would
>> have something like this:
>=20
> I'm now confused why you need n masks and what does n represent?

For this setup there are 6 codecs on the same bus but 3 of those are on =
one
data line and the other 3 are on another data line. Within the SoC these =
two
data lines (both for codec->SoC direction) are ORed together in front of =
the
receiver peripheral.

This means we need at least one codec within each group of the three to =
zero
out the bus for the duration of the slots used by the other group of =
three.

I solved this by attaching

 ti,sdout-force-zero-mask =3D <0xf0f0f0>;

on one codec from the first group, and

 ti,sdout-force-zero-mask =3D <0x0f0f0f>;

on one from the other group.

FWIW the right form of these masks is not an implementation detail of =
the
machine driver spilling into the device tree (so that the mask would =
need
to be different if the machine driver was implemented differently). This =
is
because the slots used by each codec are specified via a DT property =
too, e.g.

  ti,imon-slot-no =3D <8>;
  ti,vmon-slot-no =3D <10>;

Martin

> Rob
>=20


