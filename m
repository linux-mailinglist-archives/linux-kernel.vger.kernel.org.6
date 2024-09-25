Return-Path: <linux-kernel+bounces-338232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9F8985520
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BFDAB22F4F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89288158D87;
	Wed, 25 Sep 2024 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HE9835vO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69421591FC;
	Wed, 25 Sep 2024 08:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251682; cv=none; b=sNwEGQvr9ZvsPV1sZVfVVdQ7aD0wO+8yW1PeMoumc954Xeqyw+mnZc48bZChuwmLPy2jxeOZfRGSiOlCb7v7Wxrj+p4NS24sV8cSZET8o24SUfSwuQsWuJFlF9QMsi22hdqA/zc5n/zDO+QoArcjKJFK8FXcC2uNXxlVP6qD0xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251682; c=relaxed/simple;
	bh=lTFOVzuAlya0UbOyBgHH6STpD6xx219ysmuap5hgg10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BH6dZJQC5PslzwDBdQM4vhHcHTTf8aRxOawwFkWbejQhjPencMWpqj65JQhIXazvYO4tiFPtacvfRa6aNEklxOeeS6ILkW5SA4V+hctbgzTvuUbqrtBpHRKBw/eYPydhb3/w4FXiEg4fnVcKgD0NpUTLMTIE5xyXg6Vp/MKSH54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HE9835vO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63529C4CEC3;
	Wed, 25 Sep 2024 08:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727251681;
	bh=lTFOVzuAlya0UbOyBgHH6STpD6xx219ysmuap5hgg10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HE9835vOVFjuYgmNZaecgjKRTThlBL1JXzrDbLYqhVKaP5exW3JMNlq6ZGYUIbs98
	 A7xvKUj7DqT7euUp/pAsPtRhMSqYiZm5ZMUxMDA45/eVa9BkFHMffcRTPQE1CYjDqf
	 tNi+ktGqGmZtqYBoryPZcZXf1DbQGV5K+6kQR16s=
Date: Wed, 25 Sep 2024 10:07:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Michal Simek <michal.simek@amd.com>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, mka@chromium.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	wentong.wu@intel.com, oneukum@suse.com,
	javier.carrasco@wolfvision.net, matthias@kaehlcke.net,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, git@amd.com
Subject: Re: [PATCH] usb: misc: onboard_usb_dev: introduce new config symbol
 for usb5744 SMBus support
Message-ID: <2024092553-conclude-rebuild-5541@gregkh>
References: <1727187551-3772897-1-git-send-email-radhey.shyam.pandey@amd.com>
 <2024092551-fiddle-flatterer-e643@gregkh>
 <4da1353f-1209-43ba-930e-7b4f4a0cb2eb@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4da1353f-1209-43ba-930e-7b4f4a0cb2eb@amd.com>

On Wed, Sep 25, 2024 at 08:59:00AM +0200, Michal Simek wrote:
> 
> 
> On 9/25/24 08:33, Greg KH wrote:
> > On Tue, Sep 24, 2024 at 07:49:11PM +0530, Radhey Shyam Pandey wrote:
> > > Introduce new kernel config symbol for Microchip usb5744 SMBus programming
> > > support. Since usb5744 i2c initialization routine uses i2c SMBus APIs these
> > > APIs should only be invoked when kernel has I2C support. This new kernel
> > > config describes the dependency on I2C kernel support and fix the below
> > > build issues when USB_ONBOARD_DEV=y and CONFIG_I2C=m.
> > > 
> > > riscv64-linux-ld: drivers/usb/misc/onboard_usb_dev.o:
> > > undefined reference to `i2c_find_device_by_fwnode'
> > > drivers/usb/misc/onboard_usb_dev.c:408:(.text+0xb24): undefined
> > > reference to `i2c_smbus_write_block_data'
> > > <snip>
> > > 
> > > Parsing of the i2c-bus bus handle is not put under usb5744 kernel config
> > > check as the intention is to report an error when DT is configured for
> > > usb5744 SMBus support and kernel has USB_ONBOARD_DEV_USB5744 disabled.
> > > 
> > > Fixes: 6782311d04df ("usb: misc: onboard_usb_dev: add Microchip usb5744 SMBus programming support")
> > > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> > > Suggested-by: Matthias Kaehlcke <matthias@kaehlcke.net>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202409140539.3Axwv38m-lkp@intel.com/
> > > ---
> > >   drivers/usb/misc/Kconfig           | 11 +++++++++++
> > >   drivers/usb/misc/onboard_usb_dev.c |  6 ++++--
> > >   2 files changed, 15 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> > > index 50b86d531701..29976a93f122 100644
> > > --- a/drivers/usb/misc/Kconfig
> > > +++ b/drivers/usb/misc/Kconfig
> > > @@ -331,3 +331,14 @@ config USB_ONBOARD_DEV
> > >   	  this config will enable the driver and it will automatically
> > >   	  match the state of the USB subsystem. If this driver is a
> > >   	  module it will be called onboard_usb_dev.
> > > +
> > > +config USB_ONBOARD_DEV_USB5744
> > > +	bool "Onboard USB Microchip usb5744 hub with SMBus support"
> > > +	depends on (USB_ONBOARD_DEV && I2C=y) || (USB_ONBOARD_DEV=m && I2C=m)
> > > +	default y
> > 
> > "default y" is if you can not boot without this option enabled for all
> > Linux systems.  I doubt that is the case here :(
> 
> Intention is to have it enabled when USB_ONBOARD_DEV is enabled with all
> other conditions. In our case where our HW guys started to use this usb hub
> with usb-sd convertor where rootfs is on it. Without usb hub initialization
> via i2c we are not able to boot our system.

That's fine, so say so in the Kconfig text and your depends line should
be fine for that to be correct.  But don't do "default y" as it is not
normal for drivers.

thanks,

greg k-h

