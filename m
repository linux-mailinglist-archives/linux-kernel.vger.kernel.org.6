Return-Path: <linux-kernel+bounces-233925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B9B91BF58
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E641C21234
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111231BE25E;
	Fri, 28 Jun 2024 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="c4/iv5pU"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98621E4A4
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719580448; cv=none; b=f23/69/gYcoMdClpdfl5spJw9Y45kDSjjTELWe+4Y9IPcDKj7GY2diak8Tr72NUPFdmU/vd1DEal8nIQeJrwgFA9xLKZ6V1KnFlNc8mmFQ6DRIqed8iIvfAqgBhMchkm6jtVI6dp39AfZkYMbW5XN6paL+eXkiaC8UfX+0MfHeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719580448; c=relaxed/simple;
	bh=2yFSaGJ+Km3DFI7SCS/L/pCkOGf0qpsVjCaa2sffUn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ylt2rBb/V5Ohr4mC/mNKydFbRQP1clmzso4n9vKYOZ5I/iX7E7LXfW0hZeuzXcsFvJpRV+ZTmL6Kmkwk54EOKZUF+AIRioR0eCCOQcLU294ykn/DX0VCdC20JGkrPP+tIKuqrQ3vVDu18jg7X/ddKeAwlMBbFoIQgqDQkHuVAdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=c4/iv5pU; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4Nl3gS0QUrXTFXdXBLAhP3tCDZO9ar9+UJa2VZXcBSI=; b=c4/iv5pUGXan/JbeSdK5Y7o7mQ
	P5KX1VVikBMmy9jpRTAEuXtzJ3D4BS3+T4gfijGkBovWr4h31M6sD/Srs+jAG5LxbN0OWatNd9u1p
	I1AAVX/iWzTT+jPFGZHatqrfsTJ5NPcbXHWggQmibg8YgXLJ5zpFGH9IVwmTxRlGtQdr1pmOAVyNn
	AcDxDv1J4Js6tpHM32aPuVpNEBSHXk7XaZvaRKW/d3tt43o5ge8hvRCsOInazv80oHDO6eg+RZVFx
	aAs4dhCCZAgAZZevZoqOE2347XgFCvaic1lmW1t8kAfY4zW8bawJOTlxxy8k5k3yD8o5Pk/5hMxSy
	6dI1neBg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54088)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sNBQC-0006Yw-1N;
	Fri, 28 Jun 2024 14:13:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sNBQE-0006XI-3Y; Fri, 28 Jun 2024 14:13:50 +0100
Date: Fri, 28 Jun 2024 14:13:49 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: richard clark <richard.xnu.clark@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, will@kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Will smp_call_function_single(cpu, ...) broadcast IPI to all
 other cpus?
Message-ID: <Zn63DQhf9nMLooVw@shell.armlinux.org.uk>
References: <CAJNi4rMfRmWoYdsyH6ibNKN8DSCL_DO8Wa08mWbe8t7vH21Dpw@mail.gmail.com>
 <86pls2isal.wl-maz@kernel.org>
 <20240627101207.0bbbead0@rorschach.local.home>
 <CAJNi4rMeDgDJbN0jjPguU_v5uoscJJN=5bZaShXpu7Q8X60hcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJNi4rMeDgDJbN0jjPguU_v5uoscJJN=5bZaShXpu7Q8X60hcg@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jun 28, 2024 at 06:21:25PM +0800, richard clark wrote:
> The output is:
> 
>           insmod-1746    [000] dn.h1..   928.400039: ipi_raise:
> target_mask=00000000,000000ffe (Function call interrupts)
>           insmod-1746    [000] dn.h2..   928.400042: <stack trace>
>  => trace_event_raw_event_ipi_raise
>  => smp_cross_call
>  => arch_send_call_function_single_ipi
>  => send_call_function_single_ipi

I'm not sure whether the above is misproperly pasted or not, but if it
is correct, it shows a problem.

We can see from the first line that the target mask covers CPUs 1..11.
However, the call chain is for arch_send_call_function_single_ipi(),
which does:

	smp_cross_call(cpumask_of(cpu), IPI_CALL_FUNC);

and cpumask_of(cpu) should only ever contain a single bit, and not
multiple bits which the output above suggests it does!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

