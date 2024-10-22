Return-Path: <linux-kernel+bounces-376016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE99F9A9EA9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967E6283546
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35655186E43;
	Tue, 22 Oct 2024 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSySvbxu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DF5145B24;
	Tue, 22 Oct 2024 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729589860; cv=none; b=f1KkIWbvRj0zufMrNBL04u9xTWnI2xkSKsVMvuif/TGJuehMIOcSZL7VIUTTDXFg3w0cscxXbiWNiufhEsSbAJxGPgwzkmppH7qvuu1wG2GvVlX46xYTKdVhlBOgo4o3F7MiSsJ9op5kkqaT8WqWehL0mXM5PI4sU+DOGvj+qXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729589860; c=relaxed/simple;
	bh=2a87w8UaDORhRsLeqDi9MxGI9hJEnP13Fz3Ax9Sd9wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEYwV+CF/ITAjGVvavAomTZm4cVb39XQn1Pa4AKhXPKLGM5L+MmFY8qrxLuhuFgmrIChUUk2pV6PxXbZN0MRMD2ijs2r4bvNtQpaq3c/upDFheNHGdwlYDZKVxVl4nneWSfiE3g/Ss45+Zhtyu1N9nlrlZgM8WsmE6HkapvAdjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSySvbxu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FB8C4CEC3;
	Tue, 22 Oct 2024 09:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729589860;
	bh=2a87w8UaDORhRsLeqDi9MxGI9hJEnP13Fz3Ax9Sd9wk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QSySvbxumYqEJcj8C+thhVGq4xhPoKA1CAxmOwlH5j88SKvEn6xBP5smiNAKS/EOP
	 HYWDE/VpS3q4OoxESgW6ETLfhCiC7Xflg38XTWum83hYY7QVK7Zy4Evm+BOAinwjDJ
	 hFYEJicNaIxSU63wLlf0jqUuQDEqf+tJUCctfz3ReRY6uuJjYXn2riAyUNf0l0yt3R
	 n6yZDGUFVKo7sx58+Lvy8mlRx4C8DbkkPfknqYdsSh4lrMbHoUtM2BIEJWkDDXUgsW
	 PDvBUKZOxaodLdDULo9D33xKottcjjKSoVsKXdnVsv/V4gITt0WlvLEJNOjT/fzlsE
	 /7iW1TXZXp2og==
Date: Tue, 22 Oct 2024 05:37:38 -0400
From: Sasha Levin <sashal@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Kees Cook <kees@kernel.org>, torvalds@linux-foundation.org,
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <ZxdyYjzxSktk34Zz@sashalap>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZxdKwtTd7LvpieLK@infradead.org>

On Mon, Oct 21, 2024 at 11:48:34PM -0700, Christoph Hellwig wrote:
>On Mon, Oct 21, 2024 at 09:54:53PM -0700, Kees Cook wrote:
>> >	1. Composed of pull requests sent directly to Linus
>> >
>> >	2. Contains branches destined for imminent inclusion by Linus
>>
>> But this means hours or a day or 2 at most.
>
>Yeah.

During the -rc cycles, sure.

However, folks have been consistently sending content for the next
release early - usually a week or two before the merge window even
opens.

For that matter, we've already seen pull requests destined for 6.13
getting pulled into linus-next.

>>
>> >	3. Higher code quality expectation (these are pull requests that
>> >	maintainers expect Linus to pull)
>>
>> Are people putting things in linux-next that they don't expect to send to Linus? That seems like the greater problem.
>
>They shouldn't.  If they do we do indeed have a problem.

Not in the sense that it's not expected to be sent to Linus, but more in
the sense that folks are shoving things in -next before they passed all
the "local" tests a maintainer can run.

We end up with content that is destined to Linus, but is immature.

>> >	4. Continuous tree (not daily tags like in linux-next),
>> >	facilitating easier bisection
>>
>> I'm not sure how useful that is given the very small time window to find bugs.
>
>Same.
>
>> >The linus-next tree aims to provide a more stable and testable
>> >integration point compared to linux-next,
>>
>> Why not just use linux-next? I don't understand how this is any
>> different except that it provides very little time to do testing and
>> will need manual conflict resolutions that have already been done in
>> linux-next.
>
>Exactly!

We had multiple issues just this release cycle that would have been
caught by this tree and not by linux-next.

>> How about this, instead: no one sends -rc1 PRs to Linus that didn't go
>> through -next. Just have a bot that replies to all PRs with a health
>> check, and Linus can pull it if he thinks it looks good.
>
>Not just -rc1, otherwise agreed.
>
>> For example, for a given PR, the bot can report:
>>
>> - Were the patches CCed to a mailing list?
>> - A histogram of how long the patches were in next (to show bake times)
>> - Are any patches associated with test failures? (0day and many other
>> CIs are already running tests against -next; parse those reports)
>>
>> We could have a real pre-submit checker! :)
>
>That would be very useful.  Items 1 and 2 should be trivial, 3 would
>require a bit of work but would still be very useful.

We could add a report for the above, but:

1. Linus consistently pulls patches that haven't seen the light of day.
2. Linus explicitly objected to making a linux-next a must have.

So unless these results would be actually used, what's the point in
writing all of that?

-- 
Thanks,
Sasha

