Return-Path: <linux-kernel+bounces-273940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E42946FE8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 18:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E44A2812EB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 16:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DAF13B5AE;
	Sun,  4 Aug 2024 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isFt/x9q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2110513AD37
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722790466; cv=none; b=qilCUyfFPgYlm8vC7wGyLwZHJ6H/+j+ZitHzDipNZVjBIl8bj9g6EvQFIHXae5EI5V3R0QC92GtansVKA+q/ia1XRxiIjKTHnSnDVwUdprLIAyAgDM2oxmYgkNIg6cuyVu/VNLfi5MWiDvMhXOqOk/WNLkOy9Inll1ReNgGuxx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722790466; c=relaxed/simple;
	bh=h0rSIl9g8hhF3nZARjnWY3eIYm1RDZkOCm+g9L3MDbg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=iIkYqBZTKnowIIN5QpxeFm4r8bktQHVIQRwuVNTkF7NuZ1nm0E4pxVTtN8SCea8sbnCF/+K8HghY3dl9Mz9S7CR3eTQ861EW9dJovQaheY7CnV6ohwUiU4nz13VlE8txwhp1rl7MEOPYYBwQuT99SR4xpE+YJSPT2dWzYYA0Mlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isFt/x9q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 007EDC4AF19;
	Sun,  4 Aug 2024 16:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722790466;
	bh=h0rSIl9g8hhF3nZARjnWY3eIYm1RDZkOCm+g9L3MDbg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=isFt/x9q68cYtDn5HGCRKTAOF5zZSOTeUHCxjBW+m6ObdmhMKaR+mH7pookDV7j63
	 m9NN5JLRDYRx/7X8oFMxyehqRW0bXKQ6/bXHJy2CJM6wv+1w22+MAk0D1ldSgF4V4G
	 CA2ZV3FjCKH+aCycmWggRarSXPk7qXPcjAoJAb+ctmKWbHOZgDDvlJYvHYtGlXotGK
	 40hCTv7n8uBB9af9CJxdAMo/QBHrLUPw3yU59rkwknFghg3UmhDls6dL2n0j0oSzP5
	 d4RidIFA7iyqXIo3ugT4pRkjOyK1vryGjs4G5Q4kh7qnJaRf+4LvNgkINp+7w8+dKN
	 si6KBzmsfHwuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC9B8C433F2;
	Sun,  4 Aug 2024 16:54:25 +0000 (UTC)
Subject: Re: [GIT pull] x86/urgent for v6.11-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <172277654939.866296.14745286844919555114.tglx@xen13>
References: <172277654174.866296.10517632866315552419.tglx@xen13> <172277654939.866296.14745286844919555114.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172277654939.866296.14745286844919555114.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-08-04
X-PR-Tracked-Commit-Id: dd35a0933269c636635b6af89dc6fa1782791e56
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a5dbd76a89423eca9f8de338350f2666aacfb432
Message-Id: <172279046596.9825.17653767776000301386.pr-tracker-bot@kernel.org>
Date: Sun, 04 Aug 2024 16:54:25 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun,  4 Aug 2024 15:03:00 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-08-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a5dbd76a89423eca9f8de338350f2666aacfb432

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

