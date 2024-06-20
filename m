Return-Path: <linux-kernel+bounces-222148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE2A90FD60
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA921F22674
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B11F44366;
	Thu, 20 Jun 2024 07:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b="nep78odR"
Received: from mx.adeep.su (mx.adeep.su [185.250.0.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE392582;
	Thu, 20 Jun 2024 07:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.250.0.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718867726; cv=none; b=apjizbS1Lqv3gQbSG/ps9mBq6rw70z3saXXqcBJdL7gWyggfehmELfAPrEUAk4Y4Rz2h7wRdvhT8gDP1yoRGeuzrA7nPSssY3We0yzjxfTJT5HMtlHA5isuBoEeaP2350AttaGtzCb37KC2S7068XfIjaUB2v6W0MMJtheFhen4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718867726; c=relaxed/simple;
	bh=IcyYdfYiiQmPyGKImIiSXfQv9WUKdIW5Dqeg5Xl7rVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LDXoAsDkYTM7qsmwZTn5LIki1pJTsTOl0LBoyrz3NP86lHi6EpPmBCffV15jx3feB1bz9cYW+oJA2eXAMYA9VDlLL6dQaznmAwkRfbDYyCxsmmFDv3lecfDdBjQfd0IqGUCJnmR4ncZO3dUdtYyNMRLoYzLp2XXUEufq9fIOuLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in; spf=pass smtp.mailfrom=lexina.in; dkim=pass (2048-bit key) header.d=lexina.in header.i=@lexina.in header.b=nep78odR; arc=none smtp.client-ip=185.250.0.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8930A3C58C;
	Thu, 20 Jun 2024 10:14:57 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
	t=1718867710; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references:autocrypt;
	bh=FSfsG4wFQaSQRKS7ZW04On8EVVzNoCP8c5oRfY9w5uM=;
	b=nep78odRMFIcA7g6A9dVwUfphlJ8JoSl34cYyDkihxS1AeFR8/7BDc8c/rZKHmT5CSIoDK
	Skg7k6jZBEZNuOimLXsANvaEw3TTGsGRmSx6vMH4gPiC1ZLAQTOvHuFO6MtoIpxGRiDkuF
	HqS4uwQzUSQBjJo/Jg+LFX7/qiCojUZatT0RzbhHlSZf4F7K+JOPmY1rdcTNW9Dv4/jCVE
	J4xaIN/wnZi55NAi37HO+Nv/av0dgZm6Gsxw/eAkDZ/d4q4OYcTyTPFdiQ5AL9Usyb6UQp
	+W/+1D5XECx5df5yH0xwoIP4CbMLzm48VOL8fh9VX+rJ5nV/1pj/RpaCM8pbng==
Message-ID: <3e939ec0-f38b-468b-a897-80be207c1bdd@lexina.in>
Date: Thu, 20 Jun 2024 10:14:57 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] dt-bindings: arm: amlogic:
 amlogic,meson-gx-ao-secure: add secure-monitor property
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
References: <20240610084032.3096614-1-adeep@lexina.in>
 <20240610084032.3096614-4-adeep@lexina.in>
 <20240610-dropout-compress-6d6a9b749524@spud>
 <4866f6d4-2e3c-40c7-a8cb-ba4e422ffef6@lexina.in>
 <20240611-undying-earthy-00236ac251aa@spud>
 <20240613164244.GA1999034-robh@kernel.org>
 <c0d18fef-be65-461e-948f-c25e757199a5@lexina.in>
 <20240617-sulfate-posture-1619f1cdf090@spud>
Content-Language: ru
From: Viacheslav <adeep@lexina.in>
Autocrypt: addr=adeep@lexina.in; keydata=
 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
In-Reply-To: <20240617-sulfate-posture-1619f1cdf090@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



17/06/2024 19.57, Conor Dooley пишет:
> On Mon, Jun 17, 2024 at 11:21:30AM +0300, Viacheslav wrote:
>> Thanks for review.
>>
>> 13/06/2024 19.42, Rob Herring wrote:
>>> On Tue, Jun 11, 2024 at 07:07:28PM +0100, Conor Dooley wrote:
>>>> On Tue, Jun 11, 2024 at 01:25:11PM +0300, Viacheslav wrote:
>>>>> Hi!
>>>>>
>>>>> 10/06/2024 19.08, Conor Dooley wrote:
>>>>>> On Mon, Jun 10, 2024 at 11:39:49AM +0300, Viacheslav Bocharov wrote:
>>>>>>> Add secure-monitor property to schema for meson-gx-socinfo-sm driver.
>>>>>>
>>>>>> "bindings are for hardware, not drivers". Why purpose does the "secure
>>>>>> monitor" serve that the secure firmware needs a reference to it?
>>>>>
>>>>> This driver is an extension to the meson-gx-socinfo driver: it supplements
>>>>> information obtained from the register with information from the
>>>>> SM_GET_CHIP_ID secure monitor call. Due to the specifics of the module
>>>>> loading order, we cannot do away with meson-gx-socinfo, as it is used for
>>>>> platform identification in some drivers. Therefore, the extended information
>>>>> is formatted as a separate driver, which is loaded after the secure-monitor
>>>>> driver.
>>>>
>>>> Please stop talking about drivers, this is a binding which is about
>>>> hardware. Please provide, in your next version, a commit message that
>>>> justifies adding this property without talking about driver probing
>>>> order etc, and instead focuses on what service the "secure monitor"
>>>> provides etc.
>>>
>>> To put it another way, how many secure monitors does 1 system have?
>>
>> One per system in current device tree.
> 
> One per system, or one is currently described per system, but more might
> be added later?

it turns out to be one per system. It's either there or it's not.

> 
>>> What do you do if the property is not present? You didn't make it
>>> required which is good because that would be an ABI break.
>>
>> We need an indication of the ability to use the secure-monitor to obtain
>> additional information within the soc driver. It seemed to me that using an
>> explicit reference to the secure-monitor is the best choice.
>>
>>>
>>> You only need a link in DT if there are different possible providers or
>>> some per consumer information to describe (e.g. an interrupt number or
>>> clock ID). You don't have the latter and likely there is only 1 possible
>>> provider.
>>
>> Would replacing the reference to sm with an option, for example,
>> use-secure-monitor = <1>; look more appropriate in this case?
> 
> Perhaps a silly question, but (provided there's only one per system, why
> can't the secure-monitor driver expose a function that you can call to get
> a reference to the system-monitor? I did something similar before with
> a call to in mpfs_sys_controller_get() mpfs_rng_probe(). Granted,
> mpfs-rng is probed from software so it's slightly different to your
> case, but the principle is the same and it's not unheard of for code in
> drivers/soc to expose interfaces to other drivers like this. You can
> just call a function like that, and know whether there's a secure
> monitor, without having to retrofit a DT property.

That could be an option. But again, nothing prevents me from searching 
for the secure-monitor node throughout the entire DT array.

The question is more about something else, let me try to explain from 
the beginning:

We currently have a soc driver that uses only the register to get basic 
information and it must be loaded early because other modules' behavior 
depends on its information.
There is an option to supplement the register information with 
information from the secure-monitor.
For this, we had to write a new driver that uses the same register 
information as a fallback but can wait for the secure-monitor driver to 
load and add its information to soc.
It seemed logical to me to keep the DT structure the same and just add a 
reference to the secure-monitor (or as a second option, create a 
variable indicating support) for those SoCs that have been tested and 
can provide this information.
Not all Amlogic SoCs support this call, in some (mostly newer 
generations of SoCs), this call returns incorrect information and we and 
colleagues are still figuring out what has changed. But most established 
platforms support this.
We could add this information retrieval to the secure-monitor itself, 
but that would be a completely different story and would not constitute 
a soc driver.

In the end, we need information about the support of the secure-monitor 
call for obtaining information for the soc driver. In my opinion, this 
can only be done by specifying it in the DT in specific files for 
Amlogic platforms: either by referencing the SM or by an option that 
allows checking the SM.

> 
> Thanks,
> Conor.
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

