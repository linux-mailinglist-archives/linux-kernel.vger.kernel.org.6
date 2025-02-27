Return-Path: <linux-kernel+bounces-536355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CE7A47E87
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3387D3B3DE2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF07D22F166;
	Thu, 27 Feb 2025 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YQZn4FaJ"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56C41662EF;
	Thu, 27 Feb 2025 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661593; cv=none; b=T5OkArBB5oZ4aGkO1Si4YXwaDhbEORpCiiEfnAN69cyJTih51aM34gqDHFt4cJ/EfiUYb/q4WkTiAu5f3CD56x46lWNT7NwZ7pBCs+1X3LHzrAnbyrSjTFYoBxSTtza2yT0n9hUKhmlU59z+6m6EnHiyYghXhntljhKg+AIgvbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661593; c=relaxed/simple;
	bh=gehwLQH/F0EbzXWjJA5bmN6veVCSiRGzWa9NpQ7Foho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KvgQRwb8rigf00VgmVBVsTPjlHpnTWKp+cGWpEF7Kj6vcmPXNbNUF/PMLQTZRds/Vr3I4iKUshcLJ992VYfBiSFXeVAHrYPNTighe4FOkF/IDKZSLqeA8i7nbW8hTv7ZVKH8cHhkLbQXjOiV1y8jjutr+cn7v2pX4GlvRVTIaMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YQZn4FaJ; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 05B2F433D6;
	Thu, 27 Feb 2025 13:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740661587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0jurlLBNXfGd9DqDpI41umHtPOLvrCM/YL4keN35dP4=;
	b=YQZn4FaJmdglmiMSVbEuKnBrJAFELHRX1nhF48UX+WMCEibHQEd3UdSSticOgQ91WWHjeJ
	DQ8CpwXxJCTA/0r1BV14ekk2Nk2J1+rT8ztwsjUJK0MEyPcs/7z/a4ksZnzaAUiX2iCRbh
	oABVymmTy4kWJD/rF+VLV59ijZd1W7skFplXpH1bObyWKY/kYM1Jqt3ZLh3mX8MPGCtF+H
	WLrjwvPbk1aUA8rSumHJVYuAaZA2+kCzAH+3LDVR7P13iY5+B6tJ1JzkHwHXncspiJIuPw
	e3F2k1Becmy8iGr7WKAzsgsO8ZOCd18q+M2uOmbNDDHe5g5c+JwJqdAnFDMw4w==
Message-ID: <7d196a91-220a-41a5-8577-198b436d8440@bootlin.com>
Date: Thu, 27 Feb 2025 14:06:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] Driver core: Add faux bus devices
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Lukas Wunner <lukas@wunner.de>,
 Mark Brown <broonie@kernel.org>, =?UTF-8?Q?Ma=C3=ADra_Canal?=
 <mairacanal@riseup.net>, Robin Murphy <robin.murphy@arm.com>,
 Simona Vetter <simona.vetter@ffwll.ch>, Zijun Hu <quic_zijuhu@quicinc.com>,
 linux-usb@vger.kernel.org, rust-for-linux@vger.kernel.org,
 =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
References: <2025021023-sandstorm-precise-9f5d@gregkh>
Content-Language: en-US
From: Louis Chauvet <louis.chauvet@bootlin.com>
Autocrypt: addr=louis.chauvet@bootlin.com; keydata=
 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
In-Reply-To: <2025021023-sandstorm-precise-9f5d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekjeehgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefnohhuihhsucevhhgruhhvvghtuceolhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudfggeegueffjeffteetteehjefhiedtkedvffettddthedthefhvddvlefgleevnecuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdhorhhgpdhkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrddtrddvtdgnpdhmrghilhhfrhhomheplhhouhhishdrtghhrghuvhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudelpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhihuhguvgesrhgvughhrghtrdgtohhmpdhrtghpt
 hhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvghkshgrnhguvghrrdhlohgsrghkihhnsehinhhtvghlrdgtohhmpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhm
X-GND-Sasl: louis.chauvet@bootlin.com



Le 10/02/2025 à 13:30, Greg Kroah-Hartman a écrit :
> For years/decades now, I've been complaining when I see people use
> platform devices for things that are obviously NOT platform devices.
> To finally fix this up, here is a "faux bus" that should be used instead
> of a platform device for these tiny and "fake" devices that people
> create all over the place.
> 
> The api is even simpler than the normal platform device api, just two
> functions, one to create a device and one to remove it.  When a device
> is created, if a probe/release callback is offered, they will be called
> at the proper time in the device's lifecycle.  When finished with the
> device, just destroy it and all should be good.
> 
> This simple api should also hopefully provide for a simple rust binding
> to it given the simple rules and lifecycle of the pointer passed back
> from the creation function (i.e. it is alive and valid for as long as
> you have not called destroy on it.)
> 
> I've also converted four different examples of platform device abuse, the
> dummy regulator driver, the USB phy code, the x86 microcode dvice, and
> the "regulator" device that wifi uses to load the firmware tables, to
> use this api.  In all cases, the logic either was identical, or became
> simpler, than before, a good sign (side note, a bug was fixed in the usb
> phy code that no one ever noticed before).
> 
> Note, unless there are major objections, I'm leaning toward getting
> patch 1 and 2 of this series merged during this -rc cycle so that all of
> the individual driver subsystem cleanups can go through those subsystems
> as needed, as well as allowing the rust developers to create a binding
> and get that merged easier.  Having patch 1 merged on its own isn't
> going to cause any changes if no one uses it, so that should be fine.

