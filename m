Return-Path: <linux-kernel+bounces-259036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAD2939040
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D2C2820C9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D890B16D9D0;
	Mon, 22 Jul 2024 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/1gTHgH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2845516CD33
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721656777; cv=none; b=CNjkmlL4fQtLU/2BGRdj4b5jqcUAXSg/u4lz9bWZM19vBDzzSp44o08qTjNT65cFKwM5/k0tplyS8ciazgElFTSorljC8oPLEtUBw2cWDkXrpWBnF9n3TEg324cKmmYx5cNkfH39LqEC0fzPAgIn20d3JXVU6ymFRt1A4GJeoiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721656777; c=relaxed/simple;
	bh=iCxQ71WbzNABmbBFjX1zm5pj3iKgMFirBlm6soo6W48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOqbq2bie3geggisJE7HBixnpp9xqCkYnSsVP+18nMCswGq7S8Snugy/LmnTuZE8WHaTveyCSyvo8TkrK9fOqzEoqgs5C9EWtoNS261G79Kpd9qKyjdHrOjN1LpdZmqg2rfMmBlgzefsqDs0EMZDEQ5y9DRnviLeqaPMLSjKDrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/1gTHgH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301D7C116B1;
	Mon, 22 Jul 2024 13:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721656776;
	bh=iCxQ71WbzNABmbBFjX1zm5pj3iKgMFirBlm6soo6W48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d/1gTHgHf3WXrOMKELiUYnawBIZBJx3ZrwLEegU/RMLPaKNZU/RgLMfpAE1+s77sg
	 fUs9Ef2gqofXkOJUegcX8LgDYvyotHE8X+VCCSvrnj1UUFBS+jcX8BE5ooxRAdzJj6
	 VAy1JfDdT+SD6Bp+l3tXklQElFliYiIi3fpBOE06oLjU4jL0k+pbozfU44kGKwQ60g
	 xy1K2Bog5LSklUxMMC4Xahx0KZKfediq54b3YXpgWiwymNCHQujYfUhLhfZf44QkTN
	 lU7j4NgnVGrOYlpS+Xf1hjp94Q9m6CsE46svhV1jiZmjuxWmeFbS4f7hHaDCoZt0Da
	 8cQH95GfmQHSg==
Date: Mon, 22 Jul 2024 15:59:32 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [GIT PULL] HID for 6.11
Message-ID: <x5zjzunuxkhb4fuef6pgm2uaxqi5ry6kblctw63nfrpqdtbph3@pwgilrlrkpu2>
References: <uirri5bsktq5pk2tu4gs2u22qimjcn7hi66ek6gbj65qyczfex@yjy4brkoixfv>
 <c52b7bf6-734b-49fd-96e3-e4cde406f4e0@linaro.org>
 <f94c747c-7ee4-41b9-9851-610cecf2e555@kernel.org>
 <39ec733e-c49f-44c4-b998-19c7cbaf6ad1@kernel.org>
 <3azgpqym2yaceheefnnj54rjjb5vz54haqayxmgbnjvb3rr3sj@aoiwdpfjo65s>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3azgpqym2yaceheefnnj54rjjb5vz54haqayxmgbnjvb3rr3sj@aoiwdpfjo65s>

On Jul 22 2024, Benjamin Tissoires wrote:
> On Jul 22 2024, Krzysztof Kozlowski wrote:
> > On 22/07/2024 14:51, Krzysztof Kozlowski wrote:
> > > On 22/07/2024 14:46, Konrad Dybcio wrote:
> > >>
> > >>
> > >> On 16.07.2024 3:34 PM, Benjamin Tissoires wrote:
> > >>> Linus,
> > >>>
> > >>> please pull from
> > >>>
> > >>>   git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2024071601
> > >>>
> > >>> to receive HID subsystem updates for 6.11 merge window. Highlights:
> > >>>
> > >>
> > >> [...]
> > >>
> > >>>       HID: bpf: Add support for the XP-PEN Deco Mini 4
> > >>>       HID: bpf: Add Huion Dial 2 bpf fixup
> > >>>       HID: bpf: Thrustmaster TCA Yoke Boeing joystick fix
> > >>>       HID: fix for amples in for-6.11/bpf
> > >>
> > >> Hi,
> > >>
> > >> this commit broke b4 for everyone starting next-20240719, as it's
> > >> an empty cover letter with b4 tracking information
> > > 
> > > Uh, reminds me, I guess the same mistake of not seeing differences
> > > between git pull and git am...
> > > https://lore.kernel.org/all/311c8b64-be13-4740-a659-3a14cf68774a@kernel.org/
> > > 
> > > So just to recap:
> > > 
> > > Please *do not merge your own trees* into kernel.org repos. Instead use
> > > b4 shazam to pick up entire patchset, even if it is yours. b4 allows to
> > > merge/apply also the cover letter, if this is your intention.
> 
> Oh s***. Sorry for that. I was not at home for the whole week and
> completely missed that the branch was the developement one (I usually
> use a different machine for applying branches and sending PR).
> 
> > 
> > Also, this was not present in next-20240717 and earlier. It was added in
> > 20240719, so few days ago during merge window.
> 
> That's when I prepared my PR to Linus, but as I mentioned above I forgot
> to reset that local branch.
> 
> > 
> > I think features should be in the next for some time before the merge
> > window starts, not added to next the moment they are sent to upstream.
> 
> Yes, completely agree and that's a big mistake for me. I made a diff
> with our for-next branch and didn't see anything. The only commit on top
> of that messed up b4 cover letter is a67a1deb11d9 ("HID: samples: fix the
> 2 struct_ops definitions"), which was already in linux-next on July 8
> as b35e0dc548aa ("HID: samples: fix the 2 struct_ops definitions"), so
> almost a week before the opening of the MR.
> 
> I'm still trying to understand if I forgot to merge that for-6.11/bpf
> branch into for-next at that time.

Looks like I still pushed the change to for-next as of 3959f155ad59 ("Merge
branch 'for-6.11/bpf' into for-next") which is not appearing on Linus'
tree as expected (on 2024-07-08).

So my only mistake was the messed up b4 cover letter, everything else
was in linux-next. Again, so sorry :(


> 
> Is there anything we can do to rip off that commit from the tree and fix
> b4?

This still stands :)

Cheers,
Benjamin

