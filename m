Return-Path: <linux-kernel+bounces-294378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 723CD958CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F22DB2126A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABF81BB69B;
	Tue, 20 Aug 2024 17:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="wh4IxtXn"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328FE101C4;
	Tue, 20 Aug 2024 17:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174196; cv=none; b=EE9JUSm4KjnBVvlhQAbSs8K9LL0+JEVPlWib6X1xtLWkwHmfpbtl2IuTH6aQaXT+itTlPjLBh2D0bZxXzYI16KbKVZCCGXioAd94Lq46jkE9dYtLbcp61LRuu4ni55FH+iVP1I/RgYWrD+aE05efrliPopjfFSBVu7+0EGBPoPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174196; c=relaxed/simple;
	bh=KlsDqUJM1mHlRFZZFUQbW7vF2f4ODUm8dttJhifoJp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ure30b4Ndnbq2fWmin497ymrSVregGElm/zSDFxmbdE5NllUQqY4G3jsSg93Co0DCxdow6dN7HLo41FuCcX/QZCnAahXX1CG2Tf0O60eewnSdPyxcmn9/HnLFN9q2891n62h3h/7IFGTYknJjl8EELGvDWGrvT3nJXLkGY+rlt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=wh4IxtXn; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=2kmbQKZObU3hlHNGeGrG2jsrvoxmn7benNNYZxhr1dM=; t=1724174194;
	x=1724606194; b=wh4IxtXn88nm8TrO5LcCBDm41I7zTjm0/mqhiC4yd2+s+qxbMkpwIowzNN7cd
	iEhqIbl0/Wo48w04OLmq+cRM6DbBL4oFB3RaoMeR7vaOVXlKI4ccpuI5O6eAFB9zdfHlN1KjC/1ja
	JRMQiTOwJlYBuzGO4ihcsGI+N6dznZdggtJUJHloUJCU9j2PcjDFUP9TQtPXe1G3HlKHZxS9uFXXP
	PYaQ5LVaA6xFfy765q1911KkuvHXD5g4DtfBdY5jnCcRqwO6svCF7NZjYqsSIM0IJmTpvawjNUSHQ
	r3hF8X7XMt+hy3jRcmH67yxImym0mfCOZ+TAFpM14YmubwX7pg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sgST5-0004pl-Gt; Tue, 20 Aug 2024 19:16:27 +0200
Message-ID: <e6681b51-297e-4ef8-a199-d36712088740@leemhuis.info>
Date: Tue, 20 Aug 2024 19:16:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: bug-bisect: rewrite to better match the other
 bisecting text
To: Petr Tesarik <ptesarik@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net>, regressions@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bagas Sanjaya <bagasdotme@gmail.com>
References: <fbeae4056ae8174f454c3865bc45633281bb1b31.1723997526.git.linux@leemhuis.info>
 <20240820140751.0e024f21@mordecai>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: en-US, de-DE
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <20240820140751.0e024f21@mordecai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1724174194;02ac1176;
X-HE-SMSGID: 1sgST5-0004pl-Gt

On 20.08.24 14:07, Petr Tesarik wrote:
> On Sun, 18 Aug 2024 18:12:13 +0200
> Thorsten Leemhuis <linux@leemhuis.info> wrote:
>
>> Rewrite the short document on bisecting kernel bugs. The new text
>> improves .config handling, brings a mention of 'git skip', and explains
> Nitpick: git bisect skip

Ohh, one of those cases where one misses the most obvious mistakes. Thx
for pointing this out!

Also: many thx for your feedback in general, performed a most of the
changes you suggested (thx again), only replying to a few other bits.

 
> But it's still difficult to parse for me. Maybe it would be better to
> reorder the sentence like this:
> 
>   After issuing one of these commands, if Git checks out another
>   bisection point and prints something like 'Bisecting: 675 revisions
>   left to test affter this (roughly 10 steps)', then go back to step 1.

Chose to do it slightly different:

   After issuing one of these two commands, Git will usually check out another
   bisection point and print something like 'Bisecting: 675 revisions left to
   test after this (roughly 10 steps)'. In that case go back to step 1. 

>> +  Git might reject this, for example when the bisection landed on a merge
>> +  commit. In that case, abandon the attempt. Do the same, if Git fails to revert
>> +  the culprit on its own because later changes depend on it -- at least unless
>> +  you bisected using a stable or longterm kernel series, in which case you want
>> +  to retry using the latest code from that series.
> 
> Admittedly, this paragraph left me a bit confused. So, what is your
> suggestion if I bisected using a stable or longterm kernel series (BTW
> shouldn't we use Git-speak and call it a branch?)

Not having a strong opinion here, but I'd say "series" is the better word
here; but maybe "using" should go (see below).

> and Git fails to
> revert the commit because some later changes depend on the commit?
> Are you trying to say I should check out the current head of that
> stable or longterm branch and retry the revert there?

Yeah. Changed the text slightly; does it make things better?
 
  Git might reject this, for example when the bisection landed on a merge
  commit. In that case, abandon the attempt. Do the same, if Git fails to revert
  the culprit on its own because later changes depend on it -- at least unless
  you bisected a stable or longterm kernel series, in which case you want to
  check out its latest codebase and try a revert there.

> Overall, it all looks good to me.
> Thank you very much for your effort!

Thx for saying that, the time your spend, and your feedback, 
much appreciated!

Ciao, Thorsten

