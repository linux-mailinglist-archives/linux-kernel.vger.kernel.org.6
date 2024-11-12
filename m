Return-Path: <linux-kernel+bounces-405191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49F59C4E17
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 06:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BA9AB236EE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 05:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D58208215;
	Tue, 12 Nov 2024 05:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Dx9SMsPv"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B4B61FD7;
	Tue, 12 Nov 2024 05:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731388730; cv=none; b=C/eb/eenrwu4OHQn9qA5HVh5LZng/zXObpWQoQ/oLoVrqi3NBFYsPL2Fm7qlsMAPy6EFd6Fx3/7t1Sqhqe4b8zmZrGowmfZpqpTNJY6MjP3+0weDeljN9vdSQzZjcRj2q5InU7F8JTrs9G6xOhJsNSDeocL+KYDBX8ZUf7OxubQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731388730; c=relaxed/simple;
	bh=VEM7Vv4Gy+cVuCgvX9hJ7azFAPZBLTKEPDqPxtkXXFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAiMfsc7xBZ4hu8SGfkFimH+ARnOWgJ1syRtkpkpnLe6SJ+BfxAHqqnR6JXboLdiLdsLrraN7toySBkcCekCPe2dwIBLJ8AqsRls9kMHxcW0ukU5Pj4XUfUSdq9so9vXYT8C/6VjWW7p/mgnPu+jLCcgvw7HyvnPIneHNyOdWhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Dx9SMsPv; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DC811512;
	Tue, 12 Nov 2024 06:18:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1731388713;
	bh=VEM7Vv4Gy+cVuCgvX9hJ7azFAPZBLTKEPDqPxtkXXFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dx9SMsPv/lQyPMyTNgpXW/NTR2o6UKdFswmvlpW42WM841tpnO4tl3yy1vaJMzsxM
	 5VgKQGuVNwnYxen4J76jG+vH1RCaXZCdasDt2MVu4Wdz77I25c35vwHKoo5oZ1WpOj
	 0i2/+Hj07YlebZLZvLTvUK+Z51RKZZrDrkjPEudg=
Date: Tue, 12 Nov 2024 07:18:36 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: gregkh@linuxfoundation.org, corbet@lwn.net, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Airlie <airlied@gmail.com>,
	DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] Documentation/CoC: spell out enforcement for
 unacceptable behaviors
Message-ID: <20241112051836.GF17916@pendragon.ideasonboard.com>
References: <20241108161853.12325-1-skhan@linuxfoundation.org>
 <ZzJkAJEjKidV8Fiz@phenom.ffwll.local>
 <ba3d5492-e774-452f-9fe0-e68b743c6b0d@linuxfoundation.org>
 <20241111223538.GD17916@pendragon.ideasonboard.com>
 <7d14de47-119a-42e4-a911-f8accae4abf1@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d14de47-119a-42e4-a911-f8accae4abf1@linuxfoundation.org>

On Mon, Nov 11, 2024 at 05:35:11PM -0700, Shuah Khan wrote:
> On 11/11/24 15:35, Laurent Pinchart wrote:
> > On Mon, Nov 11, 2024 at 02:50:45PM -0700, Shuah Khan wrote:
> >> On 11/11/24 13:07, Simona Vetter wrote:
> >>> On Fri, Nov 08, 2024 at 09:18:53AM -0700, Shuah Khan wrote:
> >>>> The Code of Conduct committee's goal first and foremost is to bring about
> >>>> change to ensure our community continues to foster respectful discussions.
> >>>>
> >>>> In the interest of transparency, the CoC enforcement policy is formalized
> >>>> for unacceptable behaviors.
> >>>>
> >>>> Update the Code of Conduct Interpretation document with the enforcement
> >>>> information.
> >>>>
> >>>> Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
> >>>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>>> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> >>>> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> >>>> Acked-by: Jonathan Corbet <corbet@lwn.net>
> >>>> Acked-by: Steven Rostedt <rostedt@goodmis.org>
> >>>> Acked-by: Dan Williams <dan.j.williams@intel.com>
> >>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> >>>
> >>> I think it's really good to document these details. The freedesktop coc
> >>> team is going through the same process, we've also done a talk at XDC
> >>> about all these changes, and I think this helps a lot in transparency and
> >>> accountability in practice. With that, some thoughts below.
> > 
> > I've been thinking about replying to this patch for a few days now. I
> > think I managed to sleep over it enough to make that possible.
> > 
> > I share Sima's opinion here. There is FUD around the CoC and its
> > enforcement process due to lack of transparency, so I believe
> > documenting the goals and means is important and will help.
> 
> Thank you for your feedback.
> 
> >> Thank you Simona for your review and feedback.
> >>
> >>>> ---
> >>>>    .../code-of-conduct-interpretation.rst        | 52 +++++++++++++++++++
> >>>>    1 file changed, 52 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/process/code-of-conduct-interpretation.rst b/Documentation/process/code-of-conduct-interpretation.rst
> >>>> index 66b07f14714c..21dd1cd871d2 100644
> >>>> --- a/Documentation/process/code-of-conduct-interpretation.rst
> >>>> +++ b/Documentation/process/code-of-conduct-interpretation.rst
> >>>> @@ -156,3 +156,55 @@ overridden decisions including complete and identifiable voting details.
> >>>>    Because how we interpret and enforce the Code of Conduct will evolve over
> >>>>    time, this document will be updated when necessary to reflect any
> >>>>    changes.
> >>>> +
> >>>> +Enforcement for Unacceptable Behavior Code of Conduct Violations
> >>>> +----------------------------------------------------------------
> >>>> +
> >>>> +The Code of Conduct committee works to ensure that our community continues
> >>>> +to be inclusive and fosters diverse discussions and viewpoints, and works
> >>>> +to improve those characteristics over time. The Code of Conduct committee
> >>>> +takes measures to restore productive and respectful collaboration when an
> >>>> +unacceptable behavior has negatively impacted that relationship.
> >>>> +
> >>>> +Seek public apology for the violation
> >>>> +*************************************
> >>>> +
> >>>> +The Code of Conduct Committee publicly calls out the behavior in the
> >>>> +setting in which the violation has taken place, seeking public apology
> >>>> +for the violation.
> >>>> +
> >>>> +A public apology for the violation is the first step towards rebuilding
> >>>> +the trust. Trust is essential for the continued success and health of the
> >>>> +community which operates on trust and respect.
> >>>
> >>> Personal take, but I think a forced public apology as the primary or at
> >>> least initial coc enforcement approach is one of the worst.
> >>
> >> Seeking public apology is in response to unacceptable behaviors which are
> >> serious in nature. These incidents are exceedingly rare. When these incidents
> >> happen, they usually resolve when another developer/community member points
> >> out the behavior. The individual responds with a voluntary apology to
> >> mend fences and repair harm.
> >>
> >> The CoC  gets involved only when it receives a report which is the case
> >> when normal paths such as peers pointing out the behavior to repair the
> >> harm haven't been successful.
> >>
> >> This document isn't intended to be a complete summary of all actions the
> >> CoC takes in response to reports. There is a lot of back and forth with
> >> the individuals to bring about change before the CoC asks for an apology.
> 
> See below clarification on above use of "actions"
> 
> >> The CoC seeks public apology only when it is essential to repair the harm.
> > 
> > Limiting the CoC committee to seeking public apology, due to what it
> > means in terms of both process and goal, would deprive the committee
> > from many useful courses of action. I was expecting you were not limited
> > to this, and I appreciate that you are stating it clearly here. It is
> > not however clear from this patch, and I believe it would benefit the
> > whole community if this was explained better in the document. A more
> > detailed description of the different means of action and outcomes would
> > help balance the fact that the proceedings of the CoC committe are not
> > public.
>
> The actions CoC takes prior asking for a public apology are working
> with the individual to bring about change in their understanding the
> importance to repair damage caused by the behavior.
> 
> Since these are measures to bring about change, the document doesn't
> go into the details about the logistics.

