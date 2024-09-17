Return-Path: <linux-kernel+bounces-331494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FED97AD7A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6901F22DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B7D158550;
	Tue, 17 Sep 2024 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDL01/k7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91958136357;
	Tue, 17 Sep 2024 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563801; cv=none; b=kvVwFcK6A0uh0L60NMVPPYtDSn2dO1/BTFMQ3QTZglVhX2Z0+AJs6qJtWxYtZHTnCMO8jHP7/ZEtNJKPK8R07Fmr8fAzqYTNks8/Mf0xYZydL+ORO/daBZ1ae9ZMaIWgzoG6z7cfZX7qcVMGU+Ikl1fvobSaVE+dzZ9tllMGXlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563801; c=relaxed/simple;
	bh=OsFdptcZeF3SkvKh3KbXZC51VYL7O10KmMpKSiV9EgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPM2p++KE7NsuxSazXrtuO2rmjQ+MVhb2uzIIk8CuvXMMaqjdLNtWttFp8i9gn87xJ/OOwfDkMrXRBoEwqGq4NaIC1Ah7F42czrCJ4fxUzqC6S2OJb5xuFWTvhYKyVZ+bU8RWH0RA8v7zekuFzJgFU2z69OY0YWlE9TjMFOhTYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDL01/k7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB4DC4CEC6;
	Tue, 17 Sep 2024 09:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726563801;
	bh=OsFdptcZeF3SkvKh3KbXZC51VYL7O10KmMpKSiV9EgE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fDL01/k735mRABQsLa5JjfYg42kh4IIOz9YBzhl0cIPUqscQXIXtuWWNgEI3auO+A
	 v4/BR1LGT43a/giVYohTuuDA24hjNqKuNIoOtOJpPFCgM/igLscryEZ5MPWnPpdW/T
	 SGLeLjCxfP0NrPftCE2cIptotuAwsNVWRNs/6b0x/U1p8gcM/Cnp0XMe1g22UIJWyy
	 2ie4zsWzLObN25DtOQH5c8WzwKMUWWZj5l9qzN+gK9F2v9d8DbC4s0Zg71R/ZKAh17
	 vSWhVdSYDeSpvXso45hIZnZD+8rTpliz9lbiCNFTYI+IYOPMJcU+GpeGaZk4mh3LJd
	 ltBrlnuLbwSlQ==
Message-ID: <26fed82b-7c60-4fda-8951-b22654728743@kernel.org>
Date: Tue, 17 Sep 2024 11:03:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add framework for user controlled driver probes
To: Nayeemahmed Badebade <nayeemahmed.badebade@sony.com>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 rafael@kernel.org, yoshihiro.toyama@sony.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240911142319.3435746-1-nayeemahmed.badebade@sony.com>
 <2024091327-repacking-avatar-ec23@gregkh>
 <ZulGr8Ul7y0T0NkQ@NAB-HP-ProDesk-600sony.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <ZulGr8Ul7y0T0NkQ@NAB-HP-ProDesk-600sony.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/09/2024 11:06, Nayeemahmed Badebade wrote:
> Hi Greg,
> 
> Thank you for taking the time to check our patch and provide
> valuable feedback. We appreciate your comments/suggestions.
> 
> Please find our reply to your comments.
> 
> On Fri, Sep 13, 2024 at 06:36:38AM +0200, Greg KH wrote:
>> On Wed, Sep 11, 2024 at 07:53:17PM +0530, Nayeemahmed Badebade wrote:
>>> Hi,
>>
>> If Rob hadn't responded, I wouldn't have noticed these as they ended up
>> in spam for some reason.  You might want to check your email settings...
>>
> 
> I have ensured standard settings which we have been using are used this
> time, let me know if this email is received properly.
> 
>>> This patch series introduces a new framework in the form of a driver
>>> probe-control, aimed at addressing the need for deferring the probes
>>> from built-in drivers in kernels where modules are not used.
>>
>> Wait, why?
>>
> 
> We have a scenario where a driver cannot be built as a module and ends up
> as a built-in driver. We don't want to probe this driver during boot as its

Fix this instead.

> not required at the time of booting.
> Example: drivers/pci/controller/dwc/pci-imx6.c
> So the intention is to only postpone some driver probes similar to:
> https://elinux.org/Deferred_Initcalls
> But instead of delaying initcall execution(which requires initmem to be kept
> and not freed during boot) we are trying to delay driver probes as this is
> much simpler.
> The proposed driver is a generic solution for managing such driver
> probes.
> 
>>> In such scenario, delaying the initialization of certain devices such
>>> as pcie based devices not needed during boot and giving user the control
>>> on probing these devices post boot, can help reduce overall boot time.
>>> This is achieved without modifying the driver code, simply by configuring
>>> the platform device tree.
>>
>> PCI devices should not be on the platform device tree.
>>
> 
> You are right, we are referring to the pci host controller that will be
> listed in device tree and skipping its probe during boot as an example
> here.
> 
>> And what's wrong with async probing?  That was written for this very
>> issue.
>>
> 
> We have explored async probe as an option, but we noticed below:
> 1) Probe initiated via async
> 2) Boot continues with other setup.
> 3) Boot reaches stage where ip configuration is to be done via
>    ip_auto_config() and 1) is still in progress, then boot waits for all
>    async calls to be completed before proceeding with network setup.
>    ip_auto_config()
>     -> wait_for_devices()
>       -> wait_for_device_probe()
>          -> async_synchronize_full()
> 4) Similar thing happens with rootfs mount step in prepare_namespace()
>    initcall
> 
> So to avoid getting blocked on these probes which are not required
> during boot, we proposed this driver for managing such built-in driver
> probes execution.
> 
>>> This patch series includes 2 patches:
>>>
>>> 1) dt-binding document for the probe-control driver
>>>    This document explains how device tree of a platform can be configured
>>>    to use probe-control devices for deferring the probes of certain
>>>    devices.
>>
>> But what does that have to do with PCI devices?
> 
> As explained before, the driver is generic one and is for managing probes of
> drivers that are built-in.
> 
> To delay such probes, in DT we add dummy devices managed by the proposed
> driver. These dummy devices(probe control devices) will be setup as
> supplier to the device nodes that we want to probe later.

You embedded OS policy into DT. That's not really the way to go. Look
how boot phase does it. First of all - it already solves your problem.
Second - it's property of each device, not some fake provider.

> dt-binding doc patch explains this process with pci controller node as
> an example that needs to be probed later after the boot.
> 
>>


Best regards,
Krzysztof


