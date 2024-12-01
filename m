Return-Path: <linux-kernel+bounces-426744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C6E9DF729
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 22:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722B32816E5
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 21:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017EF1D8A16;
	Sun,  1 Dec 2024 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgqFrHGf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619F21D86CE
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733088397; cv=none; b=bl+dU5zwAaLPbu1S8ARvqKwh6CClit4zZ3JtLN+HkvYr79ZHrW/JLQKWwz9W4UkSBTyj1Rl5VCxRyuQLpW1meDlOkQ1Iut+IrXROs0rmoqeHjKwLDqW85+ckmw9E4OpROT1TE0x5lutizk+8j/ld/IX9v4FciUqLtS3DeAL04Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733088397; c=relaxed/simple;
	bh=VEvrPqd/+ro7/DkqkFjBiz+F+26ejvtuU5ZGqAzJfn8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LJIK6MAiJAet7xgJDcXO4EwWxed9eYYAW9C4gXnzFqmNK7HQ2vSC8WHfk3mj5j3iAlnFwWezgAUsvSsSmi21qsnsy1laui9Pw0XruY+jAC8z9DckKN4HkZqVf4FRr2ZdvBf8w8ekPIJtOhHtEVImhBbPfd3Yn4OBCNZ7DOYWme0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgqFrHGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC37C4CECF;
	Sun,  1 Dec 2024 21:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733088396;
	bh=VEvrPqd/+ro7/DkqkFjBiz+F+26ejvtuU5ZGqAzJfn8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hgqFrHGf2FOQY8Ug1JVJn2+0ByM4j3LAEddOkyrHi2qGbCNH6LriiY7elDFP0jEwd
	 BBTilNXPk/gPBckGlzm+5bgbH6mb0dOl8PjCAMRtim5MQUj7ufZxHockL1V6RfCF2/
	 oacrXjpmCgTBi68WieZwaTxUamZ3z6JRC/+GUNsZJQxZJyXHfE8Civ/M45oYFfF+ji
	 MsPAQURiyQmXQtVYBAWfk7SjrFtN8oxyvNEdMM2tBGAh7OXGRLk6xTIj99khJhWHlp
	 IpHav9YUU9rDzS3UH1pOw30HwqKG0kcjH77RSAfg7+9rR2ZiXyxeKY+WRO9GYn1I/D
	 K3gy7x2u4nDpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB11D3806656;
	Sun,  1 Dec 2024 21:26:51 +0000 (UTC)
Subject: Re: [GIT PULL] vsnprintf: Removal of bprintf()
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241201113435.0350cdef@rorschach.local.home>
References: <20241201113435.0350cdef@rorschach.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241201113435.0350cdef@rorschach.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-printf-v6.13
X-PR-Tracked-Commit-Id: f69e63756f7822fcdad8a34f9967e8b243e883ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88862eeb476375687a1de5f45528a437ea598338
Message-Id: <173308841064.2759937.5966342007607522350.pr-tracker-bot@kernel.org>
Date: Sun, 01 Dec 2024 21:26:50 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, Andy Shevchenko <andy@kernel.org>, "Dr.
 David Alan Gilbert" <linux@treblig.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 1 Dec 2024 11:34:35 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-printf-v6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88862eeb476375687a1de5f45528a437ea598338

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

