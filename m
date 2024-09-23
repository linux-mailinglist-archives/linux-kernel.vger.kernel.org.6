Return-Path: <linux-kernel+bounces-336296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA75F97F1BF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 22:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692BD1F21CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA795558A5;
	Mon, 23 Sep 2024 20:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Y3C7Ievs"
Received: from smtp.smtpout.orange.fr (smtp-21.smtpout.orange.fr [80.12.242.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C813A14A85
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 20:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727124376; cv=none; b=s80wquKyBkPmbEXdbYlexQpq/j8ycehkebMU3G03d04O1RsijtIPMf9uN07XxOWGKNno8AolzWMspPzapFRtdnD1dj6sMnAOHKPl70xUwfmdGmDGj0rr6pkuNYPThx8tpXYgOwQTnJnzAbYinFZ+j1p9+ZCMqpEjE1obdmvErqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727124376; c=relaxed/simple;
	bh=GuLuQV0ewbtao+0zG2F3SbACCmoaakn65TWd8ZbSaPM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Uko9z+UIjVIKNrO6JnS8VrhK4CLHYLz/SwYiNwbB3e5RAnfyRK+zcZOObttgfc7Psk6gUYHEVFkuGY4MtL1/NJFzf6b7olhOfXFOlFtPkpRR4sJ8mM998Ap7MGmV349cweAwhdKTrMA+hjnUpjOtIBRKHndrFgv/4tXAdYMw0Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Y3C7Ievs; arc=none smtp.client-ip=80.12.242.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id spvasjIY6OTuTspvbsvqOR; Mon, 23 Sep 2024 22:45:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1727124304;
	bh=iV/9JBd2mWppZGg0Oqn0pi7BbFDFWIpng6L7w9taKt0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To;
	b=Y3C7IevsQZ4FEiLlUrAQg+ITZwpE+QDT5bq81GzdzK/E5eR4GM0mkEHmNAgg4Pnaf
	 UkxAeTz6nOfbQIDeXmxjBjwCAOCeIEEOANohToV5NIlFvLgBYU5rqyBXll5tE8ecO0
	 WpaRBm5WcLEk4vU7f2glwSvQJpO5iQac8b+H3ZYVOExw0CRsYn0+5vmKOF928tfSXp
	 blKJ5rA5fYLM7ZqkYlcOvo7DNcWYXilbznmZgpheb5AKwIq3YSV5VH6kA5/UrpSMKg
	 MH1BavVZFPfDCj2gcCubGsfsHBw9PiExPDMFz8xp9hOfAkkfvj4QxJm1frCH7sOark
	 zouhk5mXeSttA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 23 Sep 2024 22:45:04 +0200
X-ME-IP: 90.11.132.44
Message-ID: <470de7f0-3f2d-444b-a949-9db6040cf371@wanadoo.fr>
Date: Mon, 23 Sep 2024 22:45:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] jfs: fix array-index-out-of-bounds
To: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Cc: shaggy@kernel.org, ghandatmanas@gmail.com, jlayton@kernel.org,
 eadavis@qq.com, brauner@kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org,
 syzbot+808f3f84407f08a93022@syzkaller.appspotmail.com
References: <20240922110000.128650-1-ghanshyam1898@gmail.com>
 <c9f80af9-4cf0-4b6e-8c61-4b7a6f287cd9@wanadoo.fr>
 <CAG-BmocfstJNC-JDgtx93EJmg5kMANu4tVRbjqYtZ1CE+AEnEg@mail.gmail.com>
Content-Language: en-US, fr-FR
In-Reply-To: <CAG-BmocfstJNC-JDgtx93EJmg5kMANu4tVRbjqYtZ1CE+AEnEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 23/09/2024 à 05:35, Ghanshyam Agrawal a écrit :
> On Sun, Sep 22, 2024 at 8:35 PM Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>>
>> Le 22/09/2024 à 13:00, Ghanshyam Agrawal a écrit :
>>> In some cases, dn_numag may be greater than MAXAG which may
>>> result in an array-index-out-of-bounds in dbNextAG. Added
>>> a check to return an error code before we crash.
>>>
>>> Reported-by: syzbot+808f3f84407f08a93022@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=808f3f84407f08a93022
>>> Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
>>> ---
>>>    fs/jfs/jfs_imap.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
>>> index 2ec35889ad24..5088da13e8f1 100644
>>> --- a/fs/jfs/jfs_imap.c
>>> +++ b/fs/jfs/jfs_imap.c
>>> @@ -1360,6 +1360,9 @@ int diAlloc(struct inode *pip, bool dir, struct inode *ip)
>>>        if (agno < 0 || agno > dn_numag)
>>>                return -EIO;
>>>
>>> +     if (unlikely(dn_numag > MAXAG))
>>
>> Hi,
>>
>> looking at other places with checks with MAXAG, I wonder if it should be >=?
>>
>> CJ
>>
>>> +             return -EIO;
>>> +
>>>        if (atomic_read(&JFS_SBI(pip->i_sb)->bmap->db_active[agno])) {
>>>                /*
>>>                 * There is an open file actively growing.  We want to
>>
> 
> Hello Christophe,
> 
> Thanks for reviewing my code. I believe the greater than symbol I have
> set is correct in this case. 

I think it's not.

If you have "if (unlikely(dn_numag > MAXAG))", then

	- dn_numag can be = MAXAG
	- [2] - so, agno can be = MAXAG as well
	- [3] - and, accessing memory past the end of the array will happen, 
because db_active is atomic_t db_active[MAXAG];
	- BUG

Or I miss something obvious?

> Can you please check it thoroughly and letme know wny it should be >= ?

Well, usually things don't work that way.

YOU propose to fix something, which is nice. So YOU should explain why 
it is correct.

If I'm correct, the way to see that your fix is incomplete is just in 
the 3 or 4 lines just above and below your change.

You've been told what could be wrong, you could have checked yourself. 
Or explained the reasoning that makes you think it is correct.



Sorry if my answer looks rude, it is not my intend. I just read your 
answer as "can you do my home work for me", which is certainly not you 
intend either.

So, no hard felling, but a bit disappointed by the lack of curiosity.

CJ

> 
> Thanks & Regards,
> Ghanshyam Agrawal
> 


[1]: https://elixir.bootlin.com/linux/v6.11/source/fs/jfs/jfs_imap.c#L1363

[2]: https://elixir.bootlin.com/linux/v6.11/source/fs/jfs/jfs_imap.c#L1363

[3]: https://elixir.bootlin.com/linux/v6.11/source/fs/jfs/jfs_imap.c#L1366


