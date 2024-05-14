Return-Path: <linux-kernel+bounces-178993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69CB8C5A2E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ACBD2812BC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC79E17F39D;
	Tue, 14 May 2024 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJsUwWBx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388CA17EBB9
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715707167; cv=none; b=ZsD1EI+qg/I5mXgvIzKUZ2V61gyQOwOuSMeTaBVC1mT7Dw+Q0vbEJZszMaEdJRXieOIIuKGFN96g8xK37FDV8+dyFCHCLLlIXD3wimxLBjf1bbdlaF7CCzl+sqFweBKY+/GtIzjWPShtqsKB7Wz1UbRuLDmMsHKeHMOwkq25ivU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715707167; c=relaxed/simple;
	bh=WLOY6GkQZoED2J/u4zbP1uV7bKZu5qshW2EYILg8fvc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=h2rH+kFtHG3aJh1qtJFf7TarKHmULx42aJkWOSz0u5OZh6k27mVu8H9XD8LfstWzM113y3lpjDHKFTdQBXINyoZU32aNgazNGKonj0bbEW6YGe0D9tixJO6N2AkpdxGoIyUG/R/OzMcRgpYvKXIXQLNzvlYjUtLq+zJf4jaX/0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJsUwWBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 144CFC2BD10;
	Tue, 14 May 2024 17:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715707167;
	bh=WLOY6GkQZoED2J/u4zbP1uV7bKZu5qshW2EYILg8fvc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NJsUwWBxJXEjS0ckGD7/A0ewoQ5oa3d7egxNT2TwG9t4bp9ak4THd7prC0Q8BZe7K
	 yBo7JHVYwyoMveeAZwjMVhRhbCMb0LgO3NaQ0qK0RyJvrR0mGLw9O7oGJ54Uvqd80K
	 7NA2ydQ16KRn1p4u716wWYB/8ts86M+gQ6hj1U/cyn0185U40xeDjWVQ638rvyUz8X
	 JoeGCN2WN7q8SNBqS27fCxpH603Ut0biA2UpvKeizQ4NB39Y8FTnF4JmbAJWX07O91
	 15+kst6mS28KeAm9bozM3ZzCI8LnoZe5ot1vUnOZApIVNoeotp1DwKr93Q22rQAK01
	 Jg4MQOBDxD4xw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01293C1614E;
	Tue, 14 May 2024 17:19:27 +0000 (UTC)
Subject: Re: [GIT pull] x86/irq for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: 
 <171560454884.3871325.5522975131804736634.tglx@xen13.tec.linutronix.de>
References: 
 <171560454635.3871325.5773365584560034962.tglx@xen13.tec.linutronix.de>
 <171560454884.3871325.5522975131804736634.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: 
 <171560454884.3871325.5522975131804736634.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-irq-2024-05-12
X-PR-Tracked-Commit-Id: 6ecc2e7932fe8f132d3b671685f9995785f19e9a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9776dd36095be19f5a0ad9f07a4fc221d2a0609a
Message-Id: <171570716698.18083.11491053659534734038.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 17:19:26 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 14:50:01 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-irq-2024-05-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9776dd36095be19f5a0ad9f07a4fc221d2a0609a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

