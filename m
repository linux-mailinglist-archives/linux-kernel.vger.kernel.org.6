Return-Path: <linux-kernel+bounces-195828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C23CD8D525A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 21:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4720C1F24A46
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 19:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D28156F57;
	Thu, 30 May 2024 19:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="wobW0bUS"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAEA156C62;
	Thu, 30 May 2024 19:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717097507; cv=none; b=PNn/O1h8MzcoJ/7JYpraCwaUs0vGIAqMTPRrZOqjaC8CRC78dG8lOMyQoj90I/T1v4YhVYvB+zJHtkJiO982npzth71XBBvxcZor7Pdj0GcWJ6OUt8XxGPdIkKlNe7DSXNO2XJYvqhSMTW6+9bXJVU/jRQxh+vWfFUwzZ50B5+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717097507; c=relaxed/simple;
	bh=mz+Tc5gTd6y/EAf0bn20tHzGg4BqnD6TaMtO7GXGH04=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fLtOmgj1AiSoombk24QyLf7sv33YPL/4DWz6gy9OuUBeul2VE0huNWoBylGd0SBZHO+VPboQBIyHPq7khBPHu+2+cdLtWCU9i0dA0WRYFxAX6LuvWEyk+NzzrDd9yL51tWNaE6H70SNP/+cSsmjuZkCRjX+JcWgYCegf5teRx7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=wobW0bUS; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1717097496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GkDv3p3MdujIs63eiYtNPcuXLqersYyHaudDkQ3VAPg=;
	b=wobW0bUSA/cxhu9cqWD2cZZRP3hnhyedEjELk87vU3ROtxDZAb+VvwjmuMM8nMBp6H8uMx
	8ogsYFSel9BVhyWRCChOg6U+O+dvjeBRFKNa5HVrzDPcgcji9YB+GEuYqwaB9Ms6P4b363
	JXGzPjoBEcoDDAZWZSv3wBnHub10dBb8A3dmy7Emlr2/lNfbvO1xDpXAQuVha9IBba3+If
	/j5ozHo2lut0b7e8UVejNAxWYVYeOs2056mdCjyqWwNScaxSz5iaoYro+O1uZagt7d+zt5
	pzMvUB2S/nh02GJvyNZI4B5q/lyaFUqt09XjyJF1IGX9eUPV6iJHkZM/OxPOtA==
Date: Thu, 30 May 2024 21:31:34 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, quentin.schulz@cherry.de, wens@kernel.org,
 daniel.lezcano@linaro.org, didi.debian@cknow.org,
 krzysztof.kozlowski+dt@linaro.org, viresh.kumar@linaro.org
Subject: Re: [RFC PATCH] arm64: dts: rockchip: Make preparations for
 per-RK3588-variant OPPs
In-Reply-To: <CABjd4YzDNQa45=KC_t0xnTDrH+g-oUrcpgP55oOj7JcAuu7uFw@mail.gmail.com>
References: <673dcf47596e7bc8ba065034e339bb1bbf9cdcb0.1716948159.git.dsimic@manjaro.org>
 <CABjd4YxD41DEkBCZfkznLboEY9ZVOfTCLcj4S_kkcsVswbANyQ@mail.gmail.com>
 <8f8623e29a479c4108141302e708dc3b@manjaro.org>
 <CABjd4Yy4RMg+6-4ygV0MSwJj5LReY-ymbctq4PPfVZ6L+c1tsw@mail.gmail.com>
 <166cc4e46f31644a50306625b2ab18a6@manjaro.org>
 <CABjd4YzDNQa45=KC_t0xnTDrH+g-oUrcpgP55oOj7JcAuu7uFw@mail.gmail.com>
Message-ID: <82db817a908b761d8c3d73ea04714314@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Alexey,

I'm sorry for my delayed response, had some "IRL stuff" to take care of.

