Return-Path: <linux-kernel+bounces-383745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A359B1FC7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 19:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04E12814B8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 18:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D3A17C230;
	Sun, 27 Oct 2024 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0V20pfK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD8017BEBF
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 18:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730055399; cv=none; b=W/Ke7U49D+vCWp/ES+CBjijc+Qog7msqViNRzQyctiVHmaslpmkzxzhL5EhFMM6TZFAV+UF117lztJV7/3lF6hW6F6SQuytl++wb2zWpNpcqGbJNuzIcL3LFBvJDvnqUQernlJeCFZT4WGrCLCl/6ByjXQ8LxQYWHFRxUZ1rtso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730055399; c=relaxed/simple;
	bh=yyk5mxPstsYZr5HJdHHo4bHqQe8fl1reGj6iriKpjGo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=a8V4dfYc/RuhnpALoJNonUkUlJG/LWWIt0o5ZwKKS02upcZUhaAKN5XKars5NDRobhDVwfU1eSTCu1f6j04jwBroveEOBnzS3+jpjBNf9Wb36/YMzb/xZQoyzIb/rlFeE2a6SpRd6l3qLHs+vAJcL6sFPdOW7DIwskKvLC6bXzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0V20pfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB65FC4CEC7;
	Sun, 27 Oct 2024 18:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730055399;
	bh=yyk5mxPstsYZr5HJdHHo4bHqQe8fl1reGj6iriKpjGo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=a0V20pfKrUBqWGlHS041H/HFUJL8W4ggGFshsx0QNThXpYz8bGvofpK2tbjz4Dga+
	 njsW6rjUPW6rblofoQeRMgjVWGmJ8ggRKpY5ddQJBIh7tcfDzN4l6liZmhpwtB6VCH
	 iGihq7KRzmzkGfJqiON7EMjepg2w33zScI3KEC4VbFzGcXsI0TAPTjYo2WKRubvWKx
	 4aJDKuMXoK+h0K9LERq4UE+k9ejyxXYJ44D8+9hNfegdgZ+gxA74968wYbpD4Qlc/a
	 Hn5lXAwbqetCQPdkusZDRoqr/WmnmoEB6pfdXgzxPdK9jx2K+ex3YOFnOGuQA3zH3N
	 iZb6JqcV4lawA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C2A3809A8A;
	Sun, 27 Oct 2024 18:56:47 +0000 (UTC)
Subject: Re: [GIT PULL] firewire fixes for 6.12-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241027070355.GA146113@workstation.local>
References: <20241027070355.GA146113@workstation.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241027070355.GA146113@workstation.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.12-rc5
X-PR-Tracked-Commit-Id: f6a6780e0b9bbcf311a727afed06fee533a5e957
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7bec4657b0c9355f235a3dc60578bc200146aabd
Message-Id: <173005540596.3429718.14573389681304590481.pr-tracker-bot@kernel.org>
Date: Sun, 27 Oct 2024 18:56:45 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 27 Oct 2024 16:03:55 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.12-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7bec4657b0c9355f235a3dc60578bc200146aabd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

