Return-Path: <linux-kernel+bounces-359193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58087998888
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0409D1F2602C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8301CB33E;
	Thu, 10 Oct 2024 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="PEJoPP6e"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC89E1CB315
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728568772; cv=none; b=ryfVcwleqFRI00vL7sJaf63Yc9lokFh+8nscfbs44/2N9QneietDtr9SXRqCRo69mM/dzBSo5UmztzCceeo5Kp2SZIe1UYoCdDgEV0Ht/eZcdIpc3zmDGFxnzQLejBCwokSS0+aixc4AN5i/LMjlYB5RxJLszCbYSPISbeqp3pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728568772; c=relaxed/simple;
	bh=w8CwfDqDbNYRgJVnk3bz43fkxgOssVsu5YCa4IMBYbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hsq6YmyVb0Tc8tRFHMJqkfmGkoI+pG1y7IU1gN+CUz+cPPPoYaFncKmIHWpsX0Qs+Bo6bquVeUpJ35JuBhSqUQAnybioQwxGDxFMczb6dhOr8OSm99yvo88CPQSaSA3jZAfmhx0urlmYFCr+c6Lt5MHtSKcHCQ3BZcSHbDaNLQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=PEJoPP6e; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=qT7ga1zCko42nvkwI93HEBrpo0tCQ0dea9Rkrv5rJiU=; b=PEJoPP6eh6BIbDI4
	664Jl+2buKuULDFq6WLkX+PiS+W6xrzkWw1k2BiiiN4rJej2G7M2PTD9fjhaEGvCEsGgtczG/BU5K
	v85O3x3U3lFTeG9LLtnLHXcXrq/3J1wD0DIK68s6CxQjkmxkezZN8GeDWRPatyKL61Bhr9UsAPYVv
	C99Xa65BMWmHSJb0tDXLu6JbELITCe86vxX7lkvRFxsIZO5OuXPRksDiCScEz7TJt9TyBL86OBmAn
	XBa5O1BbxaFWX7ZqXvlBTXzPDxOSG/4IQb5/bLt2A/EjDJU2fv/8Q9hGNNvlQ67zlYM/0H1+LTkr3
	tGJV1OHqZrGpI+bi2g==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sythN-00AFeQ-0J;
	Thu, 10 Oct 2024 13:59:25 +0000
Date: Thu, 10 Oct 2024 13:59:25 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: John Stultz <jstultz@google.com>, tglx@linutronix.de
Cc: sboyd@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clocksource: Remove unused clocksource_change_rating
Message-ID: <Zwfdve7TNSh8VRIu@gallifrey>
References: <20241009003032.254348-1-linux@treblig.org>
 <CANDhNCr=+x3fJo1dhyWnSGGLtexXLcTuHj8OEPqbj_TcDWdEPA@mail.gmail.com>
 <ZwcsOMV6kofmpduf@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwcsOMV6kofmpduf@gallifrey>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 13:56:53 up 155 days,  1:10,  1 user,  load average: 0.07, 0.05,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Dr. David Alan Gilbert (linux@treblig.org) wrote:
> * John Stultz (jstultz@google.com) wrote:
> > On Tue, Oct 8, 2024 at 5:30 PM <linux@treblig.org> wrote:
> > >
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > >
> > > clocksource_change_rating() has been unused since 2017's commit
> > > 63ed4e0c67df ("Drivers: hv: vmbus: Consolidate all Hyper-V specific clocksource code")
> > >
> > > Remove it.
> > >
> > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > 
> > Thanks for submitting this cleanup!
> > 
> > Untested, but
> > Acked-by: John Stultz <jstultz@google.com>
> 
> Hmm the test robot got an unused warning on __clocksource_change_rating
> I think that's because it's an allnoconfig and that needs moving inside
> the ifdef.
> 
> I'll look at it.

v2 posted 20241010135446.213098-1-linux@treblig.org
I shuffled the __clocksource_change_rating inside the ifdef (I guess
I could have inlined it instead).

The failure the testbot found only happens on a non-x86 allnoconfig.

Dave

> 
> Dave
> > thanks
> > -john
> > 
> -- 
>  -----Open up your eyes, open up your mind, open up your code -------   
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