On 2024-05-29 16:05, Alexey Charkov wrote:
> On Wed, May 29, 2024 at 4:22 PM Dragan Simic <dsimic@manjaro.org> 
> wrote:
>> On 2024-05-29 14:04, Alexey Charkov wrote:
>> > On Wed, May 29, 2024 at 2:45 PM Dragan Simic <dsimic@manjaro.org>
>> > wrote:
>> >> On 2024-05-29 11:57, Alexey Charkov wrote:
>> >> > On Wed, May 29, 2024 at 6:14 AM Dragan Simic <dsimic@manjaro.org>
>> >> > wrote:
>> >> >>
>> >> >> Rename and modify the RK3588 dtsi files a bit, to make preparations
>> >> >> for
>> >> >> the ability to specify different CPU and GPU OPPs for each of the
>> >> >> supported
>> >> >> RK3588 SoC variants, including the RK3588J.
>> >> >>
>> >> >> As already discussed, [1][2][3] some of the different RK3588 SoC
>> >> >> variants
>> >> >> require different OPPs, and it makes more sense to have the OPPs
>> >> >> already
>> >> >> defined when a board dts includes one of the SoC dtsi files
>> >> >> (rk3588.dtsi,
>> >> >> rk3588j.dtsi or rk3588s.dtsi), rather than requiring the board dts
>> >> >> file to
>> >> >> also include a separate rk3588*-opp.dtsi file.  The choice of the SoC
>> >> >> variant
>> >> >> is already made by the inclusion of the SoC dtsi file, and it doesn't
>> >> >> make
>> >> >> much sense to, effectively, allow the board dts file to include and
>> >> >> use an
>> >> >> incompatible set of OPPs for the already selected SoC variant.
>> >> >
>> >> > Indeed, including just one .dtsi for the correct SoC variant and not
>> >> > having to bother about what other bits and pieces are required to use
>> >> > the full SoC functionality sounds great! Thanks for putting this
>> >> > together so promptly!
>> >>
>> >> You're welcome. :)
>> >>
>> >> > Some considerations below.
>> >> >
>> >> >> No intended functional changes are introduced.  (Still to be
>> >> >> additionally
>> >> >> verified if the patch moves forward from the RFC state.)
>> >> >>
>> >> >> [1]
>> >> >> https://lore.kernel.org/linux-rockchip/646a33e0-5c1b-471c-8183-2c0df40ea51a@cherry.de/
>> >> >> [2]
>> >> >> https://lore.kernel.org/linux-rockchip/CABjd4Yxi=+3gkNnH3BysUzzYsji-=-yROtzEc8jM_g0roKB0-w@mail.gmail.com/
>> >> >> [3]
>> >> >> https://lore.kernel.org/linux-rockchip/035a274be262528012173d463e25b55f@manjaro.org/
>> >> >>
>> >> >> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
>> >> >> ---
>> >> >>  ...inctrl.dtsi => rk3588-common-pinctrl.dtsi} |    0
>> >> >
>> >> > Renaming the pinctrl includes seems superfluous - maybe keep them as
>> >> > they were to minimize churn?
>> >>
>> >> Believe it or not, the same thoughts crossed my mind.  However,
>> >> after thinking a bit about it, I concluded that renaming the pinctrl
>> >> .dtsi files as well makes the overall naming of the reworked RK3588
>> >> .dtsi files more consistent.
>> >>
>> >> It's also rather neat to have the "common" and "fullfat" file pairs
>> >> together in the arch/arm64/boot/dts/rockchip directory listing, when
>> >> it's sorted by the file name, which is the default in most (if not
>> >> all) environments.
>> >>
>> >> >>  .../{rk3588s.dtsi => rk3588-common.dtsi}      |    2 +-
>> >> >>  ...nctrl.dtsi => rk3588-fullfat-pinctrl.dtsi} |    0
>> >> >>  .../{rk3588.dtsi => rk3588-fullfat.dtsi}      |    4 +-
>> >> >
>> >> > To me, "fullfat" doesn't look super descriptive, albeit fun :)
>> >>
>> >> Yeah, I resorted to "fullfat" as some kind of a funny option. :)
>> >> That's for the "beefy" SoC variants, so it kind of fits well. :)
>> >>
>> >> > How about we rename the existing rk3588.dtsi and rk3588s.dtsi to
>> >> > something like rk3588-devices.dtsi and rk3588s-devices.dtsi
>> >> > (preserving the inheritance between them), and then I add
>> >> > rk3588s-opp.dtsi and rk3588j-opp.dtsi in a follow-up patch?
>> >>
>> >> The trouble with including "devices" into the filenames is, well,
>> >> the fact that those files isn't about any devices, but about the
>> >> SoC variants.  Thus, "devices" simply wouldn't fit there.
>> >
>> > My thinking was along the lines of "here is the file that contains all
>> > DT nodes for built-in _devices_ (as in on-chip IP blocks) on RK3588 -
>> > thus it's called rk3588-devices.dtsi", and "here's the file that
>> > contains operating parameters that distinguish RK3588 and RK3588s from
>> > RK3588j - it's called rk3588s-opp.dtsi"
>> 
>> Hmm...  I see, but a device is usually though of as some standalone
>> computer, at least in this context.  Surely, an SoC is also some kind
>> of a device, for example, but I'm pretty sure we'll very rarely call
>> an SoC a device.  It's always good to adhere to the usual meaning of
>> the words in a particular lingo.
> 
> Agreed, and calling the SoC itself a device is not what I implied by
> the suggested naming.

