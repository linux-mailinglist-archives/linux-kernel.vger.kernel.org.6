Return-Path: <linux-kernel+bounces-411722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E60D9CFED0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 13:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D2328505A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 12:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482B1194A52;
	Sat, 16 Nov 2024 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="VnU3IBXy"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B89418C039;
	Sat, 16 Nov 2024 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731760070; cv=none; b=Ly7Uluui1wepyq5eyLCneIdcyojaK8ypyK6ZcOnhWn+i3AH5ZA4YYl8VhqCEwYhoW2FZjoJCLeB7ztTl3LY/0fQB9d0r/kxfNAPY8K/pNfMREyu9TV1vzA3pn1Zn+MtViEf84GpDZzBG2T+cqDjpI/gpv87kZkdXKmSNS0+dPqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731760070; c=relaxed/simple;
	bh=iYCc8StsaIkCNaozpXqnKULrIaBSgY6FwKGrf6Ooms0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fU0Me65autZX+mXYN057o3I6h8wkNuOup5DQR4wz2IuAA/gqWu7lXytkiJZV/ucL19yMO2WDHoRXSNVBOYWK2pMBqhNU8F4Cz5IaiJvDAG8YXlLff4ziGZcyy+8HUjtsjgGwT2Yf1to/fUeA1RD9FtFczHDV6TWVz0kfq6vyVWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=VnU3IBXy; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=cIISuGw0Sz9j9PuwJvRMaFaJ8tfFFftKTKr58YfazZI=; t=1731760068;
	x=1732192068; b=VnU3IBXy4fC4rSjlkQorYsM2XAyJU5HSel5mi9PMGofurB4ML3eQHDmngp2Kh
	VzPMgCK5rR9x1kDeShUAtnH1LFrb7kLAta4D4r883ALkjxwI8MsTb9503g7Pcze7dPq/bvgRQnGJg
	gs53vJt9xnEkLBx8nVQYo8/pclkibpZW0mEF0Lbl/aAqfnq/nY65OVCYEmDxNKGo0BAWbs19bSu6Z
	/DR99EhZHbn3ylrdNETJsq9pyTkQiEg+WGuXFTrv4Wx5f7QAYvFqlMdv0gRbYTw9nsL61sTMG6SEf
	IcgfYvZ61W3A7mLKlRCkJARUiBBAhfxta6SdWPakUpXWCwTPZA==;
Received: from [2a02:8108:8980:2478:87e9:6c79:5f84:367d]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1tCHtw-0004ke-Rc; Sat, 16 Nov 2024 13:27:44 +0100
Message-ID: <7491b60c-3e46-4425-aef5-63021538c33d@leemhuis.info>
Date: Sat, 16 Nov 2024 13:27:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] docs: clarify rules wrt tagging other people
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
References: <cover.1731749544.git.linux@leemhuis.info>
 <b7dce8b22a391c2f8f0d5a47bf23bc852eca4e71.1731749544.git.linux@leemhuis.info>
 <2024111651-slather-blabber-857f@gregkh> <20241116125003.43bf305c@foz.lan>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: en-MW
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <20241116125003.43bf305c@foz.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1731760068;c2d10e7e;
X-HE-SMSGID: 1tCHtw-0004ke-Rc

On 16.11.24 12:50, Mauro Carvalho Chehab wrote:
> Em Sat, 16 Nov 2024 11:42:06 +0100
> Greg KH <gregkh@linuxfoundation.org> escreveu:
>> On Sat, Nov 16, 2024 at 10:33:59AM +0100, Thorsten Leemhuis wrote:
>>> Point out that explicit permission is usually needed to tag other people
>>> in changes, but mention that implicit permission can be sufficient in
>>> certain cases. This fixes slight inconsistencies between Reported-by:
>>> and Suggested-by: and makes the usage more intuitive.
>>>
>>> While at it, explicitly mention the dangers of our bugzilla instance, as
>>> it makes it easy to forget that email addresses visible there are only
>>> shown to logged-in users.
>>>
>>> The latter is not a theoretical issue, as one maintainer mentioned that
>>> his employer received a EU GDPR (general data protection regulation)
>>> complaint after exposing a email address used in bugzilla through a tag
>>> in a patch description.
>>>
>>> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>> Cc: Simona Vetter <simona.vetter@ffwll.ch>
>>> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>>> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
>>> ---
>>> Note: this triggers a few checkpatch.pl complaints that are irrelevant
>>> when when to comes to changes like this.
>>>
>>> v2:
>>> - Retry differently. This slightly hardens the rule for Reported-by:
>>>   while slightly lessening it for Suggested-by:. Those in the end are
>>>   quite similar, so it does not make much sense to apply different ones.
>>>   I considered using an approach along the lines of "if you reported it
>>>   in pubic by mail, implicit permission to use in a tag is granted"; but
>>>   I abstained from it, as I assume there are good reasons for the
>>>   existing approach regarding Suggested-by:.
>>> - CC all the people that provided feedback on the text changes in v1
>>>
>>> v1: https://lore.kernel.org/all/f5bc0639a20d6fac68062466d5e3dd0519588d08.1731486825.git.linux@leemhuis.info/
>>> - initial version
>>> ---
>>>  Documentation/process/5.Posting.rst          | 17 ++++++--
>>>  Documentation/process/submitting-patches.rst | 44 ++++++++++++++------
>>>  2 files changed, 45 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
>>> index dbb763a8de901d..b45c4f6d65ca95 100644
>>> --- a/Documentation/process/5.Posting.rst
>>> +++ b/Documentation/process/5.Posting.rst
>>> @@ -268,10 +268,19 @@ The tags in common use are:
>>>   - Cc: the named person received a copy of the patch and had the
>>>     opportunity to comment on it.
>>>  
>>> -Be careful in the addition of tags to your patches, as only Cc: is appropriate
>>> -for addition without the explicit permission of the person named; using
>>> -Reported-by: is fine most of the time as well, but ask for permission if
>>> -the bug was reported in private.
>>> +Be careful in the addition of tags to your patches, as nearly all of them need
>>> +explicit permission of the person named.
>>> +
>>> +The only exceptions are Cc:, Reported-by:, and Suggested-by:, as for them  
>>
>> I don't understand what you mean by "only exceptions" here.  Exceptions
>> to what?
>>
>>> +implicit permission is sufficient under the following circumstances: when the
>>> +person named according to the lore archives or the commit history regularly
>>> +contributes to the Linux kernel using that name and email address -- 
> 
> Note that get_maintainer.pl doesn't use a concept of "regularly", and it
> doesn't really matter if one has just one or dozens of patches, once it 
> has a patch merged with his address, it is now public, as git log will
> keep it forever.
> 
> Also, if a patch authored by "John Doe <john@doe>" causes a regression, 
> a patch fixing the regression should be Cc: to him, even it it was his
> first contribution.
> 
> So, having a single patch accepted is enough to have other patches
> with meta-tag pointing to a name/email.
> 
> So, this would be better:
> 
> 	... or the git commit history contains that name and email address

Good point. But we are getting closer and closer to areas where I feel
out of my league as IANAL without any backing from company lawyers if
this leads to problems down the road.

To still feel comfortable, I would change this to something like:
"""
... or a commit with a 'Signed-off-by' tag containing that name and
email address.
"""

Because one accidental expose of a name and email address (say in a CC:
tag) by a some other developer should not be enough to allow other
developers to expose it again. Highly unlikely corner case, yes, but I
feel better that way. And in the end it should not make much of a
difference.

Ciao, Thorsten

