Return-Path: <linux-kernel+bounces-248927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E25F192E3F9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897571F22E72
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0FB157495;
	Thu, 11 Jul 2024 10:01:18 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6467538B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692078; cv=none; b=IhY5kauF4kc5nl+EzAKRmdfJ8e2TymXKAOAgrhzzsggZd6PV6iI4DTAHKpbjgyAyVs5XSF5+y1GMLAlojhvaTYdh5puLmks6xr/6l21Ce4U54kQ5n95guNjMkDx/Gg5SmKvzHSuWHhS3C1VhYLcE8hVKaqHZb6nMtjmBDCg3BYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692078; c=relaxed/simple;
	bh=/wRoiK4z1j+sCQMLewQoexYt71KmqQB/4hqpd7urLoY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Bz9KATC7uGgVrRoKlEtpl4LCOgHEPpw/oNYrlPFYQ+QE8Q1bluA4zH+5eOFDc/67xm3TXRewf1vlzTg1kkEhyjFYawi+zxuhyhuT1qvg0UvlKfEJDRS71dv71xko/5QIeYlL9Z8wF7jHJJgDCmylnkn9oVt3VAMVh+ch82WN4J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 46BA1Boq018742;
	Thu, 11 Jul 2024 19:01:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Thu, 11 Jul 2024 19:01:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 46BA1Bjt018737
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 11 Jul 2024 19:01:11 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <da61490f-2d28-45ce-a6ba-2d424f50557a@I-love.SAKURA.ne.jp>
Date: Thu, 11 Jul 2024 19:01:09 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] orphaned fixes
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <a2775599-67a8-4b4e-a9df-c0da021fe59c@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <a2775599-67a8-4b4e-a9df-c0da021fe59c@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Which approach do you prefer, Linus?

On 2024/06/25 13:53, Tetsuo Handa wrote:
> These are orphaned patches which nobody can take (and as a result bugs
> remain unfixed for years). These patches have been tested using linux-next
> tree via my tomoyo tree since 20240611, and nobody found problems.
> 
> I send to you as per THE REST rule in MAINTAINERS file. Do you want me
> to send these patches as a git pull request (or not worth creating tags
> for pull requests) ?
> 
>   [PATCH 1/2] profiling: initialize prof_cpu_mask from profile_online_cpu()
> 
>     kernel/ksysfs.c  | 27 ++++++++++++++++++++++-----
>     kernel/profile.c |  6 +++---
>     2 files changed, 25 insertions(+), 8 deletions(-)
> 
>   [PATCH 2/2] Input: MT - limit max slots
> 
>     drivers/input/input-mt.c | 3 +++
>     1 file changed, 3 insertions(+)


