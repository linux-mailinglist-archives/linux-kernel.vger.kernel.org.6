Return-Path: <linux-kernel+bounces-332596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E838497BBA0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 13:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4791288711
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62340176248;
	Wed, 18 Sep 2024 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="CtsfmNVL"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D7B175D4C
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726658841; cv=none; b=FhfMJ1jNTSpTW+RPza9mUIDF2ul1Qjp/UQ/B52UB8VrBgGAcR41XEVz8lsFVYY4x41mQ02v82YPxCGy2VRLJJXwEQw76LCJWwN1uCFh3nm0vpQgn3ZX9AzCkncY/itfO4zd+L5kE7vHm2/7PEO/u6RmLdvbVc4p+hJOgLT5bWrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726658841; c=relaxed/simple;
	bh=APZDhT+NJdFY/yYp7lXO/YQdWBelGRrnsx8C18CQ8Eg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=n6X+U6VfT+XlZeGungpK9tNw7ezARnIRV42zmLSsj3/HOL57QpmDEs1xJ4hR3EVbushTPWzu9kbsNedRTgwgDzLFrBjw0ar31LDs9/UiObQdM504saoC8oeuybukGPE1rjqoy59RS5TrMJVQIa2H/lEc+dWoRu8R2Qd3s3hvx/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=CtsfmNVL; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1726658836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nfH01sB+DBUpTSjL37MwEOYgAbC2BjpMcYHpPwSx4fY=;
	b=CtsfmNVLqtJ+WQam3YvWbhBJhaWK/pE93Z78JTKYcbMqgNBnzqYJO50ASggcDMRXG9GhAG
	uAs+K/jGWO7Aote38bJpbYv9Bmcm7gnqtU0KVtWerqoqv8S4/WdyLtKMuTkG30ivTmeazG
	s7nRL0AlNVZmiQeVR/CU7qqdFHVUzwRMpy8+4FkqrosQV0PietQZPx0G6ctiCte7GKEK9E
	vw7s4tFxBSArSEv44Veg6Jv7ubptMHdLQv0M1B3pBfTKXYQOAEFmLBjd3w9PQioDR080y5
	9rOS8gFVVjQvlzUTp7wYTNqi/3xYh39FItlTa5TdkbqTClxvKtKNhOoEkZvy1g==
Date: Wed, 18 Sep 2024 13:27:16 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>
Subject: Re: [PATCH] arm64: dts: sun50i-a64-pinephone: Add mount matrix for
 accelerometer
In-Reply-To: <ZuqyuvZ6tdzp5XSW@skv.local>
References: <20240916204521.2033218-1-andrej.skvortzov@gmail.com>
 <6e5d0e9978bff30559c17f30d1495b59@manjaro.org> <ZunCysUTSfQU1ylg@skv.local>
 <c7664fda936d36e0d916ae09dd554d2e@manjaro.org> <ZuqyuvZ6tdzp5XSW@skv.local>
Message-ID: <8df5fc79a3e899738aa944a290774c72@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

[Sorry for the noise, the webmail I'm using somehow managed to mess up
the recipients list.  Sending again with the list fixed.]

Hello Andrey,

