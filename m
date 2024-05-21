Return-Path: <linux-kernel+bounces-184585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F178CA932
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 09:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A8D1C20953
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 07:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6071052F71;
	Tue, 21 May 2024 07:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CM9AT0ap"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BD5C12C;
	Tue, 21 May 2024 07:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716277431; cv=none; b=METutlkr+aoYLGhZPuL8v475/6fxL1x0FylJC1rvDWI8aF45TSs9EuKXsiyltlSL7dJDMETbysP5TzdW+1nF7ASBNwhaJ1FXNFkXejbUvUt9yoFXZ3HqmWODOtGjIx93u7lqQ8KAyh01Z68VpRUCYSySFMw/G89cCvFZPsw5SW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716277431; c=relaxed/simple;
	bh=A9IoVr57gmQQXvYv0Uila/oUZpM/Kyt0jnAtAwEIOdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTEcQZUV6dK7/LgoeM6IUS+FrxbvxzVpy7o/3/M2hXFaWUY9p6gqKWiPjjYRwovLATQME1OJF8sAHqTdMIusot5zaLU5PLIFYiY6uBB02YyoZcnuzJQpejyezQwkbu1ztR5ax651a4uOlfQn5RVoG7GcqiOBsxAVrIE/PgOppFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CM9AT0ap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F99FC2BD11;
	Tue, 21 May 2024 07:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716277431;
	bh=A9IoVr57gmQQXvYv0Uila/oUZpM/Kyt0jnAtAwEIOdM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CM9AT0apq+pZCL0u4THZUTsWP9EETGIxjdkiLNHh0cj02ai8FUL0JrZPgOP/GwGH5
	 7gL+3RguyfWuUEhL3mHYspEfmDS3wZnrnxlz2MlbdJkZu25tJMULW1kZkDEGSKSjw7
	 rytD152qkcnXY3HM9O6QKKApQkGYzT8vsllfbEImOW7/nVgPVkIYPOKy3dzX6U2pFl
	 J90Xhkq2vVMqew4OOXYzknCC2edddAo1nKoA9ivnAwQxLmQmZ1E8JPftPTW95lDVVE
	 iO/uJ9bJEhiskYxB8kVQObAWg+JPdifmIEENjJ6CSX4+S4T6cMWxLZAfumeNjgXnJn
	 OVzOlU48ZsLBg==
Message-ID: <bc9079e8-0f20-4875-80e9-bccf7d1f761b@kernel.org>
Date: Tue, 21 May 2024 09:43:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: usb: gpio-sbu-mux: Add an entry for
 TMUXHS4212
To: Nishanth Menon <nm@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Parth Pancholi <parth105105@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Parth Pancholi <parth.pancholi@toradex.com>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vigneshr@ti.com
References: <20240517111140.859677-1-parth105105@gmail.com>
 <1675a33d-47af-4de9-a0e7-177cbe208e2b@kernel.org>
 <20240519202754.GA3334@francesco-nb>
 <469be7c2-6865-40d4-bd06-15dc3a08b3e3@kernel.org>
 <20240520121441.svp6oabjyev4vmih@magazine>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240520121441.svp6oabjyev4vmih@magazine>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/05/2024 14:14, Nishanth Menon wrote:
> On 08:53-20240520, Krzysztof Kozlowski wrote:
>> On 19/05/2024 22:27, Francesco Dolcini wrote:
> 
> [...]
>>> If it's not the case we'll send the patch later on, however some
>>> DT files maintainers (e.g. arch/arm64/boot/dts/ti/) have a policy to
>>> just accept DT file in which the binding changes are already merged
>>> therefore I was trying to be a little bit proactive here.
>>
>> TI? Never heard something like this from them... Such requirement would
>> seriously slow down any work, so it's not really reasonable. Expectation
>> is to post both binding change and an user, so DTS, in case of USB in
>> separate patchsets.
> 
> There is a reason we have set that "soft rule":
> - Driver subsystem merges have known to be broken from time to time and
>   the dt maintainer is left holding compatibles that have not made to
>   master.

You mean driver tree took the bindings (because then you take the DTS)
but they did not make it up to the master? Yeah, happens, but postponing
DTS code for this is quite harsh.

> - ARM subsystem merges prefers not to see checkpatch warnings -
>   typically, this happens with new compatibles in the driver subsystem.

Never heard any comment about this. Maybe because I always do checkpatch
tests (part of workflow), so then any warning, which there are pretty
lot like touching maintainer files, is understood as accepted.

> - Off chance that driver subsystem maintainer picks up the dt changes as
>   well (should not happen, but has happened)

DTS changes? Yes, that's why they should be in separate patchsets for
few known trees, like USB, net, media.

> 
> We have however flexed the rule when:
> a) driver maintainer is willing to provide us an immutable tag that we
>    can merge in and base the dts on top.

You cannot base DTS on top of any driver branch. In the past Arnd and
Olof were rejecting this, recently this got more flexible, but still cannot.

This implies dependency, which is a no-go.

> b) We felt that the chances of the driver not making it is very very low
>    (typically after 1+ month in next) and the dts change is in the wider
>    interest of the community. In such case, we have to explicitly take
>    the action of letting the patch submitter, driver subsystem to let us
>    know if something bad happens to the PR, also in our PR to SoC
>    maintainers, we have to call it out along with rationale why this is
>    OK. This is a bunch of work from a lot of folks, so prefer only to
>    trigger this path in case of exceptional cases - there have been a
>    few far in between.
> 
> Again, the default rule (driver in one window, binding in next) has
> kept us out of trouble for a few years now at the detriment of pace
> of merges, but that took care of a lot of conflicts that we had seen
> during initial days of k3 - there are few chains in the lakml list
> where this was the direction we ended up in after discussion.
> 
> But, yes - as you mentioned, send the patches of the "user" of the dt
> binding and driver gives the subsystem and dt maintainers a chance to
> review in the context of usage prior to the driver and binding merge.

Anyway, I am fine, but then I expect from the contributor to explain
where is the user.

Specifically, for completely new bindings I will NAK them if there is no
driver or DTS posted. Why? Because experience shown me that people post
some bindings and then entirely different DTS, without running full
dtbs_check. Therefore I want to see both - bindings and DTS, if applicable.

It is easy to fulfill both requirements - mine and yours. Post bindings.
Post DTS and link the bindings, with explanation it should be picked up
*later*, because that's what TI expects. That's way I can still find
both pieces, but you do not risk taking DTS too early.


Best regards,
Krzysztof


