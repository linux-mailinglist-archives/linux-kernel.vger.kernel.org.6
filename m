Return-Path: <linux-kernel+bounces-549251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7945A54FA8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645623AFA35
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E558A1DF988;
	Thu,  6 Mar 2025 15:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="eJIOlHRm"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57E21865E2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276355; cv=none; b=MdkL/DpENG0sHs9fStySt7J0rVh1Z8NgV+AMjX5rbQGE8FR2pfNDsaqAxndBkitYWFsblDOagV7wEtUsXkr/TTiEOcEML9S9VgEa+rsWxQxFYKjebHYFm0wSvXW+Uze6P+rytRz7S+dtG1QUT1+T6gP96ID15bpnrA4pd8Jrp3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276355; c=relaxed/simple;
	bh=PV5Jc62V87unU2s3v2Pnp2p1mLoJgFL5K20eJNXMrfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWZCaxXmChj7gQZODFhwxrtqqAOUVaIfbBFrgZ2oe8k0pCuUiwpdqjKrF8jsblHWtGgkE/8yhwPtEB10pm2m9MAIDl8RD4bV7/nZfuqwmu1x+ancbU0YaQiy+31f8n/XtnhXngfBULbZDrJKzbsgWHgHXpA2CdM7OJQJIRtwP2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=eJIOlHRm; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=I6efTm9PV4pBjdbnqkqM78JjSWuS+IsxuUu8XtCPY50=; b=eJIOlHRmlzyVk07y
	JYR+R2Ub5dqbL9UX6DE2heD/fmdKnJtlowguv8rM3dWdPIrtuWOAd8aEc6LdVwTefxFpLQZGTu+0D
	LPc/qpIzBHiL4xb3ZIbd2DN91Ux/kr/yLmEC4gJmbqxviEtDcxNpDr8rY0M1wIGJJj7dKJieyLnQS
	IF1NItAWIgcy5iw8Rz4OFwd5VYa0/oTv/5vyAy7S+tGGuBSTDdvk0Usv2nveZt4OkZAgo4DbA8cHX
	aBnrtKbMR6Acr9V1HaiGVKIeJRnZWhKfhOoTfnrXXaNi/iiX7TDyTAf2YRt2wX0Sgw3DW5md6YC6m
	PO+8jVzw52UovEM7uQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tqDWO-0039N5-0Y;
	Thu, 06 Mar 2025 15:52:28 +0000
Date: Thu, 6 Mar 2025 15:52:28 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/gma500: Remove unused mrst_helper_funcs
Message-ID: <Z8nEvKh5evPw7qxp@gallifrey>
References: <20250201011434.453879-1-linux@treblig.org>
 <CAMeQTsa8enkergRai6ixmE-ivTQgWazoTJ9stMWSgzobexphJw@mail.gmail.com>
 <Z8m8i0iqgDUk5uFk@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8m8i0iqgDUk5uFk@gallifrey>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 15:52:05 up 302 days,  3:06,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Dr. David Alan Gilbert (linux@treblig.org) wrote:
> * Patrik Jakobsson (patrik.r.jakobsson@gmail.com) wrote:
> > On Sat, Feb 1, 2025 at 2:14 AM <linux@treblig.org> wrote:
> > >
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > >
> > > The mrst_helper_funcs const was added in 2013 by
> > > commit ac6113ebb70d ("drm/gma500/mrst: Add SDVO clock calculation")
> > > and commented as 'Not used yet'.
> > >
> > > It's not been used since, so remove it.
> 
> Hi Patrik,
> 
> > You talk about mrst_helper_funcs but the patch removes
> > mrst_clock_funcs. I assume this is not intentional.
> 
> Oops! Thanks for spotting that, I'll send a v2 fixing the commit
> message; I think I was intending to write something like
> 'the helper functions it references are still used elsewhere.'
> 
> v2 coming up soon.

See message 20250306155155.212599-1-linux@treblig.org.

Thanks again,

Dave

> Dave
> 
> > -Patrik
> > 
> > >
> > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > > ---
> > >  drivers/gpu/drm/gma500/oaktrail_crtc.c | 7 -------
> > >  1 file changed, 7 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/gma500/oaktrail_crtc.c b/drivers/gpu/drm/gma500/oaktrail_crtc.c
> > > index de8ccfe9890f..ea9b41af0867 100644
> > > --- a/drivers/gpu/drm/gma500/oaktrail_crtc.c
> > > +++ b/drivers/gpu/drm/gma500/oaktrail_crtc.c
> > > @@ -658,10 +658,3 @@ const struct drm_crtc_helper_funcs oaktrail_helper_funcs = {
> > >         .prepare = gma_crtc_prepare,
> > >         .commit = gma_crtc_commit,
> > >  };
> > > -
> > > -/* Not used yet */
> > > -const struct gma_clock_funcs mrst_clock_funcs = {
> > > -       .clock = mrst_lvds_clock,
> > > -       .limit = mrst_limit,
> > > -       .pll_is_valid = gma_pll_is_valid,
> > > -};
> > > --
> > > 2.48.1
> > >
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

