Return-Path: <linux-kernel+bounces-312799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6666A969B98
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC4E1F24B2B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8413C1A0BE3;
	Tue,  3 Sep 2024 11:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l39o7N67"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D291B12C8
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 11:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725362690; cv=none; b=oY4Gzlmd9nHMqq9ZDkTjNeJgTH7i/slqHhyUf/X9453CJdrlyqf3uuAm8gVtf/wXE08phWz6jzya+vLsz+dOpQE0Jyl7Cq1MSEMsKLA3d0sX7Huc+0HLUO41Whveu3JNrajPzTdQopsy4u+hX2g1ZbY2pLKnhp8WLdcll6TrXCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725362690; c=relaxed/simple;
	bh=i7gdooYruiwx6sAryziX46sz0Zt/RIUQmT8Pn0OIlrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tq2gBQWEqDFBVJlcJfR9zTzybP5Y+X/ng/tr2d02dRpKrtvJDmkTgj5Ro/7ex4MPm/x/Dyjlrs0vUoXb8XC2Rarglv6INZ0mph8zrN5jhkeOcUNIj39nwCSkiK6PW2LKJVuqf7QbcOXIiqKQGEKpxp7TI5eLAoMgqDlMJom28H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l39o7N67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FB2C4CEC5;
	Tue,  3 Sep 2024 11:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725362690;
	bh=i7gdooYruiwx6sAryziX46sz0Zt/RIUQmT8Pn0OIlrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l39o7N673wC3/fTevZtInIt+g2RBLyuQUNpIxI+eo7q4mziOC2hpEWn4n279V6i08
	 KKohO9hRES34TMpVCRuOQ+Ecn2GJOsSZm2ZIZ5SJMzGenVAALRUsYEfPseDNSNrU3p
	 bz3rsbh2X7gXw5B8q9ok1b2bL63+arYtp1dbOc5M=
Date: Tue, 3 Sep 2024 13:24:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc: srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 4/9] nvmem: layouts: add U-Boot env layout
Message-ID: <2024090303-provider-humbly-17e2@gregkh>
References: <20240902142952.71639-1-srinivas.kandagatla@linaro.org>
 <20240902142952.71639-5-srinivas.kandagatla@linaro.org>
 <2024090308-smasher-craftwork-0db5@gregkh>
 <ef6d4f332224bd7a8c1c4244047bf0ea@milecki.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef6d4f332224bd7a8c1c4244047bf0ea@milecki.pl>

On Tue, Sep 03, 2024 at 01:04:20PM +0200, Rafał Miłecki wrote:
> Hi Greg,
> 
> On 2024-09-03 12:12, Greg KH wrote:
> > On Mon, Sep 02, 2024 at 03:29:47PM +0100, srinivas.kandagatla@linaro.org
> > wrote:
> > > From: Rafał Miłecki <rafal@milecki.pl>
> > > 
> > > U-Boot environment variables are stored in a specific format. Actual
> > > data can be placed in various storage sources (MTD, UBI volume,
> > > EEPROM,
> > > NVRAM, etc.).
> > > 
> > > Move all generic (NVMEM device independent) code from NVMEM device
> > > driver to an NVMEM layout driver. Then add a simple NVMEM layout
> > > code on
> > > top of it.
> > > 
> > > This allows using NVMEM layout for parsing U-Boot env data stored in
> > > any
> > > kind of NVMEM device.
> > > 
> > > The old NVMEM glue driver stays in place for handling bindings in the
> > > MTD context. To avoid code duplication it uses exported layout parsing
> > > function. Please note that handling MTD & NVMEM layout bindings may be
> > > refactored in the future.
> > > 
> > > Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> > > Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > ---
> > >  MAINTAINERS                        |   1 +
> > >  drivers/nvmem/Kconfig              |   3 +-
> > >  drivers/nvmem/layouts/Kconfig      |  11 ++
> > >  drivers/nvmem/layouts/Makefile     |   1 +
> > >  drivers/nvmem/layouts/u-boot-env.c | 211
> > > +++++++++++++++++++++++++++++
> > >  drivers/nvmem/layouts/u-boot-env.h |  15 ++
> > >  drivers/nvmem/u-boot-env.c         | 165 +---------------------
> > >  7 files changed, 242 insertions(+), 165 deletions(-)
> > >  create mode 100644 drivers/nvmem/layouts/u-boot-env.c
> > >  create mode 100644 drivers/nvmem/layouts/u-boot-env.h
> > 
> > This patch doesn't apply to my tree :(
> > 
> > Also, if you generate patches with 'git format-patch -M' you can see
> > when files move easier (if that's what happened here, hard to tell..)
> 
> It's because it was developed on top of "nvmem: u-boot-env: error if NVMEM
> device is too small" which you applied to the "char-misc-linus" branch.
> Perhaps you could push that fix ("error if...") to your both branches
> somehow?

I can pull the char-misc-linus branch into my -next branch if that would
help out here?  Give me a few days to let 0-day run on things to make
sure they are all sane first.

thanks,

greg k-h

