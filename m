Return-Path: <linux-kernel+bounces-514327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABB2A35596
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB4F3A764F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEA515746E;
	Fri, 14 Feb 2025 04:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duB0EWOq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BAC154C1D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739506188; cv=none; b=Gbi/GDCpYF157k5HYyMI/cq8Cj2/W7JYuTRRjviYmNrmgqGwZ+V7AWwNapNgjHLX5Eo+WPy+zLj+JuyfureAbSQON1gAN/QYme7Ss8jYmFcej0EwKzc67yU5EAN4l/8GYHKCq2uGyH5IvE4lDxreIlqrmA9S+D2Dk65PVFblXIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739506188; c=relaxed/simple;
	bh=k1HtaViSWdj5Ew70nPWbSAiNehFJrH6pENr0/QKgMlQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ftPZTQZQyzPoLhhNL2BdmndmUxIqdh+CukY6O5D/XZS6prxC/UdlWQF5p8z5n/7ji8jpF2OYa593/L/5J/tMzluS4HyWpWLY1j/7r9AVm3snZvQBUs5lE2q60mQpob4YpxbwrUjfD8Ma/ije04icTObvhDRaQGRMN648w4LL5Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duB0EWOq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDC8C4CEDF;
	Fri, 14 Feb 2025 04:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739506188;
	bh=k1HtaViSWdj5Ew70nPWbSAiNehFJrH6pENr0/QKgMlQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=duB0EWOqyLohznJHnEWh8IjZy9aBwpRzvc5ofiZCNzk5BjfDfm4hmPRJNaWrfKx0O
	 exZ18XaqN3uJSlN16uVgZ0fV/zF/mz0Mz4b0BlLheZyHY+XcfsUfIbUK3hlPbsTPsZ
	 Zn+yYjFmpwjxdSsDdVKJx0qQiGbWDgZadE6ZpAgkMSW2APpRCodqvDeXL9GFyX2jno
	 rixfHajirFH5rg/5WoTT5uxAo1MRzaRvjH2Ev9R1QqNLeMPHd9+AYlvscdV4uvkOAb
	 301IhKIectbysuQJKa0uDdwXzMQPgNc83RRz8fDKoub9+x5UII8/fKJLP8IwQ6UiyV
	 GxVYXJX+K1bdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34551380CEF8;
	Fri, 14 Feb 2025 04:10:19 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.14-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9txeA4G80xej2orc-_y1=cEBaxY2Hw-48v0sw485UjuWyQ@mail.gmail.com>
References: <CAPM=9txeA4G80xej2orc-_y1=cEBaxY2Hw-48v0sw485UjuWyQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9txeA4G80xej2orc-_y1=cEBaxY2Hw-48v0sw485UjuWyQ@mail.gmail.com>
X-PR-Tracked-Remote: https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-02-14
X-PR-Tracked-Commit-Id: 04485cc34868892a823b909c6d5468ba21b63569
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 128c8f96eb8638c060cd3532dc394d046ce64fe1
Message-Id: <173950621795.1492982.7917084634100432792.pr-tracker-bot@kernel.org>
Date: Fri, 14 Feb 2025 04:10:17 +0000
To: Dave Airlie <airlied@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sima Vetter <sima@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Feb 2025 13:34:04 +1000:

> https://gitlab.freedesktop.org/drm/kernel.git tags/drm-fixes-2025-02-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/128c8f96eb8638c060cd3532dc394d046ce64fe1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

