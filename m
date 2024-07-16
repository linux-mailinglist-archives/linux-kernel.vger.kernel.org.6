Return-Path: <linux-kernel+bounces-254487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF3E9333C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 23:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1931C22D59
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD561448C6;
	Tue, 16 Jul 2024 21:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m45Zp8H3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF563143C60
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721166222; cv=none; b=qVV/5JHDInNtLgJ08fjfgehs7sMzV/oLOOUwWzUGL+v0PkHcQ9UZeXaQUKnKxGhypv+S2+7YoMhyPsZAGLvjp+J9oZZy29ek6N9mtIJg21Jj9tzpI+DYHTbZeJ6YNPQ33CyWQbv4RQaTLwOFz0eh40ktXDdtKNKy1fvlb9RHyio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721166222; c=relaxed/simple;
	bh=+aVkpmNt166hu8rVhvAKaK871T8Z8E1ZzvBw/asPyUk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=j/EGh9k0tCU2ffr+GRKhDf0VUFQjr+Z5P6unk/hOqyqRbYFafPnXOR/3KDuehlt3YeISQPvd9FNAjYnnOrx1dLchNENu3BYUsO4t3Tj8TPIuUHlwIf/UVUG40/kqMDU6V+vHtTDoIBbm0CY0XVaT/BrDOKeF/SJ1D47q8H7CEbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m45Zp8H3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5CE0C4AF0F;
	Tue, 16 Jul 2024 21:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721166221;
	bh=+aVkpmNt166hu8rVhvAKaK871T8Z8E1ZzvBw/asPyUk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=m45Zp8H3n3k9O+ilviPpkmX9nfHGCTuqtP4qRag/1ii9znNwz3fRmkVBPMt3ou0Dy
	 wYd4e07YMNFxbJb7cxzx+SG2ecunpBzxe6R8uyetLCL/5t0TzJTYkSIXX36AHY9/fn
	 M3eevsP9qVT8Vl39DRydshYLOZJBhFzJuJxMHwgr1Yx5LhQOvECp2R0Q9h2UywSCmf
	 /ULNijIlA0LuqO6VJOMHgoiBkHQCQUCQa3XUbK9rpYl0HEZ87gMvLsjIW05KcrqT9e
	 kK9cTIg7kpFvPbMSvGeQrd6HupkD7G/eL9cr7uz4kT+qsR+Scagu2Vm2KjgXJxoGE8
	 JEZkZ7YszRMbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB553C43443;
	Tue, 16 Jul 2024 21:43:40 +0000 (UTC)
Subject: Re: [GIT PULL] hardening updates for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202407150933.E1871BE@keescook>
References: <202407150933.E1871BE@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202407150933.E1871BE@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.11-rc1
X-PR-Tracked-Commit-Id: 872bb37f6829d4f7f3ed5afe2786add3d4384b4b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce5a51bfacf7a2953f8fa309a8fc8540c2e288da
Message-Id: <172116622076.23491.17032334020767775625.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 21:43:40 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>, Kees Cook <kees@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nathan Chancellor <nathan@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Thorsten Blum <thorsten.blum@toblux.com>, Yanjun Yang <yangyj.ee@gmail.com>, Yuntao Liu <liuyuntao12@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 09:34:47 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce5a51bfacf7a2953f8fa309a8fc8540c2e288da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

