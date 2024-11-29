Return-Path: <linux-kernel+bounces-425935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3184A9DECB4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 21:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E438716336A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 20:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E3115B547;
	Fri, 29 Nov 2024 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0eg8wSH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E13E156C5E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 20:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732912283; cv=none; b=VNFn3LH1vqYneA+alQq5rqqQWN11gk8GAEPQIB/Ujx7ioATX7SR4sxiI62sgrT9b4kh+uq/dKas5t4LTH30vcKZJQMWl8hfUEcoCr6u2e8VWcOX+OdGenu8ZqSzryXCD/QlSlkZAlXIuAwGuAAaaRP9NOMwyzRs1WOQRA/DZ7zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732912283; c=relaxed/simple;
	bh=aa/rj6DbiUlLkBqnZHlmAu2vEGNODQy8v0bKM698tME=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NY+hqGOWhsOojCpiAdmRLE0Y0zodbDSsJ9l5eNVb907OupOqSjQhr2iczgXySy3QScD3YIxZdo/Fyxx+utz746W4W63EMeWXhjP7o27FfbsXPjeMLahvze/2vnJtmf42q++1Hd+dzCEIyZIgZeDWwzTLz2HEIShLmyWNSWow2rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0eg8wSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B57C4CECF;
	Fri, 29 Nov 2024 20:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732912283;
	bh=aa/rj6DbiUlLkBqnZHlmAu2vEGNODQy8v0bKM698tME=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=m0eg8wSHG4VF9/717AxaHuPRFw7JTlTSmZVbf4n8h91lVFDeVksF7dYo5TTuj8KxE
	 uNWZwPEl5Sv06sNwtHeKWXLHKGv5oZGDWf35d5nKEsJGgZkU8kePXHDx7mmpojUO38
	 Qsp/MZ4+0SO9WZHe+bCtJIUpagsEaHY41VvAYBAFeyM3iG0Sp4jqZVbUqTeweinyYM
	 GSKkeGOe4OkL7EmdCmiUZvZEIYgQTpYOa2YbGsA9wXBDtMitRfKOezcybhIcPvk4b4
	 +Kf+L3q3nqlN+9vFsj1fJJqgdhOEZ9wdKGO1hH6w26sfYQ12lnDCkpDq9tFpshEFVZ
	 Lm+TqILZJSeUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE4FC380A944;
	Fri, 29 Nov 2024 20:31:37 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core changes for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z0lEwR55Gv4K0GpR@kroah.com>
References: <Z0lEwR55Gv4K0GpR@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z0lEwR55Gv4K0GpR@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.13-rc1
X-PR-Tracked-Commit-Id: acfeb6defcb9310b1ff44db1e633798ba766337d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 55cb93fd243bad2c6e15f9151a32f575d2f5371f
Message-Id: <173291229632.2176319.823909197590573915.pr-tracker-bot@kernel.org>
Date: Fri, 29 Nov 2024 20:31:36 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Saravana Kannan <saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Nov 2024 05:36:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/55cb93fd243bad2c6e15f9151a32f575d2f5371f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

