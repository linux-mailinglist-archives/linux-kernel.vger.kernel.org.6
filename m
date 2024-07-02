Return-Path: <linux-kernel+bounces-237385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 567B691F032
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10FF72819BD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 07:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603B713D248;
	Tue,  2 Jul 2024 07:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oL9g5Fnf"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373DB4779E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 07:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719905481; cv=none; b=j20jH5obxNOxLG3ExKYc9calgF56AfMuzrlfdhZnK+gdsaWUzSDCrqwThohTB01fY380EmwpNl1q9ACOLWA5bdLZyWdqBFtbe/NpjRwgaNiKRhd5m84YnXrCHfQpniEwHt9bdUuvqFesVG29mKPicPPwjlHEixexVk9J4zioScw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719905481; c=relaxed/simple;
	bh=houxP7rbMvESO3dK1/THNpSPjo2MqET0uHnd/QAzvos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqMfR0He1RGHpVSkYAJhp+0gRp4HtvzEa8d5chU1F0CEIvvWvmoR39MICMV7zasDmbU2hy3rLbOR1bpoWkANb9tuwjnueSQ0ixa5nFfZTwRAl8bwfDpEVlyt7e6aVGn8CityJ440V4UnwXzTpzETunu/xgvssRkhg/4HjaflvZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oL9g5Fnf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C/X+2l5D7uGaKTeDgwyoQehcEUfPRIbQrtjemVf7r8E=; b=oL9g5FnfsLKeZdDPRmMJA9ovo7
	RdDsQ22RgtbREg6HoFgCfrDjP/5RhfC5Y5tt/gNQGyaOXvsLngsAv2yItKpaaS0NFXBPxOe8/yWxC
	mPAmriZNCDvs/lKIThcpDDdrp8Gkp8hf54u2cBl99Sr/sLGoVHsNYzEBXtm+2v6bwajLeb9T2F6NN
	WcWsS3y8ISArqd7aks95XhROVP0MTI+7Id8n2wigCOY8i6ODLxa6j2sinSR5tj2w556fnlH7h+jsz
	qqhY5MbjJcvIDLax5V3TlP6udTQYleNVTKA1CF3BcbDeZoi/k5ZAcdB1uEV3EIig7gB5KMDccbwiX
	gEvuHuYQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57944)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sOXyU-0002wC-2U;
	Tue, 02 Jul 2024 08:30:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sOXyU-0001km-4p; Tue, 02 Jul 2024 08:30:50 +0100
Date: Tue, 2 Jul 2024 08:30:50 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: arnd@arndb.de, afd@ti.com, akpm@linux-foundation.org,
	linus.walleij@linaro.org, eric.devolder@oracle.com, ardb@kernel.org,
	gregkh@linuxfoundation.org, deller@gmx.de, javierm@redhat.com,
	bhe@redhat.com, robh@kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] ARM: 9322/1: Switch over to GENERIC_CPU_DEVICES
Message-ID: <ZoOsqrhlsENjHwKN@shell.armlinux.org.uk>
References: <20240702065906.929987-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702065906.929987-1-ruanjinjie@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

What's going on with the subject in all of this series? Why does it
contain:

	"ARM: 9322/1"

?

We already have:
	"3562257b3416 ARM: 9322/1: Explicitly include correct DT includes"

Merged in the kernel tree, and this has nothing to do with it. Moreover,
these numbers are generated by the patch system and are supposed to be
unique to each patch.

On Tue, Jul 02, 2024 at 02:59:04PM +0800, Jinjie Ruan wrote:
> Currently, almost all architectures have switched to GENERIC_CPU_DEVICES,
> except for arm32. Also switch over to GENERIC_CPU_DEVICES, which can also
> make the code more concise.
> 
> Jinjie Ruan (2):
>   ARM: 9322/1: Switch over to GENERIC_CPU_DEVICES using
>     arch_register_cpu()
>   ARM: 9322/1: Convert to arch_cpu_is_hotpluggable()
> 
>  arch/arm/Kconfig           |  1 +
>  arch/arm/include/asm/cpu.h |  1 -
>  arch/arm/kernel/setup.c    | 14 ++------------
>  3 files changed, 3 insertions(+), 13 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

