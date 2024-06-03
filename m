Return-Path: <linux-kernel+bounces-198799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D728D7D8D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0511B1F23622
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C7264CCC;
	Mon,  3 Jun 2024 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aq000GDw"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0636726AD0
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717403981; cv=none; b=kSQHXho/23X4KV43Q5tMak+Ctfj8cvQjIUSI9roO/bmzvQKyLM/sn5BsFmFOCd7j1IbNSf5Tml4nZrcYG0RAPPWDudXFGWqGxUR8NJMQAfqNs6MKPxTevMB3fCtw0Ji35A/2AnMFBPD6rGu17I3GYohh+KyiG7oQRvrnq8j9e+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717403981; c=relaxed/simple;
	bh=ioNQPeE6dcN4g7b9w4om4bfdVlgNm5KQPxatUE+0XD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnT14RTN0jh6+G7HNXZ8OZrrvR1jzap4rTn53kqU74tnbiOCrzDc1gv+IfEoZzQaCSnUtGvn31Aj6JnxouOZwNb+u/ajrwA1lv8o6oZfe8e4Kji0NlPJNfve1Bgz9Amw0TRzstssY57i3rt/PhxJvMyyt28OoYuItgwtxJIDv5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=aq000GDw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0HlUQLpV6dwNNdThUICIrY2+VfVWUdO6SeprKbBBR0Q=; b=aq000GDw6Pb4G6BYu2/HxZdiA4
	s7Z5E/poXNwiGzEyRk+uoiEgrqBGdwLgF4AgGnJiOotWJSACT/lW2ZkcdNBiTE9IXgyylwTEMxZHj
	NDrIG4IjxEaFEuqRKOLUqWJYgfS7fIuhAJCjFPk6kWI7tx0xMkFUT7Ajmxd45o4ZOYwFcT6fY6n2s
	W7LxLP5P8Znsq7JQ6YPM2E+ilM7aLDq5Xwf9IefKUzecdLIlRReDgeZqsUbIhO8GJRelaFiVRngpR
	aUFGPXg1gl/Vr1MXZOBr700rVfFjPa3829eZTplBL6jK5gklxjt043+DQQq75zdqjlbhAbSVUz/zV
	kD/74iLQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37758)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sE3Dp-0002S0-0l;
	Mon, 03 Jun 2024 09:39:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sE3Do-0000IG-DI; Mon, 03 Jun 2024 09:39:16 +0100
Date: Mon, 3 Jun 2024 09:39:16 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: oleg@redhat.com, arnd@arndb.de, afd@ti.com, akpm@linux-foundation.org,
	linus.walleij@linaro.org, eric.devolder@oracle.com, robh@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: Add HAVE_FUNCTION_ARG_ACCESS_API support
Message-ID: <Zl2BNCXzKRG+eTDv@shell.armlinux.org.uk>
References: <20240603073751.2282024-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603073751.2282024-1-ruanjinjie@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jun 03, 2024 at 03:37:51PM +0800, Jinjie Ruan wrote:
> Currently, kprobe on ARM32 can not use the '$argx' syntax available on
> other architecture. So implement regs_get_kernel_argument() and add
> HAVE_FUNCTION_ARG_ACCESS_API support.

This may work in the simple case, but it just doesn't work in the
general case, where a function accepts 64-bit arguments. For example,
for EABI and a function taking a 64-bit argument followed by a 32-bit
argument:

	R0/R1 = 64-bit argument
	R2 = 32-bit argument

Now consider 32-bit argument followed by 64-bit argument:

	R0 = 32-bit argument
	R1 = unused
	R2/R3 = 64-bit argument

Note that the mapping isn't argN = RN.

Also, given that "unsigned long" is 32-bit on 32-bit Arm, one can't
return a 64-bit argument through this interface. Even if one typed
the function as u64, it still wouldn't work because the caller
assigns the return value to an unsigned long. This seems to be an
issue throughout the kernel tracing - it isn't written to support
64-bit arguments on 32-bit architectures. See, for example,
fetch_store_raw(), where the unsigned long gets cast to a u64.
It'll still only have 32-bits of significant value.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

