Return-Path: <linux-kernel+bounces-205112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E281F8FF793
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 00:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D931F246CD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B04813D884;
	Thu,  6 Jun 2024 22:13:31 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA1B4CB4B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 22:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717712010; cv=none; b=kYhObnYBgGxVwk4l74BkHZfgtLoUaflhbXLXkvZXnnIFWRsfgLMValCoZ5EZyifvQdKkRtBxIYNFLxBz0GC5fHl9qMplGBln/xmrn1SYl2bfY1s8732S3QEf08bq9s6d5qM49ypQCNYPHs2q/CgMLG0YhtzYCNL6jEMCVwEBd0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717712010; c=relaxed/simple;
	bh=YEjcYWyqqMx+i407spGpkuKbTMcr1ntE3BIawNmtirU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nXDb9z8Jox0UYfyt/weaf5A3wp/R5HVNTwXpQpBDUO67sx2cPdO+ivrDRxmvMqPXsFuIjaRPK0JwY0RYN5S2yA+FWfwCa+Vkblcz2gh0QjCeoj7LKp1wHDdMT0Q8Xxfid/di8d4aTSrdeMv9V3axuwph4wOoX54SOeCXOHIwsbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 456MDP2M095630;
	Fri, 7 Jun 2024 07:13:25 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Fri, 07 Jun 2024 07:13:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 456MDOW8095624
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 7 Jun 2024 07:13:24 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d17e8d0c-b292-4915-a61b-1a4c2c496bae@I-love.SAKURA.ne.jp>
Date: Fri, 7 Jun 2024 07:13:25 +0900
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
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CAHk-=wh5Odts_1ZL3gLuxmQBveTWveeWn3equ2JcH2yA9cyjxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/06/07 1:50, Linus Torvalds wrote:
> On Thu, 6 Jun 2024 at 07:40, Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>>   git://git.code.sf.net/p/tomoyo/tomoyo.git
> 
> Tssk, tssk. I want to see a proper pull request from a signed tag.
> 
> I did find the tag in your repo, so I pulled it, but please don't make
> me have to go look for it.

Excuse me, but what did I miss?

I think I made the tag using "git tag -s tomoyo-pr-20240606".
What is "a proper pull request from a signed tag"?
(I'm wondering if this is caused by moving the repository...)


