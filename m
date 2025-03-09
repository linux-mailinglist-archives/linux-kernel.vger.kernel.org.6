Return-Path: <linux-kernel+bounces-553326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA5CA58780
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 20:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE3D188D359
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C38721505D;
	Sun,  9 Mar 2025 19:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSFyQGZR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9038414A639
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 19:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741547899; cv=none; b=ftNBCWboLb4uctz48wM/6+QpsQM1YD+Rw4SA6m8CMlTVGq5Ul6AmJfqU1UedzRufIkCfNEZGtztEFcIkblPjiAURLjU00RYVYUa9JgLKeJAiughSY4cktH3bfqpt0h/KfgVo6m2Fvt9BQ2ayxIo6uvjhIcFJLhq+kAO6X4Rg4L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741547899; c=relaxed/simple;
	bh=1a56cXTQTloxX0XDhDOD1B4QzigXOxhNQ1zOE9Z4PQg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fe1lsEJls8BPlboPMNi/70og3Vw/sUJAECKVR1nR+BI37Ct2YyXYhFJb2KBY0gR03N8136mt1iP8MomK2MXzGNYq8WlWKPymmlrCGYsM+7Pq9V7bdlPTMEVSJnbocnl2rUvDoHye8b0PAMyuOWtltNhoQEuzsqMDADl8XzeBNrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSFyQGZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B5DC4CEF7;
	Sun,  9 Mar 2025 19:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741547898;
	bh=1a56cXTQTloxX0XDhDOD1B4QzigXOxhNQ1zOE9Z4PQg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pSFyQGZRFY+ivzu64eoFhWaaVWvt+gI9hyFPQpQXuY7HjJx/zWeEGNUSZ7qGlPlQY
	 V5mKzMSOBHP5I5/kqtU1soK8g1FDiu1XDxO1JFpIwX/lM8XygT19XCwxAYD/PduGWq
	 PYBxkLxKSp7mhGr580iOmJcwcVSVIjm9DhGGAUHKyQpIxirLtpJf/e7oFMby3i915J
	 IWAANv1ilrmjFYquTT0+fHUiVyeSx1WnmhosQU2Y3iNsAXXgeaB80c1IR8xG1znCsI
	 ywOkGMdD8uwVQG4kdDVw+wDVkjWYfbA2+fclvpVZ+uu+cCAf0EachnVPTM9EXgYu8m
	 8LjrkYFVGO+9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC4E380DBC0;
	Sun,  9 Mar 2025 19:18:52 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc/IIO driver fixes for 6.14-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z83TCEMlzC7MlW77@kroah.com>
References: <Z83TCEMlzC7MlW77@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z83TCEMlzC7MlW77@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.14-rc6
X-PR-Tracked-Commit-Id: 2397d61ee45cddb8f3bd3a3a9840ef0f0b5aa843
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2cc699b3c2fe5ea84081059c88c46373cbebe630
Message-Id: <174154793163.2953179.14081613315416138784.pr-tracker-bot@kernel.org>
Date: Sun, 09 Mar 2025 19:18:51 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 9 Mar 2025 18:42:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.14-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2cc699b3c2fe5ea84081059c88c46373cbebe630

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

