Return-Path: <linux-kernel+bounces-411710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 350D79CFEAE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 12:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CBC1B2672F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 11:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5331922F9;
	Sat, 16 Nov 2024 11:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pakccu1+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA895372;
	Sat, 16 Nov 2024 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731757810; cv=none; b=WNafVx1rp6omIteQ0e1ZLsbXgBAUXQqXUfeqr/2SIFyMONkkhGEBUFqIPLUy82lRJ9AbyRz0/gIN45glKoV3s8qlrON1dQV2atZJyaSeZFM8OyaakjnhpIo2VIX5cIDbM2sq2SwXfI6pkxtPYt8w7xGTGZW5xA713n8/SlQhNF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731757810; c=relaxed/simple;
	bh=dP6CG9uq94TTrjRd6ucgv3kA63Z8FNi1KHL8K1mYr4o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okiZH0pDTpSSU9yhRaCeg3lzjMjcLch7pF6xnn4YG4R9TTAkt3YB6ZlR1hHzItjuclOhaIduYf8Y0vZj7r1L0RLTy8zsYSN2Hcm1w6gHy7tA3kd7XAUTY+IZw83CipnzL8n66TyPK/n9LpdinX70v8KJ0BUs2Nguu6IPNjkdIgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pakccu1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B6CC4CEC3;
	Sat, 16 Nov 2024 11:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731757809;
	bh=dP6CG9uq94TTrjRd6ucgv3kA63Z8FNi1KHL8K1mYr4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pakccu1+MNi2jBcKI+WuuyQyF4NneSkZnID71gTDi7FNmxqoXcTMa4YyXnKt6Kj48
	 uRUR/FYWTJKW9YG5xxW5wmlqwQBdmZl1PlSkDhtv1uMuOs5S4cV8II45lzaRWABxSZ
	 oKcHdwPPXqN8D8/oH6B5Qs+d1kBMJj38x9Hj+YClUCdvAREtVPnVfiptsyeDXa5xjK
	 NkL04lE/onOZfNeg8NZKSg6LbQ2Cg+MpHJW/I/4cDVHaOU80lWwb+Q/Og3Nqk5ZICA
	 8IsO2CCltw8spi9qbIHhAkfNyy6BBlrRnAazDAR3zuk8Op31Ih7nR/RdzFy+ZKUi70
	 RMi+S4jTi8Ucg==
Date: Sat, 16 Nov 2024 12:50:03 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thorsten Leemhuis <linux@leemhuis.info>, Jonathan Corbet
 <corbet@lwn.net>, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v2 2/2] docs: clarify rules wrt tagging other people
Message-ID: <20241116125003.43bf305c@foz.lan>
In-Reply-To: <2024111651-slather-blabber-857f@gregkh>
References: <cover.1731749544.git.linux@leemhuis.info>
	<b7dce8b22a391c2f8f0d5a47bf23bc852eca4e71.1731749544.git.linux@leemhuis.info>
	<2024111651-slather-blabber-857f@gregkh>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Sat, 16 Nov 2024 11:42:06 +0100
Greg KH <gregkh@linuxfoundation.org> escreveu:

> On Sat, Nov 16, 2024 at 10:33:59AM +0100, Thorsten Leemhuis wrote:
> > Point out that explicit permission is usually needed to tag other people
> > in changes, but mention that implicit permission can be sufficient in
> > certain cases. This fixes slight inconsistencies between Reported-by:
> > and Suggested-by: and makes the usage more intuitive.
> > 
> > While at it, explicitly mention the dangers of our bugzilla instance, as
> > it makes it easy to forget that email addresses visible there are only
> > shown to logged-in users.
> > 
> > The latter is not a theoretical issue, as one maintainer mentioned that
> > his employer received a EU GDPR (general data protection regulation)
> > complaint after exposing a email address used in bugzilla through a tag
> > in a patch description.
> > 
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Simona Vetter <simona.vetter@ffwll.ch>
> > Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> > ---
> > Note: this triggers a few checkpatch.pl complaints that are irrelevant
> > when when to comes to changes like this.
> > 
> > v2:
> > - Retry differently. This slightly hardens the rule for Reported-by:
> >   while slightly lessening it for Suggested-by:. Those in the end are
> >   quite similar, so it does not make much sense to apply different ones.
> >   I considered using an approach along the lines of "if you reported it
> >   in pubic by mail, implicit permission to use in a tag is granted"; but
> >   I abstained from it, as I assume there are good reasons for the
> >   existing approach regarding Suggested-by:.
> > - CC all the people that provided feedback on the text changes in v1
> > 
> > v1: https://lore.kernel.org/all/f5bc0639a20d6fac68062466d5e3dd0519588d08.1731486825.git.linux@leemhuis.info/
> > - initial version
> > ---
> >  Documentation/process/5.Posting.rst          | 17 ++++++--
> >  Documentation/process/submitting-patches.rst | 44 ++++++++++++++------
> >  2 files changed, 45 insertions(+), 16 deletions(-)
> > 
> > diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
> > index dbb763a8de901d..b45c4f6d65ca95 100644
> > --- a/Documentation/process/5.Posting.rst
> > +++ b/Documentation/process/5.Posting.rst
> > @@ -268,10 +268,19 @@ The tags in common use are:
> >   - Cc: the named person received a copy of the patch and had the
> >     opportunity to comment on it.
> >  
> > -Be careful in the addition of tags to your patches, as only Cc: is appropriate
> > -for addition without the explicit permission of the person named; using
> > -Reported-by: is fine most of the time as well, but ask for permission if
> > -the bug was reported in private.
> > +Be careful in the addition of tags to your patches, as nearly all of them need
> > +explicit permission of the person named.
> > +
> > +The only exceptions are Cc:, Reported-by:, and Suggested-by:, as for them  
> 
> I don't understand what you mean by "only exceptions" here.  Exceptions
> to what?
> 
> > +implicit permission is sufficient under the following circumstances: when the
> > +person named according to the lore archives or the commit history regularly
> > +contributes to the Linux kernel using that name and email address -- 

Note that get_maintainer.pl doesn't use a concept of "regularly", and it
doesn't really matter if one has just one or dozens of patches, once it 
has a patch merged with his address, it is now public, as git log will
keep it forever.

Also, if a patch authored by "John Doe <john@doe>" causes a regression, 
a patch fixing the regression should be Cc: to him, even it it was his
first contribution.

So, having a single patch accepted is enough to have other patches
with meta-tag pointing to a name/email.

So, this would be better:

	... or the git commit history contains that name and email address

> > and in
> > +case of Reported-by: and Suggested-by: did the reporting or suggestion in
> > +public. For all other situations explicit permission is required to among
> > +others prevent exposing email addresses considered private. Especially ask for
> > +permission when it comes to bug trackers, as most only show addresses to logged
> > +in users; that includes bugzilla.kernel.org, whose privacy policy explicitly
> > +states that 'your email address will never be displayed to logged out users'.
> 
> How about makeing this much simpler, basically "any public reference can
> be used, but please note, email addresses in bugzilla.kernel.org are not
> public.  Anything offered in private should probably not be referenced."

This works too.

> or something like that?
> 
> thanks,
> 
> greg k-h
> 



Thanks,
Mauro

