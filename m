Return-Path: <linux-kernel+bounces-335895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3648997EC36
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6707C1C21160
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42E819994A;
	Mon, 23 Sep 2024 13:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rffk1QKP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5751993BB;
	Mon, 23 Sep 2024 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727097860; cv=none; b=fTJ1aXS9WP85ggUkryFduLCvyuIlYaJA/1/Z3uFXfbCT9KqD9KBH2yHfrI61T+rOuFDrmGHt4YG2b4SRxEvk07FxHWqc3tGM82GaS7oculB2a1CmOaTGp+FzDdo5wRmuxjG4GCtIyoiC/ktGA/rkjyX6HWlYqdlF5jYB2MO0YsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727097860; c=relaxed/simple;
	bh=1Y5lWsWltXKCLrbYTCBEEqslN/hWBYcwxbc2HekEYDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BEFGFQxTvOV4VROPrC46bmC6kkbWMDTkYOD09C4SYUZXpl/+BoM/Kyl/Odcmu61o+NHpjN/3CUWkfn3wZvHZCPRkVbggvKXdGAYvtJZGn8aukpPJi5oy+Ziy0DKY5038SP9QHz6j/P7mVTlPVQiY0fcjLA6ajbm32P5FQBFUsUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rffk1QKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA41C4CEC7;
	Mon, 23 Sep 2024 13:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727097859;
	bh=1Y5lWsWltXKCLrbYTCBEEqslN/hWBYcwxbc2HekEYDc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rffk1QKPBAYFtMH/ZWgcOreUBrNLZhVVmajBiOhZU6zjiayA8mI7wlOOjsv2HKIja
	 mxHuD6khAtWxzLrUJhQSgBOZCjjACKOLCi16Qww8SHqHnE+45qONN6zybu5QXQLMIy
	 reWyv4yPGpJUYW0txFfwZ9HEwmXIuHx4p0M3KxyQx/K3y6BhWfdsfU7WQH0GNEbMeO
	 fXbvEMK+TNzz0LT2cAzdbn8q+l0gncIgO2yeONITpskAlKFHxaoUJ65W1ccO818/wu
	 +q8/X2IKXuVBYdjlN6qVFfwQNc29iFoLBPTi5riPTVnQdaephJNCiQtKFEusqF2H0q
	 TmROieqrSXjew==
Message-ID: <ed7e7044-1b5a-44a4-be24-7c94278244b0@kernel.org>
Date: Mon, 23 Sep 2024 16:24:15 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] sub: cdns3: Use predefined PCI vendor ID constant
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240913131710.3630560-1-andriy.shevchenko@linux.intel.com>
 <d6ec3b8b-9405-49fa-ba39-a0bf6311a489@kernel.org>
 <ZvFkv-xrs1ul7-oI@smile.fi.intel.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <ZvFkv-xrs1ul7-oI@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23/09/2024 15:53, Andy Shevchenko wrote:
> On Mon, Sep 23, 2024 at 03:42:20PM +0300, Roger Quadros wrote:
>> On 13/09/2024 16:17, Andy Shevchenko wrote:
>>> The PCI vendor ID for Cadence is defined in pci_ids.h. Use it.
>>> While at it, move to PCI_DEVICE() macro and usual pattern for
>>> PCI class and device IDs.
> 
> ...
> 
>>> +#define PCI_DEVICE_ID_CDNS_USB3	0x0100
>>
>> Why do we need to change this? You did not explain in commit log.
> 
> It's explained: "...usual pattern for PCI class and device IDs."
> 
>> I would call this PCI_DEVICE_ID_CDNS_USBSS3. Also see later why to differentiate with USBSSP.
> 
> It's good to know that there are semantic differences,
> but it is already applied, feel free to update.
> 
> ...
> 
>>> -	{ PCI_DEVICE(CDNS_VENDOR_ID, CDNS_DEVICE_ID), },
>>> +	{ PCI_VDEVICE(CDNS, PCI_DEVICE_ID_CDNS_USB3) },
>>
>> For better readability I still prefer
>> 	PCI_DEVICE(PCI_VENDOR_ID_CDNS, PCI_DEVICE_ID_CDNS_USBSS3)
> 
> I disagree. The PCI_VDEVICE() has less letters and much easier to get
> the vendor from the (less power to parse and decode is required).
> 

:)

> ...
> 
>>> -#define CDNS_DEVICE_ID		0x0200
>>> -#define CDNS_DRD_ID		0x0100
>>> -#define CDNS_DRD_IF		(PCI_CLASS_SERIAL_USB << 8 | 0x80)
>>> +#define PCI_DEVICE_ID_CDNS_USB3		0x0100
>>
>> This is an entirely different card who's device ID should be 0x200?
>> Also I don't think this card supports USB3 so it is a wrong name choice.
> 
> Are you stating that 0x0100 in both cases points to the *different* devices?!
> This is unbelievable, however possible abuse of PCI IDs.

I am not entirely sure.
What I do know is that one card should be USBSS (0x100) and other should be USBSSP (0x200). P for super-speed-Plus.

Also please see commit 96b96b2a567f ("usb: cdnsp: changes PCI Device ID to fix conflict with CNDS3 driver")

> 
>> I would call this PCI_DEVICE_ID_CDNS_USBSSP	0x200	to match with PCI driver name.
>>
>>> +#define PCI_DEVICE_ID_CDNS_UDC		0x0200
>>
>> UDC is used for Peripheral controller only. Is that really the case here?
>> originally it was called DRD. 
>> So how about?
>> 	PCI_DEVICE_ID_CDNS_DRD		0x0100
> 
> I strongly disagree. The same PCI IDs should be named the same independently on
> how many drivers use them.

Agreed.

> 
> The only possibility to have what you propose is the complete screwed up PCI
> IDs allocations done by vendor (I do not believe this is the case with Cadence).
> 
-- 
cheers,
-roger

