Return-Path: <linux-kernel+bounces-173897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888128C0756
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 00:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F891C212AD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 22:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A9D1339B8;
	Wed,  8 May 2024 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FEtckNfX"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5178F132816;
	Wed,  8 May 2024 22:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715207378; cv=none; b=NSPc7gN0fuS6Kjga9jVZC0b/cgLakxoSc9LU5BQdUYErqtSgYkh845gpa+FCwsBMpEp7IBf5+7W62GDxdAx4MztPuppfKeYZcoEC/oSNe8UqWMfUObignInI1TAI/DgiOt2fgY6k/JMfkmVPpzlQ4jfBGCMHMSIEfg0McaMyrf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715207378; c=relaxed/simple;
	bh=8CFE89KQ1YCyvoNxJkTNQ2HS3pGySrvPKIrTF4hkP6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJHJ8C3UlIDOPdkfrhRTd4gdwKKCCUJXFXagB/A6MOkQKNxHQiJIsc058zFU4qPI1bOWlIviusRO7lHweh1eP9tkXpWTEhZrSD6BFuSQ7CedmoTo9f4ihL2polrt4jHIRtGlMMYz3UYfLM2rG2p9YH4GIW5SJu5pV+wiCKd6Uqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FEtckNfX; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Eb6h6lYO2Xj8IhPPKAoLKWE2vlA1ySJ+zUASlEJjoTU=; b=FEtckNfXCagMhx2pYvdo/RZKvJ
	p+XTKA9wWiv4JnepfK8na49y4qvgRBuV6gu5VwTbHIpxtKv11fbkIu7CX4pNltuQG/kZ/9PDV9+RY
	Pr9J9yyKsf91exZwtiK/iCuSFt8RoyQEQbBCpTT5NGnLlKv5RFuhq9b5DJxE0T2kt9037o8S9a7qs
	zrVodNGW4wdEeB2S+N4Bx/2ZOhH44sveIZxPly0jFcPNMz7WbqGOXLf6/uOAs9pW1SVOa2fL4dXWE
	kcXbOhFdYl7bUh0HLakR2Kdqn9TYuUehFv6e/eVHGZTvHg1MqQ331GwS2qHKP6gCpk+u5EsCsIbMD
	yTWc6/Rw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48902)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s4pmv-0005h2-1q;
	Wed, 08 May 2024 23:29:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s4pmu-0001hI-UL; Wed, 08 May 2024 23:29:24 +0100
Date: Wed, 8 May 2024 23:29:24 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	linux-clk <linux-clk@vger.kernel.org>, lkft-triage@lists.linaro.org,
	open list <linux-kernel@vger.kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: clkdev: report over-sized strings when creating clkdev entries
Message-ID: <Zjv8xBXcRnfShpvf@shell.armlinux.org.uk>
References: <CA+G9fYuZd_ur56H8fwDSvUywopvn_b7ogprGkjEatQ7EPTLwYQ@mail.gmail.com>
 <11be44d3-0f32-49c6-b4ae-ba97a9f97763@app.fastmail.com>
 <820ddc2ec70780ae1ecd3af864dc8bd6.sboyd@kernel.org>
 <CAPLW+4=D_31Fy_W_7+_ko22y9_-8rZ9Logh6KyW8UPM3q58J0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPLW+4=D_31Fy_W_7+_ko22y9_-8rZ9Logh6KyW8UPM3q58J0A@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, May 08, 2024 at 04:07:57PM -0500, Sam Protsenko wrote:
> The patch [1] ("clk: samsung: Don't register clkdev lookup for the
> fixed rate clocks") fixes those. I think both have to be applied ASAP.
> In case of E850-96, I guess [1] is more critical.

The fixes to clkdev.c have been pushed out for a while now, so I think
you may need to update your tree. There's been one more fix to it more
recently (because of the whole va_copy() debacle).

Whether linux-next picks up the latest version depends when they pull
in relation to me pushing the changes out, which can take 48 hours
due to the timezone differences. linux-next tends not to pick stuff
up quickly if one's in the UK and pushes stuff out in the late
afternoon/evening. That said, the NULL fix has been pushed out for
a few days now.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

