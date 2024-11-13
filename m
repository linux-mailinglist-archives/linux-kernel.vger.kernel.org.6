Return-Path: <linux-kernel+bounces-407421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEE89C6D33
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C224E1F2359A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3611FEFA1;
	Wed, 13 Nov 2024 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="aMRMp5Cq"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE0A1F9EA7;
	Wed, 13 Nov 2024 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731495348; cv=none; b=lv2DaMHwQxBCrrXrXzPUDBCDGqdDN1csbQeyssFhrhuicUwaK4xTs4b2wLXSlWv3DLZkW3xbQn0WrjToMWySktyWPeWrSZyJwKVhyonxWdfV+qAEoBo5wUxBEwYbJ956q7Ol7cMiRB7OmnDgO64licO42UqNqADCZaFYR0c6IdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731495348; c=relaxed/simple;
	bh=m7wOBRgU2spbrZix7KyEi/LWG891HlE2tVxELfXvML0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4QXVakQ9cTZoRFOsNMkzq8Q7/S/NgH33kjqqq8eYKeSskfzzSoaK/aa9tL7jxZAB42u5PEY/oOyZbdE87O6sOXjPp0EbEsrR1NDdJdgabdWalbW61S7QH4TaYcOEEyaVQ1aGPDonpcgCj9E1V600W6DbxMW/umQZSebBdBT4Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=aMRMp5Cq; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=nsjEypAraY2ONLP3l2i6Y2FBtdzcLBx8eOibBcrRQ2Q=; t=1731495346;
	x=1731927346; b=aMRMp5CqEyzgBWUyCR2G/hJH2H6lKLsQMzUQ16oVqdEPlf9u9xMuXQh91COWp
	dPG0HPdD8olQ0TqJZpJUWYvBSqKSciGFWXJ5xPLRzdccvUj3hnkyH6FL9jJZDs82fqmNkTbP43kTz
	rSneNSTe0RJzGYRwdkgvj3ML9hMTZOpBT11LJMrDHDmoHZW70gnvoO8EMGcTR3MP1b0Aj5n/HL9J6
	Wd37lXiEuYxYK5r6ZSv4GoxfV+P0bD4Pjj+w3CsfacxqOcbFZg0FLa9t/Sl8l3QpjEb/AX6k/RNaR
	douhTaGC64Mstb1RrTaUGkeTmUROvYvslKtxMIejZ9ct3yDJvg==;
Received: from [2a02:8108:8980:2478:87e9:6c79:5f84:367d]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1tBB2C-0003XN-Nz; Wed, 13 Nov 2024 11:55:40 +0100
Message-ID: <b160f728-b34f-433d-8cc4-677605990936@leemhuis.info>
Date: Wed, 13 Nov 2024 11:55:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] docs: reminder to not expose potentially private email
 addresses
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <f5bc0639a20d6fac68062466d5e3dd0519588d08.1731486825.git.linux@leemhuis.info>
 <20241113102619.GC29944@pendragon.ideasonboard.com>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: en-MW
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <20241113102619.GC29944@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1731495346;636977f5;
X-HE-SMSGID: 1tBB2C-0003XN-Nz

On 13.11.24 11:26, Laurent Pinchart wrote:
> On Wed, Nov 13, 2024 at 09:35:03AM +0100, Thorsten Leemhuis wrote:
>> Remind developers to not expose private email addresses, as some people
>> become upset if their addresses end up in the lore archives or the Linux
>> git tree.
>>
>> While at it, explicitly mention the dangers of our bugzilla instance
>> here, as it makes it easy to forget that email addresses visible there
>> are only shown to logged-in users.
>>
>> These are not a theoretical issues, as one maintainer mentioned that
>> his employer received a EU GDPR (general data protection regulation)
>> complaint after exposuring a email address used in bugzilla through a
>> tag in a patch description.
>>
>> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
>> ---
>> Note: this triggers a few checkpatch.pl complaints that are irrelevant
>> when when ti comes to changes like this.
>>
>> v1:
>> - initial version
>> ---
>>  Documentation/process/5.Posting.rst          | 17 +++++++++---
>>  Documentation/process/submitting-patches.rst | 27 +++++++++++++++++---
>>  2 files changed, 36 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
>> index b3eff03ea2491c..1f6942948db349 100644
>> --- a/Documentation/process/5.Posting.rst
>> +++ b/Documentation/process/5.Posting.rst
>> @@ -264,10 +264,19 @@ The tags in common use are:
>>   - Cc: the named person received a copy of the patch and had the
>>     opportunity to comment on it.
>>  
>> -Be careful in the addition of tags to your patches, as only Cc: is appropriate
>> -for addition without the explicit permission of the person named; using
>> -Reported-by: is fine most of the time as well, but ask for permission if
>> -the bug was reported in private.
>> +Note, remember to respect other people's privacy when adding these tags:
>> +
>> + - Only specify email addresses, if owners explicitly permitted their use or
>> +   are fine with exposing them to the public based on previous actions found in
>> +   the lore archives. In practice you therefore often will be unable to hastily
>> +   specify addresses for users of bug trackers, as those usually do expose the
>> +   email addresses at all or only to logged in users. The latter is the case
>> +   for bugzilla.kernel.org, whose privacy policy explicitly states that 'your
>> +   email address will never be displayed to logged out users'.
>> +
>> + - Only Cc: is appropriate for addition without the explicit permission of the
> 
> Isn't Cc: as problematic as any other tag, is it ends up in both the git
> history and the lore archive ?

Hmmm. Good point, thx for bringing this up. And of course it is. But
it's the second point in a list and thus should not overrule the first
one. But I can see that it could be read like that. :-/ Up to some point
I even was aware of it, as the added "given the above constraints" later
in that point shows. But I guess I wanted to stay close to the previous
text and that is not sufficient.

Hmmm. So how about writing the second point like this:

"""
Even if the email address is free to use in tags, it is only appropriate
to use in Cc: without explicit permission of the person named; using it
in Reported-by: likewise is often appropriate as well, but ask for
permission for bugs reported in private.
"""

Hope that "likewise" is sufficient here...

>> +   person named; using Reported-by: is fine most of the time as well given the
>> +   above constraints, but ask for permission for bugs reported in private.
> [...]

Ciao., Thorsten

