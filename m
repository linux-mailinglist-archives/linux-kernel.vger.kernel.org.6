Return-Path: <linux-kernel+bounces-196671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D44E08D5FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FFE6286CA7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408D7155A5D;
	Fri, 31 May 2024 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=exactco.de header.i=@exactco.de header.b="sq/68tkN"
Received: from mx.exactcode.de (mx.exactcode.de [144.76.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3D9150997;
	Fri, 31 May 2024 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717151192; cv=none; b=DMxSE7xVcCGDPoy2nzyMMqJFsrUpclX6U8903OiTegT/qkrAKU+TcFIjYQkr6sysfKSLOeHZmvI+hO8wnYDpXH4VbI9ax8vRnUUdi9WHiUX9nknnh2Qy98IIz0ON21R//b95ZsBa6nqKitgrujGBHHIGxXTrGHCoB+Yg2S+91Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717151192; c=relaxed/simple;
	bh=7DUjjMTSikNgt3aT++EcWYY1TqaPsjZb2Iel1P6aPxs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ldEmTpu610kcA/DowtTzFngoXXua2JnUTL330GpuujqmuvxWv+nhpOGouQr4s2RMb3u13Ev8WfW4CAEaZkpYAfrgqtjNShfZKxOx1p8Gt5kciY947EBge3GjlGng6A9wIJFNZcH+4kzYWsgIRd/utkfIHQ0QoPjrtN3HaZOAA9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactcode.de; spf=pass smtp.mailfrom=exactcode.de; dkim=pass (1024-bit key) header.d=exactco.de header.i=@exactco.de header.b=sq/68tkN; arc=none smtp.client-ip=144.76.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactcode.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactcode.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de; s=x;
	h=To:References:Message-Id:Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:Content-Type; bh=a8KggmGaKDZZtnscDRz48StTHWGYeHwCoGv1AU1JscY=;
	b=sq/68tkN8ocozxD3yYsVWsexRuHm/2jGblms4BiyahZ/S0nxSmKCFxSdezsqS/lqTEds7nVGUzepcM8rO5uM3ENsY22b3byBlS2ZTvTrMWs9yM2mH9W7K9m2YafBE+GrrJCPCqvIJtQvqnOunsyxgf+rJYQD6WKGd/sCxtG1urg=;
Received: from exactco.de ([90.187.5.221])
	by mx.exactcode.de with esmtp (Exim 4.82)
	(envelope-from <rene@exactcode.de>)
	id 1sCz5V-0000Ud-8I; Fri, 31 May 2024 10:02:17 +0000
Received: from [192.168.2.131] (helo=smtpclient.apple)
	by exactco.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.86_2)
	(envelope-from <rene@exactcode.de>)
	id 1sCz86-0002lf-BT; Fri, 31 May 2024 10:04:58 +0000
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
In-Reply-To: <20240531093154.rna2vwbfx7csu2sj@ninjato>
Date: Fri, 31 May 2024 12:01:35 +0200
Cc: Guenter Roeck <linux@roeck-us.net>,
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
Message-Id: <BA0B79E0-6582-45EA-8EA9-35E278B8CC42@exactcode.de>
References: <20240529205204.81208-1-linux@roeck-us.net>
 <20240529205204.81208-3-linux@roeck-us.net>
 <34a4292e-c4db-4b40-822e-b892e1444045@t-8ch.de>
 <16e448f1-cfc9-4e88-b3f1-55e1856d1405@roeck-us.net>
 <0a2ed64d-06d9-45e8-a054-4ded4429f952@t-8ch.de>
 <ffd72953-ecd2-405a-ad6d-236143b26946@roeck-us.net>
 <20240531093154.rna2vwbfx7csu2sj@ninjato>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
X-Mailer: Apple Mail (2.3774.300.61.1.2)
X-Spam-Score: -0.5 (/)

Hi,

On May 31, 2024, at 11:31, Wolfram Sang =
<wsa+renesas@sang-engineering.com> wrote:
>=20
> Hi all,
>=20
>>> Wolfgang seems to think it's important:
>=20
> Wolfram, please.
>=20
>>> =
https://lore.kernel.org/lkml/tdia472d4pow2osabef24y2ujkkquplfajxmmtk5pnxll=
sdxsz@wxzynz7llasr/
>>>=20
>>=20
>> Ok, but that doesn't explain the reason. Wolfram, Paul, why do you
>> think this is needed ? Note that I am not opposed to adding spd
>> eeprom support, but I'd like to know why I am doing it before
>> I spend time on it.
>=20
> A working eeprom driver is needed to get 'decode-dimms' from the
> i2c-tools package working. Jean reported that EEPROM access for DDR5 =
is
> different from DDR4, so it needs a separate driver. And
> i2c_register_spd() then needs to be updated to use the new driver for
> DDR5.

Well my original downstream driver already had eeprom access:

	=
https://svn.exactcode.de/t2/trunk/package/kernel/linux/spd-5118.patch

Note there are some surrounding -2, and parity patches around this =
patch.

Thanks,
	Ren=C3=A9

--
ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
http://exactcode.com | http://exactscan.com | http://ocrkit.com


