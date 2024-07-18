Return-Path: <linux-kernel+bounces-256768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D3F93700B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11782831AC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFCE80043;
	Thu, 18 Jul 2024 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhqQmS4O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C011C77107
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721337984; cv=none; b=kFG+XewhbiG4F9p+QsKwDXHUGLX5KZX0CZHKhYsaa0Hn1L+5XFpTdPK2yBC8IbcPPqsRwDDzdaF9rRkFCcWIBw69EqTJaVUCNS6ppx3HXMmS4IQW6dT6U9kaHe7AzKHqdVEC9qm6gbUbrwm0oy1INWwM6ZjrH2N3tB9TYjAOUoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721337984; c=relaxed/simple;
	bh=rfOIJjohG3afT5VClqb3NIhijHizJ6a7yN9FqP5qs5c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sNLEVxJTzQaNQMXDMkYlhGc2Lpzx1vsUUWaA76ylqtjnYTHCtg7HWAoNQvknvq/0GIjHQjJrxVNMNcmkhiAE54anSKPPOlaLoB4xJg6vpBHugV5GssCrTaXv6zMEnYihZgMGg6xASigDa+E5J1PuzomCTk4XXhUwY9Xf0fGLa7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhqQmS4O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9ABADC4AF0E;
	Thu, 18 Jul 2024 21:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721337984;
	bh=rfOIJjohG3afT5VClqb3NIhijHizJ6a7yN9FqP5qs5c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qhqQmS4OjUrtIdnVHbMkDKzsFOprV/KC7EkLof+k23dRQs1J9BSaYjDIP25ksQaeB
	 484UsJGMVzpv1kITiaxUt92sogddbT50QyoSO8Qcz+O/ZO24Ec1lE8DXr8Ap3MC+Hx
	 cX0nC8mDw7A5BqDlLxXIdOowTUYqoHSWGwvgPLG7zbHBsu0cnZFlNLpwjlSQMezqbs
	 YEyMb2eBpxvebkMBKYkatDIBaIg5M8nrMxtaQv0UvYN5SN8QreeJNn1ZcT+wefCSGs
	 YpKPdyn80hGmpZGNrFS+agnn0CAmBi+GWRw+BRnWX4X6UgCYMxbbC5RhjLv4y1QTE4
	 8Pbe1ntfkad4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91B71C433E9;
	Thu, 18 Jul 2024 21:26:24 +0000 (UTC)
Subject: Re: [GIT PULL] bootconfig: Updates for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240716234447.1971543e2c6f19d6e4b2092c@kernel.org>
References: <20240716234447.1971543e2c6f19d6e4b2092c@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240716234447.1971543e2c6f19d6e4b2092c@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git bootconfig-v6.11
X-PR-Tracked-Commit-Id: 0d9c0a67b14401344183cc0f8239f8d1851637fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db2451e78d5df51b8f926e31e343e74e6aafba9d
Message-Id: <172133798459.21905.8256445019220957931.pr-tracker-bot@kernel.org>
Date: Thu, 18 Jul 2024 21:26:24 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Thorsten Blum <thorsten.blum@toblux.com>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 16 Jul 2024 23:44:47 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git bootconfig-v6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db2451e78d5df51b8f926e31e343e74e6aafba9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

