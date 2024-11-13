Return-Path: <linux-kernel+bounces-407730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B62A9C71CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0371F214D6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0747C1F4FD4;
	Wed, 13 Nov 2024 13:59:55 +0000 (UTC)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727DA1F95E;
	Wed, 13 Nov 2024 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506394; cv=none; b=Q+QhYe78aG2RDPN10XV3T75vLNAPOJYrpGYzPx2rUX9NLrTaDPW7KyoTB61IoXvdX4TXOGlzjq0G5eA8/PKe4eq/ckzq+5vJcUdhBBcHxul08qDhUwFBZlkHu72eyiQc52UoK28Tx3Ct0lqROjVI9n1A+wBUwqTpxgU9yPOWpF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506394; c=relaxed/simple;
	bh=EQ4nVMInWjLVVvk7ZDimpUUnfo2RMlK6Z948pBnM2BI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZXUBEM0RZXQMPGP2uGBJTcVw/D6XIWBbSjo3U8txTZ8XYm2g5mcL8c1YHlRbxtBpVSOq/f3FPdWKVpGrwBHd9VHGDkHkCe6+xNDIVKXnpjAJtCFeWCQhGfjIOU//cbKKtYEkfuhXePCCdjnKArLQWbasB2juZ4sGUcf++px5C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e30d517c82fso6695227276.1;
        Wed, 13 Nov 2024 05:59:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731506391; x=1732111191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8Bi9gNLJSRkT6EmXrrthSS9+B4UxawvP0DH0yPwwpo=;
        b=CVACxMtjvMJ8fiZ/8JpeMsZO4tKeosXlN4ZCom35mq5KZhyouhMonFnzJKGvgG5Gi6
         Tz755YQLirunmBLYQx1ftWu3r6onz0UPUoEMJizno6PE8tGdTpq8ae8KgiC3Mgg2L9Rc
         giPKF1WVcRsoYY5r4B1a+bwrTeb7xWppR/8g0hIeHejeC6E0dPoPGYO5CfDF7DOoicU/
         lLfMn84Oa1WP7/5IvjqeXrlVmeg3PmX7u73SUmPRPU237+1TgBo+YLQM1JRGJLyO0CUC
         7OjlVKwdDQKJn8cpfZSROSf1YHI5aeb3lA7X27kPOzQYXBuhsTggxneF55+gbZnW/jco
         9n1w==
X-Forwarded-Encrypted: i=1; AJvYcCXM+TL+dCFVQgL6GRHVQjB7EcXPbrXw8SSkItWY2qaGJZOzvzgASw+3OyySWdfN7y0tE31Rvx7el0vpPvtG@vger.kernel.org, AJvYcCXl75i+DuBssovmFE8/reupURq05hoZ9rWc8r6y0vsLLivkB6srSoSnI5Vwmq87RCfMI3CEZ5TfWaA=@vger.kernel.org, AJvYcCXz5v4P1c3l1xM9RWAMnD1ZPr66mJLP903KqDU6CoGZU97TC/i8n6zCHm51HAjL7bCl4xOVIvA+4/vM@vger.kernel.org
X-Gm-Message-State: AOJu0YxCxuDCXDx7k+yVLdO10QZGTQBPKrqjkFionTuG//pP0MSTkbYv
	RiFQi+Lbg/m6zUvTIN8pVmRzmiTAWm9+afZvAUrS6MdBukG7X5xIRvUJwWJK
