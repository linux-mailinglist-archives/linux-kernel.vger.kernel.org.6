Return-Path: <linux-kernel+bounces-414945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CF99D2F8C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C869283396
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BBB1D433B;
	Tue, 19 Nov 2024 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxq27Bxl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D441D4325
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732048525; cv=none; b=oTVMYVIcWD8fXnVmXLfY2J8rq3tT2GpqsCvJsrcrPmlzltozwQ5uYGiQ8A8cvZ3keKDAbubXVtEVS6DakJDcf/9BUuPlT7xRn/jsNfU5LrazUkMCyJqmp9uD3TGjp54Ak+kFBKywIDb8vOKd3JVn88tfs15DI3Dz0dM76D7TcYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732048525; c=relaxed/simple;
	bh=B5NHnq151wV5dJJIdVlRKE+ZX9Vq0J8enL9uy9Ru0xM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JaXaY6SwR+yhSWFBSYCUVQxPeOWJVK0uYNIC84lZ81uRggB+MO9KxiuyZyxna8k7JySmMs+57Dn8EK9C8Pops4wLMnjQxw23dVfNf/qY8F0EqIAEMuEJLGKhOmjFEfnoA1k4JlDGTswzIAWw0gk5oBtb7g5xkSeDk/0ebqY3A/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxq27Bxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D87A2C4CED0;
	Tue, 19 Nov 2024 20:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732048524;
	bh=B5NHnq151wV5dJJIdVlRKE+ZX9Vq0J8enL9uy9Ru0xM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hxq27BxlVdVkD0xrmnqp/bFMqq5UYSiXDZ5fTjGtIbv0MYhfq54zumQzd1RYo1zpU
	 /KNF8Ie8jqkrKEJ5jB5fcdJS96F+s1sOnGpgm3KUOER/u9ByKlwLF7+nEAhTTiDUJU
	 DO3e5aDbiLD2OxEx82jvuPVqr6zPo4J5r7tOfNJlBxmmul2RqvJ/orSZvec41g/j5g
	 YHp9adunLWLmiLPvWOFjheMRdiT1ESJ1n0XUdOVV/TjYl1gQM4eQItYgom+nmztoEK
	 IlWx/o5LmaUu8RNNAPp9Twype3pWU9mJFfAOS3qJlyfsHz3EJ3b4rn/GBvjlOXZ8LN
	 8otkQ2FitQV0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB9E3809A80;
	Tue, 19 Nov 2024 20:35:37 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cache for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241118144436.GAZztS1DHC5ZXOi8vT@fat_crate.local>
References: <20241118144436.GAZztS1DHC5ZXOi8vT@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241118144436.GAZztS1DHC5ZXOi8vT@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cache_for_v6.13
X-PR-Tracked-Commit-Id: 9bce6e94c4b39b6baa649784d92f908aa9168a45
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a4b3fbb4849c66814e89772dad2e71fc9160805
Message-Id: <173204853622.680579.2669736541789811565.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 20:35:36 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 15:44:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_cache_for_v6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a4b3fbb4849c66814e89772dad2e71fc9160805

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

