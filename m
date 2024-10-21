Return-Path: <linux-kernel+bounces-375029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D74609A8FF1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65B09B228B5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6144F1FBCA1;
	Mon, 21 Oct 2024 19:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOK308uF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9401D12E0;
	Mon, 21 Oct 2024 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539346; cv=none; b=d3DA7Ee6rA5wBDTdlJDhennxn/+QTEpqqiHoJfMh3PdQmxYbLNlXJ+/U4KMC2ntl0esdiPxUpv0hVBsS26SiNtr1CP1R1yqnH3tHBqR3RbivFMIU7U76AVMfuxBbPE7EhAF7XHT08h9+OYaqYUtpOSv1eUTMtb2G/ARffIiJn10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539346; c=relaxed/simple;
	bh=bKOdD2DQboA2xhUxsX07ctKS9t84zsPpWtZW6h5BiPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqKSTVHD1Z/2QPrfznbGT8p5TVFihlrius4QQWR6DoAn57x86b7wY58b3L6luIRQKB0QcX5wq3pyoa2nSRkx6u+kPUrXAi5rzKI71YWXYdBuFa4MZEBUoqciBLWRDmdrOcb4RlIzGdl6HieOl2jmyQOg4gNw+24rK3LEUTwyLEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOK308uF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F2EC4CEC3;
	Mon, 21 Oct 2024 19:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729539346;
	bh=bKOdD2DQboA2xhUxsX07ctKS9t84zsPpWtZW6h5BiPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NOK308uFq62GnMH9TsCUKUjMlhDnZhiniTVyiVk5GWA2b7MhBMQWtJjR3EI1rfDPo
	 L7S8O2KTU9dY8oPBLAasrXvhI4BPbDFclwwXMusq+VArGptJdSFX7exMToCTaY+jg6
	 ttiFObt2idvbOX/p3H8KyXqAVrQcbyRj/3sQXd3G1VstrdSrqyE4Sx+Hq/XAZby2V3
	 py3OyICtcghCJ+P/gmg4AAnjLcMquS4cqtxXaMuESUuJQ8GjjMNd2BfCsXUkHal7m+
	 nCMk7RwU0A8cR4y8hIE/U9PQ4WdIAWiS5C9KcpP3bzerkISbh+Wz6iSAYeYlZt445q
	 +Mn02Rt7rRu2w==
Date: Mon, 21 Oct 2024 13:36:25 -0400
From: Sasha Levin <sashal@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <ZxaRGWhXndfHMOBD@sashalap>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <e7bc3cfe-f7c0-4d8b-b89d-a2f260d34a76@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7bc3cfe-f7c0-4d8b-b89d-a2f260d34a76@kernel.org>

On Mon, Oct 21, 2024 at 07:18:38PM +0200, Matthieu Baerts wrote:
>Hi Sasha,
>
>On 21/10/2024 18:07, Sasha Levin wrote:
>
>(...)
>
>> In an attempt to address the concerns, we're trying out a new "linus-next"
>> tree is being created and maintained with the following characteristics:
>>
>>     1. Composed of pull requests sent directly to Linus
>>
>>     2. Contains branches destined for imminent inclusion by Linus
>>
>>     3. Higher code quality expectation (these are pull requests that
>>     maintainers expect Linus to pull)
>
>That's a good idea! Thank you for putting this in place!

Thank you!

>If you don't mind, I have some questions below.
>
>>     4. Continuous tree (not daily tags like in linux-next),
>>     facilitating easier bisection
>
>What will happen when a pull request is rejected?

My mental playbook is:

1. If a pull request is just ignored, ping it in case it was forgotten.
2. If we have an explicit NACK, just revert the merge commit.

>(...)
>
>> We also want to avoid altering the existing workflow. In particular:
>>
>>     1. No increase in latency. If anything, the expectation is that
>>     the cadence of merges would be improved given that Linus will
>>     need to do less builds and tests.
>>
>>     2. Require "sign up" for the tree like linux-next does. Instead,
>>     pull requests are monitored and grabbed directly from the
>>     mailing list.
>
>Out of curiosity: is it done automatically? Will it email someone when a
>conflict is found?

So it's 80% automatic now: my scripts monitor emails using lei, parse
relevant ones and manage to extract the pull instructions out of them,
and then most of those pull requests just merge cleanly.

There are some with conflicts, but since Linus insists on having an
explanation for merge conflicts, those pull requsts contain those
instructions within them. In those cases I manually followed the
instructions to resolve the conflicts (which were trivial so far).

I'll likely send a mail out *only* if I see a non-trivial merge conflict
without an explanation in the body.

>(...)
>
>> Current testing:
>>   - LKFT: https://qa-reports.linaro.org/lkft/sashal-linus-next/
>>   - KernelCI: https://t.ly/KEW7F
>
>That's great to have more tests being executed! Who is going to monitor
>the results? This task can quickly take time if this person also has to
>check for false positives and flaky tests.
>
>Are the maintainers supposed to regularly monitor the results for the
>tests they are responsible for? Or will they be (automatically?) emailed
>when there is a regression?

I'm not sure about this part. While I look at it in and will likely send
a mail out if I see something fishy, the only change in workflow that I
hope will happen here is Linus looking at a dashboard or two before he
begins his daily merge session.

-- 
Thanks,
Sasha