X-Google-Smtp-Source: AGHT+IGMLhmockcIPuGmsCRiGZ4Agz5Q3LdWi/ZvaHo8ORNVQbwUV+MiBnsSEC1EvkNs7ruW+o+jJg==
X-Received: by 2002:a05:6902:300b:b0:e25:d21b:715a with SMTP id 3f1490d57ef6-e35dc5e4bc6mr6278822276.36.1731506390613;
        Wed, 13 Nov 2024 05:59:50 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336f1ba728sm3291967276.42.2024.11.13.05.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 05:59:50 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e30cef4ac5dso6676070276.0;
        Wed, 13 Nov 2024 05:59:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUaVo7v641qHmB6PbuwSLIWHfVL+9A6El2OGpEQfOUboniuSj4eKONVQ+0/rxZz59hqak3Gt6L95zSDsCdO@vger.kernel.org, AJvYcCVRiJHY3P16GU5OFiy5Fm7gU0+1hIeVVz2uTlSYpoe1ow94rCQLcWboUglWHh1fMU73296+Vc8KYI0u@vger.kernel.org, AJvYcCXE51YJD8Q05Xlt6UX5ZPtQ1cXii5R0GrqriJnVa9sWahV15sDSytF49uJlNOMIvHw1JrHQQ/VkL3A=@vger.kernel.org
X-Received: by 2002:a05:690c:6ac3:b0:6e2:12e5:35a2 with SMTP id
 00721157ae682-6eca4643368mr67104007b3.4.1731506389814; Wed, 13 Nov 2024
 05:59:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f5bc0639a20d6fac68062466d5e3dd0519588d08.1731486825.git.linux@leemhuis.info>
 <20241113102619.GC29944@pendragon.ideasonboard.com> <b160f728-b34f-433d-8cc4-677605990936@leemhuis.info>
 <CAKMK7uGwK0OYu+cVJnUVd5nMZRG8jJBXJUuo0xFXdyrubJFW4g@mail.gmail.com>
 <20241113113650.GA31681@pendragon.ideasonboard.com> <20241113141112.10bde770@foz.lan>
In-Reply-To: <20241113141112.10bde770@foz.lan>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Nov 2024 14:59:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXKBfKhKdm-HvF8H4BPVH5k9n08YViuK8i9f5bmOj0v+g@mail.gmail.com>
Message-ID: <CAMuHMdXKBfKhKdm-HvF8H4BPVH5k9n08YViuK8i9f5bmOj0v+g@mail.gmail.com>
Subject: Re: [PATCH v1] docs: reminder to not expose potentially private email addresses
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Simona Vetter <simona.vetter@ffwll.ch>, Thorsten Leemhuis <linux@leemhuis.info>, 
	Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 2:20=E2=80=AFPM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
> Em Wed, 13 Nov 2024 13:36:50 +0200
> Laurent Pinchart <laurent.pinchart@ideasonboard.com> escreveu:
> > On Wed, Nov 13, 2024 at 11:59:39AM +0100, Simona Vetter wrote:
> > > On Wed, 13 Nov 2024 at 11:55, Thorsten Leemhuis <linux@leemhuis.info>=
 wrote:
> > > > On 13.11.24 11:26, Laurent Pinchart wrote:
> > > > > On Wed, Nov 13, 2024 at 09:35:03AM +0100, Thorsten Leemhuis wrote=
:
> > > > >> Remind developers to not expose private email addresses, as some=
 people
> > > > >> become upset if their addresses end up in the lore archives or t=
he Linux
> > > > >> git tree.
> > > > >>
> > > > >> While at it, explicitly mention the dangers of our bugzilla inst=
ance
> > > > >> here, as it makes it easy to forget that email addresses visible=
 there
> > > > >> are only shown to logged-in users.
> > > > >>
> > > > >> These are not a theoretical issues, as one maintainer mentioned =
that
> > > > >> his employer received a EU GDPR (general data protection regulat=
ion)
> > > > >> complaint after exposuring a email address used in bugzilla thro=
ugh a
> > > > >> tag in a patch description.
> > > > >>
> > > > >> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> > > > >> ---
> > > > >> Note: this triggers a few checkpatch.pl complaints that are irre=
levant
> > > > >> when when ti comes to changes like this.
> > > > >>
> > > > >> v1:
> > > > >> - initial version
> > > > >> ---
> > > > >>  Documentation/process/5.Posting.rst          | 17 +++++++++---
> > > > >>  Documentation/process/submitting-patches.rst | 27 +++++++++++++=
++++---
> > > > >>  2 files changed, 36 insertions(+), 8 deletions(-)
> > > > >>
> > > > >> diff --git a/Documentation/process/5.Posting.rst b/Documentation=
/process/5.Posting.rst
> > > > >> index b3eff03ea2491c..1f6942948db349 100644
> > > > >> --- a/Documentation/process/5.Posting.rst
> > > > >> +++ b/Documentation/process/5.Posting.rst
> > > > >> @@ -264,10 +264,19 @@ The tags in common use are:
> > > > >>   - Cc: the named person received a copy of the patch and had th=
e
> > > > >>     opportunity to comment on it.
> > > > >>
> > > > >> -Be careful in the addition of tags to your patches, as only Cc:=
 is appropriate
