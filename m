Return-Path: <linux-kernel+bounces-342539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A65989014
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 132A42825EB
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7553D136327;
	Sat, 28 Sep 2024 15:32:35 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F2914A96
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727537555; cv=none; b=YIZuqbWeYxtITH5/lc4ksfmDIo6DmrOVRbODmaOuR+RsAqGeoyjL/th28f1+PC3oTRTRE5JKIDpy29Eo90/mclDgWbPpZHaV+8a20jfOSvymIzClejP9QLuDB4EdH9dXG4J/YShANrMw6ZLSdPVqI7rgJ8UopldVeLnuj707uy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727537555; c=relaxed/simple;
	bh=auhGgE3bGyAne2vpm+sE22Y7KDft5BCuH3Nb2DmgK3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/V33Owa+glSq3GF3cTEE5kkNHa6/OAeIDCdgG5bLSXXqrs2xfSvwb774Ea0hbM3YG7W3VIYM7v+aUcEyjFI2u7pfNJ1BDwCEitbFYoXuxwAvRM1kaB+EJBTzRAxKTYq/YBFL9T5GOUD7WamtlsBI2yf33382YZloeJIkfBTFWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav313.sakura.ne.jp (fsav313.sakura.ne.jp [153.120.85.144])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 48SFWIN9089327;
	Sun, 29 Sep 2024 00:32:18 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav313.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp);
 Sun, 29 Sep 2024 00:32:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav313.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 48SFWIfL089324
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 29 Sep 2024 00:32:18 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7dce903c-2f76-43b2-bb6f-808cb50d0696@I-love.SAKURA.ne.jp>
Date: Sun, 29 Sep 2024 00:32:18 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] tomoyo update for v6.12
To: Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>
References: <0c4b443a-9c72-4800-97e8-a3816b6a9ae2@I-love.SAKURA.ne.jp>
 <877cavdgsu.fsf@trenco.lwn.net>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <877cavdgsu.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/09/28 22:54, Jonathan Corbet wrote:
>> I was delivering pure LKM version of TOMOYO (named AKARI) to users who
>> cannot afford rebuilding their distro kernels with TOMOYO enabled. But
>> since the LSM framework was converted to static calls, it became more
>> difficult to deliver AKARI to such users. Therefore, I decided to update
>> TOMOYO so that people can use mostly LKM version of TOMOYO with minimal
>> burden for both distributors and users.
> 
> I must confess that this change confuses me a bit.  Loadable LSM modules
> have been out of the picture for a long time, has that changed now?

No, the loadable LSM modules had been in the picture since 2010. There had been
many on-list and off-list discussions for how to support loadable LSM modules.

Since Casey Schaufler had been working on multiple concurrent LSM modules,
with a promise that we won't make changes that make loadable LSMs impossible
( https://lkml.kernel.org/r/ed785c86-a1d8-caff-c629-f8a50549e05b@I-love.SAKURA.ne.jp ),
I was waiting for Casey's work to complete. Meanwhile, I was using loadable
LSMs as out-of-tree code.

> Even stranger, to me at least, is the backdoor symbol-export mechanism.
> That seems like ... not the way we do things.  Was the need for this so
> urgent that you couldn't try to get those symbols exported properly?

Yes. This is a chicken-and-egg problem. Symbols not used by in-tree kernel
code cannot be justified for export, but I can't prove that loadable LSM
can work unless I export symbols. This became an urgent chicken-and-egg
problem due to "static calls" changes which went to this merge window
( https://lkml.kernel.org/r/caafb609-8bef-4840-a080-81537356fc60@I-love.SAKURA.ne.jp ).

KP Singh has suggested an approach
( https://lkml.kernel.org/r/CACYkzJ7_42dhynhmuCBF6z0hyMkYL_FxLR9rM1beCwJVkEv9gQ@mail.gmail.com )
and I posted what KP Singh has suggested
( https://lkml.kernel.org/r/d1e5b74a-5161-4906-96eb-4987ff440d19@I-love.SAKURA.ne.jp )
but Paul Moore refused what KP Singh has suggested
( https://lkml.kernel.org/r/CAHC9VhT_eBGJq5viU8R_HVWT=BTcxesWAi3nLcMgG8NfswKesA@mail.gmail.com ).

Since Paul Moore continues ignoring my concerns, waiting for support of loadable
LSMs at LSM framework layer won't help. I had to express my concerns and
demonstrate/prove that loadable LSM can work immediately. I know that people shall
forget my concerns if I didn't take action right now.

This backdoor symbol-export mechanism is a transitional hack needed for
demonstrating that loadable LSM can work. This hack will be replaced with
proper symbol-export via appropriate trees after this merge window closes.


