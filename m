Return-Path: <linux-kernel+bounces-203416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8FC8FDACF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42CF42877D2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A74F167DB8;
	Wed,  5 Jun 2024 23:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1JOkIQt8"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B0315F400
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 23:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717631096; cv=none; b=TlPz1p139s6y74gdpKcwp1SFlWPVeD6g+JMA9tnOaGT1q6Lf9MWaDZS5hP8ht15U0DUJefEQ8FGcY45lupxLPaltx1TK/RbfLCprWRiNg03zCFO9sQjeb5CepQLI+ZU9yBzMKdzwUSJdVr0rbg8vbiogIytkU8wfO2e+0Lq7lsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717631096; c=relaxed/simple;
	bh=7OjL+3GEtdjxh562vgCkkyQ+/dP20USij1K8LM2y+JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EiD9c5kJzBPqa0DJL02QmEFtW3POGOyJLP9TigL2OB0v3t/JjUN17XlJbaDvTqfDuEWbXF0wvpkIljD0HoKZl3o6a6quG7XYeeHAIl+vOH/PvcLLTrhJCjQajlPrMjX6HR//d+KNQso+of5+DqwskZkULwnW7joCKM902Bf6bLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1JOkIQt8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Ff7wJvQnINbudpdFG654dwQXX6KDWHFegXGS0vKRZZ0=; b=1J
	OkIQt8aC1OFXD59PB2S36fjva8jd2QGMY9kPjaOtz0OzshDPg+KLp7PlY2N3NpMOquBD8UXsQkPdK
	8RopAp4ljfY6l/83v6QYBFEEDLuBa6q9zd+ye0XEYLVAptuyETxmtuP0QnIv0dzw7jYZ03/jAHvOU
	8DgC1Va0y86PDgE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sF0JD-00GxWu-FD; Thu, 06 Jun 2024 01:44:47 +0200
Date: Thu, 6 Jun 2024 01:44:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc: Benjamin Schneider <bschnei@gmail.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Benjamin Schneider <ben@bens.haus>
Subject: Re: [PATCH] cpufreq: enable 1200Mhz clock speed for armada-37xx
Message-ID: <dce98e50-6b50-4d4e-abe2-8419a675d25e@lunn.ch>
References: <20240603012804.122215-1-ben@bens.haus>
 <20240603012804.122215-2-ben@bens.haus>
 <20240605194422.klxtxgyljrrllkzy@pali>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240605194422.klxtxgyljrrllkzy@pali>

On Wed, Jun 05, 2024 at 09:44:22PM +0200, Pali Rohár wrote:
> On Sunday 02 June 2024 18:26:38 Benjamin Schneider wrote:
> > This frequency was disabled because of unresolved stability problems.
> > However, based on several months of testing, the source of the
> > stability problems seems to be the bootloader, not the kernel.
> > Marvell has recently merged changes to their bootloader source that
> > addresses the stability issues when frequency scaling is enabled at
> > all frequencies including 1.2Ghz.
> > 
> > Signed-off-by: Benjamin Schneider <ben@bens.haus>
> > ---
> >  drivers/cpufreq/armada-37xx-cpufreq.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
> > index bea41ccab..f28a4435f 100644
> > --- a/drivers/cpufreq/armada-37xx-cpufreq.c
> > +++ b/drivers/cpufreq/armada-37xx-cpufreq.c
> > @@ -102,11 +102,7 @@ struct armada_37xx_dvfs {
> >  };
> >  
> >  static struct armada_37xx_dvfs armada_37xx_dvfs[] = {
> > -	/*
> > -	 * The cpufreq scaling for 1.2 GHz variant of the SOC is currently
> > -	 * unstable because we do not know how to configure it properly.
> > -	 */
> > -	/* {.cpu_freq_max = 1200*1000*1000, .divider = {1, 2, 4, 6} }, */
> > +	{.cpu_freq_max = 1200*1000*1000, .divider = {1, 2, 4, 6} },
> >  	{.cpu_freq_max = 1000*1000*1000, .divider = {1, 2, 4, 5} },
> >  	{.cpu_freq_max = 800*1000*1000,  .divider = {1, 2, 3, 4} },
> >  	{.cpu_freq_max = 600*1000*1000,  .divider = {2, 4, 5, 6} },
> > -- 
> > 2.45.1
> 
> As without the updated firmware on 1.2 GHz variant of the SoC is kernel
> already crashing, even with commented line for .cpu_freq_max = 1200,
> this change makes sense.
> 
> There is no reason to have 1.2 GHz line disabled as it does not solve
> any issue (as was originally thought) and just prevent people with
> updated firmware to use non-performance governor on that SoC.
> (When cpufreq driver is not loaded then CPU frequency of the SoC is
> locked at the max speed, which has observed behavior same as performance
> cpufreq governor).
> 
> So, go ahead with this change with my
> 
> Reviewed-by: Pali Rohár <pali@kernel.org>

I defer to your knowledge in this matter.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

