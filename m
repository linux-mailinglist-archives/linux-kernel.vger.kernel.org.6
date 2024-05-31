Return-Path: <linux-kernel+bounces-196874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B728D62D5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12FA92818C8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEB3158A2D;
	Fri, 31 May 2024 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=exactco.de header.i=@exactco.de header.b="n2F1nR1t"
Received: from mx.exactcode.de (mx.exactcode.de [144.76.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E70976026;
	Fri, 31 May 2024 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161654; cv=none; b=BvS3lOInMMGAUDxmrLW5SIERm3QtoH+TIhhxHmdpkbh57cSGGYbBEhRTSPdujI7+UmDoLyzq41PfdGAFksKvTrHtml7lLjDOIhSLTOTnqvv7MMpydjx9uvPb43KwZSfNvF191epeo2tad9rv0x1sDOWcJM2RcGYdlZ+/BY2tKLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161654; c=relaxed/simple;
	bh=dKmNE0E7ZviqScpi94wGgebczcb90IUx8m5/5bHX5Ws=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=n/ewiA6d8Sl2LwBIsH6d7R1ykE7maIqFGldBTrpgCpMA1X53NVNnM4VpMxjDxw9O8Tt7CtDmF6N1w1dseeSRFkDs4VrMu0lUFeP+826oK/RUtekC8k3zOvm6tOcvHIUCsesieD5ojB4OQtfJq/NvGJCVZFFrKB+QTPOL1eaWBzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactcode.de; spf=pass smtp.mailfrom=exactcode.de; dkim=pass (1024-bit key) header.d=exactco.de header.i=@exactco.de header.b=n2F1nR1t; arc=none smtp.client-ip=144.76.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactcode.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactcode.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de; s=x;
	h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:Content-Type; bh=Q6kQeXhhImb9rMJUOuoy86swbcuC/f501yBqI5RiV3g=;
	b=n2F1nR1tSZ7c0W/+3REcThrguG+vW9GcMusMwpnJIc4qxkdYqA9heaS6Kb54r0LfqBo4tmcbO9aSHWf8oiyTz/91xlzh4JVgeKxsJXh88g6De3M1cU2wz5qaLvPaI4nC9TDFt0iS1aXFzMl98BqNg5iBLtP3nyvGvjKBzsx27Cw=;
Received: from exactco.de ([90.187.5.221])
	by mx.exactcode.de with esmtp (Exim 4.82)
	(envelope-from <rene@exactcode.de>)
	id 1sD2C8-00007J-Pt; Fri, 31 May 2024 13:21:20 +0000
Received: from [192.168.2.131] (helo=smtpclient.apple)
	by exactco.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.86_2)
	(envelope-from <rene@exactcode.de>)
	id 1sD2Ek-0005ig-1p; Fri, 31 May 2024 13:24:02 +0000
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH 2/3] hwmon: Add support for SPD5118 compliant temperature
 sensors
From: =?utf-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.de>
In-Reply-To: <ea135424-841c-4a5a-b881-a3295d87b64a@roeck-us.net>
Date: Fri, 31 May 2024 15:20:38 +0200
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 =?utf-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 linux-hwmon@vger.kernel.org,
 Hristo Venev <hristo@venev.name>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Radu Sabau <radu.sabau@analog.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <151934EE-F826-4655-BEF1-2199B1AAAD5C@exactcode.de>
References: <20240529205204.81208-1-linux@roeck-us.net>
 <20240529205204.81208-3-linux@roeck-us.net>
 <34a4292e-c4db-4b40-822e-b892e1444045@t-8ch.de>
 <16e448f1-cfc9-4e88-b3f1-55e1856d1405@roeck-us.net>
 <0a2ed64d-06d9-45e8-a054-4ded4429f952@t-8ch.de>
 <ffd72953-ecd2-405a-ad6d-236143b26946@roeck-us.net>
 <20240531093154.rna2vwbfx7csu2sj@ninjato>
 <BA0B79E0-6582-45EA-8EA9-35E278B8CC42@exactcode.de>
 <ea135424-841c-4a5a-b881-a3295d87b64a@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
X-Spam-Score: -0.5 (/)

Hi,

> On May 31, 2024, at 15:14, Guenter Roeck <linux@roeck-us.net> wrote:
>=20
> Hi Ren=C3=A9,
>=20
> On 5/31/24 03:01, Ren=C3=A9 Rebe wrote:
>> Hi,
>> On May 31, 2024, at 11:31, Wolfram Sang =
<wsa+renesas@sang-engineering.com> wrote:
>>>=20
>>> Hi all,
>>>=20
>>>>> Wolfgang seems to think it's important:
>>>=20
>>> Wolfram, please.
>>>=20
>>>>> =
https://lore.kernel.org/lkml/tdia472d4pow2osabef24y2ujkkquplfajxmmtk5pnxll=
sdxsz@wxzynz7llasr/
>>>>>=20
>>>>=20
>>>> Ok, but that doesn't explain the reason. Wolfram, Paul, why do you
>>>> think this is needed ? Note that I am not opposed to adding spd
>>>> eeprom support, but I'd like to know why I am doing it before
>>>> I spend time on it.
>>>=20
>>> A working eeprom driver is needed to get 'decode-dimms' from the
>>> i2c-tools package working. Jean reported that EEPROM access for DDR5 =
is
>>> different from DDR4, so it needs a separate driver. And
>>> i2c_register_spd() then needs to be updated to use the new driver =
for
>>> DDR5.
>> Well my original downstream driver already had eeprom access:
>> https://svn.exactcode.de/t2/trunk/package/kernel/linux/spd-5118.patch
>=20
> Yes, but you didn't send it upstream, so I took it, fixed a couple of =
bugs,

And I appreciate that!

> dropped eeprom support since that is secondary for my use case as well =
as the

I only said the original code had this implemented if someone wants to =
re-add it
to save them some time not having to re-write it from scratch ;-)

> out-of-tree parity code, and submitted it. I'd be more than happy to =
let you
> take over if you like.

I=E2=80=99m mostly out of time, so I appreciate you starting the =
upstream process.

Thank you so much,
	Ren=C3=A9

--=20
ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
http://exactcode.com | http://exactscan.com | http://ocrkit.com


