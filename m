Return-Path: <linux-kernel+bounces-188653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E63CF8CE4F4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 13:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155361C21620
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEAB8624E;
	Fri, 24 May 2024 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="InS41C++"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E03A85640;
	Fri, 24 May 2024 11:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716551223; cv=none; b=ozSGTj9QdXJevMacWOdCHp4AHB6OL1MNJ8/xGchUHCz9HdNJbNuhDJEjJgbz2FXGwsNH/A4Db6IftRxfbupoKebPbm0EL/6FJ5h8Vx1QFd9kMfAk7yZJGWzZPvMBhKrIFk5XnRcOIMpXEGz3lxZq0INk582XJygK/fOZF6jbMHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716551223; c=relaxed/simple;
	bh=JpuU8lZO9Lj61ZyzRAc21/U7aehfqnVfemYlR7Llv6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnlC5s324MecScJuPnvsFNpFVUQUpjefLAqzLoRd2xvzrO+HCp2qLokmdIdYPjAWOBn2KgwVJFIbGJ3NSf5VfX5ii0MPpz5vCWvrBAY0ZgQ6f46xU7dvPyJsAgN5Ii1+3NgNWy8wETQwISlFD/no3WBko6i2OCB9o2dElGiNspQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=InS41C++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF4FC2BBFC;
	Fri, 24 May 2024 11:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716551223;
	bh=JpuU8lZO9Lj61ZyzRAc21/U7aehfqnVfemYlR7Llv6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=InS41C++hlq0xqUEiSCu0NHF5SAuHHc4pieLDq1F4ofqzD9Xf7sAGrT0nJEJl10Th
	 DBKgjzuKvr5reIu4UTMKc2t5yEBNp71WfpC0WUOlKEP7IOQiHD0iwJ8QUeiy0WYi4F
	 IS6nggAKu3jztxrBeHVwgcIsD/Asw5jr0ArWjhOM=
Date: Fri, 24 May 2024 13:47:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-35906: drm/amd/display: Send DTBCLK disable message on
 first commit
Message-ID: <2024052458-matrimony-making-b7f1@gregkh>
References: <2024051954-CVE-2024-35906-1c6f@gregkh>
 <ZkxbObACcnUMZ3LA@tiehlicka>
 <2024052136-cubbyhole-ecologist-5b68@gregkh>
 <ZkzREEA5_N_xfqED@tiehlicka>
 <2024052110-grasp-liking-22c0@gregkh>
 <ZkzgZoxF_RD50PdW@tiehlicka>
 <2024052243-napping-coastal-3306@gregkh>
 <Zk790Afi1sfwgrZi@tiehlicka>
 <2024052309-scabby-favored-0973@gregkh>
 <ZlBnsEsr66mR-frf@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlBnsEsr66mR-frf@tiehlicka>

On Fri, May 24, 2024 at 12:10:56PM +0200, Michal Hocko wrote:
> On Thu 23-05-24 15:49:59, Greg KH wrote:
> > On Thu, May 23, 2024 at 10:26:56AM +0200, Michal Hocko wrote:
> > > On Wed 22-05-24 05:57:38, Greg KH wrote:
> [...]
> > Because of asking, many others are starting to help out, you can too,
> > just submit patches against the cve/review/proposed/ directory with a
> > list of commits that you feel should have CVEs assigned for, or annotate
> > why you feel specific ones we have reviewed should NOT have a CVE
> > assigned, and our tools can handle them quite well as part of the
> > assignment process (see scripts/cve_review for a tool that some of us
> > use to create these files, that's not required, as not all of us use it,
> > but the output format is the key, and that's a simple list of commit
> > ids, personally I generate that from mboxes.)
> 
> Do I get it right that proposals shouldn't be sent via email to
> cve@kernel.org as suggested by the in tree documentation?

The documentation should say that you _SHOULD_ send proposals to
cve@kernel.org, did we get it wrong somehow?

> I do not mind
> the specific workflow but until now I have followed Documentation/process/cve.rst
> as authoritative source of the process. It would be really great if that
> matched the workflow.

I'm confused as to what in that document is incorrect, care to point it
out?

> > > If you really want to build a trust around the CVE process then make it
> > > more transparent. I would start by adding reason why something has been
> > > marked CVE. You are saying there is peer review process going on then
> > > why not add Reviewed-by: to make it explicit and visible.
> > 
> > We have that, see the git log of the cve/review/ directory for the files
> > and where most all of the cves come from.  Some come directly from
> > requests by others to us, and a few other places (i.e. security
> > reports), so we of course can't document the source of everything for
> > obvious reasons.
> 
> Thanks for pointing me there but I do not think this is what I've had in
> mind. I do understand that there is some pattern matching happening to
> select most of the candidates, but as you've said this is then reviewed
> and during that review you likely need to read through that changelog
> and build some sort of statement why this is considered a security
> threat.

Right now for the 3 people doing all of the reviews, 1 is using pattern
matching of a sort (see the cve_review tool for the big regex and
workflow used there), one is reading each patch/header in mbox format,
and one is using some other tool.  Then for the ones that we disagree on
(i.e. not a score of 2 out of 3), we comment as to why we feel they
should, or should not, be accepted.  As this process is evolving, we
haven't really documented it, except here and in talks with others as we
travel.  We're working on making that more public over time.

Note, I do not know of any other CNA that does this in public as much as
we are already, we are pushing the boundry of what CNAs are doing pretty
hard here by putting almost all of our reviews in public _before_ a CVE
is assigned.  That's not normal, and hopefully we don't get told to stop
that (sshhh, don't tell anyone...)

> I believe exactly _this_ would be a much more valuable information in
> the CVE announcement than a copy&past of the changelog which on its own
> can be trially referenced by a link. Also if there is a peer review
> happening then Reviewed-by would be really nice. Not to mention
> Reported-by if this was externally reported (the report could be a part
> of the announcement as well).

We can't do a "Reported-by:" for CVEs as we aren't allowed to add
personal information like that to the records as per cve.org's rules.
And people want to word-smith the text all the time already, so we just
default to using the changelog text as that's the most "neutral" and
public information out there (i.e. we don't have to worry about any sort
of data-retention or classification laws as the information is already
public in kernel changelog text.)

Same for "reviewed-by:" we don't want to do that, as again, no personal
information can be added to cve records, but as we are putting our
reviews in a public repo, you can work backwards if you are curious from
there.

And again, others are sending us reviews as well, you can see them in
the repo already.  Hopefully more will do the same as time goes by, and
we have a steady stream of developers at various companies sending us
requests as well just through email and we handle them that way.

We do have one CVE right now that does want the text changed, and we are
working on making that possible (by accepting patches to the text) as
the changelog text was incorrect and called out an incorrect device as
being a problem when it was not.  But that's an outlier and we will
handle that on a case-by-case basis.

thanks,

greg k-h

