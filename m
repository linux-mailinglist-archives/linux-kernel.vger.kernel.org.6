Return-Path: <linux-kernel+bounces-333765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 422E497CDA5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 20:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A17F281155
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F4A200AE;
	Thu, 19 Sep 2024 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="nCHrOSvO"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F651F95A
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770884; cv=none; b=Zp16/U73ksHJJjDL7iDHCY3MYP9VV4jmnimtEqAW2rg9JHoF2oW7bVPSAEW3v26I9Tkc1MI0Cu0OqqSXw4PM4m4kscrYxfHMMEvcmLKTOWyN1xbKZV2aaBaMxRRCZiqiVrjpUlmIgDv2ttlRBKzqjkrHhCihrqoeFZgGQF75Yhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770884; c=relaxed/simple;
	bh=H8L3MMxZlrxSwYFY6yRO+F9fFEKVsbGYX7CDv5z/Ufo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=OdMaTj+xNLY2KEs7z8oliz7ifZ2vbkziYyv1T1Nl4+ACdUAZSIWg7KKo8M/yNLw3hIcpTsY/vTtJx6JnYprqZBJzuu3lKaFcPEnNwcF12cuGiz484Yj78n5fcuMdpwUxQv86TTOVIRdl+CEWdnVezDN6JkQ4z2qce5e0MjCwlac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=nCHrOSvO; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1726770873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIULysZF5TMjnjwraqB7R4rq843vxTAF9l4sGzR+ceA=;
	b=nCHrOSvOtD0+oRTQuarYBV89rrMdq/kQH6Z+Ir4t5BctX2hYMj/tmNNDqQASN4SOeTbUdU
	xUPDRDX/Nzyr5wsZejOuZ2b20PlJcbIqobXgLrvAecwy1BxxW0OGhQOo5LktEjnYHpOp10
	fIHL5Dei7FtU0QU1EpEsc43m92vW7CiYLNJByduEk0Tp4sZoY3ZlmG2UGfU+2cTmQY06Vw
	/4wYp5rxUozH0esTWQ4DGYG3TRwl61bQYmEgZX3SB5bpg9hQIAhYNP/33Dl8yG7A8TXhiE
	C9ugtx0FhGNVT5NxYD+22D3flLCIZTDQvq6VAjZhLVFNYXIBzomX08lksu5feQ==
Date: Thu, 19 Sep 2024 20:34:32 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>
Subject: Re: [PATCH] arm64: dts: sun50i-a64-pinephone: Add mount matrix for
 accelerometer
In-Reply-To: <Zur4rhyT50lwxE_v@skv.local>
References: <20240916204521.2033218-1-andrej.skvortzov@gmail.com>
 <6e5d0e9978bff30559c17f30d1495b59@manjaro.org> <ZunCysUTSfQU1ylg@skv.local>
 <c7664fda936d36e0d916ae09dd554d2e@manjaro.org> <ZuqyuvZ6tdzp5XSW@skv.local>
 <8df5fc79a3e899738aa944a290774c72@manjaro.org> <ZurYndjVz7r0U6dz@skv.local>
 <Zur4rhyT50lwxE_v@skv.local>
Message-ID: <b4139fedf81f3a3fc94d361b7f013109@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Andrey,

On 2024-09-18 17:58, Andrey Skvortsov wrote:
> On 24-09-18 16:41, Andrey Skvortsov wrote:
>> On 24-09-18 13:27, Dragan Simic wrote:
> 
>> > > In device tree mount-matrix documentation [3] there is
>> > >
>> > >  users would likely expect a value of 9.81 m/s^2 upwards along the (z)
>> > >  axis, i.e. out of the screen when the device is held with its screen
>> > >  flat on the planets surface.
>> > >
>> 
>> how I read kernel documentation.
> 
> Hm, I think I misunderstand this part in kernel
> documentation and you were correct.
> 
>> Picture 2.
>> 
>> up
>> 
>>      +--------+
>>      !        !
>>      ++++++++++
>>          !
>>          !
>>          v
>>        gravity, Z
>> 
>> down
>> 
>> Screen (drawn as ++++++++++) is looking downwards ("its screen flat on
>> the planets surface"). Gravity and Z axis point into the same
>> direction and it's expected to read positive value.
> 
> Sorry, for the noise.

Oh, no worries at all.  It's always good to discuss and iron out
any kinks, to eliminate any possible doubt.

The entire concept of how the values on the z-axis are read is
a bit confusing indeed.  When the device is stationary on a level
surface, with the screen pointing upwards, it's like the device is
defying the Earth's gravity pull.  Well, not actually the device,
but the surface it's resting on, :) but you get the point.

>> Actually, unless my analysis is proven wrong, perhaps it would
>> be better if I'd submit this patch in its final form, because it
>> has diverged a lot from the original patch.  IIUC, Ondrej only
>> imported the original patch from somewhere, without some kind of
>> proper attribution. [4]
> 
> please, submit your version of this patch. I'd be glad to review it (I
> think, I've already did)

Yes, you basically already did that. :)  Thanks, I'll send my version
of the patch in the next few hours, with proper attribution included
for you and Ondrej, of course.

>>> [1] https://rimgo.reallyaweso.me/vrBXQPq.png
>>> [2] https://rimgo.reallyaweso.me/uTmT1pr.png
>>> [3] 
>>> https://www.kernel.org/doc/Documentation/devicetree/bindings/iio/mount-matrix.txt
> 
>> [4] 
>> https://xff.cz/kernels/6.9/patches/0221-arm64-dts-sun50i-a64-pinephone-Add-mount-matrix-for-.patch