On 2024-09-18 13:00, Andrey Skvortsov wrote:
> On 24-09-18 11:27, Dragan Simic wrote:
>>   arm64: dts: allwinner: pinephone: Add mount matrix to accelerometer
>> 
>> The patch description should be reworded like this, reflown into
>> proper line lengths, of course:
>> 
>>   The way InvenSense MPU-6050 accelerometer is mounted on the
>>   user-facing side of the Pine64 PinePhone mainboard requires
>>   the accelerometer's x- and y-axis to be swapped, and the
>>   direction of the accelerometer's y-axis to be inverted.
>> 
>>   Rectify this by adding a mount-matrix to the accelerometer
>>   definition in the PinePhone dtsi file.
>> 
>>   [andrey: Picked the patch description provided by dsimic]
>>   Fixes: 91f480d40942 ("arm64: dts: allwinner: Add initial support for
>> Pine64 PinePhone")
>>   Cc: stable@vger.kernel.org
> 
> Thanks for the commit description, it's much better, than original
> one.

  Thanks, I'm glad that you like it.

>> Please note the Fixes tag, which will submit this bugfix patch
>> for inclusion into the long-term/stable kernels.
>> 
>> Also note that the patch description corrects the way inversion
>> of the axis direction is described, which should also be corrected
>> in the patch itself, as described further below.
>> 
>> After going through the InvenSense MPU-6050 datasheet, [1] the
>> MPU-6050 evaluation board user guide, the PinePhone schematic,
>> the PinePhone mainboard component placement, [2] and the kernel
>> bindings documentation for mount-matrix, [3] I can conslude that
>> only the direction of the accelerometer's y-axis is inverted,
>> while the direction of the z-axis remain unchanged, according
>> to the right-hand rule.
> 
> yes, it looks so on the first glance, but in MPU-6050 datasheet there
> is also following information:
> 
>  7.8 Three-Axis MEMS Accelerometer with 16-bit ADCs and Signal
>  Conditioning
> 
>  When the device is placed on a flat surface, it will measure
>  0g on the X- and Y-axes and +1g on the Z-axis.
> 
> So sensors reports positive acceleration values for Z-axis, when
> the gravity points to Z-minus. I see the same on device. positive
> values are returned, when screen and IC point upwards (not the center
> for gravity).
> 
> In device tree mount-matrix documentation [3] there is
> 
>  users would likely expect a value of 9.81 m/s^2 upwards along the (z)
>  axis, i.e. out of the screen when the device is held with its screen
>  flat on the planets surface.
> 
> According to that, it looks like Z-axis here has to be inverted.

Yes, reporting +1 g on the z-axis with the device remaining stationary
on a level surface is the normal behavior, and the returned positive
value actually goes along with the quoted description from the kernel
documentation.  The z-axis of the MPU-6050 goes upward and out of the
screen, the way the MPU-6050 is placed inside the PinePhone.

> It applies to other axes as well. And because of that I came from
> (only Y-axis is inverted)
> 
> x' = -y
> y' =  x
> z' =  z
> 
> to inverted solution (Y-axis is kept, but X and Z are inverted).
> 
> x' =  y
> y' = -x
> z' = -z
> 
> probably should put this information into commit description.

Wouldn't inverting the direction of the z-axis go against the
above-quoted description from the kernel documentation?

>> > > > Signed-off-by: Ondrej Jirman <megi@xff.cz>
>> > > > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
>> > > > ---
>> > > >  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 3 +++
>> > > >  1 file changed, 3 insertions(+)
>> > > >
>> > > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
>> > > > b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
>> > > > index bc6af17e9267a..1da7506c38cd0 100644
>> > > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
>> > > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
>> > > > @@ -229,6 +229,9 @@ accelerometer@68 {
>> > > >  		interrupts = <7 5 IRQ_TYPE_EDGE_RISING>; /* PH5 */
>> > > >  		vdd-supply = <&reg_dldo1>;
>> > > >  		vddio-supply = <&reg_dldo1>;
>> > > > +		mount-matrix = "0", "1", "0",
>> > > > +				"-1", "0", "0",
>> > > > +				"0", "0", "-1";
>> > > >  	};
>> > > >  };
>> 
>> With the above-described analysis in mind, the mount-matrix
>> should be defined like this instead:
>> 
>> 		mount-matrix = "0", "1", "0",
>> 			       "-1", "0", "0",
>> 			       "0", "0", "1";
> 
> 
> x' =  0 * x + 1 * y + 0 * z =  y
> y' = -1 * x + 1 * y + 0 * z = -x
> z' =  0 * z + 0 * y + 1 * z =  z
> 
> your description says, that only Y-axis is inverted, but this matrix,
> imho, inverts original X axis as it was in original description.

The way it's specified, it actually swaps the x- and y-axis, and
inverts the direction of the y-axis, all that from the viewpoint
of the accelerometer, which matches the proposed patch description.
IOW, the description keeps the original names of the axes.

>> Please also note the line indentation that was changed a bit.
>> 
>> [1] https://rimgo.reallyaweso.me/vrBXQPq.png
>> [2] https://rimgo.reallyaweso.me/uTmT1pr.png
>> [3] 
>> https://www.kernel.org/doc/Documentation/devicetree/bindings/iio/mount-matrix.txt

