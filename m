Return-Path: <linux-kernel+bounces-576472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195FBA70FBD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 05:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD15116E898
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 04:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBC118C32C;
	Wed, 26 Mar 2025 03:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZ3zDPM2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFF916C69F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 03:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742961570; cv=none; b=TBm89nfw10+GI1P5GiSIQ7UXX/5xotFaeHOQSORBgGmbeL718KoDkoWdKH87ITP66jzwPglAEWUoOnNcbDBg4MlA8PRFdVPgqnIcYKEQbMEjCiIf4muL4fkxhdBZ2D41Tg9JZL3rZT+mP2niresEPKBd8kpgEZPSDcHs8AAw2fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742961570; c=relaxed/simple;
	bh=bRcPp+R3NVUrC8k56dY7vJwRUni8JBsqhdM0C+LeDIs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nj1CpLExnFzRZfrWlVWeO3PVYvMnmOqA7nfQYhQNWc4WQNze5YMDbq/CtepprzMrG0AK1j6aSPE2aszdo4vyNNQoiL9rPDNiG/odr/IJDGdEd/dbX2us97N0xzuhoqbx8TLz5Qf63oPZImdxK4ehIUd/a1Y/oRJ7gv7joyUZ6I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZ3zDPM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52EEC4CEE2;
	Wed, 26 Mar 2025 03:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742961569;
	bh=bRcPp+R3NVUrC8k56dY7vJwRUni8JBsqhdM0C+LeDIs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DZ3zDPM2iC9Bz5A429Pyf5WhhCl0SAdlwe7/1yPT1f8dI68ZTRaCCk3kUaw7JUJEA
	 aKh4LPF/ySHExSHmeBSo6MRvtLPuyWqjFbuInKlPXOVrck5k6sxjlvmHQ9fpGEQKRO
	 yCZ8BeoZ7EH/RilQL6ed2t2Nrko1uIQ0UFF3KAdKI7oHVfzbjQT6w1r1aZr17Zb+cz
	 dbwZA/6DpyPX0vVl6FelCR05uAEL6tMJM/5uQILGt8dskRFU9xcQS4mOWIH+3HVAUg
	 5waHwttFhBj1oafEEvhMuQOJ4hhE8ZrT2ShRakPfX8KuXvStGSF29UnzhNaNQS6UZ2
	 VNz0CMAj1x1Rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71681380DBFD;
	Wed, 26 Mar 2025 04:00:07 +0000 (UTC)
Subject: Re: [GIT PULL] auxdisplay for 6.15-1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z-LNP8zSHOHSLVhZ@black.fi.intel.com>
References: <Z-LNP8zSHOHSLVhZ@black.fi.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z-LNP8zSHOHSLVhZ@black.fi.intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-auxdisplay.git tags/auxdisplay-v6.15-1
X-PR-Tracked-Commit-Id: 67200d70e45982f5120c43b3724f1b6e4a8a01e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c84907a1459588c883ef84a35bb69d46ca37e4e7
Message-Id: <174296160595.837738.1039164070245661286.pr-tracker-bot@kernel.org>
Date: Wed, 26 Mar 2025 04:00:05 +0000
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 25 Mar 2025 17:35:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-auxdisplay.git tags/auxdisplay-v6.15-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c84907a1459588c883ef84a35bb69d46ca37e4e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

