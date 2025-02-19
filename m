Return-Path: <linux-kernel+bounces-521847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7555BA3C328
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F56C3AA03B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121AF1F4160;
	Wed, 19 Feb 2025 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="HNz74Uzy"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E311F417E;
	Wed, 19 Feb 2025 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739977573; cv=none; b=os0D4qxaw6yquRWigf0yVlB88rBbul86/YWa8Jv7aXD2VY1LuQqgB6t0bLtvEyigNjjTHmLUXHexF2zZEnlPfIwDu49sMk+Qymp/HYIog+RC1ocXqLlWHbadGUG6JymuqUzSBrfmWUTyQT/4ke6upl1y5P9yMcTGBOqYAVM+sjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739977573; c=relaxed/simple;
	bh=tIxf2kJ2DG7gfisurkYdaFjSbgVpZ/DLEHxNk3gVMlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHzeVB1spOltKHA+tN/CB71XLKIFfMIyEWkUzeQ6YvHFM4XenfDMg1vqyXpbbICD9DriLwi5fjfovbNV1rWEl88/+s8W+FcW+ws8elEFsa6gxxfUrC/SzCpby3U/V7lkcQ9OJn3KgH5sKyEHxkAvt9nkirkppnbHwBOoP2Qdgdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=HNz74Uzy; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9AF8F169;
	Wed, 19 Feb 2025 16:04:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1739977486;
	bh=tIxf2kJ2DG7gfisurkYdaFjSbgVpZ/DLEHxNk3gVMlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HNz74Uzy/VJyMGqyVU0Nk9FpWHneFQB0fd33CfjnvFpWXk6UMP05dAQ0PPD3Y0QP3
	 LR34ZO1NHrtSN2T4a0o86H5/2nI1sPbz3PujXu7KOLX0iVQ6xOhboVYMVumxhWMkjb
	 pX+Ts5a9M24ej97lpllzij/9/OjfuKU95ZqBRkOg=
Date: Wed, 19 Feb 2025 17:05:53 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <20250219150553.GD15114@pendragon.ideasonboard.com>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
 <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025021954-flaccid-pucker-f7d9@gregkh>

On Wed, Feb 19, 2025 at 06:39:10AM +0100, Greg KH wrote:
> On Tue, Feb 18, 2025 at 07:04:59PM -0800, Boqun Feng wrote:
> > On Tue, Feb 18, 2025 at 04:58:27PM -0800, H. Peter Anvin wrote:
> > [...]
> > > > > David Howells did a patch set in 2018 (I believe) to clean up
> > > > > the C code in the kernel so it could be compiled with either C
> > > > > or C++; the patchset wasn't particularly big and mostly
> > > > > mechanical in nature, something that would be impossible with
> > > > > Rust. Even without moving away from the common subset of C and
> > > > > C++ we would immediately gain things like type safe linkage.
> > > > 
> > > > That is great, but that does not give you memory safety and everyone
> > > > would still need to learn C++.
> > > 
> > > The point is that C++ is a superset of C, and we would use a subset of C++
> > > that is more "C+"-style. That is, most changes would occur in header files,
> > > especially early on. Since the kernel uses a *lot* of inlines and macros,
> > > the improvements would still affect most of the *existing* kernel code,
> > > something you simply can't do with Rust.
> > > 
> > 
> > I don't think that's the point of introducing a new language, the
> > problem we are trying to resolve is when writing a driver or some kernel
> > component, due to the complexity, memory safety issues (and other
> > issues) are likely to happen. So using a language providing type safety
> > can help that. Replacing inlines and macros with neat template tricks is
> > not the point, at least from what I can tell, inlines and macros are not
> > the main source of bugs (or are they any source of bugs in production?).
> > Maybe you have an example?
> 
> As someone who has seen almost EVERY kernel bugfix and security issue
> for the past 15+ years (well hopefully all of them end up in the stable
> trees, we do miss some at times when maintainers/developers forget to
> mark them as bugfixes), and who sees EVERY kernel CVE issued, I think I
> can speak on this topic.
> 
> The majority of bugs (quantity, not quality/severity) we have are due to
> the stupid little corner cases in C that are totally gone in Rust.
> Things like simple overwrites of memory (not that rust can catch all of
> these by far), error path cleanups, forgetting to check error values,
> and use-after-free mistakes.  That's why I'm wanting to see Rust get
> into the kernel, these types of issues just go away, allowing developers
> and maintainers more time to focus on the REAL bugs that happen (i.e.
> logic issues, race conditions, etc.)
> 
> I'm all for moving our C codebase toward making these types of problems
> impossible to hit, the work that Kees and Gustavo and others are doing
> here is wonderful and totally needed, we have 30 million lines of C code
> that isn't going anywhere any year soon.  That's a worthy effort and is
> not going to stop and should not stop no matter what.

