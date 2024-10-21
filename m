Return-Path: <linux-kernel+bounces-375037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F929A9013
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE021F23135
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231821FCC7F;
	Mon, 21 Oct 2024 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzlYHMf0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666B11D0E2F;
	Mon, 21 Oct 2024 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539854; cv=none; b=XEELtNx+C3Q9MhwSo2hPiYxxTjj9DjM4+pdlbtKAddXLIKbv8/jeFJs1tkBnAu/u70gMMtyHqsdzPGtkydKvFr/BNq2Ad63HdsuJtAucC5gox2o3tC1aKwLk6CUXjwdVra+eIsTA443AqbDaZivf6veQ5T0DKfv2wDRaTTY6QxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539854; c=relaxed/simple;
	bh=lt9IZgebpUmwFfGy4DoMADM3P3rv3/HpBmChqkr8OSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biG7ubMrxDAnyKnS/y+5lNI2yIu4PEZoCye7Wl0ZUu+BALPVzSYMohBvB1bIOOFsqJWEzlyPzRKf9noNnlVPkQIkT60u5nO3ezImYPegszcjk+VQI8BOYiPTHGSmJ2UVqhLZdglGEuRUC95rcObPYYln2wL1/VVXfg+Cxk8NKkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzlYHMf0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0049C4CEC3;
	Mon, 21 Oct 2024 19:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729539854;
	bh=lt9IZgebpUmwFfGy4DoMADM3P3rv3/HpBmChqkr8OSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tzlYHMf0aiwfAsoHrnek0xbJT3P9ZsgvOapSwqJXl37zqovojEg2+j33isQNFFmh0
	 9NeMlN7svx0g/89lNVzIc1vc66TC5TCyIIo8MRGiSrjZhNdQMRuLu1lGP/J2lr4eCp
	 vL4vWrpKRewUb6dxUOAtQYr34b9lOUKarGAKrNBcdIc/WGpJgUp6HOgJ0o+N6Q0JuW
	 5fnk1azK78nLm0CjcleL7YEJqVB9Ldx0AKsqzM4bzu0sPQJLNse8NJBF4cEEIQwLa2
	 DPMhJTjQcAj1BwJhLpnSUodHXwgX9TP3u7noqFti70NsIejxYp+kRZbq+mhXNyaxBq
	 GS8IA/L1DePNg==
Date: Mon, 21 Oct 2024 15:44:12 -0400
From: Sasha Levin <sashal@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: torvalds@linux-foundation.org, ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <ZxavDApnkMl2xZNA@sashalap>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <xhjzj6kfgg2dxq6swurwaeyzqtd2sl4dat5pzg6jolirw5og6z@bmwdcuwsf2bv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xhjzj6kfgg2dxq6swurwaeyzqtd2sl4dat5pzg6jolirw5og6z@bmwdcuwsf2bv>

On Mon, Oct 21, 2024 at 02:36:39PM -0400, Liam R. Howlett wrote:
>* Sasha Levin <sashal@kernel.org> [241021 12:32]:
>> Hi folks,
>>
>> The linux-next tree we all know and love is widely used by the kernel
>> community for integration work. It offers several advantages:
>>
>> 	1. Early detection of conflicts between matinainer trees
>>
>> 	2. Catching most new build errors/warnings
>
>Would it be difficult to catch branches that change things outside their
>scope without correct SOB/RB/Acks?  Asking for a friend...

Up to the guy in charge... I don't want to attempt and monitor a policy
that won't be enforced :)

If Linus wants to add this to the workflow (which is doable), then an
explicit ack would be great.

>> However, it faces significant testing challenges:
>>
>> 	1. Contains a mix of "ready-to-go" code and experimental additions
>>
>> 	2. A single "bad" piece of code can affect testing of everything else
>>
>> 	3. Low barrier of entry, encouraging inclusion over exclusion
>>
>> 	4. While linux-next offers early conflict resolution and
>> 	identifies build issues, it is very difficult to actually test
>> 	due to the abundance of runtime issues it tends to have
>>
>> These factors combine to make linux-next a valuable tool for integration
>> but problematic for comprehensive testing.
>>
>> During the Maintainer's Summit, Linus Torvalds expressed concerns about
>> the quality of testing that code receives before he pulls it. The
>> subsequent discussion side-tracked to the testability of linux-next, but
>> we didn't directly address Linus's original concern about pre-pull
>> testing quality.
>>
>> In an attempt to address the concerns, we're trying out a new "linus-next"
>
>The names are really close, could it be something that's more than one
>character different?
>
>linus-pulled, linux-pending, linux-pr or something?  They are also the
>same length, which adds to the parsing challenge on both typing and
>reading.  I'm thinking I'll get emails about the wrong branch or send
>them with the wrong branch specified - especially pre-coffee.

Maybe... I didn't think about the name too much because my thinking is
that it'll mostly be a behind-the-scenes for most folks outside of a
very small group.

>> tree is being created and maintained with the following characteristics:
>>
>> 	1. Composed of pull requests sent directly to Linus
>>
>> 	2. Contains branches destined for imminent inclusion by Linus
>>
>> 	3. Higher code quality expectation (these are pull requests that
>> 	maintainers expect Linus to pull)
>>
>> 	4. Continuous tree (not daily tags like in linux-next),
>> 	facilitating easier bisection
>>
>> The linus-next tree aims to provide a more stable and testable
>> integration point compared to linux-next, addressing the runtime issues
>> that make testing linux-next challenging and focusing on code that's
>> about to be pulled by Linus.
>
>What about the people who send them late?  I know people get told not to
>do that, but some people still do.  Those late pull requests would
>potentially invalidate a lot of the testing in this scenario.
>
>For example, if there was a late mm change, then anything using mm could
>be affected.  That's a large subset.
>
>Is there any cut-off time for testing?

I think that the answer here is the same as whatever Linus considers as
"too late".

My cron scripts will pick up the pull request quickly and send it out to
be tested, but it's up to Linus to decide if he wants to sit on it for
another day/week/month or not.

Again, not enforcing policy, that's up to the penguin in charge...

-- 
Thanks,
Sasha

