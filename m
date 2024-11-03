Return-Path: <linux-kernel+bounces-393927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629579BA78B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 20:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B0C28173A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 19:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A07C18991E;
	Sun,  3 Nov 2024 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LynojFKc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072A11E52D
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730660538; cv=none; b=Ssndi6UOSouZDezAHAdZWHKaesZvDOTc1I7IwJrVFQG8HRmR5nJ6XMfyCkcLA9XM9za32+Ka3ZfVeGeE4EXDELc/lTLWCDXwKwgFu/G05BRwjqdO9oOm36mEF54/Lag4+HKSFj1HjXvLsshjPYQD+8UAD01w9zhH06l1zTuG5wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730660538; c=relaxed/simple;
	bh=2gJ8QW1XmnBI3LPhwrdRAWnIKxOdHaBPCWNW+EWLWEo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=vElxSTtdTs8u/APuRpJ+fRBVY4RVnMUkQR7mTdbPwgMZHLKt42p0DlDS5kikRpEHFhPQfalF/+//VhNw9USmgKEWuqovYDnN8I6I/SV5Qm81iXEkVFggXcEY33J/jk8aG6P3QRnv9mchwKMfxmNA0ilFhj+hcfZIM0wCzOQuyns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LynojFKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FA5C4CECD;
	Sun,  3 Nov 2024 19:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730660537;
	bh=2gJ8QW1XmnBI3LPhwrdRAWnIKxOdHaBPCWNW+EWLWEo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LynojFKc4ZlQfdtvDKIYbeiLFLiaQGV45W9hKYvuViugW4Cq4M6lFSmDQhtKzW9oY
	 d/0kE1G6Ec6EhrOFluxLrgquRQRWqXWtgkx27KaybfRAQnWs8RbQwOJhqqigVDIgZp
	 ab+kvzdhI15+E0W/zHh7PsQ9K18PRYXBuJ4OaWqt74iclPy3ZXUu63zVO2kKBpj/3z
	 6gJyft/9blKUYHtOYDIAQdEkQc7F8FwaQ13OO33S4/1WOS9JDQQaJENX/iXyDToGno
	 ejYHwIhc/WidAD8AZks0dcjVfSxFB9MW4s2HcUYCsVQUhGuAFw5DDmsUqQOg1myPs+
	 pLzKqOO99Zd6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B4738363C3;
	Sun,  3 Nov 2024 19:02:27 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc/IIO driver fixes for 6.12-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZydmHKdMoOr4tMgM@kroah.com>
References: <ZydmHKdMoOr4tMgM@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZydmHKdMoOr4tMgM@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.12-rc6
X-PR-Tracked-Commit-Id: d0bc3b92fb9b2c3c981984d52fffe8cca77165dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32cfb3c48e24511ccf9f76d8a2e04a30397af438
Message-Id: <173066054577.3233701.8616736089146025641.pr-tracker-bot@kernel.org>
Date: Sun, 03 Nov 2024 19:02:25 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 3 Nov 2024 13:01:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.12-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32cfb3c48e24511ccf9f76d8a2e04a30397af438

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

