Return-Path: <linux-kernel+bounces-253182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE51931DE2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30536B2097E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 23:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC334145B27;
	Mon, 15 Jul 2024 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9TdMRrd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B00144D1E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 23:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721087785; cv=none; b=XAzSM96y+JbXMCTosvNo4c7Pgmx7YEDdRRJqu3cpQbN0kG6Hwc12XRSTpqyafcCqs6JuzZO7FyiwnbyvzweTStwh1vqwtd2sWPw/5CF4aY+O3CqD0KTrBX+I0C9T0/Gmjb0RvWVKxeHw2OgqQP/sQ8kl/p079WGtpJK+LwD0L3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721087785; c=relaxed/simple;
	bh=U7yqwBvPaSZUrniTpqPK/zXZ6COOeE9j3Vqo4A1VLxg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AKBQ1mK9AvHYXfDHwFRRW7mX1t1jA+lTebn3cZXmvQBgaWZoq8jkylom87KNYD8wXWQnYJKJPzv+OrBpXJmiWAOp1Lj0wPzQwapvTMb+9jTYldVgqHM/3ClEO+NiXI4VBzUuHJ+D/FeO/DhJRr8ARlPyj3wshiYw5aDMtNWVlL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9TdMRrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40D67C4AF0E;
	Mon, 15 Jul 2024 23:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721087785;
	bh=U7yqwBvPaSZUrniTpqPK/zXZ6COOeE9j3Vqo4A1VLxg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=p9TdMRrdDvmf36RLbfgDQMjIqRiO8DTOhzE0wLFMpAnU3b9tp5vk4fSyMVpYmu6mq
	 oIJ3Gph1ShuaVyLXzk5lyV4MN5yNHFdibekkCwg46Wk5etraxJuc1qlaloOsAWGAO2
	 1A7f2D55GmGs5tO0aYkWbPMGuEyRaEoHkbq6rz6I8M80y0vqW/Tizl+XeMHKcC+kUt
	 +FEviY7Fcp4Mf1+IPV2GgqcroVAg+F6a2KMOdquiyAAHBSZUvYeLuNs14UxHyiXEyr
	 ajM2YEZUafECnDj4pS4IvhesvO4us7guINQHqqnfozbUIjeIZJBZgwjpmiVkXIiTuA
	 1YTKweYy3/SHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 379A4C43443;
	Mon, 15 Jul 2024 23:56:25 +0000 (UTC)
Subject: Re: [GIT PULL] KCSAN changes for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <6d532a3c-709f-4038-8482-34dc2dcbfaae@paulmck-laptop>
References: <6d532a3c-709f-4038-8482-34dc2dcbfaae@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6d532a3c-709f-4038-8482-34dc2dcbfaae@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/kcsan.2024.07.12a
X-PR-Tracked-Commit-Id: ddd7432d621daf93baf36e353ab7472d69dd692f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4b2b0b1e41e3b5c542a18639cd4f11c9efbb465
Message-Id: <172108778522.25181.1636303695976869353.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jul 2024 23:56:25 +0000
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, kernel-team@meta.com, elver@google.com, quic_jjohnson@quicinc.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 15:23:32 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/kcsan.2024.07.12a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4b2b0b1e41e3b5c542a18639cd4f11c9efbb465

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

