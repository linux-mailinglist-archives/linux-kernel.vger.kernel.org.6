Return-Path: <linux-kernel+bounces-431509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E2D9E3EB6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAD6BB2A2E3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D29020ADD0;
	Wed,  4 Dec 2024 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VhmVb4Z+"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B361B4124
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733326260; cv=none; b=IAtcIBTXhLZCM20J6yzGTIFNSGVcW2250VycXjRkwzSuIBmqG5qMAY+JnGyDfAcgS/Pbk18Ok3eA60bRas/+v0jQpb+YWy74oldjOKDFvg18MR9NpheRimZIV9R/I3qx8KrkYLHQD+JuH5RTttkI3dK4X1Onvkd/cGU5ZVr8ZTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733326260; c=relaxed/simple;
	bh=wVnK2ofcypwI5P40i4apQOTUDZqigbVQ+yVfP24fI1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3CXbAPfqX0krzsN+ZQ1WlU8Nc7Sa3xtfloV2rtrJu+SsgPCQ12CdPLUMG2n/je5+UnAp9gpM9oz0ShAyjYjAvxo66Tpx9VCb0rl7PwS5uHwRm05cKxhrcfnc52yoCXD/a2jAD6TCSLVqgbzPvrBLmZzVaxqqis5A+9PGczw1yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VhmVb4Z+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jsv4DyFtp2uJhVyt+kJ1zSZIlddKaM2KbUrSxNXbbHM=; b=VhmVb4Z+UIhP450eSpi9XGP++L
	WHF1/2i0fXq701JVCHs3Q+7euJhCmkavJGAbcDQz2WP5gPFxCS6LsCKH1i2OYSynf9YRSLmiUVGZA
	AXDjXFdw2S5FuBxISyP/pNPkWgBm+ejlyNpY3EFiPsZi2pSWulRodEh2sCY5zhmIiY+B0vAJEK/HE
	odzhogCgy/waj8VXZBX21s5wGFiaJE/eqtj/UUHhA8ZdJM5tOT9ohuUPQ/NX68FFtIb5tQTrqmaGp
	IYbqXKlE1Jk8Fkqzu1d9gdeUrc0b/ytKpvlYFSFuHLZE9hwBfMn6zXcKcKCU+C6VBBmOArIzMwWLO
	c18FROEg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47318)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tIrL3-0003Vq-1L;
	Wed, 04 Dec 2024 15:30:53 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tIrL1-0005dy-39;
	Wed, 04 Dec 2024 15:30:51 +0000
Date: Wed, 4 Dec 2024 15:30:51 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Marc Zyngier <maz@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andrew Lunn <andrew@lunn.ch>, Ard Biesheuvel <ardb@kernel.org>,
	Daniel Mack <daniel@zonque.org>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	"Jeremy J. Peper" <jeremy@jeremypeper.com>,
	Kristoffer Ericson <kristoffer.ericson@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Ralph Siemsen <ralph.siemsen@linaro.org>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Tony Lindgren <tony@atomide.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 15/15] ARM: mark footbridge as deprecated
Message-ID: <Z1B1q3Q3B_3TFlMn@shell.armlinux.org.uk>
References: <20241204102904.1863796-1-arnd@kernel.org>
 <20241204102904.1863796-16-arnd@kernel.org>
 <CACRpkdahQhj5u9ATghszi-N2OYhFbvHF_W_eAMDAU+vhmvdrJA@mail.gmail.com>
 <Z1BpNQjWwxEKFbg0@shell.armlinux.org.uk>
 <CACRpkdY-uKYqAR2Sj_cG7dPAtXMFG0Ldka7U13qZSFr+w15WxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdY-uKYqAR2Sj_cG7dPAtXMFG0Ldka7U13qZSFr+w15WxQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 04, 2024 at 04:14:07PM +0100, Linus Walleij wrote:
> On Wed, Dec 4, 2024 at 3:37 PM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> 
> > > I am booting it occasionally, last time to test my KCFI patches.
> > > But admittedly that is only to test it for other SA110 users. I remember
> > > that Christoph had problems consolidating the DMA used in this
> > > machine as well so it is standing in the way of useful work.
> >
> > What problems with DMA? The fact that it uses an offset between
> > physical and PCI bus space should be nothing that causes a problem
> > for the kernel. As maintainer for Footbridge, I've heard nothing
> > about there being any issue.
> 
> No issue other than testing and iterating the patches I think.
> 
> I was thinking of this patchset to do dma_direct_set_offset():
> https://lore.kernel.org/linux-arm-kernel/20200917173229.3311382-3-hch@lst.de/
> 
> It seems to have stalled some years ago, but maybe there was
> some other reason.
> 
> IIRC Christoph was onto me to test it on the NetWinder, but I
> couldn't locate a good DMA capable device to test it with.
> (Would be the soundblaster but then I needed some userspace...)

It isn't soundblaster, but waveartist, and needs special setup to be
functional (which was all in my OSS waveartist driver.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