> > > > >> -for addition without the explicit permission of the person name=
d; using
> > > > >> -Reported-by: is fine most of the time as well, but ask for perm=
ission if
> > > > >> -the bug was reported in private.
> > > > >> +Note, remember to respect other people's privacy when adding th=
ese tags:
> > > > >> +
> > > > >> + - Only specify email addresses, if owners explicitly permitted=
 their use or
> > > > >> +   are fine with exposing them to the public based on previous =
actions found in
> > > > >> +   the lore archives. In practice you therefore often will be u=
nable to hastily
> > > > >> +   specify addresses for users of bug trackers, as those usuall=
y do expose the
> > > > >> +   email addresses at all or only to logged in users. The latte=
r is the case
> > > > >> +   for bugzilla.kernel.org, whose privacy policy explicitly sta=
tes that 'your
> > > > >> +   email address will never be displayed to logged out users'.
> > > > >> +
> > > > >> + - Only Cc: is appropriate for addition without the explicit pe=
rmission of the
> > > > >
> > > > > Isn't Cc: as problematic as any other tag, is it ends up in both =
the git
> > > > > history and the lore archive ?
> > > >
> > > > Hmmm. Good point, thx for bringing this up. And of course it is. Bu=
t
> > > > it's the second point in a list and thus should not overrule the fi=
rst
> > > > one. But I can see that it could be read like that. :-/ Up to some =
point
> > > > I even was aware of it, as the added "given the above constraints" =
later
> > > > in that point shows. But I guess I wanted to stay close to the prev=
ious
> > > > text and that is not sufficient.
> > > >
> > > > Hmmm. So how about writing the second point like this:
> > > >
> > > > """
> > > > Even if the email address is free to use in tags, it is only approp=
riate
> > > > to use in Cc: without explicit permission of the person named; usin=
g it
> > > > in Reported-by: likewise is often appropriate as well, but ask for
> > > > permission for bugs reported in private.
> > > > """
> > > >
> > > > Hope that "likewise" is sufficient here...
> > >
> > > I think these two points are fairly unrelated. The first is about
> > > using the email address, for privacy concerns. The second point is
> > > about adding the tag at all, which you're not allowed to do except fo=
r
> > > Cc: tags. Because forging reviewed/acked/tested-by tags is really not
> > > good. Putting the "no tag forgeries" rule under the privacy section i=
s
> > > I think what's confusing here.
> >
> > Reviewed-by, Acked-by, Tested-by or Signed-off-by clearly must never be
> > forged, and that's indeed unrelated to privacy. Separating the privacy
> > concerns and the no-forgery concerns sounds like it would make the
> > document clearer.
> >
> > It's not just tag forgery though. I can imagine that some people would
> > be fine with their e-mail address appearing in lore, but wouldn't when
> > to be listed in any tag in the git history.
>
> I can't imagine that. This is for sure an exceptional case, on which
> people should explicitly notify.
>
> > I try to ask permission
> > before adding a Reported-by or Co-developed-by tag, even if the person
> > has participated in public discussions on mailing lists.
>
> If someone reports a problem publicly, IMO the right thing to do is
> to just add a reported-by to credit who reported the issue, except
> if, while doing the report, someone explicitly asks not to do so.
> Personally, I never faced such case, though.

And nowadays scripts/checkpatch.pl will instruct you to add a
Closes:-tag too.  Perhaps it should recommend to double-check
if no public report is available?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

