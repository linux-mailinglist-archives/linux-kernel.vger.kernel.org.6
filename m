Return-Path: <linux-kernel+bounces-282336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B54B94E263
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 19:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF436B212E8
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 17:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5184015820C;
	Sun, 11 Aug 2024 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpgZVc3i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929331547FD
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723395851; cv=none; b=YRJvSdBYMQdQmvguVG4iMNlv0B0KoQKWBqyE0ko+Wkd+wketh6wPgDn3ahsEd5kRRI9ISC9cpd47tu9opuyBf2sJ6r7ZoCAURCBMJhhEFb/jN8xG9qNi9JX0Eblb4FxyBs58lxIlhikaxXd3Oj9/WlSoRb+17F9m6FuGXDAAp0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723395851; c=relaxed/simple;
	bh=bDGHwxBSRZUaTxMMTpeAz7lWUjz0e9SgrC85AygIH+U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WJzUeyXzj4VY1YiulS61Tz9h9QsdWMqHS3+e/JxGhEMhJIzjkSrBwQGOs7E1LwZ0/V+3LtG/LgkLjXiPy5WY4GVg4UqU0dJz28dODZ5CT2lBIBtiLlcqw0G7bRnDfFN9R7n/p7BSYrumjzwbL6z1/D0MfFrI9W1MuzFowVeXBH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpgZVc3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741D3C4AF0E;
	Sun, 11 Aug 2024 17:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723395851;
	bh=bDGHwxBSRZUaTxMMTpeAz7lWUjz0e9SgrC85AygIH+U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DpgZVc3ih0aAPz0Bsu6w5qAZsRLo6pOIPXHFhosTtrBKfVAeWH8bwcBX9BQKlaCyl
	 OvLxygCLwIBn5TRFgDQg21ht+rB4SgHHdqQK7nX6DClgJk+osvlqh692YEu7xg3Ci9
	 XpqBAUKyPV8atLXplnfjsWMw4ZFTaWOD9nuAddIK4E9kHiyg/VBpsRMde1K+2ja+Sd
	 bo3+WGvGssB84hb4MY/7Idyxh/GaqS7PmtRdDNMk7KL3Y+7vgs07rkfSWJZlZrzLAf
	 IUdrQucDVchK+QmUcalZLixysWMhEI0SJz9xlMSVSZ1+skzsizUnCrht9ZYOIRZOhF
	 uAr+jUgOdaV6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE27B3823358;
	Sun, 11 Aug 2024 17:04:11 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.11-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zri7F8cRtyS1ylM2@kroah.com>
References: <Zri7F8cRtyS1ylM2@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zri7F8cRtyS1ylM2@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.11-rc3
X-PR-Tracked-Commit-Id: ffcf2eb4bfa24f7256de53a95182c3e3e23fdc6c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9221afb2d8e8db75bbf71a223010e37db1b64f30
Message-Id: <172339585023.226577.11269470398597657314.pr-tracker-bot@kernel.org>
Date: Sun, 11 Aug 2024 17:04:10 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 11 Aug 2024 15:22:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.11-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9221afb2d8e8db75bbf71a223010e37db1b64f30

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

