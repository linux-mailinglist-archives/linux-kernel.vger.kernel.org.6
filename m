Return-Path: <linux-kernel+bounces-205130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 464688FF7BF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 00:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D61101F27366
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1022713DB8C;
	Thu,  6 Jun 2024 22:41:49 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDC713D884
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 22:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717713708; cv=none; b=XMNfaqqIKHI5USibplAbn5ySYBfHoUDw8Moz07vH9VAmGgpRuml/itOP7JswP4J86r6mnBsxcepq5VhCFzFS4xcsPDTUuo1gaOujN4THVnaEB2jX3Ln+WAuEiZB1QQbn2rkPaReM5DpRJy5DnMoqJCe+8zgbD2KXpF8aaZsnx7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717713708; c=relaxed/simple;
	bh=xWCgy38cvDuskInMt7OTyMUpXnOnCk+OcVb+nBt39FA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ueMZ/Qem+Ghxan2mzdzazSttNCWZxlCTZ0/0n9a5P2goYPagaBInbgcvMlDu5/ywuQoTSe41eJizJ7FoflESU5IWaXpXaKq7NrtZvuA28JmuSnUQ/OEmyGgZ7437Zp9hgj/TzZJhvLuAgyFgi4xOowRU6FJO1FrZvaRl69P6iBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 456MfhYO001988;
	Fri, 7 Jun 2024 07:41:43 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Fri, 07 Jun 2024 07:41:43 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 456Mfg0Q001983
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 7 Jun 2024 07:41:43 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e90b6291-7f6e-4e5d-9131-7eb7604f575f@I-love.SAKURA.ne.jp>
Date: Fri, 7 Jun 2024 07:41:43 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] tomoyo update for v6.10
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <c86f0ed7-4336-4bc8-a27c-8d7ccaaec5d8@I-love.SAKURA.ne.jp>
 <CAHk-=wh5Odts_1ZL3gLuxmQBveTWveeWn3equ2JcH2yA9cyjxQ@mail.gmail.com>
 <d17e8d0c-b292-4915-a61b-1a4c2c496bae@I-love.SAKURA.ne.jp>
 <CAHk-=wgU-ybmkd7rA+GcN1fSE+w3Hbm1E_Q0YHO2q5Uoo69pUQ@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHk-=wgU-ybmkd7rA+GcN1fSE+w3Hbm1E_Q0YHO2q5Uoo69pUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/07 7:22, Linus Torvalds wrote:
> On Thu, 6 Jun 2024 at 15:13, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> On 2024/06/07 1:50, Linus Torvalds wrote:
>>> On Thu, 6 Jun 2024 at 07:40, Tetsuo Handa
>>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>>
>>>>   git://git.code.sf.net/p/tomoyo/tomoyo.git
>>>
>>> Tssk, tssk. I want to see a proper pull request from a signed tag.
>>>
>>> I did find the tag in your repo, so I pulled it, but please don't make
>>> me have to go look for it.
>>
>> Excuse me, but what did I miss?
> 
> Note how it doesn't actually mention the tag-name anywhere.

Oops, I didn't notice that

  git request-pull tomoyo-pr-20240606 git://git.code.sf.net/p/tomoyo/tomoyo.git

command does not include the tag name in the output. (Since I previously didn't
need to manually add the tag name, this seems to be caused by moving to the new
repository.)

That line should have been in the following format.

  git://git.code.sf.net/p/tomoyo/tomoyo.git tags/$tagname

I'll add the tag name manually. Thank you for pointing this out.

> 
>> I think I made the tag using "git tag -s tomoyo-pr-20240606".
>> What is "a proper pull request from a signed tag"?
> 
> Oh, the signed tag _existed_. And it was in the public repository. But
> it wasn't actually ever mentioned in the pull-request itself, so I had
> to find it by doing
> 
>     git ls-remote git://git.code.sf.net/p/tomoyo/tomoyo | less
> 
> and then look for the tag that pointed to the commit ID that you mentioned.
> 
> 
>                 Linus


