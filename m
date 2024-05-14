Return-Path: <linux-kernel+bounces-178980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB2F8C5A05
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6687A1C21623
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F9A1802C5;
	Tue, 14 May 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRbyFooq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3619B17F39A
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715706186; cv=none; b=YpgSW0le8aAAWR7PpiKeihuf35FEEbW5ZDp9+FXIyhZWovb/7NqCXqJY5vspeJ+JtouBVvIMMuyTI4jJHX+wKwXqNcP+b1D1XAdoe6NShdrUHClJ0m0podDBDW5QJdVDezFInaONf/a8Q72yEHYFFE9y3e0QfJ20NVbRnKsg3zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715706186; c=relaxed/simple;
	bh=KBQCFWfXDcwEhI+UraiOef88EdBE426YYe6vY544U1M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rWK5NMymtoi/z7UXsreWqHDTQHhy4XjnurZTgWGjS9Zjifz14eDlTKR2zctpRIO4MmJBwerMv1ZCBnQ9aw3kna13BASp8VdY1vDTch1YPg2uhDDOhA51KTzSBeqfYa0PgpKmKuK4M0/pA90KhLBUEJ5AAdz/L+bs5NkVjThuvLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRbyFooq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3685C4AF08;
	Tue, 14 May 2024 17:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715706185;
	bh=KBQCFWfXDcwEhI+UraiOef88EdBE426YYe6vY544U1M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aRbyFooq4+IpHxEiGcQpnLOdgqBwfop025Jq73+VwVOXgFW495DOZxmVCx50TBueq
	 qKupZGvD+CR4iLQiXB4ufxWmofPX7SfRlKnqpUC1XSY89Dukc6YWJT8Fpvwv8iYWtE
	 +icO6mFNwOo9/KO04RGzWtI5W+yOk4GVjbGWIW2PTvx602AA7YNjcguXLI5pc71mKL
	 vop8RRTfIpVoLcu9q/sij/GECW1mfax7/QEwqSsg0j4fiQwvDWiqH9mqRUNhW6UtXf
	 3cew/6fWnyGjN+Bczbayp9gr+PiA3NJ0vbmeU4c2IRznAqvEoIOdVD8zrszvKRUiKe
	 LDORRA9jlY/Lw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA539C43339;
	Tue, 14 May 2024 17:03:05 +0000 (UTC)
Subject: Re: [GIT pull] timers/core for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: 
 <171560454760.3871325.16502445987718332843.tglx@xen13.tec.linutronix.de>
References: 
 <171560454635.3871325.5773365584560034962.tglx@xen13.tec.linutronix.de>
 <171560454760.3871325.16502445987718332843.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: 
 <171560454760.3871325.16502445987718332843.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2024-05-12
X-PR-Tracked-Commit-Id: a3825a7691585485e960cec04ce6667d176b7c67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d9db778ddca079228ef10e60bceea06b34b0eaa
Message-Id: <171570618575.7410.14322780060844174500.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 17:03:05 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 14:50:00 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2024-05-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d9db778ddca079228ef10e60bceea06b34b0eaa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

