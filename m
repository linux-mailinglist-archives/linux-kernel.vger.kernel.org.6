Return-Path: <linux-kernel+bounces-410822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A659D9CE15E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E5631F210A3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB221D47A0;
	Fri, 15 Nov 2024 14:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="JRt66b+g"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE201D435C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731681310; cv=none; b=tjE3HAdvyhQ7boTlahhfRsjiXZ61Svl1shw8yjOe07n6ux1vKP3SjoXR+Mszr/Rs7aNV16M1cIdm9cI5mr54a6qabSL2Ep3sWsaDkU2MG4pBAG2AvpFnMiDRDpXCrtjeYFw4GyQsmIx261OJkPGyoOcwX9HUwd3s+TQ60CsD4Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731681310; c=relaxed/simple;
	bh=lW3sAs7jk5CetavtAEWJp/vyVmLZfX1pyJMGycUUtIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghT0y2rui590VeYH4INNKN+qPTa1SricIwnKGmaLHWxwxdyhc4X5inqJrFyNdt/QbJV1sWOFQ1nAauCAsJjODhJsSXe+3i+rN8ZJL0zFFvY50T3VC24Jvdd9RThlw78hS5aY+t49PGNo7enDjRQoIWQm0pCbb/BqQRLqapKzqDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=JRt66b+g; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=PziflvkJk/OjtUhhIJ+EoSytNdEt0t4O2VdwVRCgKNA=; b=JRt66b+gZanobAYH
	yxXwqoJlHBA1h1hURBLg0fToppdHdiKW5I8I+1I2VYf3/PWRntdpuXPQlsQQ30AATjIlEIh4AHvIV
	VwX49FXRPVmIB+F7cbBBglqouDfuWqYcvme2Gy0csbGGdZ1XD7Mp0wxDyOFNkwRY3zI1lTkJEA3/B
	7CysevlKQaHM4IdY1M/5qL7Zu1PcHw3eokV8J8U7EIr8oECfebjOTPJeSr6MOE3AK+idXSFGyIAhz
	Ht5BSgIx1xS5+KfvruCEO4LT/4TjxBFNTvgHVsPGAEsyg8OgV6nazeZR6lOv+S92Wh3NfFjvnz8cA
	UIe9dwVxC2MZ/nKn9g==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tBxPd-0008ac-2A;
	Fri, 15 Nov 2024 14:35:05 +0000
Date: Fri, 15 Nov 2024 14:35:05 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: stuyoder@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Of fsl_mc_allocator_driver_exit
Message-ID: <ZzdcGbIRCjOqaVbS@gallifrey>
References: <ZzdRhcE2kG5z6NLk@gallifrey>
 <ZzdUE1E7ypErPuSz@gallifrey>
 <xly4pttb77ivx24tjd2zhqnrrwvvcdqdgdirvvshb2lugcbdq7@njdg5ogzho7u>
 <ZzdaC0_V6P-HsUdo@gallifrey>
 <5ogpp4jskwjdxyrnrw3j6szxbvv3gy7at2pdse2v6nynineltw@bruwu2w5dts3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <5ogpp4jskwjdxyrnrw3j6szxbvv3gy7at2pdse2v6nynineltw@bruwu2w5dts3>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 14:34:37 up 191 days,  1:48,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Ioana Ciornei (ioana.ciornei@nxp.com) wrote:
> On Fri, Nov 15, 2024 at 02:26:19PM +0000, Dr. David Alan Gilbert wrote:
> > * Ioana Ciornei (ioana.ciornei@nxp.com) wrote:
> > > > * Dr. David Alan Gilbert (linux@treblig.org) wrote:
> > > > > Hi,
> > > > >   One of my scripts noticed that fsl_mc_allocator_driver_exit()
> > > > > was added explicitly in
> > > > > commit 1e8ac83b6caf ("bus: fsl-mc: add fsl_mc_allocator cleanup function")
> > > > >
> > > > > but appears to be unused; given it's a cleanup function it feels like
> > > > > it should be wired up _somewhere_.
> > > > >
> > >
> > > I don't think that fsl_mc_allocator_driver_exit() is of any use at this
> > > point. The entire FSL_MC_BUS can only be built-in which means that there
> > > is no module_exit() which references it.
> >
> > OK, well I'm happy to send a patch to clean it out, I was also
> > going to clean out fsl_mc_portal_reset().
> 
> Sure. Please keep me in cc so that I can give it a run.

No problem.

> >
> > > The same thing is true about the dprc_driver_exit() function.
> >
> > Hmm, that's explicitly called from the error path of fsl_mc_bus_driver_init
> 
> My bad. I missed that.

OK,

Dave

> Thanks,
> Ioana
> 
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