I'd say it should accelerate. Ironically, I think it's also affected by
the same maintainer burn out issue that is hindering adoption of rust.
When time is limited, short term urgencies are very often prioritized
over long term improvements.

As a maintainer of some code in the kernel, I sometimes find it very
hard to strike the right balance of yak shaving. Some of it is needed
given the large scale of the project and the contributors/maintainers
ratio, but tolerance to yak shaving isn't high. It varies drastically
depending on the contributors (both individuals and companies), and I've
recently felt in my small area of the kernel that some very large
companies fare significantly worse than smaller ones.

(More on this below)

> But for new code / drivers, writing them in rust where these types of
> bugs just can't happen (or happen much much less) is a win for all of
> us, why wouldn't we do this?  C++ isn't going to give us any of that any
> decade soon, and the C++ language committee issues seem to be pointing
> out that everyone better be abandoning that language as soon as possible
> if they wish to have any codebase that can be maintained for any length
> of time.
> 
> Rust also gives us the ability to define our in-kernel apis in ways that
> make them almost impossible to get wrong when using them.  We have way
> too many difficult/tricky apis that require way too much maintainer
> review just to "ensure that you got this right" that is a combination of
> both how our apis have evolved over the years (how many different ways
> can you use a 'struct cdev' in a safe way?) and how C doesn't allow us
> to express apis in a way that makes them easier/safer to use.  Forcing
> us maintainers of these apis to rethink them is a GOOD thing, as it is
> causing us to clean them up for EVERYONE, C users included already,
> making Linux better overall.
> 
> And yes, the Rust bindings look like magic to me in places, someone with
> very little Rust experience, but I'm willing to learn and work with the
> developers who have stepped up to help out here.  To not want to learn
> and change based on new evidence (see my point about reading every
> kernel bug we have.)
> 
> Rust isn't a "silver bullet" that will solve all of our problems, but it
> sure will help in a huge number of places, so for new stuff going
> forward, why wouldn't we want that?
> 
> Linux is a tool that everyone else uses to solve their problems, and
> here we have developers that are saying "hey, our problem is that we
> want to write code for our hardware that just can't have all of these
> types of bugs automatically".
> 
> Why would we ignore that?
> 
> Yes, I understand our overworked maintainer problem (being one of these
> people myself), but here we have people actually doing the work!

This got me thinking, this time with thoughts that are taking shape.
Let's see if they make sense for anyone else.

First, a summary of where we stand, in the particular area I'd like to
discuss. Hopefully the next paragraph won't be controversial (but who
knows, I may have an unclear or biased view).

Maintainability, and maintainer burn out, are high in the lirst of the
many arguments I've heard against rust in the kernel. Nobody really
disputes the fact that we have a shortage of maintainers compared to the
amount of contributions we receive. I have seen this argument being
flipped by many proponents of rust in the kernel: with rust making some
classes of bugs disappear, maintainers will have more time to focus on
other issue (as written above by Greg himself). Everybody seems to agree
that there will be an increased workload for maintainers in a transition
period as they would need to learn a new language, but that increased
workload would not be too significant as maintainers would be assisted
by rust developers who will create (and to some extent maintain) rust
bindings to kernel APIs. The promise of greener pastures is that
everybody will be better off once the transition is over, including
maintainers.

