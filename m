Return-Path: <linux-kernel+bounces-337588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 549F9984C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80EBA1C2339A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B69413C9C7;
	Tue, 24 Sep 2024 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqXCstgL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E0D13CA8A
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727209271; cv=none; b=ejXgJ6bmgjmbb7c3uzQ4LcKBDUHJwUwaJX+AXpoXZsSUnxmx077fonrde6NOe2b8JyEBpmaCZ6lE2ByOhXnk2q7htPBO93FZ3UGbC0+BuAqHUI2Bn5WOSswHNEa+OQ4SZ1vZueSYK2HBrvWG/fUWmZLlr6FNUexafDZUpFAKgzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727209271; c=relaxed/simple;
	bh=dx2OaxEwyXOKZvIvFclE6PPQvUlh2LPCEHyq9Kra94c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=c8UcqQ6GolnYroMDP9xEfUy+3pnFoHYF2h6ivVtDGkBFYCFSCv8MxW6aAQeNKFcFSBbZgeNILkt1qaeiRr8zhJ0XJbCLDXWPH7qcr4SOhfSCiGuKuLqra+bcXPL+zmnngemMaporu0+W3rsZh6tqXa2Bd9Yz/7GocTbpBQgD2gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqXCstgL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B0FC4CEC4;
	Tue, 24 Sep 2024 20:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727209271;
	bh=dx2OaxEwyXOKZvIvFclE6PPQvUlh2LPCEHyq9Kra94c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lqXCstgLtRQlat+wWrR6KNuD5gVE9c2UDYvBMPTbWfpVjKe8Eg0cbIQDknJGSIbmZ
	 p6mlDP9s99s1pJY7jq4pdSyTQXM/RbHX/Z2DqTKA557rlLbr5J8tbm8WYer2/ann2o
	 EUqAADAIIdtiaR0vt4fl9Zd9ljlYbsBvYjmjzBziRmakuO5rM6DPzpnuJiny6N8M97
	 wl8VBIAfmnxCWwRXg0slggGWEE2ZPgohvNMrJHpx//VGYqvNfBEbPNEoCFny4NYR+B
	 U6HrL85raSLm6UWUxVGkVqnxZBBI64PiOsqO58OYzhK4uaeWvH0Ts0z+uuKCIA9Afx
	 9Jx4r+3kWTJGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343073806656;
	Tue, 24 Sep 2024 20:21:15 +0000 (UTC)
Subject: Re: [GIT PULL] I3C changes for 6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240923222839975a95a9@mail.local>
References: <20240923222839975a95a9@mail.local>
X-PR-Tracked-List-Id: <linux-i3c.lists.infradead.org>
X-PR-Tracked-Message-Id: <20240923222839975a95a9@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.12
X-PR-Tracked-Commit-Id: 61850725779709369c7e907ae8c7c75dc7cec4f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd3d6477298155482b772eae481ce01c9e764129
Message-Id: <172720927387.4186044.6677655873054229688.pr-tracker-bot@kernel.org>
Date: Tue, 24 Sep 2024 20:21:13 +0000
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 24 Sep 2024 00:28:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd3d6477298155482b772eae481ce01c9e764129

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

