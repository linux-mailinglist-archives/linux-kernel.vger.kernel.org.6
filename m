Return-Path: <linux-kernel+bounces-415038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D90959D30F5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0120283E6B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 23:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561B21D79BB;
	Tue, 19 Nov 2024 23:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjxHEGKu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54341C4A22
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 23:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732059215; cv=none; b=Td8Dw8SlvKmrz7LTGstSpWL14uandakGn5/5Yuo7ASMuJaDTE7QwR2jyMEXMvBAJmIsoSP5XyKa12Kv21sxs+9u878HXiFkzQGUwaK3NwqztKNS5ZOF9KfnuupsSszuGYk7VY6z8x8ZdmjOU5ALFZnxStLPw05s+XwYcmnuCwf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732059215; c=relaxed/simple;
	bh=WRrkPtEd4IwzGmc/VdCQEhnEP0TpAkwphO9fPgThhW4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jTZDcSIoSOU5s7SPngvqhIqlkSINURtCNWZymIPn83h/PzsOjj2QfzyMhFigO/Vb0UwLbHNjnrbwqsPr5EzqBeHWtcMzCpX2eunVkuXtvrMi9AW0shHcUh+Mxm89I/d9Tr8KQLj8pNKvGYstNO6Bb08BICvUZqYj4+wFtqzAYE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjxHEGKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EA0C4CED1;
	Tue, 19 Nov 2024 23:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732059215;
	bh=WRrkPtEd4IwzGmc/VdCQEhnEP0TpAkwphO9fPgThhW4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fjxHEGKuAeklLnCaK63gYeaeOeF1ys3LGmZHJngCJ6+YvtTghLusFhON9GAURLOHv
	 vXJiaAtSCK4+pV5ESnaRH7ewXKZ09RunImVZeXxT/rbndMlQEkzX6SOue2fk3KKh4s
	 SztBBIYLEnbkiZ3LtNJx7salPMFRMWt+KX3/er+ceqTnE4IlaeHP6uqk3nHkB+iN43
	 EnlEdFNJ4qScZEQkHiCWmQ8SqSFh+bABWioV9SnchcFLVCfEO9DGHKmgBYbIXLMsyQ
	 6WCwPAvh1kdRXABSI0CzipbN60uf3aaM6zUBWETqfXv4zO0nhNqmjc+mZNuAi9j/Ce
	 IxHNKpXHGHajA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D3F3809A80;
	Tue, 19 Nov 2024 23:33:48 +0000 (UTC)
Subject: Re: [GIT PULL] x86/splitlock changes for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZzuBNj4JImJGUNJc@gmail.com>
References: <ZzuBNj4JImJGUNJc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZzuBNj4JImJGUNJc@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-splitlock-2024-11-18
X-PR-Tracked-Commit-Id: 408eb7417a92c5354c7be34f7425b305dfe30ad9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0892d742132e09e132a501d3f54428f8ffd4b2b5
Message-Id: <173205922699.720598.18218475814317470859.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 23:33:46 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Ravi Bangoria <ravi.bangoria@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 19:02:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-splitlock-2024-11-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0892d742132e09e132a501d3f54428f8ffd4b2b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

