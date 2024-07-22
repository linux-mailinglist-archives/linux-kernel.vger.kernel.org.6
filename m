Return-Path: <linux-kernel+bounces-259025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C94939023
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC4A281C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FFA16D9C4;
	Mon, 22 Jul 2024 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWYFr67T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C241D696
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721656296; cv=none; b=et6g6MUXix8TEJ7mZlZhCFySaY503g2Jt4fmmPwHAUR1A0dokn2XrLPBTtssj/2UNKiKbqs1giUJJCzRvFiEjCwbZkCbLjkUQUeHV/zn5sh3jJy3dMGBNxZqeTfGJ30Vd+1H0rwzjJ12Fv0Z9xYnCbY49+EGiHrwLj3ch7+9qRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721656296; c=relaxed/simple;
	bh=a1Sw8+RV80wZuYtYq6+ZycCkbjhrW/tor6yynVu5TkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdWLwtNKxk7WA9O79HHIkaRrzjaKuvX9gqveVGcQvIiaEcxR438/6KSrFiisgmqu4BwG8/6eleyUUtkp/1Xn363pJv9bmtXQaNcRSfVZaxPRtNu8c8lisREWgOcNXKzI1vGzPMDwwfnDSP2FS42pQWDBs0dANOfGUOdi0JBEDXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWYFr67T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8450C116B1;
	Mon, 22 Jul 2024 13:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721656296;
	bh=a1Sw8+RV80wZuYtYq6+ZycCkbjhrW/tor6yynVu5TkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sWYFr67T1bXHInLVLTdY8GH4NhL415Oi+GvTtKDGubYoWIY9k0DZ3W0AD4+g72ZXe
	 9EKKUyJVQL6+TPqRYm/rZjU0aEUaRdB7HrQxdzest02e2TCyeL4NRZeul4QtBPTrtd
	 M4y6k9xyjA119HdAcRqBFcrYtO9a/VXQCVvJhmO4dwk8bET3dJbRttyAjxejNpFYsY
	 SrVkdl2xBdD0MT58CORVvnDCPGE2BTmLdDVPxztcUf9X5QuXJiE8T7x+U6bqpLj9Hu
	 0VdbYrswNt8+cnZDwOrRgfknvmgEcJbBzrWP1pEPogQJhlDpTLctJ1Bb5pX/PhIld6
	 B4EnFO1ZYKiRA==
Date: Mon, 22 Jul 2024 15:51:32 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [GIT PULL] HID for 6.11
Message-ID: <3azgpqym2yaceheefnnj54rjjb5vz54haqayxmgbnjvb3rr3sj@aoiwdpfjo65s>
References: <uirri5bsktq5pk2tu4gs2u22qimjcn7hi66ek6gbj65qyczfex@yjy4brkoixfv>
 <c52b7bf6-734b-49fd-96e3-e4cde406f4e0@linaro.org>
 <f94c747c-7ee4-41b9-9851-610cecf2e555@kernel.org>
 <39ec733e-c49f-44c4-b998-19c7cbaf6ad1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39ec733e-c49f-44c4-b998-19c7cbaf6ad1@kernel.org>

On Jul 22 2024, Krzysztof Kozlowski wrote:
> On 22/07/2024 14:51, Krzysztof Kozlowski wrote:
> > On 22/07/2024 14:46, Konrad Dybcio wrote:
> >>
> >>
> >> On 16.07.2024 3:34 PM, Benjamin Tissoires wrote:
> >>> Linus,
> >>>
> >>> please pull from
> >>>
> >>>   git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2024071601
> >>>
> >>> to receive HID subsystem updates for 6.11 merge window. Highlights:
> >>>
> >>
> >> [...]
> >>
> >>>       HID: bpf: Add support for the XP-PEN Deco Mini 4
> >>>       HID: bpf: Add Huion Dial 2 bpf fixup
> >>>       HID: bpf: Thrustmaster TCA Yoke Boeing joystick fix
> >>>       HID: fix for amples in for-6.11/bpf
> >>
> >> Hi,
> >>
> >> this commit broke b4 for everyone starting next-20240719, as it's
> >> an empty cover letter with b4 tracking information
> > 
> > Uh, reminds me, I guess the same mistake of not seeing differences
> > between git pull and git am...
> > https://lore.kernel.org/all/311c8b64-be13-4740-a659-3a14cf68774a@kernel.org/
> > 
> > So just to recap:
> > 
> > Please *do not merge your own trees* into kernel.org repos. Instead use
> > b4 shazam to pick up entire patchset, even if it is yours. b4 allows to
> > merge/apply also the cover letter, if this is your intention.

Oh s***. Sorry for that. I was not at home for the whole week and
completely missed that the branch was the developement one (I usually
use a different machine for applying branches and sending PR).

> 
> Also, this was not present in next-20240717 and earlier. It was added in
> 20240719, so few days ago during merge window.

That's when I prepared my PR to Linus, but as I mentioned above I forgot
to reset that local branch.

> 
> I think features should be in the next for some time before the merge
> window starts, not added to next the moment they are sent to upstream.

Yes, completely agree and that's a big mistake for me. I made a diff
with our for-next branch and didn't see anything. The only commit on top
of that messed up b4 cover letter is a67a1deb11d9 ("HID: samples: fix the
2 struct_ops definitions"), which was already in linux-next on July 8
as b35e0dc548aa ("HID: samples: fix the 2 struct_ops definitions"), so
almost a week before the opening of the MR.

I'm still trying to understand if I forgot to merge that for-6.11/bpf
branch into for-next at that time.

Is there anything we can do to rip off that commit from the tree and fix
b4?


Cheers,
Benjamin


> 
> Best regards,
> Krzysztof
> 

