Return-Path: <linux-kernel+bounces-547671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C1AA50C37
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F223ACB3E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53A125523E;
	Wed,  5 Mar 2025 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kC8w/wzV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACC619D06A;
	Wed,  5 Mar 2025 20:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741205344; cv=none; b=SnZQjAV6qI+Qf/0nLNZh8U2OmHtq1rVTwJQGKcfwOVGsYJPxs1wC6R0Pi8dKfduS5QNtMqNUWIlcqmJrq1ZDgqLNLhyHiWYf9fb66UyjiOj8OkGfeNuibSaj1mT7I9TXCDRfwjrjy79jGQTo8DUWc5NntDDWF/qcHNPnj1Bjc2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741205344; c=relaxed/simple;
	bh=3GEXo0R3oi/i957HgbWWMqT94pZhKmcGNV8yUuiPhGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cvg03almkfb5O82XKYQGCxAK/gMiwg4nCB7gjXlNnTzCmYBiVmnu82k1JHln4sWg+acnWNDQ1XTb9wWgdo8N/y4fIeNxlGm6PVNO08bmLvMv5qlZNV8Te2cH+MiaPVzYG32nrn6wkdr0rTCefslfwvCTeZ1FH07UOm+KZsxbnZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kC8w/wzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F5DC4CED1;
	Wed,  5 Mar 2025 20:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741205343;
	bh=3GEXo0R3oi/i957HgbWWMqT94pZhKmcGNV8yUuiPhGY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kC8w/wzVrOeI+eaIoh+n2wfbPqxzUEDR4IFvOqOpHP7xW1Bbt4+RlNrFiPoRWDSlw
	 Vp72Y9UKlZHt9R5C7Db3lbRKbFrANwLiXSjnqbWvQZHNiwLzDCaBvs1LyMa+S0QD1m
	 VSx3283CCG++gn4F4N1Xvj4DhL5D03QUVak3sC7fR2uvonbTagTpkMHnGC+kANYtgU
	 2iUmPy9wqj5SblPyJMOfsNQpNXALNJ/gIlF6ajNREQUd+RHb/fhdB8aVJ7gi2G5Zgi
	 0b0fqQ3q4W+ueiB/U663TT2rE8cbOac2X7r0Yufwe8nM54WOSbBdea1SiDtxkZ9wcW
	 5HDiKvyX2A0PQ==
Message-ID: <5a284bee-c332-4af2-b7ad-56296e419e18@kernel.org>
Date: Wed, 5 Mar 2025 13:08:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/CoC: Spell out the TAB role in enforcement
 decisions
To: Steven Rostedt <rostedt@goodmis.org>, Jani Nikula <jani.nikula@intel.com>
Cc: Shuah Khan <shuah@kernel.org>, gregkh@linuxfoundation.org,
 corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, conduct@kernel.org, tab@lists.linux.dev,
 Miguel Ojeda <ojeda@kernel.org>
References: <20250304194813.11049-1-shuah@kernel.org>
 <87h647yf8r.fsf@intel.com> <20250305103108.4943e301@gandalf.local.home>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <20250305103108.4943e301@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/25 08:31, Steven Rostedt wrote:
> On Wed, 05 Mar 2025 11:54:28 +0200
> Jani Nikula <jani.nikula@intel.com> wrote:
> 
>> 2/3 actually means 7/10 for the TAB.
>>
>> Except two of the CoC committee members currently serve on the TAB, and
>> will not vote. Assuming they will also not count for the total, 2/3
>> means 6/8 = 75%.
>>
>> All of a sudden you actually need 3/4 majority in the TAB to approve any
>> CoC measures.
>>
>> Perhaps consider using a simple majority instead? The numbers become
>> 6/10 and 5/8.
> 
> I'm a TAB member but I'm speaking for myself and not on behalf of the TAB.
> 
> I rather keep it as is and not move it to a simple majority. If the TAB is
> going to make a decision that may affect the ability of a developer to get
> their work done, the issue had better be substantial where it should have no
> problem getting to 75%. Ideally, it should even be unanimous, but there are
> cases where a member may be involved, and decides to abstain.
> 

I am in total agreement with Steve on this. The way the document reads now
with this change allows for oversight when the CoC, the TAB and the community
is forced to make tough decisions that impact developer's ability to participate
in the development process.

thanks,
-- Shuah

