Return-Path: <linux-kernel+bounces-576293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A75D1A70D8A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 00:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640EC189311F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDA7269B0E;
	Tue, 25 Mar 2025 23:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJT8WTtX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B391AD41F;
	Tue, 25 Mar 2025 23:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742944610; cv=none; b=mSy8RMBZU9+yfJ6JgPWz7Oqtgf+NvtU/HUBpl16ucij3uSfgZKNbL+MUKTd0YvPWuerK0kRY4TJ0vEAFXnXpJ4PHyahL/gIA/2noU5pEjqpmOeEwS4sMihtYIUrjdnPGd3vA9bhFRYNPVqRDt0z/Q/YnTatJnYAT22E26wxs0m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742944610; c=relaxed/simple;
	bh=o739ocdZiRKxxaojo7nDmLPLSBSgZTXSMIOYgIHtuaI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hQcdpf2sB1vk9/JhIsrfUKo+1r3fnoMKj/im7YFwYwWkHUV0ZalIWFeE1PV5XkYJdswC3RbE5RdLmwGEPYiEz/gucJ43thHd3KnTKtxmscZGick+M1aVReoDrRYQfLNdUHFzU5j71ozzOP6Xnk21aFdz/fxVXRXi2kAItRFtFjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJT8WTtX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA393C4CEE4;
	Tue, 25 Mar 2025 23:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742944609;
	bh=o739ocdZiRKxxaojo7nDmLPLSBSgZTXSMIOYgIHtuaI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qJT8WTtXqJMLk19aSu2p/lFQ6K9r8lbVAjW71soEq0HkAME0kxzthxf2TB/1hMMh1
	 RkcEm8grPCazFcqroqOQ0IvOc48mV+DLOm8r89oVov45g3mt3Ha1eso/hJ30EiysPQ
	 z1jactmwkU81RlRfSq44CYVGrcF5F0uNBIGY22SB4J/+SwWO/nUCkintwn4ZBClQFR
	 2JHI4jq96YpEeRh29rMK2Q8TIHWGaPNAx/r6sH1FIgHx3Nj7k9dFAEvoQQkaN+AzfV
	 pORU+XdR0rC/Feuu4l8B2kCD+pqg4J2yv6Bh9Dlfky5hXAhs1zBhVBk1ducCYG0v2L
	 lpV9JKWA5ToDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C96380DBFC;
	Tue, 25 Mar 2025 23:17:27 +0000 (UTC)
Subject: Re: [GIT PULL] lsm/lsm-pr-20250323
From: pr-tracker-bot@kernel.org
In-Reply-To: <795b758412f3cb7dc64777a6fde9c16c@paul-moore.com>
References: <795b758412f3cb7dc64777a6fde9c16c@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <795b758412f3cb7dc64777a6fde9c16c@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20250323
X-PR-Tracked-Commit-Id: 65b796acea1e5efc13eb29fdb4638fd26deabc17
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 054570267d232f51b5b234a5354f301f65374dd4
Message-Id: <174294464587.770882.2963612289023193721.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 23:17:25 +0000
To: Paul Moore <paul@paul-moore.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 23 Mar 2025 15:39:42 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20250323

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/054570267d232f51b5b234a5354f301f65374dd4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

