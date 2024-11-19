Return-Path: <linux-kernel+bounces-415035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC77E9D30F2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B006283EB6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 23:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2EB1D4325;
	Tue, 19 Nov 2024 23:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjQhn5EA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AB41D3584
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 23:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732059208; cv=none; b=HXVYjUFXJ+16FMT3MedAYclmJ3BdVliKR9omsb8v9AnoKBwd68/7q+CFdA+OWveeUOCgnY6GjLSbcfDLUCxAne88M1Ca4YNf1lKVjKDXKOhgv6Ksd8j8rkHtg1Oai1Rm3H66d/V2OR5vI+LF1/iD15jxPR0eUSQMmAET2Kd5gr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732059208; c=relaxed/simple;
	bh=KgrI2zUvG5FL/faG5Hsw/IrgTcTA6cKo2WwuwDQ1OL4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AiX3KhHwIX11qDgylEEGCCb8wkuJl+xDYzUlGdTlhOBO0iuguW/V6y0om6XPab9jxJeFYbU5CSmc3ppx4P3LjNT35329IBhlwuyLgqT97b9KgR925M5lYFRA0EKfg0OycZMMtWN1PTrtbL1OD/rgk+2evVGqB+SfsZBFPC4Rvsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjQhn5EA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0D6C4CED2;
	Tue, 19 Nov 2024 23:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732059208;
	bh=KgrI2zUvG5FL/faG5Hsw/IrgTcTA6cKo2WwuwDQ1OL4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DjQhn5EAk7hE227wrzo+/bYf+m/dpYgCEN/yGJyyGOm1LqDq3Y0ulmcs+zcPrM7Jn
	 IjmHNrqvSC1uwB2N6UoSGlnQJ4syLx6RtAW51l1RblpWFgBuEjHhaI0JXjFkmvrOgM
	 20A/pVxhWTbqJL2g0DpJB1RKglQ/50SRnuyVllgWce61OY4PUOyY1D503u6JAnw3OQ
	 HCv0ZOfa/rEs+I6QRz8Z57JdWh2w3jtuCUXZiZeRCIFLLG5i3JgZ70gp+a/KlqrB6I
	 KhgPtFSlTIkszb6ohjblxDt9SJZQ0Owb75InGvU1yJ3C7+p1HZ5Fp7tjMpe3m86vut
	 mz+zY/nc3d6ig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3431F3809A80;
	Tue, 19 Nov 2024 23:33:41 +0000 (UTC)
Subject: Re: [GIT PULL] objtool changes for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZzsWHrSROj-PyQOz@gmail.com>
References: <ZzsWHrSROj-PyQOz@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZzsWHrSROj-PyQOz@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2024-11-18
X-PR-Tracked-Commit-Id: d5173f7537505315557d8580e3a648f07f17deda
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9d7d4ad222aea8ab482e78858d03b10221c7fe78
Message-Id: <173205921972.720598.11087179425753243496.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 23:33:39 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 11:25:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2024-11-18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9d7d4ad222aea8ab482e78858d03b10221c7fe78

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

