Return-Path: <linux-kernel+bounces-380466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F06E9AEF16
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420CA28387C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17265200105;
	Thu, 24 Oct 2024 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Wmgj/tGe"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C391FE0E4
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792861; cv=none; b=u0FpF5ko5WuGy29czuysW7eLsIeTwq+51/ZPJp7LrqHidPUCS/bok5jgVEnfqaeyYVNabvS/PibgE5JlWAxK0Insjr/5QSt4VRtBnYjuO/4eecxtDr840ecIqfYBsV9tv7YHU4iEYx9lDVe9PEUXA92h/OR+7EzPjqixBs8HzXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792861; c=relaxed/simple;
	bh=OgWldQezjpBrrbfCshiZNSNUzgKfNReUGscix533674=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=NRhuN7PJCX8hqRZjgE5fvLjuqo93sN9S7Gyfrz7IYtO5zhnJGZ0HCIzt+iUWzvpjNJicUkNvrt70lB7MXa/N6hGB45AKdkxZmZ/uOYCeus2gNAnhjTignXCrrFRnETf4ui9PLue9v5WLlcH2eeAj1KcGZQ5xbjAEeYra2207OMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Wmgj/tGe; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1729792856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GHgDKeqNVrBn9md44XPQvQ0FnJfd+8TS+EEdFg8hSss=;
	b=Wmgj/tGeb9etrXamiid7kJygIUFAPiuOTEw2Bl7jRkdMO3AeVubAJOrxP7xjX+u/JtGO7W
	QukaMZNhloBrZ3M3gVEwSLM8XhcZqdqMrlsNrG46CEXZ28OsCcUUYtcHriPn7hlW3eEE1t
	rMGti/cpYeTQk+SZU1S5qhZQPHC4kf62+hkLuSIvcOeGARcraCu8MmhzGhlPlum9dZc3iL
	DSH3sO/Ved//K0YDX9OqghfLchk9n4pd0sSR1vtco0220Rl61wqtbWJ65/GuGu55Ez66KH
	XrvtUqZANP95XOSVsn/yWDLu37EZMq1GZjc3IyxkmOODfjMoTzul/2RbxD5eLA==
Date: Thu, 24 Oct 2024 20:00:56 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Shimrra Shai <shimrrashai@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org
Subject: Re: Thinking about firmware and hardware description for latest
 Rockchip platforms
In-Reply-To: <20241023173514.4538-1-shimrrashai@gmail.com>
References: <b12103b968cd5817f25deb7277d6054a@manjaro.org>
 <20241023173514.4538-1-shimrrashai@gmail.com>
Message-ID: <560b5a4f419aa4bbe2df198fd528e5a8@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Shimrra,

On 2024-10-23 19:35, Shimrra Shai wrote:
> On 2024-10-23  2:46, Dragan Simic wrote:
>> As you noted already, the DT definitions are fixed and improved
>> all the time, which is actually great.  However, the backward
>> compatibility is ensured, because newer kernels are guaranteed
>> to work with older DTs, which doesn't mean that the board DTs
>> provided through firmware should become frozen in any way, as
>> explained further below.
> 
> Thanks - my concern was about backward compatibility so that if some
> user did not upgrade their FW but then tried to install a *newer*
> Linux found things mysteriously breaking due to that some DT revision
> in code had broken the backwards compatibility. Of course that could
> also be considered a bug, even while new FWs could/would still be
> rolled out.

That's a valid concern, but such scenarios shouldn't happen by
design, unless there's some bug, of course.

>> Freezing anything would be simply wrong.  It might look good from
>> the perspective of having something "stable", which is similar to
>> how x86_64 firmware works on PC motheboards, but the continual
>> bugfixes and improvements are actually extremely good, because
>> they prevent various ARM boards from effectively becoming abandoned,
>> which is unfortunately rather usual with x86_64 motherboards that
>> become so "stable" that some nasty firmware bugs are never fixed
>> and their users are left high and dry.
> 
> Yes, I'm not against new FW upgrades, just the idea of users *having*
> to upgrade their FW simply because a new kernel came out when nothing
> like that is typical on x86 or at least in my experience using it over
> many years).

Yes, users don't _have_ to upgrade their firmware, as described
above in more detail, but they actually _should_ upgrade.  In fact,
they should be happy and eager to upgrade. :)

> Note that the situation of a DT upgrade that is obtained by FW
> upgrade breaking older kernels, i.e. broken *forward* compatibility of
> the older kernel with later DT, isn't so much a problem because we can
> simply keep the older DT in the FW when issuing the FW upgrade, as I
> believe there is a facility for supporting multiple, versioned DTs in
> that UEFI package [and if not, it could easily be added]. It's the
> backward compatibility that is my issue because reflashing FW, even
> though not too hard on these boards, is perhaps more heady for your
> average PC or smartphone user.

Hmm, I don't think that keeping older DTs around is a good idea.
Instead, we should simply document the required kernel version,
or even better, make some kind of a dependency between the firmware
version and the version of the kernel packages.  The latter is,
of course, a much more complex option, but also better.

For the record, please note that I have zero interest whatsoever
in any kind of "full-fat" UEFI firmware implementation.

> That is to say, I'm imagining the case of bundled computers
> pre-shipped with the loaded FW and OS installed as usual and someone
> says "hey they got a new Ubuntu [or whatever], let's install it!" BAM,
> devices stop working because they did not upgrade FW, forcing an FW
> upgrade in a way an x86 user would not be similarly forced. Though of
> course, that could then be reasonably called a regression bug (as it
> would appear from the user's perspective, not knowing about the FW
> change), if backwards compatibility is indeed already a long-standing
> policy (and is really what I was after with that "freeze" suggestion
> even if it itself would not be the way to get it).

Well, it's perfectly reasonable to expect the users to install
different Linux distributions, etc.  However, as already described
above, running a newer kernel version without updating the firmware
should never lead to such issues.

I think we should raise the awareness of the actual benefits coming
from the openness of firmware on various ARM boards, and the available
choice of _not_ having to use "full-fat" UEFI firmware, instead of
trying to make the whole thing be more like x86_64 UEFI firmware.

