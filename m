Return-Path: <linux-kernel+bounces-406472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D03A9C5F78
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0A81F22460
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFD02144CC;
	Tue, 12 Nov 2024 17:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Wf6PSpPg"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9144212F05;
	Tue, 12 Nov 2024 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731433772; cv=none; b=ae8TAf7nzNt7TPAXnE7TYnXp2o8pMEhjviZsEfbI/V0aXGNJxk2WiwXR6+Llut24uqHuC6NVmgEvca2KyS8M3DOUia8B+YOor8lNiU7Miz+5kA0kch/ndrPSIudlaDNYBX5hoNvEujFRwkasGdhaSYttnjRRxBNYFkSkZ3fiOHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731433772; c=relaxed/simple;
	bh=c1v17xoFfsCerNNjyrz6CSJxETYPE5z1Uz4Gqvbilig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoRlYVtT1rwQyo2gQnSbfmG0JuH4hYyrPkT4h1U79ETMCOrD8kc09iblAeYey4gnTVcVDoZVuAp2wShM2pw7dtcrPoKFKxmBiaqwTixge9sxAoxDGVVodH3mHGh+BlcO4nbuz8EviXptt1BymzQtbTxhxo5RY6EjLlcD7L8YJAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Wf6PSpPg; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 77252710;
	Tue, 12 Nov 2024 18:49:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1731433750;
	bh=c1v17xoFfsCerNNjyrz6CSJxETYPE5z1Uz4Gqvbilig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wf6PSpPgqTAzDQNQcMPSOV3o4/3GGt4UjA9e3DMNxpgaLQ+Zurp12bU0TfsN4IwhJ
	 ZlJuyeL7bTStOrwcC5MhItCasBQSxQkkO3grLYBzFzB0QRwHYBb/iPncgVLqotja8o
	 /2MM5+GGyB2QhRD8cq5gs5/DCsPHicr0wlczS99c=
Date: Tue, 12 Nov 2024 19:49:15 +0200
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
Message-ID: <20241112174915.GB806@pendragon.ideasonboard.com>
References: <20241108161853.12325-1-skhan@linuxfoundation.org>
 <ZzJkAJEjKidV8Fiz@phenom.ffwll.local>
 <ba3d5492-e774-452f-9fe0-e68b743c6b0d@linuxfoundation.org>
 <20241111223538.GD17916@pendragon.ideasonboard.com>
 <7d14de47-119a-42e4-a911-f8accae4abf1@linuxfoundation.org>
 <20241112051836.GF17916@pendragon.ideasonboard.com>
 <ec850949-7987-41ec-ba1f-a0c90b465661@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec850949-7987-41ec-ba1f-a0c90b465661@linuxfoundation.org>

