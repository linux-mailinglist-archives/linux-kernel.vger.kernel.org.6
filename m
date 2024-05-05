Return-Path: <linux-kernel+bounces-169077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432AB8BC2BE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 19:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07AE280DD5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 17:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD2D6EB52;
	Sun,  5 May 2024 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRuT56q/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D1D6CDD5
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714929181; cv=none; b=Q0iAO7pQr6hBHgb6F9ZsCmmy4oOaFfzedqAlJDid6Q9Qg1KwnA8Dd+IhLyxiJSGujeZeOAejwd0ZweEpGXeFCX+T7W67ps0DwVFrFKL2JvBOAiNntXYxGckVV8pnDisxg5wjJTW/DM3EtTBSWVqjJMlrrbMJzxQpMTrJDk4k7Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714929181; c=relaxed/simple;
	bh=lKWsFLRuPa+/Ii+TsfT8FJzLra2eEuUNOFDjMbRGgFk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mi6/fbQQZIqldb3fPEWbMlYA3OSqmUE+4Ak+cfn350jLhRB+St85DSCsdEryxVvisfj4A1CVx/s5bAY3XCKnGyPel38EwfaO0E9ZPsNtWh39jHoOaKIZpv+Isg3IRN/dAFrgeRoifWc5150iUr1l/BwUV4FXuX4RaGCeWESWFJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRuT56q/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D81E4C4DDE1;
	Sun,  5 May 2024 17:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714929180;
	bh=lKWsFLRuPa+/Ii+TsfT8FJzLra2eEuUNOFDjMbRGgFk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KRuT56q/dfj12oL4srhSxzcqerHNpJ3EpHDtYStmZQzbGXFF1UiBb68s7mv3zm0NJ
	 QRWLfcQqtTwgNVD5pQF4R8mhnMUDkq8dRogb2SIcQfOds8ZKDLA+gQbKuaRkiPzSQt
	 uCNM0rfzVzK9ZykVFZAFAQPDODoJwUz0SMrVHWUVMxuZC+Hb3SEQ1865K5EhQ6KNgY
	 3fndK+T2wV+tJiQ6EibbUVXJkx6ehBt80y0sp/TolNYqcQU8U8VU0VepLA0o0qHySj
	 zswF65K1BOxa8a4dMaQr1tm0WXtzIoeqTkCaGNKlW8I1uVPatvdgqUKlpauGwJxpLd
	 Z6QHFfEowngHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA8A7C43336;
	Sun,  5 May 2024 17:13:00 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.9-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZjdE2yWk-I3YmLf1@kroah.com>
References: <ZjdE2yWk-I3YmLf1@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZjdE2yWk-I3YmLf1@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.9-rc7
X-PR-Tracked-Commit-Id: 98241a774db49988f25b7b3657026ce51ccec293
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9158815de525572333d0499a681459f6b075f28
Message-Id: <171492918082.31500.7862145447229523291.pr-tracker-bot@kernel.org>
Date: Sun, 05 May 2024 17:13:00 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 5 May 2024 09:35:39 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.9-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9158815de525572333d0499a681459f6b075f28

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

