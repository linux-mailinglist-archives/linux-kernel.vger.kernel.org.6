Return-Path: <linux-kernel+bounces-411750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5FF9CFF28
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 14:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DD961F21482
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 13:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865C71990A2;
	Sat, 16 Nov 2024 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEnk3WvF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB388161;
	Sat, 16 Nov 2024 13:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731763006; cv=none; b=bp1++7NLxAJV5V0N+XQAIhJUdO1GwuGOZ+sD8xL9syD2yyqHO5v1Y1zAfD61ZTp/c+2x3gHP5trRWiXaq2sa6hqG85V+uepkufymFqx5k8mudUT2aI5anq9/eTk7GekCWgP2xPBQyPAm8zh0om/OM7zM5G7Dt5bFoWp6lLX0GCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731763006; c=relaxed/simple;
	bh=XNgAawX6XLOa4/demc/OpYXjlzmHxNtnjOdaMjMRKCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AsT7XT7cXvQcD1rtX7e9YCQnvfqgycanyRthauADv5RYyGTXZ6UGcLH7cmtBZ/KRMc56OA67u25GevzXu+0KOmHzS+hOC/dAyBOXVTA418BZNWytOq48X9CUffFE77gMJjiTBmRii98VSSvGdd7l4LzjgfaaSaLxVSJVXTfmGpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEnk3WvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D78C4CEC3;
	Sat, 16 Nov 2024 13:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731763006;
	bh=XNgAawX6XLOa4/demc/OpYXjlzmHxNtnjOdaMjMRKCM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UEnk3WvFJhwIzB5jN/zko4f6MTzOl0oeR+O281JOQE/TRtTGnrtf43PAjTSygnRnZ
	 Gsx2vsi5s+vwy0EUpMEhomzM3oWohQpLU5BlAKJ2DC+g+Pb76yNiHbcJrg5JP1KDek
	 KLwA/Pmrz9UN/KMSIOEu3+8jrBbgPtNesauRe/aPcSX+BtLikw/bYL4N6aHe0q+Ygt
	 yOWJH0Hs3dUGYo01JQlT6+wWiEQW6xN07167UNstQII7NT+8cbfP5eue9ya4famEEc
	 6QmsOYjR1WhSPydvpGp57CDU8HPgXwdfCC0EcuX/VeFbRVJzPZqV7SUaC+0doU/M0t
	 bJUJBUqBJ2D0A==
Date: Sat, 16 Nov 2024 14:16:39 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v2 2/2] docs: clarify rules wrt tagging other people
Message-ID: <20241116141639.5adb4a95@foz.lan>
In-Reply-To: <7491b60c-3e46-4425-aef5-63021538c33d@leemhuis.info>
References: <cover.1731749544.git.linux@leemhuis.info>
	<b7dce8b22a391c2f8f0d5a47bf23bc852eca4e71.1731749544.git.linux@leemhuis.info>
	<2024111651-slather-blabber-857f@gregkh>
	<20241116125003.43bf305c@foz.lan>
	<7491b60c-3e46-4425-aef5-63021538c33d@leemhuis.info>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Sat, 16 Nov 2024 13:27:44 +0100
Thorsten Leemhuis <linux@leemhuis.info> escreveu:

