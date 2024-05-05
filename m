Return-Path: <linux-kernel+bounces-169116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB2B8BC34C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 21:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABD0F1C20FE5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 19:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26A06EB7E;
	Sun,  5 May 2024 19:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdoyYM3D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81C66E611
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714938237; cv=none; b=Gv9SMUvTezr6zQH/51zg28hBV9DoU/G7e+YPOxfLWKz3PEozrD6Yr5eYek6GdMTMk1esS5CbKNtpy6ZvgDGIVRv41JqPZlyGd/uf+h2neKX494MXjhkyyTbqqglMJoK8oKU6ffvW8cIxqZLPnskxmETudCzc5BxzmNFfjKpFF4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714938237; c=relaxed/simple;
	bh=KyuBQsAa5lBeTTYE4+PFwcnjamOstKxEe6m7tOytGQA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jQXGpcsHKUNtZttfUbIYwJcZdtDIpcz5Bl+uzxnTJw2yQCud+hGLJLKlH19JODqdyB/073UMSTF5xC6y58tPUIn6c8jmSkpGXMIzZ7Jc1A22eubFjF9p+wI7et0tWyWzPHkxjvYSq98Z/d645PqzSEjOM13UHfpaTB7br7s6ZJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdoyYM3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAA73C116B1;
	Sun,  5 May 2024 19:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714938236;
	bh=KyuBQsAa5lBeTTYE4+PFwcnjamOstKxEe6m7tOytGQA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=RdoyYM3DgMeJ+z0fzHP5l1uTHve4uFTjZjKQA9OqXhkRRReBqQVBh0md7NehiFi8z
	 DyBlYuZYTz2j9Z98zSHXRR3/vWtf+fcMuXGuuIuWuhAfI6ujah3iW7g4xT809RW601
	 eKAk59bcPXJoX95zCC5QszsnTVUz3PdHuZ2+F6R8A5jeGyeEpXA/z9kIt2txR5KHIz
	 kjoGyDTnuNy/zkzSFNoi7AlOenOOzH5t7518mKBQo6ZTRtHE/FiLk2BljF6Fyssl+Y
	 +qGr7zGj9cXHjdpNHmFF6itb93P235ifHIEz/y45se2oq8TaFq2Ovn3KowR+oBTfIf
	 BQ3TT+Ni7ZMfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1A2DC4339F;
	Sun,  5 May 2024 19:43:56 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.9-4 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87fruxumnu.fsf@mail.lhotse>
References: <87fruxumnu.fsf@mail.lhotse>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87fruxumnu.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.9-4
X-PR-Tracked-Commit-Id: 49a940dbdc3107fecd5e6d3063dc07128177e058
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef095257750bb434959648331e48e44705d802e9
Message-Id: <171493823678.6787.2479407685189394456.pr-tracker-bot@kernel.org>
Date: Sun, 05 May 2024 19:43:56 +0000
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, gbatra@linux.ibm.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, nayna@linux.ibm.com, ajd@linux.ibm.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 05 May 2024 10:28:53 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.9-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef095257750bb434959648331e48e44705d802e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

