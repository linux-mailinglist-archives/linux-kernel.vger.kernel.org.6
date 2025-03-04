Return-Path: <linux-kernel+bounces-545639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FFAA4EF7F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20057188FA53
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FB4277028;
	Tue,  4 Mar 2025 21:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7M13DMR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ADC24C06A;
	Tue,  4 Mar 2025 21:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741124611; cv=none; b=qcS/Uo3TqQuDJyZ9krtrtLWjv5pQKF+xnVpCd+SoC6X//Qt1DIA+O1vLSUP90GNOCGRVXnw71kgqFLOMg7kxDwDk77+zYFYG7aMzBB/wpnQht0ZDJ+Tj47Mn6dSsH1wBjwyTOChBAwRCWwFMzNJQVGZ/TKnz8zFv1rHm0HovQ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741124611; c=relaxed/simple;
	bh=poIfZ6zxpAupZhduwjOEwwCNb5TCatwUR+RgFojwMQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GqUergLfBiSJYUQ51zPw14iTX6Y9SSlM9Pt0aGyH9yzkkZSwqI1VWT/3i8fqzqTZ3bCRXrxTIqtoygi939FwLJE+wzTCh4/8B/hn1HBzEFwi3E8MLCQQzt08eMwksAdud9bFWJs6H3WQP/EiAqAWs7h+2W342scM/+18JlT7rH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7M13DMR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8D8C4CEE5;
	Tue,  4 Mar 2025 21:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741124610;
	bh=poIfZ6zxpAupZhduwjOEwwCNb5TCatwUR+RgFojwMQU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m7M13DMRjwg+vDheRJTY+qkx6bKmvLxcYOQpZXq1uAj0Lo11e5hVpGofX/NDmd/Ww
	 Eg4BwxN9BIo1acUHnq1sDEwnXrdWNFizQ4a6sUB+DkrVgPWZ1AAZXMkd00CYdbwpCS
	 juAV+L4Nvoqt64c1Qk3IAoMGOIaXCxiZVoqqD5h75RCjBdJFXJRfd5mZMEwuDmRIgK
	 P7R6gM4mIdIOxiyDdBTXD3BhtxlSpvHcK5LaGrCC+hoocZRt2IfhJBfwL1CWpiHtgx
	 NEzO4orCP5eqyr8kLxVZPx5nlIvgOpuF7a4qf/lMjtgXXZbBOzS+5m57eT0xOfMsyw
	 5WOfTT8RL7xxA==
Message-ID: <2b3aad9e-5288-45d5-bcdd-9dbc4f7298b4@kernel.org>
Date: Tue, 4 Mar 2025 14:43:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/CoC: Spell out the TAB role in enforcement
 decisions
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Shuah Khan <shuah@kernel.org>
Cc: gregkh@linuxfoundation.org, corbet@lwn.net, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, conduct@kernel.org,
 tab@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
References: <20250304194813.11049-1-shuah@kernel.org>
 <20250304200947.GF30583@pendragon.ideasonboard.com>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <20250304200947.GF30583@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/25 13:09, Laurent Pinchart wrote:
> Hi Shuah,
> 
> Thank you for the patch.
> 
> On Tue, Mar 04, 2025 at 12:48:12PM -0700, Shuah Khan wrote:
>> Updates to clarify and spell out the TAB role in approving and overturning
>> enforcement measures for Code of Conduct violations.
> 
> As with any technical change, I think it would help reviewers if the
> commit message could explain *why* this change is appropriate at this
> time. For instance, it would be good to know if this is meant to ensure
> the document clearly describes the existing practices without a change
> of rules, or if there's another reason.

This change is to clarify and clearly describe the scope and role the
TAB plays in making decisions on violations that don't resolve. When
the CoC has to make a call on instituting a ban, it doesn't act without
the TAB's approval and when the TAB okays it with 2/3 vote in favor.

This is an update to the rules spelled out a few months ago and to
ensure the document is consistent throughout.
> 
> Without an explanation of the intent, the CoC and TAB would appear more
> opaque, especially given the tags present on v1 that shows the patch has
> been discussed behind closed doors.

No decisions are made behind the closed doors. As mentioned above, the
document had inconsistent in when it described the TAB role. This patch
is fixing the inconsistency.

> 
>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Acked-by: Miguel Ojeda <ojeda@kernel.org>
>> Acked-by: Steven Rostedt <rostedt@goodmis.org>
>> Acked-by: Jonathan Corbet <corbet@lwn.net>
>> Signed-off-by: Shuah Khan <shuah@kernel.org>
>> ---
>>   .../process/code-of-conduct-interpretation.rst  | 17 +++++++++++------
>>   1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/Documentation/process/code-of-conduct-interpretation.rst b/Documentation/process/code-of-conduct-interpretation.rst
>> index 1d1150954be3..4cdef8360698 100644
>> --- a/Documentation/process/code-of-conduct-interpretation.rst
>> +++ b/Documentation/process/code-of-conduct-interpretation.rst
>> @@ -145,13 +145,16 @@ kernel community.
>>   
>>   Any decisions regarding enforcement recommendations will be brought to
>>   the TAB for implementation of enforcement with the relevant maintainers
>> -if needed.  A decision by the Code of Conduct Committee can be overturned
>> -by the TAB by a two-thirds vote.
>> +if needed.  Once the TAB approves one or more of the measures outlined
>> +in the scope of the ban by two-thirds of the members voting for the
> 
> There was no mention of "ban" in this section, is the addition of that
> word on purpose ?

It previously stated that the TAB can overturn any decision made by CoC.
This document moves it into a direction where the CoC will not act without
the approval from the TAB. This applies to if and when "ban" is required
which is rather infrequent. This word "ban" is not a new addition to the
document in this patch as it is mentioned in the last paragraph in the
"Remedial measures" section.

The reason for adding the word "ban" here is to make the text consistent
with the "Remedial measures" section.

> 
>> +measures, the Code of Conduct Committee will enforce the TAB approved
>> +measures.  Any Code of Conduct Committee members serving on the TAB will
>> +not vote on the measures.
> 
> We're switching from a 2/3 majority to *not* implement a recommendation
> to a 2/3 majority to implement it. Without judging the merit of this (at
> first sight I feel positive about the change), I think it's worth
> explaining why.

Right. I think this is a positive change and gives the TAB oversight
on the CoC decisions before they are enforced as opposed afterwords.

I can add the above explanation to the change log.

thanks,
-- Shuah

