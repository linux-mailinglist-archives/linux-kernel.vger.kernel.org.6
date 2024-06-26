Return-Path: <linux-kernel+bounces-231531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6824A919995
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6797B21830
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CF919307E;
	Wed, 26 Jun 2024 21:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vB+GkfyY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5484E19149E;
	Wed, 26 Jun 2024 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719435806; cv=none; b=MwpnChXKRRR2JsFzxiM5OHBHmmKmPZVeTY5lX+1jHGy9c3ryWmlUZk5o4yCgpolT5MgxY0kn0zoi9cjcWg2E4psbREzaaiYqJ3j1YLC0iedCS1yi1hWTvDSwsERetzubLGG8zG9deb/W4zjM2ykqWTiGxahRxsecYkbbDN7Tszw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719435806; c=relaxed/simple;
	bh=Hr0cYQOnT8q2iekB4fnYppelItCZeQ6LII/9879q54Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlfUO7W0wTA5f+m8xseoMIzbjZXpwXy926X7jCS6eBecgC+OrMhujpUQBm/WflS5MN2tzQdm1wdDcYjk1fo+MCa0AqQWn3ln5ZVCgTbFRP2ejOQ8CGYywM6+H3wXW6vtyh0v2NJux0GU0ZhlW3P+GrFAzuj8zXv4owGcddMs6Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vB+GkfyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D2BC116B1;
	Wed, 26 Jun 2024 21:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719435806;
	bh=Hr0cYQOnT8q2iekB4fnYppelItCZeQ6LII/9879q54Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vB+GkfyY3eApzMyqyZEJNDNlzPWrONWNassqdBx+DWbKo1UHZoD4GFnwpw8EyoPxc
	 XqfjAwmftHUyMU18kjlUqWuDxEhMnS2dWLsiNMRAvRgUjzEFeHf8XnjGkJpekTPBtm
	 qFAKlldeDx3n7O+8SJ3sY6deSoNTxdywzsNjO1PSWNKOKizDzDGU8D/5mTZGewY6FE
	 yMqF3WQ4hSXGNaKQ3e9DCZLxcr6MrSbp/a9lu9RVPRwEm8xC2qs5jxeecblXJYck2a
	 oshFdjZAUkjUcTjX8Y8sTydJNpH04VjbKGPjcML7M7o3yCBoeNr2Nf9e8FulvOK+OC
	 uF06wZFIoFG8Q==
Date: Wed, 26 Jun 2024 14:03:24 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Sami Tolvanen <samitolvanen@google.com>
Subject: Re: arch/arm/mm/proc.c:82:6: error: conflicting types for
 'cpu_arm920_reset'
Message-ID: <20240626210324.GA109435@fedora-macbook-air-m2>
References: <202406260432.6WGV2jCk-lkp@intel.com>
 <20240626172154.GA50752@fedora-macbook-air-m2>
 <CACRpkdaXd1sosdWzWOpbtin1h2NFS88Dc3ZfXhyix+t1uC1L8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdaXd1sosdWzWOpbtin1h2NFS88Dc3ZfXhyix+t1uC1L8A@mail.gmail.com>

On Wed, Jun 26, 2024 at 10:59:11PM +0200, Linus Walleij wrote:
> On Wed, Jun 26, 2024 at 7:21 PM Nathan Chancellor <nathan@kernel.org> wrote:
> 
> > Hmmm, it seems like the prototypes of the reset functions in
> > arch/arm/mm/proc.c are incorrect? This builds for me with the original
> > configuration and allmodconfig + CONFIG_CFI_CLANG=y.
> 
> Incidentally I fixed it earlier today!
> https://lore.kernel.org/linux-arm-kernel/20240626-arm-proto-regression-v1-1-089c23ea13dd@linaro.org/

Aha, I did not go searching like I normally do to see if a patch was
already sent for it, guess that would have saved me a little time :)

> I added you on Reported-by for now.
> 
> > +void cpu_arm7tdmi_reset(unsigned long addr, bool hvc) __attribute__((noreturn));
> 
> The attribute is not needed on the prototype AFAICT?

I think that in general, noreturn needs to be on prototypes, but for
this prototype/the sake of CFI, I don't think it matters. Sami is free
to correct me though.

Cheers,
Nathan

