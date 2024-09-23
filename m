Return-Path: <linux-kernel+bounces-336249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 716DD97F10F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25DC1C21A42
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA131A0BCC;
	Mon, 23 Sep 2024 19:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIcfHqqq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA84E181BA8;
	Mon, 23 Sep 2024 19:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118374; cv=none; b=u9Oru0Sq2sooXQ9lNkoRihbszn2jRTp056svZLZaoFixy/V/IskDIX0+3E7tAUlZ6lY8lgMyyh4SMnhu9O4grcRXw1b+aXpISNyeTB4yRfzLjIWWIeywwOfdTqKY9947lXVnbq52DlG1nr+oC7pqsCOozNKUp1QjLs4QspTFUqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118374; c=relaxed/simple;
	bh=5Ydr5eYxyf/vsPiTOx8clSN3PCV209SoyZSXbOnuJm0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nZrITTRR1tev9pxkF4iksjc3At7PL8trBWq0TnXC+zI75jCER/eMJqIqAdHdqfarNnuoyu9955iLT6VZ4lLhXYFEalTv8nE9Alj1gWMomEJOofqM/SMoJCf+FVYF5dHy5FkOYFpm5z4y5TMY5n9VxfB8JaoyNHsNKg9cA3HeDac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIcfHqqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0BCC4CEC4;
	Mon, 23 Sep 2024 19:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727118374;
	bh=5Ydr5eYxyf/vsPiTOx8clSN3PCV209SoyZSXbOnuJm0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RIcfHqqqVzSLHGldu8JIlX4XqU0nJ9yGEGmMJjiYM83l99s4Y6Zr/Qgz/EbM2YS3m
	 ScOEzPnfCYPOxHO+z7S1roTDz/RxpDgAxbxlw2pl/F904OjJsTFk/Jfn6HNhrV89rA
	 5ToxH8P2prh+VmpUhQyYpDe9ATqmLVsUm3g6IA5lCmGSPqClyDEp0bCY0S2VT7EPPH
	 3FoYnFrdf2KYI3UkvsCU2GGVjwQxealvmNUZ7VkSJaKHJLMbslL0JISWSol5vJBmnI
	 wIw9OwXdpjVklw+e9kVz5nQ67hVjEJnddQCZfP9ahj9jmwSYEc9YRAQjTLMMWF1AGA
	 dR1g0VTneBkSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342C53809A8F;
	Mon, 23 Sep 2024 19:06:18 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 changes
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240923180432.270779-1-agruenba@redhat.com>
References: <20240923180432.270779-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <gfs2.lists.linux.dev>
X-PR-Tracked-Message-Id: <20240923180432.270779-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.10-fixes
X-PR-Tracked-Commit-Id: 6888c1e85f5db129e6ddcff879bb127bbfdb5c64
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 721068dec4ec3cc625d8737d4dfa0ff0aa795cd1
Message-Id: <172711837668.3454481.18118976487656144321.pr-tracker-bot@kernel.org>
Date: Mon, 23 Sep 2024 19:06:16 +0000
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 23 Sep 2024 20:04:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.10-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/721068dec4ec3cc625d8737d4dfa0ff0aa795cd1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