Thanks.  As a clarification, I just used calling an SoC a device as
another example of how "device" can be used in an uncommon way.

>> When it comes to rk3588s-opp.dtsi, it would be more of a file that
>> completes the rk3588s.dtsi by adding the OPPs, but we can in fact
>> add the OPPs directly into rk3588s.dtsi, because in the new layout
>> rk3588s.dtsi isn't a parent to any other file.
>> 
>> >> Moreover, in the envisioned scheme there should be no separate
>> >> OPP .dtsi files;  the OPP data should go directly into the new
>> >> rk3588.dtsi, rk3588s.dtsi and rk3588j.dtsi files, where it actually
>> >> belongs.  That's why those .dtsi files exist and are mostly empty,
>> >> at least the way I see it.  I'll get back to this below.
>> >>
>> >> > Then we keep "thin" versions of rk3588.dtsi, rk3588s.dtsi and
>> >> > rk3588j.dtsi for board files to include. The mix-and-match of
>> >> > different on-chip devices and different OPPs then gets transparently
>> >> > represented within those "thin" .dtsi, something like this:
>> >> >
>> >> > rk3588.dtsi:
>> >> > #include "rk3588-devices.dtsi"
>> >> > #include "rk3588s-opp.dtsi"
>> >> >
>> >> > rk3588s.dtsi:
>> >> > #include "rk3588s-devices.dtsi"
>> >> > #include "rk3588s-opp.dtsi"
>> >> >
>> >> > rk3588j.dtsi:
>> >> > #include "rk3588-devices.dtsi"
>> >> > #include "rk3588j-opp.dtsi"
>> >>
>> >> Such a layout, in general, has also crossed my mind, but my conclusion
>> >> was that having the per-SoC-variant OPP data specified directly in the
>> >> reworked rk3588.dtsi, rk3588s.dtsi and rk3588j.dtsi files is a better
>> >> option in the long term, even if we end up that way with rk3588.dtsi
>> >> and
>> >> rk3588s.dtsi repeating most (if not all) of the same OPP data.
>> >
>> > From all the info we have available so far, RK3588 and RK3588s share
>> > identical OPPs, so having one file with OPPs that both variants refer
>> > to should be more maintainable (and fewer lines of DT code).
>> 
>> Hmm.  Perhaps we can have rk3588-opp.dtsi as a separate file with the
>> OPPs shared between the RK3588 and the RK3588S, which would be 
>> included
>> from rk3588.dtsi and rk3588s.dtsi.
>> 
>> Though, the OPPs for the RK3588J should go directly into rk3588j.dtsi;
>> if we ever split the OPPs for the RK3588 and the RK3588S, the new OPPs
>> should also go directly into rk3588.dtsi and rk3588s.dtsi.
> 
> Sounds good to me!

Thanks!  I'm glad you agree.

