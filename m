Return-Path: <linux-kernel+bounces-419221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEEB9D6AFE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 20:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE83F281F35
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 19:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4B11494CC;
	Sat, 23 Nov 2024 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhV68Qbk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686F9182C5
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 19:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732388742; cv=none; b=S+5DZJuJRNYpjlUC1oz7gPG3hlrTj4Nt24DodvqhNzkVnfnfS6mimQ2Je0S6PQ13ftbe+Uhwvl/oI5j3urVavdkhC20OBib4h7RlmNRp8+HQJ4R1pR66MvjpKFcobMRYa1aa4tSV1a4juTnuIhyRIJ2GPF3NEOZ4OePaCLPwZbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732388742; c=relaxed/simple;
	bh=o2PWTH0sI8Z9fqFnWRCI8k8Lwwwm1yNlBv3w5fruW3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSgwVxVOB9yltOjiczHKJVpvhwfjZxWrjwtlRVA7pW3gKcP8h5yEMfdfZy2zfXx8tXF1gmULNajAMYnn+uVhUXTZ5yfOT2GntdFjkGfO6j8/sDNPOCHLl7riZg6RHx6gcy13Y5iAwnfkYJvivQD0HMVDYluBzXyVkctaUPKONgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhV68Qbk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11224C4CECD;
	Sat, 23 Nov 2024 19:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732388741;
	bh=o2PWTH0sI8Z9fqFnWRCI8k8Lwwwm1yNlBv3w5fruW3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PhV68QbkNh2vBBG2RYU7PMtCi9/P1BqybTO35G2pTo0/AehZP4WYgIWog0CrgRBFJ
	 fj90Rbj92M8H7E8M3sZD71S8Tb7UPqRfkmX1JxZpZO+k0FQD1FHXZEBMVAtOyvVbUm
	 Ta9pXHy0dG97gE9rifvYT+yUrwQ2uLRs0Ro9qsEZe3krv9FkhOdpvqqmy+w2//tO0B
	 6hCN0V0NiGv2zJ0DnQWoQ8+ZxhxrRC5tX9NDHiJtttaLsu+zeKeDNxb0Lro2aLF3ph
	 mrB2k2fFNfCSc/6xx5uN8v0UxEvh7tbN4tybt9ez0cnS5mpm5BBRMGRILSdOOlX8vR
	 oAZrAMYc5K3vg==
Date: Sat, 23 Nov 2024 20:05:38 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] HID for 6.13
Message-ID: <2eh3ep6ft5kekc6u6hj3m5qflk5bypbfatpwo6oiptnpspaa6j@wqapte332xgy>
References: <nycvar.YFH.7.76.2411182207390.20286@cbobk.fhfr.pm>
 <CAHk-=wiUkQM3uheit2cNM0Y0OOY5qqspJgC8LkmOkJ2p2LDxcw@mail.gmail.com>
 <ziofbee4q5cvxvovpzb2rfjw2cduefpm4umwtfyyx5kfwajjp4@nrjwkqryz2j5>
 <CAHk-=wj2XYoq5Rp-An0SMRiA0x7mzGWgt1RyqQYpm1DtX0XwJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj2XYoq5Rp-An0SMRiA0x7mzGWgt1RyqQYpm1DtX0XwJQ@mail.gmail.com>

On Nov 23 2024, Linus Torvalds wrote:
> On Sat, 23 Nov 2024 at 08:42, Benjamin Tissoires <bentiss@kernel.org> wrote:
> >
> > IMO the suspect might be 526748b925185e95f1415900ee13c2469d4b64cc.
> 
> I'll try reverting it when I have more time (which is probably end of
> next week.. merge window).

No need to bother with this one then, because your receiver is the
0xc52b, which is the old (and well known) unifying receiver, when this
commit touches teh bolt receiver, which is 0xc548. So a revert would
have no impact.

> 
> > In addition to Jiri's requests, could you also post the dmesg after the
> > fresh (and broken) reboot, and after unplug/replug the dongle? We would
> > get more information on to which kernel modules are involved this way.
> 
> All I get for a unplug/replug is
> 
>   usb 5-4.2.2: USB disconnect, device number 10
>   usb 5-4.2.2: new full-speed USB device number 11 using xhci_hcd
>   usb 5-4.2.2: New USB device found, idVendor=046d, idProduct=c52b,
> bcdDevice=24.11
>   usb 5-4.2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
>   usb 5-4.2.2: Product: USB Receiver
>   usb 5-4.2.2: Manufacturer: Logitech
> 
> and then
> 
>   logitech-djreceiver 0003:046D:C52B.0019: hiddev100,hidraw9: USB HID
> v1.11 Device [Logitech USB Receiver] on usb-0000:46:00.1-4.2.2/input2
>   input: Logitech MX Anywhere 3 as
> /devices/pci0000:40/0000:40:01.1/0000:41:00.0/0000:42:08.0/0000:46:00.1/usb5/5-4/5-4.2/5-4.2.2/5-4.2.2:1.2/0003:046D:C52B.0019/0003:046D:4090.001A/input/input36
>   logitech-hidpp-device 0003:046D:4090.001A: input,hidraw10: USB HID
> v1.11 Mouse [Logitech MX Anywhere 3] on
> usb-0000:46:00.1-4.2.2/input2:1
>   logitech-hidpp-device 0003:046D:4090.001A: HID++ 4.5 device connected.
> 
> but doing some grepping, at bootup time I also see a line line
> 
>   hid-generic 0003:046D:4090.000E: input,hidraw10: USB HID v1.11 Mouse
> [Logitech Wireless Device PID:4090] on usb-0000:46:00.1-4.2.2/input2:1

What would be interesting to know is if the line

logitech-hidpp-device 0003:046D:4090.001A: HID++ 4.5 device connected.

ever happens on a fresh reboot (before the unplus/replug).

Anyway, this confirms my theory that the mouse wheel is set to high
resolution mode by the previous boot and that the next one (using
hid-generic) is actually not handling properly: I bet that if you scroll
long enough in the same direction (can't remember exactly the actual
multiplier) you'll eventually get one scroll event. Not convenient I
agree :)

> 
> which does not happen at replug. There's a few other boot-time
> messages that seem to be about module init stuff too, ie
> 
>   input: Logitech USB Receiver as /devices/...
>   input: Logitech USB Receiver Mouse as /devices/...
>   input: Logitech USB Receiver Consumer Control as /devices/...
>   input: Logitech USB Receiver System Control as /devices/...
>   input: Logitech Wireless Device PID:4090 Mouse as /devices/...
> 
> and that only happens once and then never again. Some module loading
> thing? I have
> 
>   CONFIG_HID=y
>   CONFIG_HID_BATTERY_STRENGTH=y
>   CONFIG_HIDRAW=y
>   CONFIG_HID_GENERIC=y
> 
> but then the Logitech part is modules:
> 
>   CONFIG_HID_LOGITECH=m
>   CONFIG_HID_LOGITECH_DJ=m
>   CONFIG_HID_LOGITECH_HIDPP=m
> 
> which I think is all normal (ie I have my own local config, but that
> part matches the default distro kernel config)
> 

Yep all normal.

The problem seems to be that hid-generic is not letting
hid-logitech-hidpp taking over (or that the driver is not properly
loaded at boot time once the disk is ready). I have some suspicions on
some core changes I made in hid-core for handling a new quirk, but I
should be able to reproduce next week with all of that information.

Sorry for the trouble.

Cheers,
Benjamin

