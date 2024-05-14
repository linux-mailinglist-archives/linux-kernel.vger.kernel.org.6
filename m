Return-Path: <linux-kernel+bounces-178277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD60D8C4B54
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 04:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0B61F21486
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0506A38FB6;
	Tue, 14 May 2024 02:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZli4E4j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EF72B9BA
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 02:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715655092; cv=none; b=FPLaYsWMm+PC3/64ZYsMpxGuPrVWP8gpbAwwwLROGM3DWHJjTXMlPNiQWlpcTedzg0H/D2sd0ZOfLnCOcc78c3AFz3JDBuazZL5WM6KvdkZ2bDitEKbJHRROGAau894GC/4NxO46BmrbabhoFNY62wZm64OD0VzMeM/cWtiUk0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715655092; c=relaxed/simple;
	bh=feCdUJHxcP7Js6kj08glOGOCOgCKcVVn4r4QbwgKAvg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BlqyUVM6fnAyC7VfEX/edTbA1RO7ef5a9k/1nPkY8R3YxkZ6zUzxJWicRA+x0Qt1OBT4i1am4EBfDNRvSHuePS3lyb9Lg8ilACW100rIMuY4zD5a3htQpVhTQML9YHYYJ6l+artt/wI8B7v2nhN5DwlDEMJ8a0uFmtTfEgBnqmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZli4E4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B76EDC4AF0A;
	Tue, 14 May 2024 02:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715655090;
	bh=feCdUJHxcP7Js6kj08glOGOCOgCKcVVn4r4QbwgKAvg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=TZli4E4jigkkPPRDgLYICA2JAJ8aynxyrLhZun7wgj639wEkwDBnt2rsw9ZzUZ5uA
	 ylpg7X2O8a7Q7IYieesn2IuctaudUf1FyM0MZz/+Nx78d9l5AzjHpx4UjwQ9CzVFNL
	 86/pE0gAjFhpJ/NyuVp8VXimsV8BwWrkISU5rshwaWJJfu3rRKR41FfrufEMGyUFBo
	 /pnAna/k3n3EP7MYVd5fEIPq3o3CA1loWspPL0HsGQ7hR4G3p3FlLfNWRvkeDGT+NM
	 LrglMg9FfR/TbS4Dn5QN7mp/Z7GIYucubtc3CqOYRGMs9283ds3OIpBzpPII8jwq8x
	 N6jln6LoH40Hw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE06CC433E9;
	Tue, 14 May 2024 02:51:30 +0000 (UTC)
Subject: Re: [GIT PULL] x86/mm changes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkHFtnfjXcZQX5ds@gmail.com>
References: <ZkHFtnfjXcZQX5ds@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkHFtnfjXcZQX5ds@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2024-05-13
X-PR-Tracked-Commit-Id: 5bc8b0f5dac04cd4ebe47f8090a5942f2f2647ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eabb6297abd3115220c8072e463780efc549bc97
Message-Id: <171565509070.649.14859912429844867609.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 02:51:30 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Juergen Gross <jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 09:48:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2024-05-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eabb6297abd3115220c8072e463780efc549bc97

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