On Tue, Nov 12, 2024 at 10:44:29AM -0700, Shuah Khan wrote:
> On 11/11/24 22:18, Laurent Pinchart wrote:
> > On Mon, Nov 11, 2024 at 05:35:11PM -0700, Shuah Khan wrote:
> >> On 11/11/24 15:35, Laurent Pinchart wrote:
> >>> On Mon, Nov 11, 2024 at 02:50:45PM -0700, Shuah Khan wrote:
> >>>> On 11/11/24 13:07, Simona Vetter wrote:
> >>>>> On Fri, Nov 08, 2024 at 09:18:53AM -0700, Shuah Khan wrote:
> >>>>>> The Code of Conduct committee's goal first and foremost is to bring about
> >>>>>> change to ensure our community continues to foster respectful discussions.
> >>>>>>
> >>>>>> In the interest of transparency, the CoC enforcement policy is formalized
> >>>>>> for unacceptable behaviors.
> >>>>>>
> >>>>>> Update the Code of Conduct Interpretation document with the enforcement
> >>>>>> information.
> >>>>>>
> >>>>>> Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
> >>>>>> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>>>>> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> >>>>>> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> >>>>>> Acked-by: Jonathan Corbet <corbet@lwn.net>
> >>>>>> Acked-by: Steven Rostedt <rostedt@goodmis.org>
> >>>>>> Acked-by: Dan Williams <dan.j.williams@intel.com>
> >>>>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> >>>>>
> >>>>> I think it's really good to document these details. The freedesktop coc
> >>>>> team is going through the same process, we've also done a talk at XDC
> >>>>> about all these changes, and I think this helps a lot in transparency and
> >>>>> accountability in practice. With that, some thoughts below.
> >>>
> >>> I've been thinking about replying to this patch for a few days now. I
> >>> think I managed to sleep over it enough to make that possible.
> >>>
> >>> I share Sima's opinion here. There is FUD around the CoC and its
> >>> enforcement process due to lack of transparency, so I believe
> >>> documenting the goals and means is important and will help.
> >>
> >> Thank you for your feedback.
> >>
> >>>> Thank you Simona for your review and feedback.
> >>>>
> >>>>>> ---
> >>>>>>     .../code-of-conduct-interpretation.rst        | 52 +++++++++++++++++++
> >>>>>>     1 file changed, 52 insertions(+)
> >>>>>>
> >>>>>> diff --git a/Documentation/process/code-of-conduct-interpretation.rst b/Documentation/process/code-of-conduct-interpretation.rst
> >>>>>> index 66b07f14714c..21dd1cd871d2 100644
> >>>>>> --- a/Documentation/process/code-of-conduct-interpretation.rst
> >>>>>> +++ b/Documentation/process/code-of-conduct-interpretation.rst
> >>>>>> @@ -156,3 +156,55 @@ overridden decisions including complete and identifiable voting details.
> >>>>>>     Because how we interpret and enforce the Code of Conduct will evolve over
> >>>>>>     time, this document will be updated when necessary to reflect any
> >>>>>>     changes.
> >>>>>> +
> >>>>>> +Enforcement for Unacceptable Behavior Code of Conduct Violations
> >>>>>> +----------------------------------------------------------------
> >>>>>> +
> >>>>>> +The Code of Conduct committee works to ensure that our community continues
> >>>>>> +to be inclusive and fosters diverse discussions and viewpoints, and works
> >>>>>> +to improve those characteristics over time. The Code of Conduct committee
> >>>>>> +takes measures to restore productive and respectful collaboration when an
> >>>>>> +unacceptable behavior has negatively impacted that relationship.
> >>>>>> +
> >>>>>> +Seek public apology for the violation
> >>>>>> +*************************************
> >>>>>> +
> >>>>>> +The Code of Conduct Committee publicly calls out the behavior in the
> >>>>>> +setting in which the violation has taken place, seeking public apology
> >>>>>> +for the violation.
> >>>>>> +
> >>>>>> +A public apology for the violation is the first step towards rebuilding
> >>>>>> +the trust. Trust is essential for the continued success and health of the
> >>>>>> +community which operates on trust and respect.
> >>>>>
> >>>>> Personal take, but I think a forced public apology as the primary or at
> >>>>> least initial coc enforcement approach is one of the worst.
> >>>>
> >>>> Seeking public apology is in response to unacceptable behaviors which are
> >>>> serious in nature. These incidents are exceedingly rare. When these incidents
> >>>> happen, they usually resolve when another developer/community member points
> >>>> out the behavior. The individual responds with a voluntary apology to
> >>>> mend fences and repair harm.
> >>>>
> >>>> The CoC  gets involved only when it receives a report which is the case
> >>>> when normal paths such as peers pointing out the behavior to repair the
> >>>> harm haven't been successful.
> >>>>
> >>>> This document isn't intended to be a complete summary of all actions the
> >>>> CoC takes in response to reports. There is a lot of back and forth with
> >>>> the individuals to bring about change before the CoC asks for an apology.
> >>
> >> See below clarification on above use of "actions"
> >>
> >>>> The CoC seeks public apology only when it is essential to repair the harm.
> >>>
> >>> Limiting the CoC committee to seeking public apology, due to what it
> >>> means in terms of both process and goal, would deprive the committee
> >>> from many useful courses of action. I was expecting you were not limited
> >>> to this, and I appreciate that you are stating it clearly here. It is
> >>> not however clear from this patch, and I believe it would benefit the
> >>> whole community if this was explained better in the document. A more
> >>> detailed description of the different means of action and outcomes would
> >>> help balance the fact that the proceedings of the CoC committe are not
> >>> public.
> >>
> >> The actions CoC takes prior asking for a public apology are working
> >> with the individual to bring about change in their understanding the
> >> importance to repair damage caused by the behavior.
> >>
> >> Since these are measures to bring about change, the document doesn't
> >> go into the details about the logistics.
> > 
> > I think that's where it falls short. The private proceedings policy that
> > governs the CoC committee (I'm not interested here to debate whether
> > that is good or not, the question is out of scope) needs in my opinion
> > to be offset by more transparency in the procedures documentation to
> > avoid the "secret court" image that many attach to the CoC committee. I
> > do understand this is not a trivial exercise, as any policy documented
> > in writing can have a limiting impact on the actions the CoC committee
> > can take, but I believe that this patch, as it stands, gives a wrong and
> > possibly damaging impression of the committee's work.
> 
> Thank you Laurent.
> 
> Bulk of the Code of Conduct Committee work involves listening, talking,
> and discussing the best outcomes for all involved parties.
> 
> I will add more content to the document distilling the discussion on
> this thread in the interest of transparency.

Thank you, much appreciated. I think that will be very helpful to
maximize trust in the process and in the pleasureless but important work
the committee is doing.

-- 
Regards,

Laurent Pinchart

