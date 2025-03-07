Return-Path: <linux-kernel+bounces-551238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6489AA569F3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE4D179C7B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B6721ADBC;
	Fri,  7 Mar 2025 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="MHwg6mD5"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB4818DF65
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741356402; cv=none; b=mXQP2RL/qxybo3x/YsOGJCRPPjHjA9G7HslTgklBl51pjNhlI2MMHsn0d9RRixQMH6KqBEvpsBVNKGM1xW2cwI48l3aONL/6Den5Qvf/RRbiIC4Ta/c1qdKk+WR/cnbhDXJp36DlsnTTUxtUYe9gplJiJzINscyrVZc4DR+dTNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741356402; c=relaxed/simple;
	bh=imVyh6k1rb/XZNJVY9COulfZL4IKvp42PjLpgWwlSBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0Zh0lT4rzKIMe9xO2GvM0/MUcqZLWBr2qbKKvDAUIPDj+ptW5ce6ox/J3htrygUWjUoBeD/+obEOD/0PEaqsqeJhntxhmNel9WlScGZFfiiS6r08lUpcdWi95Vn0d4FVZxFWeSy11fZ2YtwDi4TAelZaBfjSbSDoTvoKyfYKQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=MHwg6mD5; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=UBQ6q3i2ePjT2i8U7tBuzMQdDLItSqljC2sOjafdBNw=; b=MHwg6mD546FqX8Qj
	TTP1dLVNaTx/Us4Jukg/gkx3CPbq9+KmF18KUfEyNmQARN+9/JlkGWgYJ/vydPZsvCMCrqwYTDjG1
	yWPWAei5PZFGyapLmjmB9VIyCypdeDm/SIjSn6d8Qw+fyNNNKNBBn/AxPIZi6dfa+oWVnWZT1UxAG
	sucV4PDp3n+rMZH8mvQO/6al7/VEhUdjVKLekXH5+KWg55EVrmMAEVVnuxCbYOVa/fv8NbEd/hkAy
	GNrdja++lzROCpZDPNbBiHzRXQoJYPuzpmqo1qzhOrWogkE59ADqBe5qO0p1hWzvhzHL5mhaW8LFZ
	M6uvPM+z3/DTLgJvJQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tqYLQ-003Phw-2S;
	Fri, 07 Mar 2025 14:06:32 +0000
Date: Fri, 7 Mar 2025 14:06:32 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/gma500: Remove unused mrst_clock_funcs
Message-ID: <Z8r9aE0mtb9_R0p8@gallifrey>
References: <20250306155155.212599-1-linux@treblig.org>
 <CAMeQTsaNfQJ=OgWXwQ2bAxa1xbbQxAWDYEcokQ3VJE_EApPbzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMeQTsaNfQJ=OgWXwQ2bAxa1xbbQxAWDYEcokQ3VJE_EApPbzQ@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 14:06:22 up 303 days,  1:20,  1 user,  load average: 0.03, 0.01,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Patrik Jakobsson (patrik.r.jakobsson@gmail.com) wrote:
> On Thu, Mar 6, 2025 at 4:52 PM <linux@treblig.org> wrote:
> >
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >
> > The mrst_clock_funcs const was added in 2013 by
> > commit ac6113ebb70d ("drm/gma500/mrst: Add SDVO clock calculation")
> > and commented as 'Not used yet'.
> >
> > It's not been used since, so remove it.
> > The helper functions it points to are still used elsewhere.
> >
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> Applied to drm-misc-next

Thanks!

Dave

> Thanks
> 
> 
> > ---
> > v2
> >   commit message fixed to use correct struct name, and add
> >   note about the functions used still being used.
> >
> >  drivers/gpu/drm/gma500/oaktrail_crtc.c | 7 -------
> >  1 file changed, 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/gma500/oaktrail_crtc.c b/drivers/gpu/drm/gma500/oaktrail_crtc.c
> > index de8ccfe9890f..ea9b41af0867 100644
> > --- a/drivers/gpu/drm/gma500/oaktrail_crtc.c
> > +++ b/drivers/gpu/drm/gma500/oaktrail_crtc.c
> > @@ -658,10 +658,3 @@ const struct drm_crtc_helper_funcs oaktrail_helper_funcs = {
> >         .prepare = gma_crtc_prepare,
> >         .commit = gma_crtc_commit,
> >  };
> > -
> > -/* Not used yet */
> > -const struct gma_clock_funcs mrst_clock_funcs = {
> > -       .clock = mrst_lvds_clock,
> > -       .limit = mrst_limit,
> > -       .pll_is_valid = gma_pll_is_valid,
> > -};
> > --
> > 2.48.1
> >
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

