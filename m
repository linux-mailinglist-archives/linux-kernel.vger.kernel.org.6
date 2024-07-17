Return-Path: <linux-kernel+bounces-255644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD93934328
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 433A81F21C40
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A25B18C171;
	Wed, 17 Jul 2024 20:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxSuyhEf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719941891A8;
	Wed, 17 Jul 2024 20:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721247509; cv=none; b=ckY1zo5VewsSJ+F8aF+lp/5A2UU4wh4H5UUzQTY5RumKSV/Ixngoh/jDw0I6VKGdd4gl3BFGAlCToZaaSSzwo0DM5tnUoOBKTcjT1NgMW/9PNIioQyqQAEN0UGjfAvfRJwBEEoowiWGYlh+pKZlOT5+U4CnCnW2xp+F9BybWMXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721247509; c=relaxed/simple;
	bh=3pWsuCBbTSEwMUON2NoNUEJI31XSepoa5JVeCc29jiE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=f9ml943MQQeDlqksHmTCQ5F1EHOEsB0AaAZ/WKghVcZiRp/sSkv71xI44G6HYylOQAUO0SfKnTdVt2hMIg5zl8mJ4KT5QSbQA7I3KTzXivWqe84+VN8tpTeMPqHCRqtb5tx229ixLQgIqY6qmkkC7OlOwwJ9EALqpJctwvWDUQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxSuyhEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54061C4AF12;
	Wed, 17 Jul 2024 20:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721247509;
	bh=3pWsuCBbTSEwMUON2NoNUEJI31XSepoa5JVeCc29jiE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OxSuyhEfUSh5gcelyERxGYb2L7vKGQYGYhZF8EBHakG40/dvHcqvDBqZMvROK3UY/
	 iABdeMFO+YQwLti5X72Mj8TUpxp7rp07f+/zURpPxkTkLS5YUb4uGrOgwk886Uf96E
	 L4R2DH+DX8lrs6l7Nq0OKRabRJnjSJjzM6nYsRMKobn+ZVWRAjTnhp72gmOjZApsrC
	 vNYHwlk1v2RrfaZtycoh/MPM6Q6aj/oCPDJI0lctEaxpPZ18ZmPMaGfcHqeDi2D6ah
	 hYl1Tg7M4TNp1JJtcLFTZ9ca7yjukdGznjaerl4rKtXU/VNu/IEeQqqtLNFf0Uvi7E
	 LDdJgRouZ0d4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42183C4332D;
	Wed, 17 Jul 2024 20:18:29 +0000 (UTC)
Subject: Re: [GIT PULL] dlm updates for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZpVUcCId-3JUmz03@redhat.com>
References: <ZpVUcCId-3JUmz03@redhat.com>
X-PR-Tracked-List-Id: <gfs2.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZpVUcCId-3JUmz03@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.11
X-PR-Tracked-Commit-Id: 89b01913dc73d7c4b8440b1396909ccb7ec8c4b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f097ef0e7625f70844ddaba60ca43d421db5b1b0
Message-Id: <172124750926.12217.9099399968531617753.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jul 2024 20:18:29 +0000
To: David Teigland <teigland@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 11:55:12 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f097ef0e7625f70844ddaba60ca43d421db5b1b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

