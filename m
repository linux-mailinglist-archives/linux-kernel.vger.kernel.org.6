Return-Path: <linux-kernel+bounces-410808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E599CE132
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1A0F1F228CB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B011CEE9A;
	Fri, 15 Nov 2024 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="PrJQKNAD"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9258B1BE87C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731680784; cv=none; b=mpvhBABfKX9YoT/H4unjZxTZeF0rgDzkx0PKROnOT7F2Ap/fPT1gMi/3WTisuK1SosUHTW/anHMjJKTyBBnTlRd9VvaK69gddTBhqg9OmDUt5eabCBX5H9UeXxyJ2SpwNsmQ45xlVngWSJxQJ/lPY6D1dQPId+ijomT9v/s3pPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731680784; c=relaxed/simple;
	bh=/t5ZN5ATMY8GPrqmA3KZpopToPElnRTiz8lIDHzuuUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZ5kpLpsquHZV4ySMiHxnUXc5VXale+ehhXazS3bI7w67V+VPgpzXdF8xwcgyI3hMB62AnHiV2dvvKSzsQg9wLYDf9YoY7JFQxrsjMOEuuOYjHEwdcX+WWLrsvzk7848g1GL+FdDnrtscSr5+0x0Nd4LU0Tn28efTigIX0GcY2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=PrJQKNAD; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=ergx7apg1pWU0HwCipHlzTdf/KOGlTf7z6AJhk+YnTQ=; b=PrJQKNADo3D5h9zr
	B1UcYTFxVZdwiWhd05G0gXjTIsJj7JExxf27/WGqhczTWmyAkP2WAzzK4ZuAofRjHFw8P8qp8710F
	PU6F2RoWxdy1rtsRBYHfWvKzy6BVEFfC7NpaWxu8/Cr2jfYoXbCJ7DQBuFuo6mHb1eTLSs37Ii1Ov
	ZXvAak2TstDSs6kdFPm69DAABP00gm5Ub29qj6ZhzGUjTtOxGH6DkLOGMCb89eL2yh21gbrLZ/YmH
	JLjzt2q5C1ZWHlAOUhrrbroDb8ds1CXR0wdqOukQG5ljaRI2G3N0b8t6vlHVijcTlIzWm/WF9aFkK
	qOvrMegJ31hmhfL21Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tBxH9-0008TD-12;
	Fri, 15 Nov 2024 14:26:19 +0000
Date: Fri, 15 Nov 2024 14:26:19 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: stuyoder@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Of fsl_mc_allocator_driver_exit
Message-ID: <ZzdaC0_V6P-HsUdo@gallifrey>
References: <ZzdRhcE2kG5z6NLk@gallifrey>
 <ZzdUE1E7ypErPuSz@gallifrey>
 <xly4pttb77ivx24tjd2zhqnrrwvvcdqdgdirvvshb2lugcbdq7@njdg5ogzho7u>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <xly4pttb77ivx24tjd2zhqnrrwvvcdqdgdirvvshb2lugcbdq7@njdg5ogzho7u>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 14:24:16 up 191 days,  1:38,  1 user,  load average: 0.05, 0.03,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Ioana Ciornei (ioana.ciornei@nxp.com) wrote:
> > * Dr. David Alan Gilbert (linux@treblig.org) wrote:
> > > Hi,
> > >   One of my scripts noticed that fsl_mc_allocator_driver_exit()
> > > was added explicitly in
> > > commit 1e8ac83b6caf ("bus: fsl-mc: add fsl_mc_allocator cleanup function")
> > >
> > > but appears to be unused; given it's a cleanup function it feels like
> > > it should be wired up _somewhere_.
> > >
> 
> I don't think that fsl_mc_allocator_driver_exit() is of any use at this
> point. The entire FSL_MC_BUS can only be built-in which means that there
> is no module_exit() which references it.

OK, well I'm happy to send a patch to clean it out, I was also
going to clean out fsl_mc_portal_reset().

> The same thing is true about the dprc_driver_exit() function.

Hmm, that's explicitly called from the error path of fsl_mc_bus_driver_init

Dave

> Ioana
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

