Return-Path: <linux-kernel+bounces-179285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C19A8C5E72
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 02:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A771B21A60
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 00:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A8418E3F;
	Wed, 15 May 2024 00:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCcnf7xl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608AAF9C1;
	Wed, 15 May 2024 00:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715734395; cv=none; b=rf26FwH4oTB001JRND2aO2vkgGwWcSSEFclQ9jz43EW1c/FKaCt0wmGlGImW4wQ7dhysMg1Flj7IZLnYC7XwYnVYVHIg3BZc6KzzhrZje7aVxRlLSQ0OyFjpLOcIZDJjdV0yOpn/iXee+nHmDKItSJ8zp42l5OZd1IPvejxn2RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715734395; c=relaxed/simple;
	bh=NEGKILO0fuH0LE65AFdQHCVNd3NixqerNJPLG83FawI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Kqxbng/E4jSl7POTFbZQiw4bFmt6GUk5DAUbEoS/1kU61MvsP0cuO7Kpea5p1WXfnXdKp3GU0o0Tjhvg04W8x8uMqTX3zRiR8DcPc5a19U4u0OR6toucM+qF+S7dvsthzMXQoTGfqk/PfKF3/hFNt8L4ouPTfdG6pyh1gZTbKik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCcnf7xl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42F8EC4AF09;
	Wed, 15 May 2024 00:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715734395;
	bh=NEGKILO0fuH0LE65AFdQHCVNd3NixqerNJPLG83FawI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nCcnf7xlo4obIvPUXelZz6K6GTN5V8yxsBjwGAeBlIa0lYHYqnPpGSyA8VVaImLtZ
	 g2kCXeDQFLFocugbKb7jWwqouR0eFiPsF+P7sNo0NDil8C+zB4SlTePRhrNvua8tqB
	 uI8yapH2H/eUQGxyxVYOS1IhaeZNJbX6aQvm2Rg7j4+yftjaenZrWqnOjjBh/tgRft
	 VUS9rFhZOlJ7O82bN2ihfPfG9eVtSUJN+ptdWraBTlu2w7B3DkD0JqGgJ7G+or9MyI
	 VFf1vCzwU5C+o4B7YLYsLyy20/aMb0TNsL5bPmkvoBrV6JPYrBAigUq7MRurZXO+kw
	 JyIw9myLRl2OA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C89CC433A2;
	Wed, 15 May 2024 00:53:15 +0000 (UTC)
Subject: Re: [GIT PULL] dlm updates for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkJ1PTW7V25ePbLF@redhat.com>
References: <ZkJ1PTW7V25ePbLF@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkJ1PTW7V25ePbLF@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.10
X-PR-Tracked-Commit-Id: 7b72ab2c6a468305449db8f204bf1e406fd3e147
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6fffab6676853d52cfdbb030365354252a66a20a
Message-Id: <171573439524.24206.15082558027067952645.pr-tracker-bot@kernel.org>
Date: Wed, 15 May 2024 00:53:15 +0000
To: David Teigland <teigland@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 15:17:01 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6fffab6676853d52cfdbb030365354252a66a20a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

