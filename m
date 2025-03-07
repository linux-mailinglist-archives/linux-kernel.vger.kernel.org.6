Return-Path: <linux-kernel+bounces-552063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AD3A574E2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7CC1896805
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7032D256C9B;
	Fri,  7 Mar 2025 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsAPKPhy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4C72561DA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 22:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741386575; cv=none; b=YvGxefWc6QMtW3tjubFnzMCpuEcj2lk1QARuljIgkaX9GLFJV4Iu8H2L0eeOoC4HaKs3P/QIqtR+Sp6mW456ncwq1VtQb6FJyPu2yHCI8LsAEuDnNTIxrNyA49TWZUi5ZX3prnbVi4hpiwTvX5YFY/2lPDgYtujp5jCf7lgB3ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741386575; c=relaxed/simple;
	bh=LCKLsqJmqOJWubX1+sw1XfChT9f5pGhC+KM0ZxKeN8g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RGDY6qxdZDHHct1lICc+ZNgTdIa7v/+G3FUrsm9ZZBaXUj5SjielHCpUNHbAaJ+59srOFlveacjUkqJtPUVHLP0OD1hgxWl7C5Edjt/OV0WEp//Oger0WhAyZRHUtBvA/IF+nj+PoT5C6+NlrEhjnEuOzcKYA2yJwnbinhh6M0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsAPKPhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79F2C4CED1;
	Fri,  7 Mar 2025 22:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741386575;
	bh=LCKLsqJmqOJWubX1+sw1XfChT9f5pGhC+KM0ZxKeN8g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qsAPKPhycb/v0YsetmSGsJ1IEeHAHYaoS9a+MjFuw2R15wCHBpGgPRzYWzxxtM844
	 4OUfNIVhCQOGvcFxHM1KrMyWX5cbK2XUwAdVikkdDWyNlz0FDCJ7Zo8JTUbpk1Z0jl
	 VrvCQa+2jmRnPIlEJg+kHapz3OwpW6WMzmYj5O1jemB6jXU5Kgt7t2Kx1VKpRWRMhZ
	 /qNW9sTnBOytyp8NVlypjhBur2zyjnULASnlgqVPIADhUdeMLTVsiaKAb+UWnG27aT
	 5KDsbgdWgJp+LmlbajvAR+fcBsTdWlGvIrIbQz41lUR6ZUnyTktGQiXx8NIjVJ++JG
	 HDjeSTecR0QZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7121B380CFD7;
	Fri,  7 Mar 2025 22:30:10 +0000 (UTC)
Subject: Re: [GIT PULL] slab fixes for 6.14-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <d0a04abe-6f6c-4d9f-895c-b3aef4617505@suse.cz>
References: <d0a04abe-6f6c-4d9f-895c-b3aef4617505@suse.cz>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <d0a04abe-6f6c-4d9f-895c-b3aef4617505@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.14-rc5
X-PR-Tracked-Commit-Id: dfd3df31c9db752234d7d2e09bef2aeabb643ce4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 21e4543a2e2f8538373d1d19264c4bae6f13e798
Message-Id: <174138660906.2505911.15369546484208819734.pr-tracker-bot@kernel.org>
Date: Fri, 07 Mar 2025 22:30:09 +0000
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 7 Mar 2025 22:29:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.14-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/21e4543a2e2f8538373d1d19264c4bae6f13e798

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