I think that's where it falls short. The private proceedings policy that
governs the CoC committee (I'm not interested here to debate whether
that is good or not, the question is out of scope) needs in my opinion
to be offset by more transparency in the procedures documentation to
avoid the "secret court" image that many attach to the CoC committee. I
do understand this is not a trivial exercise, as any policy documented
in writing can have a limiting impact on the actions the CoC committee
can take, but I believe that this patch, as it stands, gives a wrong and
possibly damaging impression of the committee's work.

> If you have other possible courses of action in mind, please do state
> them.
>   
> > I would like to add that I appreciate the emphasis on rebuilding trust
> > as a goal, as I also believe trust and respect are essential. This
> > includes trust that victims will receive the support and protection they
> > need, trust that authors of behaviour deemed unfit by the community will
> > be treated fairly, and trust that the community will continuously work
> > on improving inclusiveness. All three aspects are needed to avoid
> > driving current and prospective community members away.
> > 
> >>> First, a ban or temporary suspension seems too mechanical and not in
> >>> proportion with the offence of failing to apologize. In my enforcement
> >>> thus far as maintainer and now also freedesktop.org CoC member we only use
> >>> punishment if behavior has failed to change _and_ we need to protect the
> >>> community from further harm. Usually it takes years to get to that point,
> >>> unless in extremely severe cases (like public harrassment campaigns) or
> >>> when the person stated that they refuse to even consider changing behavior
> >>> at all.
> >>
> >> Please see above. Public apology is necessary to repair and restore the
> >> health of the community in these rare cases when an individual doesn't
> >> understand that their behavior could cause harm. The CoC tries to get
> >> the individual to realize that offering a public apology is necessary
> >> to repair the harm and resume respectful and productive discussions.
> >>
> >>> Public means you're amping up the stakes and massively increase the odds
> >>> of people being afraid of their reputation and losing face. In my
> >>> experience people are a lot more reasonable when you discuss their
> >>> behavior and what needs to change in private. This even includes the case
> >>> where a temporary suspension had to be put in place already first, to
> >>> protect others.
> >>
> >> Please see above. The CoC works with the individual prior to taking the step
> >> of asking for an apology. It is a balancing act between repairing
> >> the harm caused to the individuals at the receiving end of the public
> >> unacceptable behavior and working with the individual to understand the
> >> harm done by such a behavior.
> >>
> >> The CoC is mindful of the negative impact of seeking public apology and
> >> instituting ban could have on individuals.
> > 
> > It could also be worth adding that, as Sima pointed out below, public
> > apology is sometimes not the best option for the victim.
> 
> The CoC takes these into consideration during the investigation,
> before determining the best course of action.
> 
> Some people may
> > be afraid to report bad behaviours if they thought that the story would
> > be made public by a requirement to apologize publicly. I have total
> > confidence that the CoC committee will consult with the victim to
> > determine the best course of action, and that is worth documenting
> > explicitly.
> 
> Thank you for your confidence in the CoC.
> 
> Please note that the CoC has the obligation to keep the reports
> and individual information private. This public apology is specific
> to a public violation that has taken place on a public email list.
> The information and details are already public.
> 
> The CoC could receive reports from a community member who could be
> an observer and not the victim. The CoC has the responsibility to
> investigate all such public violations.
> 
> The CoC has the obligation to keep the reports privates. The public
> part is where the individual who violated the agreed upon Code of
> Conduct is asked to apologize to in response to the thread in which
> the violation has taken place.

-- 
Regards,

Laurent Pinchart