> On 16.11.24 12:50, Mauro Carvalho Chehab wrote:
> > Em Sat, 16 Nov 2024 11:42:06 +0100
> > Greg KH <gregkh@linuxfoundation.org> escreveu:  
> >> On Sat, Nov 16, 2024 at 10:33:59AM +0100, Thorsten Leemhuis wrote:  
> >>> Point out that explicit permission is usually needed to tag other people
> >>> in changes, but mention that implicit permission can be sufficient in
> >>> certain cases. This fixes slight inconsistencies between Reported-by:
> >>> and Suggested-by: and makes the usage more intuitive.
> >>>
> >>> While at it, explicitly mention the dangers of our bugzilla instance, as
> >>> it makes it easy to forget that email addresses visible there are only
> >>> shown to logged-in users.
> >>>
> >>> The latter is not a theoretical issue, as one maintainer mentioned that
> >>> his employer received a EU GDPR (general data protection regulation)
> >>> complaint after exposing a email address used in bugzilla through a tag
> >>> in a patch description.
> >>>
> >>> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>> Cc: Simona Vetter <simona.vetter@ffwll.ch>
> >>> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >>> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> >>> ---
> >>> Note: this triggers a few checkpatch.pl complaints that are irrelevant
> >>> when when to comes to changes like this.
> >>>
> >>> v2:
> >>> - Retry differently. This slightly hardens the rule for Reported-by:
> >>>   while slightly lessening it for Suggested-by:. Those in the end are
> >>>   quite similar, so it does not make much sense to apply different ones.
> >>>   I considered using an approach along the lines of "if you reported it
> >>>   in pubic by mail, implicit permission to use in a tag is granted"; but
> >>>   I abstained from it, as I assume there are good reasons for the
> >>>   existing approach regarding Suggested-by:.
> >>> - CC all the people that provided feedback on the text changes in v1
> >>>
> >>> v1: https://lore.kernel.org/all/f5bc0639a20d6fac68062466d5e3dd0519588d08.1731486825.git.linux@leemhuis.info/
> >>> - initial version
> >>> ---
> >>>  Documentation/process/5.Posting.rst          | 17 ++++++--
> >>>  Documentation/process/submitting-patches.rst | 44 ++++++++++++++------
> >>>  2 files changed, 45 insertions(+), 16 deletions(-)
> >>>
> >>> diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
> >>> index dbb763a8de901d..b45c4f6d65ca95 100644
> >>> --- a/Documentation/process/5.Posting.rst
> >>> +++ b/Documentation/process/5.Posting.rst
> >>> @@ -268,10 +268,19 @@ The tags in common use are:
> >>>   - Cc: the named person received a copy of the patch and had the
> >>>     opportunity to comment on it.
> >>>  
> >>> -Be careful in the addition of tags to your patches, as only Cc: is appropriate
> >>> -for addition without the explicit permission of the person named; using
> >>> -Reported-by: is fine most of the time as well, but ask for permission if
> >>> -the bug was reported in private.
> >>> +Be careful in the addition of tags to your patches, as nearly all of them need
> >>> +explicit permission of the person named.
> >>> +
> >>> +The only exceptions are Cc:, Reported-by:, and Suggested-by:, as for them    
> >>
> >> I don't understand what you mean by "only exceptions" here.  Exceptions
> >> to what?
> >>  
> >>> +implicit permission is sufficient under the following circumstances: when the
> >>> +person named according to the lore archives or the commit history regularly
> >>> +contributes to the Linux kernel using that name and email address --   
> > 
> > Note that get_maintainer.pl doesn't use a concept of "regularly", and it
> > doesn't really matter if one has just one or dozens of patches, once it 
> > has a patch merged with his address, it is now public, as git log will
> > keep it forever.
> > 
> > Also, if a patch authored by "John Doe <john@doe>" causes a regression, 
> > a patch fixing the regression should be Cc: to him, even it it was his
> > first contribution.
> > 
> > So, having a single patch accepted is enough to have other patches
> > with meta-tag pointing to a name/email.
> > 
> > So, this would be better:
> > 
> > 	... or the git commit history contains that name and email address  
> 
> Good point. But we are getting closer and closer to areas where I feel
> out of my league as IANAL without any backing from company lawyers if
> this leads to problems down the road.
> 
> To still feel comfortable, I would change this to something like:
> """
> ... or a commit with a 'Signed-off-by' tag containing that name and
> email address.
> """

You should also cover commit authorship, as SOB e-mail might be
different. Currently, -next catches it as warnings, but still
there are cases where maintainer might opt to keep as is, for
instance when the SOB has name+company@e.mail and the author
may have just name@e.mail - or vice-versa.

What about:

"""
commit with a 'Signed-off-by' tag or patch(es) authored or committed by 
that name and email address.
"""

> Because one accidental expose of a name and email address (say in a CC:
> tag) by a some other developer should not be enough to allow other
> developers to expose it again. Highly unlikely corner case, yes, but I
> feel better that way. And in the end it should not make much of a
> difference.

IANAL either, but, once someone else exposes a secret publicly, it is
not a secret anymore. You can't be blamed to mention a previously
"secret email" that was now public.

> 
> Ciao, Thorsten
> 



Thanks,
Mauro