In my experience, chasing bugs is neither the hardest nor the most
mental energy consuming part of the technical maintenance [*]. What I
find difficult is designing strong and stable foundations (either in
individual drivers, or in subsystems as a whole) to build a maintainable
code base on top. What I find even more horrendous is fixing all the
mistakes we've made in this regard. As Greg also mentioned above, many
of our in-kernel APIs were designed at a time when we didn't know better
(remember device handling before the rewrite of the device/driver model
? I was fortunately too inexperienced back then to understand how
horrible things were, which allowed me to escape PTSD), and the amount
of constraints that the C language allows compilers to enforce at
compile time is very limited. I believe the former is a worse problem
than the latter at this time: for lots of the in-kernel APIs,
compile-time constraints enforcement to prevent misuse doesn't matter,
because those APIs don't provide *any* way to be used safely. Looking at
the two subsystems I know the best, V4L2 and DRM, handling the life time
of objects safely in drivers isn't just hard, it's often plain
impossible. I'd be surprised if I happened to have picked as my two
main subsystems the only ones that suffer from this, so I expect this
kind of issue to be quite widespread.

History is history, I'm not blaming anyone here. There are mistakes we
just wouldn't repeat the same way today. We have over the years tried to
improve in-kernel APIs to fix this kind of issues. It's been painful
work, which sometimes introduced more (or just different) problems than
it fixed, again because we didn't know better (devm_kzalloc is *still*
very wrong in the majority of cases). One of the promises of rust for
the kernel is that it will help in this very precise area, thanks to its
stronger philosophy of focussing efforts on interface design. As Greg
mentioned above, it will also lead to improvements for the C users of
the APIs. As part of their work on creating those rust bindings, rust
for Linux developers and maintainers improving the situation for
everybody. This is great. On paper.

In reality, in order to provide API that are possible to use correctly,
we have many areas deep in kernel code that will require a complete
redesign (similar in effort to the introduction of the device model),
affecting all the drivers using them. I understand that the development
of rust bindings has already helped improving some in-kernel C APIs, but
I have only seen such improvements of a relatively small scale compared
to what would be needed to fix life time management of objects in V4L2.
I would be very surprised if I was working in the only area in the
kernel that is considered broken beyond repair by many people related to
life time management, so I think this kind of maintainer nightmare is
not an isolated case.

The theory is that rust bindings would come with C API improvements and
fixes. However, when I expressed the fact that rust bindings for V4L2
would first require a complete rewrite of object life time management in
the subsystem, I was told this was way too much yak shaving. As a
maintainer facing the horrendous prospect of fixing this one day, I just
can't agree to rust bindings being built on top of such a bad
foundation, as it would very significantly increase the amount of work
needed to fix the problem.

If we want real maintainer buy-in for rust in the kernel, I believe this
is the kind of problem space we should start looking into. Helping
maintainers solve these issues will help decreasing their work load and
stress level significantly in the long term, regardless of other
benefits rust as a language may provide. I believe that cooperation
between the C and rust camps on such issues would really improve mutual
understanding, and ultimately create a lot of trust that seems to be
missing. If someone were to be interested in rust bindings for V4L2 and
willing to put significant time and effort in fixing the underlying
issue, I would be very happy to welcome them, and willing to learn
enough rust to review the rust API.


[*] I'm leaving out here community building, which is the other
important part of a maintainer's work, and also requires lots of
efforts. How rust could help or hinder this is interesting but out of my
scope right now. If you feel inclined to share your thoughts on this
mine field, please do so in a reply to this e-mail separate from
feedback on the technical subject to avoid mixing topics.

> Yes, mixed language codebases are rough, and hard to maintain, but we
> are kernel developers dammit, we've been maintaining and strengthening
> Linux for longer than anyone ever thought was going to be possible.
> We've turned our development model into a well-oiled engineering marvel
> creating something that no one else has ever been able to accomplish.
> Adding another language really shouldn't be a problem, we've handled
> much worse things in the past and we shouldn't give up now on wanting to
> ensure that our project succeeds for the next 20+ years.  We've got to
> keep pushing forward when confronted with new good ideas, and embrace
> the people offering to join us in actually doing the work to help make
> sure that we all succeed together.

-- 
Regards,

Laurent Pinchart

