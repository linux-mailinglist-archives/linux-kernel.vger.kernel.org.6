Return-Path: <linux-kernel+bounces-332464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F0997BA1D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F360B20B59
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5841C17838A;
	Wed, 18 Sep 2024 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="hFeOihVP"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CEB176FDB
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726651666; cv=none; b=SoGFgPPmRfS6qZXo8PVEGZUpNP5n1CpgpiaU3Q2h9XJIpoj1FuVvmbksO6f9hGQbxKHco9/Uoj5HZ6RhjA/u5RDdk6VkYWpYrEYLE30QIZ42sfK3OF+pIHUnZ3Q4iID0HfFzsu2rvYqd5QP0cOHNHHBS9xw6t4c5eSK21KzeHtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726651666; c=relaxed/simple;
	bh=fbl02o7WY/EAFJap1sYR8J1ap6Y7e0nRr1EcBE9LY6Q=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=P1LuOd1OHA1agnk/GJEZmJUDVPc1N0FYPZnin++khIRSN0LszjRJx+rr1enaWHxSZmCj1E7lddgVrAeDZ4cZx3CiWlaL0TPRQnGSJ4ZeSSkEL9VOa0vjaycLQtBLDYX9v40IDAQIm1MKYcbGRi99/Ae8av1X9FmVHlCtoyF+bkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=hFeOihVP; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1726651654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CcXS7pKBmWCVMi0FiYuE7jrw1z1w0kyY8yOpJgkZTWg=;
	b=hFeOihVPMGvcGl4yvu0jpqU+l3bTHwD0UqT3ybAR184ENHUaLim/C2bL85ZB/mLxyHwjCp
	hBURPWpy5BgCPnu1sdzYGqxe2s3wBB3UkBWKKgOouBeAi2TqBjkqy+ek7Dd3sVNlRjO+nq
	0eTSlaeZgcH7hUQfpFbMV/IItqmdcq+K2mwUXS5Vtvlw6PNLtPQXxwz0T6Q7w1FRN2yTIu
	133JxZbTm+8P1KTH8/qcl8hPZYC/vv6goOJ6Vt1/Jgaoht/qRb9DyfJvzazkZGDyZnD4qN
	9ilXSe+sf92BsH+goOkgDaebiqL/xoqbqDvnufuyRnB4y4X9KSRgwNNakSXeEQ==
Date: Wed, 18 Sep 2024 11:27:31 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>
Subject: Re: [PATCH] arm64: dts: sun50i-a64-pinephone: Add mount matrix for
 accelerometer
In-Reply-To: <ZunCysUTSfQU1ylg@skv.local>
References: <20240916204521.2033218-1-andrej.skvortzov@gmail.com>
 <6e5d0e9978bff30559c17f30d1495b59@manjaro.org> <ZunCysUTSfQU1ylg@skv.local>
Message-ID: <c7664fda936d36e0d916ae09dd554d2e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Andrey,

On 2024-09-17 19:56, Andrey Skvortsov wrote:
> On 24-09-16 23:08, Dragan Simic wrote:
>> On 2024-09-16 22:45, Andrey Skvortsov wrote:
>> > From: Ondřej Jirman <megi@xff.cz>
>> >
>> > accelerometer is mounted the way x and z-axis are invereted, x and y
>> > axis have to be spawed to match device orientation.
>> > The mount matrix is based on PCB drawing and was tested on the device.
>> 
>> This commit summary should be copyedited for grammar and style.  If
>> you want, I can provide a copyedited version?
> 
> It would be helpful to avoid further grammar/style problems in the
> commit message. Thanks in advance.

Alright, here's how it could be worded...  First, the patch summary
should use the common prefix, together with a bit of rewording, so
the patch summary should read like this:

   arm64: dts: allwinner: pinephone: Add mount matrix to accelerometer

The patch description should be reworded like this, reflown into
proper line lengths, of course:

   The way InvenSense MPU-6050 accelerometer is mounted on the
   user-facing side of the Pine64 PinePhone mainboard requires
   the accelerometer's x- and y-axis to be swapped, and the
   direction of the accelerometer's y-axis to be inverted.

   Rectify this by adding a mount-matrix to the accelerometer
   definition in the PinePhone dtsi file.

   [andrey: Picked the patch description provided by dsimic]
   Fixes: 91f480d40942 ("arm64: dts: allwinner: Add initial support for 
Pine64 PinePhone")
   Cc: stable@vger.kernel.org

Please note the Fixes tag, which will submit this bugfix patch
for inclusion into the long-term/stable kernels.

Also note that the patch description corrects the way inversion
of the axis direction is described, which should also be corrected
in the patch itself, as described further below.

After going through the InvenSense MPU-6050 datasheet, [1] the
MPU-6050 evaluation board user guide, the PinePhone schematic,
the PinePhone mainboard component placement, [2] and the kernel
bindings documentation for mount-matrix, [3] I can conslude that
only the direction of the accelerometer's y-axis is inverted,
while the direction of the z-axis remain unchanged, according
to the right-hand rule.

>> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
>> > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
>> > ---
>> >  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 3 +++
>> >  1 file changed, 3 insertions(+)
>> >
>> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
>> > b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
>> > index bc6af17e9267a..1da7506c38cd0 100644
>> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
>> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
>> > @@ -229,6 +229,9 @@ accelerometer@68 {
>> >  		interrupts = <7 5 IRQ_TYPE_EDGE_RISING>; /* PH5 */
>> >  		vdd-supply = <&reg_dldo1>;
>> >  		vddio-supply = <&reg_dldo1>;
>> > +		mount-matrix = "0", "1", "0",
>> > +				"-1", "0", "0",
>> > +				"0", "0", "-1";
>> >  	};
>> >  };

With the above-described analysis in mind, the mount-matrix
should be defined like this instead:

		mount-matrix = "0", "1", "0",
			       "-1", "0", "0",
			       "0", "0", "1";

Please also note the line indentation that was changed a bit.

[1] https://rimgo.reallyaweso.me/vrBXQPq.png
[2] https://rimgo.reallyaweso.me/uTmT1pr.png
[3] 
https://www.kernel.org/doc/Documentation/devicetree/bindings/iio/mount-matrix.txt

