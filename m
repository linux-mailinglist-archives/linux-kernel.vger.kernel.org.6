Return-Path: <linux-kernel+bounces-200229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 592798FAD40
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7B51C21C5C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AEC142648;
	Tue,  4 Jun 2024 08:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Jb0kIbDW"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C533C1420B0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717488902; cv=none; b=d8qtfn9VltqVQgyMOxM8p7B5/2lONRvskwW/jm1dSqwyJK2lDnHRb0coUyEyvaK4xm3u5Q69LXRzFCrOPJg3NDcOvld78xtcVhkJLBN3ni+VDsNUuK7bKQW2cbyrDZGEeQcINmHXfPTSHvHqMwdgvAi5mq39WgCbw3sm2BUZjug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717488902; c=relaxed/simple;
	bh=ELX7vFUiYE58hm1BlTFFznXSHKxuJsMEd4l4bZBWZYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q462XVxXefx5+oQ+wiYWsOrBeR1vcpjv+csE8ATXKNYEczH/BsLYbZUQ3U76cIwFNLMyMqulDRgoixeR5XCEQH7hanAocuOm/9kWsfklTwo5aAEmIzEBKy3N5nO051YQ2xiuYD2nkFyumGMTTcM0rd0Ix2erdy9zwKWLlJOluDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Jb0kIbDW; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RGEvpyljn8l4dpaAhowiJvPUFQxRVV5PVPBwQb0hnnM=; b=Jb0kIbDWrvmuCMfYEcPhvTC9Zk
	6MkLi5HIEBm/7Hq++gEOC8dTEtve2EA+bxK24a2QwS3pZZ4oQn3GtoLI3m+8xbDQxva9n94IVR5dW
	OlooT6r6dKvDDosJdSpujecs/IJhkQRktSUTLJtalnyuwT+3+g3F4JAEJ6Gv6VbnEXZ2HW7QpFo/4
	DQCO1KjCNYb0wTBVxYP84uPcrlQcpjMnoIDCLKSGPWKJnaTKLlY0eLL/LdDnDLDxeHZbH3g1CVo/m
	+9HjmQ6VbTB4+/LQY97qmE0/FPZLFgNMtueINbCXuExpvroarSZlf5aFeNUSrEyD2WnV9TZW2bXVF
	BV36sVOw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38158)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sEPJM-0003bA-23;
	Tue, 04 Jun 2024 09:14:28 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sEPJK-0001G6-Gf; Tue, 04 Jun 2024 09:14:26 +0100
Date: Tue, 4 Jun 2024 09:14:26 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: oleg@redhat.com, arnd@arndb.de, afd@ti.com, akpm@linux-foundation.org,
	linus.walleij@linaro.org, eric.devolder@oracle.com, robh@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: Add HAVE_FUNCTION_ARG_ACCESS_API support
Message-ID: <Zl7M4rjQbN2c9Bje@shell.armlinux.org.uk>
References: <20240603073751.2282024-1-ruanjinjie@huawei.com>
 <Zl2BNCXzKRG+eTDv@shell.armlinux.org.uk>
 <3089651e-d8eb-f193-5eac-db925000dce9@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3089651e-d8eb-f193-5eac-db925000dce9@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jun 04, 2024 at 09:36:04AM +0800, Jinjie Ruan wrote:
> On 2024/6/3 16:39, Russell King (Oracle) wrote:
> > On Mon, Jun 03, 2024 at 03:37:51PM +0800, Jinjie Ruan wrote:
> >> Currently, kprobe on ARM32 can not use the '$argx' syntax available on
> >> other architecture. So implement regs_get_kernel_argument() and add
> >> HAVE_FUNCTION_ARG_ACCESS_API support.
> > 
> > This may work in the simple case, but it just doesn't work in the
> > general case, where a function accepts 64-bit arguments. For example,
> > for EABI and a function taking a 64-bit argument followed by a 32-bit
> > argument:
> > 
> > 	R0/R1 = 64-bit argument
> > 	R2 = 32-bit argument
> > 
> > Now consider 32-bit argument followed by 64-bit argument:
> > 
> > 	R0 = 32-bit argument
> > 	R1 = unused
> > 	R2/R3 = 64-bit argument
> 
> I agree with you, the current implementation considers a very simple
> case, where all parameters are 32-bit.
> 
> From "Procedure Call Standard for the Arm® Architecture", the
> "6.1.1.1 Handling values larger than 32 bits" describes it this way:
> 
> A double-word sized type is passed in two consecutive registers (e.g.,
> r0 and r1, or r2 and r3).
> 
> > 
> > Note that the mapping isn't argN = RN.
> > 
> > Also, given that "unsigned long" is 32-bit on 32-bit Arm, one can't
> > return a 64-bit argument through this interface. Even if one typed
> > the function as u64, it still wouldn't work because the caller
> > assigns the return value to an unsigned long. This seems to be an
> > issue throughout the kernel tracing - it isn't written to support
> 
> How about updating this interface to solve this problem? Let
> regs_get_kernel_argument() return u64.

That doesn't solve the first problem. The issue is that once we enable
this, it becomes userspace ABI, and any changes to it then become
regressions.

So no, I'm not going to have it enabled in mainline in a half-broken
state.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

