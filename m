Return-Path: <linux-kernel+bounces-441389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8895F9ECDA9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C90E16145D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBE023027F;
	Wed, 11 Dec 2024 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bTLCy0es"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDFE381AA
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925068; cv=none; b=UNsaWIldB+8hgUP07SSqfN9IF+H1leqiS4lt+ITZhX3ymKJnrTnagmihBms14bo7sMcF2gaVCNiVuanwxAM6/ztCHaYfR6PwpTCuLTXOZaTA122Hjmr5p7PoY2i4STB5OPuLOwRtD7N2gGLk4irHVOIoHHGhtf1YH1oMPHFizQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925068; c=relaxed/simple;
	bh=5qubLMaGuBz29aMyEIFBlCc81fI0ogHv+dJZtbbm9uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ninqLPXTsOjU+juWZi5FfMRFFlKdiZEElvjgHJti/cvstUnO4/GzIrrSDPfqUXWoLj65xrAnx0TYder+TaAEs8wol9He9RFloK8u0E7t+1FIzZPkUSmt9C/Tzvwuxd4TGSC57MB6vt8+CTfkFN1Eyg+YVDEHt27B4emGU1rdfu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bTLCy0es; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Et/J9SQdT88EyXCsKLWmZ8BwqDw8CUv9dJzq6Y7P/LI=; b=bTLCy0es9Myffa2YtoKYWxYB0l
	taRrsBab9izJB7hzMLz/dMCekfnIEbpysaxo4UXsLkMUGaT26VpObytEWsdvtLJq6vbBcZBJOgCVm
	6uNbdWzwV8AsTjoro3AOS/43rKAYCoHT12Jv+9JNUWARE5kX6fTGQjLj/UMqLiRYIk/iYY5BK+xK7
	AOvkTwF7J6Q3FASo3+GnqSZXWcFfV2uv+qMuSFYT5P1vem4lnBd1PfobizDSynEiGADPv7/+w9Zwh
	sJPBKmVvr7FZgYdPZ8waDzFLpIAR5TuMCzIBGOLLW6dQZ5nfXC85HVz2pVVzWxvprpiYWbA8M15G1
	w4e88fug==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48524)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tLN77-0003zU-2t;
	Wed, 11 Dec 2024 13:50:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tLN73-0004CI-1c;
	Wed, 11 Dec 2024 13:50:49 +0000
Date: Wed, 11 Dec 2024 13:50:49 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev,
	Ard Biesheuvel <ardb@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/4] ARM: drop CONFIG_HIGHPTE support
Message-ID: <Z1mYufbtXpeEwTAq@shell.armlinux.org.uk>
References: <20241210160556.2341497-1-arnd@kernel.org>
 <20241210160556.2341497-4-arnd@kernel.org>
 <CACRpkdZoRbJ4DwRpZQMKbEAvzg4AAdp4B+94SFLm1ssiQmjUwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZoRbJ4DwRpZQMKbEAvzg4AAdp4B+94SFLm1ssiQmjUwQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Dec 11, 2024 at 02:32:51PM +0100, Linus Walleij wrote:
> On Tue, Dec 10, 2024 at 5:06 PM Arnd Bergmann <arnd@kernel.org> wrote:
> 
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > CONFIG_HIGHPTE was added in linux-2.6.32, a few years before 64-bit
> > support. At the time it made sense, as the CONFIG_ARM_LPAE option allowed
> > systems with 16GB of memory that made lowmem a particularly scarce
> > resource, and the HIGHPTE implementation gave feature parity with 32-bit
> > x86 and frv machines.
> >
> > Since Arm is the last architecture remaining that uses this, and almost
> > no 32-bit machines support more than 4GB of RAM, the cost of continuing
> > to maintain HIGHPTE seems unjustified, so remove it here to allow
> > simplifying the generic page table handling.
> >
> > Link: https://lore.kernel.org/lkml/20241204103042.1904639-8-arnd@kernel.org/T/#u
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> I'm in favor of this if the x86 patch goes in. We need to get rid
> of highmem anyway and this will need to happen sooner or later
> either way.

Well... I use highmem routinely.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

