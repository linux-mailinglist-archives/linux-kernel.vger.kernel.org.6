Return-Path: <linux-kernel+bounces-271625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B5E9450E2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF3DE2824C3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65EF1BD502;
	Thu,  1 Aug 2024 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cddZt4X2"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3051BB686
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722530181; cv=none; b=kIzBCADjMXiJp11vQMUmxKXFmsnvuhh3ZB5hWGN0qh8GljWMgPubo5Zscev9WECL6unrc4wtGmVAbTLDpmn/mGjNyCNFR5klYiK8HYexXq59y4Fnjsr7y3MOaftm+mdihGwpOhzizDv0l67XRN+1GGmKp6WBXCqijzYhJSMPO3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722530181; c=relaxed/simple;
	bh=6MYtvNwqzr89kuMijj7dj05YG0cddZdYGXuIn2AaA/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnqeF0fSD9Iao4Jyea3GrihQb0vH6O5ou+dGl/SuSYhJZ3qYaEM9/lOzZPrSq3DDoTKa6hNXSg7rPAU5vjBAfyim8Rzte+bRPVYmeIBCw+xjh0vTicrmNvHMojxhn+JMQ81SMC19gO8lQTHgmseJCSO+RL6URNvlwcJony2QijY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=cddZt4X2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SaIPytHxWcAaYza32KmNAPXihLWLj5CDb3e50E+sMRQ=; b=cddZt4X2EOKhHMr2SS7Oecnifx
	oGjj4+9YuXZMQi4YdWfEX0j4UPccH3G9E5JzTCDEBoMRBFwNoSsQ302iKdPkZJRknC9vcMxcyXkG4
	QYfxVOJZbFZfqbAm5/lxLGoawvXH8rJbDYQ8W0WXd91IMuof5olo9xZwkLdlK+WNEpdfmpT8GaRDM
	n9wMctRP9JawI+VOOb5vqOLhdnyBEe1BR4FMYQbFU0ZfRSy32Zlwb6sGVIzKX3o8/XhfqyxMaIFgD
	a1PU3J7EB1zt8RVNoF6QSILWEGqkg9gGwNXEx5dwoNFQi6Vfcprmm4gqPLJKcAplRdxGLGhnDbOys
	Sm1GZFMQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36698)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sZYmV-0003Wu-3C;
	Thu, 01 Aug 2024 17:36:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sZYmY-0007EW-5x; Thu, 01 Aug 2024 17:36:02 +0100
Date: Thu, 1 Aug 2024 17:36:02 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: dianders@chromium.org, mhocko@suse.com, akpm@linux-foundation.org,
	maz@kernel.org, vschneid@redhat.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: smp: Fix missing backtrace IPI statics
Message-ID: <Zqu5ck+Ik8KlzE0O@shell.armlinux.org.uk>
References: <20240801094022.1402616-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801094022.1402616-1-ruanjinjie@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Aug 01, 2024 at 05:40:22PM +0800, Jinjie Ruan wrote:
> It is similar to ARM64 commit 916b93f4e865 ("arm64: smp: Fix missing IPI
> statistics"), commit 56afcd3dbd19 ("ARM: Allow IPIs to be handled as normal
> interrupts") set CPU_BACKTRACE IPI "IRQ_HIDDEN" flag but not show it in
> show_ipi_list(), which cause the interrupt kstat_irqs accounting
> is missing in display.

I don't see why this needs to be included. If this IPI fires, it means
that the kernel has suffered a lockup and is probably not very useful.
So the chances of being able to read out from /proc/interrupts a non-
zero "CPU backtrace interrupts" figure is highly unlikely.

So, I don't see much point to this change.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