>> > All in all, it appears that RK3588 and RK3588j have an identical set
>> > of built-in devices, but different OPPs due to RK3588j being spec'd
>> > for industrial use which apparently has different requirements. At the
>> > same time, RK3588s uses an identical set of OPPs as RK3588 but a
>> > reduced set of built-in devices. The combination of includes I
>> > proposed above makes this explicit.
>> 
>> Again, calling IP blocks devices is, AFAIK, very uncommon.
> 
> Perhaps. Shall we settle on something like "-devicenodes.dtsi" or
> "-hwblocks.dtsi"? :) This will delineate what goes to which .dtsi:
> things that describe the hardware composition go to "-hwblocks.dtsi",
> things that describe performance parameters for that hardware go to
> "-opp.dtsi" (or directly to the SoC .dtsi if there is only one SoC
> variant that uses a particular OPP table).

But why not use "-common" instead?  It's simple and aready used for
another SoC family, which I actually took the inspiration from.  That
way we'll have both simplicity (it is what it is, common part of the
RK3588 dtsi, shared among all RK3588 variants) and some arm64-dts-wide
consistency.  (See also below for further thoughts.)

> The problem I have with -common is that there are several layers of
> "common" even among just the three of these chip revisions, and a
> clear inheritance hierarchy between them (i.e. RK3588j and RK3588 also
> have a sizeable chunk of their IP blocks that is "common" between
> these two variants, in addition to those shared among all three
> variants)

Hmm, I see, that's a rather valid concern.  How about using "-base"
for what I called "-common", and "-extra" for what I called "-fullfat",
for the lack of a better term?  Using "-extra" takes inspiration from
the way Linux distribution package repositories are commonly named, so
it should be rather familiar to nearly everyone.

Also, "-base" and "-extra" are rather short, so their shortness would
also make them stand out in the directory listing as something that 
isn't
just another board .dts or .dtsi file, which can only help.

>> > As for RK3588m, it seems to include all the same devices as RK3588 and
>> > RK3588j, but a slightly modified set of OPPs compared to RK3588j. We
>> > don't have any boards using that variant in the mainline tree right
>> > now, but it would be easy, when the need arises, to add something
>> > along the lines of:
>> >
>> > rk3588m.dtsi:
>> > #include "rk3588-devices.dtsi"
>> > #include "rk3588m-opp.dtsi"
>> >
>> > rk3588m-opp.dtsi:
>> > #include "rk3588j-opp.dtsi"
>> > &cluster0_opp_table {
>> >         /delete-node/ opp-1296000000;
>> > };
>> 
>> I don't think that deleting nodes that way is a good option.  It's
>> rather error-prone and hard to track, so it would be better to have
>> the OPPs for RK3588M specified directly (and fully) in the future
>> rk3588m.dtsi file, just like in rk3588j.dtsi.
> 
> You're right, that does indeed look fishy upon further thought.

Thanks, I'm glad you agree.

>> >> That way we'll have no roadblocks if, at some point, we end up with
>> >> having
>> >> different OPPs defined for the RK3588 and the RK3588S variants.  Or
>> >> maybe
>> >> even for the RK3582, which we don't know much about yet.
>> >
>> > Guess we'll deal with that one once we stumble upon an actual RK3582
>> > board out in the wild and heading to the mainline kernel tree :)
>> 
>> Of course, that was just an example for the future use.
> 
> In fact, I've just discovered that Radxa has recently released Rock 5C
> Lite which is based on RK3582, and starts at just $29 for the 1GB
> version, making it interesting for tinkering. Especially given that
> its GPU, one of the big-core clusters and one of the VPU cores seem to
> be disabled in software (u-boot) rather than in hardware, which means
> there is some chance that a particular SoC specimen would actually
> have them in a working condition and possible to re-enable at no cost.
> Ordered myself one to investigate :)

Yes, I also saw the RK3582-based ROCK 5C Lite a couple of days ago. :)
It seems that the disabled IP blocks are detected as defective during
the manufacturing, which means that they might work correctly, or might
actually misbehave.  It seems similar to the way old three-core AMD
Phenom II CPUs could sometimes be made quad-core.

