Return-Path: <linux-kernel+bounces-187595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3778CD506
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C319E284FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D3914A08F;
	Thu, 23 May 2024 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pRr41XoO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76EB1E520;
	Thu, 23 May 2024 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716472203; cv=none; b=SQo7ZxZqPQi0XYH2m/C13n5z5VAE4Jt1Ohacw74JSs8nYFwZXWn1mXKJ1ZmGO1bqYkEtSWTCZaFddamu4xbXtBLQLtkkD9o4qZS89PL9sdthKHe2HhTGdn4Q/g4G3/5KAow6xIrV2oYX4NdqZpdKgT0yOxyRL/35F8UByQ/24V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716472203; c=relaxed/simple;
	bh=p4SE2t2t9xproHJFHx8jIsBOYFhu7L96mr6qTM2GP0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZyr8GZoj1h33sd4fEBY20nWTVb6bDMmovpUBSoChv+yh2QFk6gCg3E9LbEHrpERBooB1UkzTwjJuSKqY8jDPhxelKtFWkNFfux0y6JA/zJzZoX/7v94GJyBX5BiAaSJ9i+8lnG4PGQT0VYUZj0fljMcPAuiR+mRLVrrl7m/ks0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pRr41XoO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03C3C2BD10;
	Thu, 23 May 2024 13:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716472202;
	bh=p4SE2t2t9xproHJFHx8jIsBOYFhu7L96mr6qTM2GP0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pRr41XoOZ1avtvfDkIXUjviT2jhrcwY4hhtNjzbGpE+lTr7NrkNu+hv+p0F2zLeNw
	 iKR/Hq3hZ5Kg7KFL/eiBC9UzalW73EmRcKelaxBe9BPlAUUgEKKCLXlZSWLTfQBDfw
	 Q8TUJzbDdaYGyMyBnkH4xo4J0X/WceJAtYIuDc6E=
Date: Thu, 23 May 2024 15:49:59 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-35906: drm/amd/display: Send DTBCLK disable message on
 first commit
Message-ID: <2024052309-scabby-favored-0973@gregkh>
References: <2024051954-CVE-2024-35906-1c6f@gregkh>
 <ZkxbObACcnUMZ3LA@tiehlicka>
 <2024052136-cubbyhole-ecologist-5b68@gregkh>
 <ZkzREEA5_N_xfqED@tiehlicka>
 <2024052110-grasp-liking-22c0@gregkh>
 <ZkzgZoxF_RD50PdW@tiehlicka>
 <2024052243-napping-coastal-3306@gregkh>
 <Zk790Afi1sfwgrZi@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk790Afi1sfwgrZi@tiehlicka>

On Thu, May 23, 2024 at 10:26:56AM +0200, Michal Hocko wrote:
> On Wed 22-05-24 05:57:38, Greg KH wrote:
> [...]
> > > I completely do get why you do not care about that downstream
> > > engineering cost but generating bogus CVEs on top of a huge pile of
> > > dubious ones is less than useful, don't you think?
> > 
> > How is this a "bogus" CVE on their own?
> 
> I suspect you haven't looked at those commits. This is a boot time
> suboptimal HW configuration. There is no way any user can exploit that I
> can see. Not to mention it cases system boot hangs!

Yes, you are correct, the original should not have had a CVE assigned to
it, that was wrong, and I have rejected it now.  Same for the revert, it
too is now rejected.  Thanks for the review, it is much appreciated.

Also, the reason the original had a cve assigned to it was a fault on my
side, that shouldn't have happened, and I've re-reviewed to make sure
that I didn't mark anything else that way as well (so far I have not
found anything, the 'revert' caused problems in our tools, not to blame
them, but me, the author of that tool...)

> [...]
> > > Seriously, we can disagree whether something is a security threat that
> > > is worth marking by a CVE. But making the CVE generation process mostly
> > > unattended script driven process without any _serious_ review in place
> > > is burning a lot of man power that could be used in a much more
> > > productive way. This is not the way how to convince people to use stable
> > > kernels.
> > 
> > To think that any of this is an "unattended script without any _serious_
> > review" is slandering all of the people who put in their free time to do
> > this work for you and the community.  This is ANYTHING BUT an unattended
> > script.
> 
> This is a perception one can easily draw by watching the stream of
> incoming flow. Sorry if that is not the case but there is about zero
> transparency about the process except for Documentation/process/cve.rst
> and let me quote
> "
> As part of the normal stable release process, kernel changes that are
> potentially security issues are identified by the developers responsible
> for CVE number assignments and have CVE numbers automatically assigned
> to them.
> "
> 
> There is no mention about criteria, review process. Who is involve in
> the assignment and who is doing the review. The vulns.git tree doesn't
> contain Sign-off-by of those involved parties except for the submitter.

The "criteria" is that as described by cve.org, we can't do anything
about that.  The process, yes, we can be more open about that but as it
has been evolving over time, it's hard to describe a moving target at
times.  I know Lee is writing up an article about how this all works,
and I'm going to be giving talks at conferences in a few months as well.
And people also just ask us directly, which you can :)

Because of asking, many others are starting to help out, you can too,
just submit patches against the cve/review/proposed/ directory with a
list of commits that you feel should have CVEs assigned for, or annotate
why you feel specific ones we have reviewed should NOT have a CVE
assigned, and our tools can handle them quite well as part of the
assignment process (see scripts/cve_review for a tool that some of us
use to create these files, that's not required, as not all of us use it,
but the output format is the key, and that's a simple list of commit
ids, personally I generate that from mboxes.)

> > Also, this is work ostensibly that you are also already doing for your
> > day-job, right?
> 
> We, like stable trees, rely on Fixes tag and those (including other
> commits that might be this tag) are reviewed by domain experts.

Great, so you already have reviewed all of these, so it should be a
simple match up on your end.

> I have raised a concern based on observed CVE flow that the current
> process is automated without a proper review as I can see very dubious
> CVEs being assigned (splats resembling oops/warnings coming from lockdep,
> data_race fixes as they resemble race condition fixes, READ_ONCE fixes
> which do not fix anything discussed in other thread and others).

It's a learning process for all of us involved, and I thank you for your
reviews to help make this better.

> I have tried to dispute quite some but quickly learned that many of them
> have been dismissed because "no usecases are assumed". It is a very
> broad category that could indeed make any fix a CVE.

We can't assume usecases, sorry, you know that.  And yes, it does make
it such that many broad categories can get a CVE, which is just part of
the "business" when working at this low level in the stack.

> If you really want to build a trust around the CVE process then make it
> more transparent. I would start by adding reason why something has been
> marked CVE. You are saying there is peer review process going on then
> why not add Reviewed-by: to make it explicit and visible.

We have that, see the git log of the cve/review/ directory for the files
and where most all of the cves come from.  Some come directly from
requests by others to us, and a few other places (i.e. security
reports), so we of course can't document the source of everything for
obvious reasons.  But always feel free to ask if you think something
looks "odd" and we'll do the best that we can to answer it.

thanks,

greg k-h

