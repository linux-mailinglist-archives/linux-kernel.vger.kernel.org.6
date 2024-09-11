Return-Path: <linux-kernel+bounces-325096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D499754F4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B30A1C22EB1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E4219343B;
	Wed, 11 Sep 2024 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iGjp5JS5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894C1224F6
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726063582; cv=none; b=GTvJqqf8lEPd0Os8k1PRseAcKW3q3myZEa/FLHFL+lCh+/aEGtK3zuZIKs9Ppz5pTuHpr+ChrpK3Fy8l+x+dCWVJLDlb9metXfVkl6TGQVErYF5Ex9GPtRLBOVRa11XveYqZZJjEgQHSj8kMIZKiHg0QX8pjczc2bbka1Kr6+CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726063582; c=relaxed/simple;
	bh=EpoCUnv6j1hFtvDESsdaD++ReKUouR9Rg5dBkvMR4MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G59z15dlGKz8IpzfRxVlx4r5/Im6DbcoM6y2uK+E2q0z3p+rw3OuLYx7F1ONxWUwtFcYz7UiBAz5HncJxMQgA/u9XT/Hu5/W0sFRriFiteZ++YhL7WMYMgdzEtH6LSaeYMDoPYpWlel34lIJJksVtq6qsxOzF1bT3trxGhBQG3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iGjp5JS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F0CC4CEC0;
	Wed, 11 Sep 2024 14:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726063582;
	bh=EpoCUnv6j1hFtvDESsdaD++ReKUouR9Rg5dBkvMR4MU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iGjp5JS5DLmaVibB86CVIuOiGjqtFtbC81BEUduFu2DbQjstj0a7BrnoNDnEni0zx
	 afv6ReYhxXUVVvE2xRTCRm8POUqPsKSHzC07DY5e3zKAbwRb1nPTY+7Xm+Unhmhf+5
	 LQszooKIenh7IsGSxpZbRgqQYHH78DCSWpY1LWQ8=
Date: Wed, 11 Sep 2024 16:06:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc: srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 4/9] nvmem: layouts: add U-Boot env layout
Message-ID: <2024091110-broiler-sensually-602d@gregkh>
References: <20240902142952.71639-1-srinivas.kandagatla@linaro.org>
 <20240902142952.71639-5-srinivas.kandagatla@linaro.org>
 <2024090308-smasher-craftwork-0db5@gregkh>
 <ef6d4f332224bd7a8c1c4244047bf0ea@milecki.pl>
 <2024090303-provider-humbly-17e2@gregkh>
 <f4268b9f5ffc320320ef9a97902d3521@milecki.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4268b9f5ffc320320ef9a97902d3521@milecki.pl>

On Tue, Sep 10, 2024 at 03:24:33PM +0200, Rafał Miłecki wrote:
> On 2024-09-03 13:24, Greg KH wrote:
> > On Tue, Sep 03, 2024 at 01:04:20PM +0200, Rafał Miłecki wrote:
> > > Hi Greg,
> > > 
> > > On 2024-09-03 12:12, Greg KH wrote:
> > > > On Mon, Sep 02, 2024 at 03:29:47PM +0100, srinivas.kandagatla@linaro.org
> > > > wrote:
> > > > > From: Rafał Miłecki <rafal@milecki.pl>
> > > > >
> > > > > U-Boot environment variables are stored in a specific format. Actual
> > > > > data can be placed in various storage sources (MTD, UBI volume,
> > > > > EEPROM,
> > > > > NVRAM, etc.).
> > > > >
> > > > > Move all generic (NVMEM device independent) code from NVMEM device
> > > > > driver to an NVMEM layout driver. Then add a simple NVMEM layout
> > > > > code on
> > > > > top of it.
> > > > >
> > > > > This allows using NVMEM layout for parsing U-Boot env data stored in
> > > > > any
> > > > > kind of NVMEM device.
> > > > >
> > > > > The old NVMEM glue driver stays in place for handling bindings in the
> > > > > MTD context. To avoid code duplication it uses exported layout parsing
> > > > > function. Please note that handling MTD & NVMEM layout bindings may be
> > > > > refactored in the future.
> > > > >
> > > > > Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> > > > > Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > > > ---
> > > > >  MAINTAINERS                        |   1 +
> > > > >  drivers/nvmem/Kconfig              |   3 +-
> > > > >  drivers/nvmem/layouts/Kconfig      |  11 ++
> > > > >  drivers/nvmem/layouts/Makefile     |   1 +
> > > > >  drivers/nvmem/layouts/u-boot-env.c | 211
> > > > > +++++++++++++++++++++++++++++
> > > > >  drivers/nvmem/layouts/u-boot-env.h |  15 ++
> > > > >  drivers/nvmem/u-boot-env.c         | 165 +---------------------
> > > > >  7 files changed, 242 insertions(+), 165 deletions(-)
> > > > >  create mode 100644 drivers/nvmem/layouts/u-boot-env.c
> > > > >  create mode 100644 drivers/nvmem/layouts/u-boot-env.h
> > > >
> > > > This patch doesn't apply to my tree :(
> > > >
> > > > Also, if you generate patches with 'git format-patch -M' you can see
> > > > when files move easier (if that's what happened here, hard to tell..)
> > > 
> > > It's because it was developed on top of "nvmem: u-boot-env: error if
> > > NVMEM
> > > device is too small" which you applied to the "char-misc-linus"
> > > branch.
> > > Perhaps you could push that fix ("error if...") to your both branches
> > > somehow?
> > 
> > I can pull the char-misc-linus branch into my -next branch if that would
> > help out here?  Give me a few days to let 0-day run on things to make
> > sure they are all sane first.
> 
> FWIW I can confirm that
> [PATCH 4/9] nvmem: layouts: add U-Boot env layout
> [PATCH 5/9] MAINTAINERS: Update path for U-Boot environment variables YAML
> apply cleanly on top of the "char-misc-next".

Ok, that worked, both now applied, thanks.

greg k-h

