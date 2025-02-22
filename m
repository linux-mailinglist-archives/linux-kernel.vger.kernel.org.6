Return-Path: <linux-kernel+bounces-527452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439C6A40B6A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA383B7A88
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979AF213254;
	Sat, 22 Feb 2025 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOVvo6V2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0608821323B
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740252167; cv=none; b=LX36AuTWlvkL/GaOQ4eZiilTPTZJ67M97hNeHkrCoEUaZPGK7lz2pBFY+UKtlL4RUJPneLxUdVUmdxE3dwybfczAbmUkDi3r/Opbo2YwHy9VOU6c2PJfj+LlgU6Kd8Xj/YYFKrgWG06mDu5Uyz3d0C5XhfNpdOXUiAN7YmN2bUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740252167; c=relaxed/simple;
	bh=rzSltgCMirR1Q6Ei5oUc2BPi7EEO79ZxvMRJ3XPpUTQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ECVwfYH7IQhEnToSA1y054WZjosZMYT3A603PDd7aiWXxeY8BBaFTaJnP5iXbdOhOp6XRFVDh7vLdXypNuBgfeIZQrXRH+80gaSJBwBNMlcUDQYS4y0r6if8Xjevm39JU0pRliFrvggsprsfFRG98MsjwjrNaLMS2IP7tR5LyAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOVvo6V2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D041BC4CEEA;
	Sat, 22 Feb 2025 19:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740252166;
	bh=rzSltgCMirR1Q6Ei5oUc2BPi7EEO79ZxvMRJ3XPpUTQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BOVvo6V2ACnGzDGj9TfH5Qi0bk9qlRMkPJKsOqWpwZA6PjyScQgS2iuZU7c8bbB4/
	 eHxivi7u/1ERypW85aZijWbKT7R2+pXEJkZLzC8uuQDlXPV9CHG9jPkwZri5g6pmfk
	 waT+J63VgQt3PtQCKRrtFecNpGFdncoyHnJiXxEegQDQitixDvd+qUj7yRpOtX5CKb
	 hxzKyR0Zz6DS/miDcy3qGvm0jirrta2ur7ZwOyjViuQT27nj6CxmEKEqrVWguFzxNL
	 UNcOAygMO7qJW4GWdycq1eVoqIA1lotvN7q/5RKlnsNrT3z8bdmxcyScuCkajixYUc
	 5cprsQqdOyyqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D59380CEF9;
	Sat, 22 Feb 2025 19:23:19 +0000 (UTC)
Subject: Re: [GIT PULL] performance events fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z7nXAHg-7bznAz83@gmail.com>
References: <Z7nXAHg-7bznAz83@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z7nXAHg-7bznAz83@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2025-02-22
X-PR-Tracked-Commit-Id: 782cffeec9ad96daa64ffb2d527b2a052fb02552
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ceffff65f12d5f7e57e627555521a205f477ef5
Message-Id: <174025219775.2429034.8870453268821870831.pr-tracker-bot@kernel.org>
Date: Sat, 22 Feb 2025 19:23:17 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kan Liang <kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 22 Feb 2025 14:54:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2025-02-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ceffff65f12d5f7e57e627555521a205f477ef5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