Hi all,

I have a maybe dumb question regarding the patches 3..9: do they break 
the UAPI?

With a platform device, the drivers appear under /sys/bus/platform, but 
with faux device, they appear under /sys/bus/faux.

I ask because I found out that one (see my reply to [2]) of the main drm 
library expects to find all the devices under pci, usb, platform, virtio 
and host1x buses [1], so at least for the vgem and vkms driver, this 
library will be broken (it will not crash, but previously detected 
devices will suddenly disappear).

I don't know what are the rules for /sys/bus, but changing a device from 
one bus to another seems to break userspace programs. How should we 
handle this situation? Should we fix the existing drivers? Or only new 
drivers should use it?

+CC: José Expósito

Thanks,
Louis Chauvet

[1]:https://gitlab.freedesktop.org/mesa/drm/-/blob/main/xf86drm.c#L4460-4515
[2]:https://lore.kernel.org/all/20250218165011.9123-21-jose.exposito89@gmail.com/

> Changes from v4:
>    - really dropped the internal name structure, remanants were left over
>      from the last patch series
>    - added the rust binding patch from Lyude (is this one of the first
>      patch series that adds a new kernel api AND the rust binding at the
>      same time?)
>    - added a parent pointer to the api so the devices can be in the tree
>      if the caller wants them
>    - made probe synchronous to prevent race when using the api (when the
>      create call returns the device is fully ready to go.)  Thanks to
>      testing of the drm driver change to find this issue.
>    - documentation tweaks
>    - #include <linux/container_of.h> finally added to faux.h
> 
> 
> Changes from v3:
>    - Dropped the USB phy porting, turned out to be incorrect, it really
>      did need a platform device
>    - converted more drivers to the faux_device api (tlclk, lis3lv02d,
>      vgem, and vkms)
>    - collected some reviewed-by
>    - lots of minor tweaks of the faux.c api, and documentation based on
>      review, see the changelog in patch 1 for details.
> 
> Changes from v2:
>    - lots of cleanups to faux.c based on reviews, see patch 1 for details
>    - actually tested the destroy device path, it worked first try!
>    - added 3 more example drivers
> 
> 
> 
> Greg Kroah-Hartman (8):
>    driver core: add a faux bus for use when a simple device/bus is needed
>    regulator: dummy: convert to use the faux device interface
>    x86/microcode: move away from using a fake platform device
>    wifi: cfg80211: move away from using a fake platform device
>    tlclk: convert to use faux_device
>    misc: lis3lv02d: convert to use faux_device
>    drm/vgem/vgem_drv convert to use faux_device
>    drm/vkms: convert to use faux_device
> 
> Lyude Paul (1):
>    rust/kernel: Add faux device bindings
> 
>   Documentation/driver-api/infrastructure.rst |   6 +
>   MAINTAINERS                                 |   2 +
>   arch/x86/kernel/cpu/microcode/core.c        |  14 +-
>   drivers/base/Makefile                       |   2 +-
>   drivers/base/base.h                         |   1 +
>   drivers/base/faux.c                         | 232 ++++++++++++++++++++
>   drivers/base/init.c                         |   1 +
>   drivers/char/tlclk.c                        |  32 +--
>   drivers/gpu/drm/vgem/vgem_drv.c             |  30 +--
>   drivers/gpu/drm/vkms/vkms_drv.c             |  28 +--
>   drivers/gpu/drm/vkms/vkms_drv.h             |   4 +-
>   drivers/misc/lis3lv02d/lis3lv02d.c          |  26 +--
>   drivers/misc/lis3lv02d/lis3lv02d.h          |   4 +-
>   drivers/regulator/dummy.c                   |  37 +---
>   include/linux/device/faux.h                 |  69 ++++++
>   net/wireless/reg.c                          |  28 +--
>   rust/bindings/bindings_helper.h             |   1 +
>   rust/kernel/faux.rs                         |  67 ++++++
>   rust/kernel/lib.rs                          |   1 +
>   samples/rust/Kconfig                        |  10 +
>   samples/rust/Makefile                       |   1 +
>   samples/rust/rust_driver_faux.rs            |  29 +++
>   22 files changed, 502 insertions(+), 123 deletions(-)
>   create mode 100644 drivers/base/faux.c
>   create mode 100644 include/linux/device/faux.h
>   create mode 100644 rust/kernel/faux.rs
>   create mode 100644 samples/rust/rust_driver_faux.rs
> 

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


