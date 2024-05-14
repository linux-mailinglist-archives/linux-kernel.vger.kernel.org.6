Return-Path: <linux-kernel+bounces-179203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AFF8C5D00
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 23:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEA2E28212A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C97181D04;
	Tue, 14 May 2024 21:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+d1pxVi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4C7181BB0
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715723087; cv=none; b=EXB9bNBdiaALKmYTBLVsZ9XSslxTBDrNnWeO6ZORO182d5zZmprI2pWBZXj1UW9ots+ww/bc/utzKGVITjJGiM3SwtSemVSk6FWWP5dw5ecfh3xaN5Ml1gC0YLqD6FKxTaCIKMC29St+3XmA2xWJdY0lZNSQC0k8pAQvTKcqPRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715723087; c=relaxed/simple;
	bh=sq3D28wyx/4XYdKA8OjgJTzM4z67outt/PY0cI0dGFY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kmDUep8EqF4jlkNmtsn0xpMSDsRNRxnv59tQ3TzCFVKh+odwP4cSloTRtlQW8jgs4vFFO1lYen3qlHELzRqcuBUeMuj8TmctQlJowEC74jlXPfKWU+kOuzij7EHzwKrzxsn6ZwVau5TZqP28+4rA5d+9xuwJmRfxfwQDIM/k6eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+d1pxVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AD4FC4AF07;
	Tue, 14 May 2024 21:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715723087;
	bh=sq3D28wyx/4XYdKA8OjgJTzM4z67outt/PY0cI0dGFY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=u+d1pxVidB87poAgL1JR2fVYeQ/5t7Rzvo2TLVr9Tt+DAO8wbxwEU8eJf5+a8G16r
	 TtWbRSCGx2VgbMTwgM0hl/GjYcx+rlsPJSVtwjkgh9G8lhOm4X7XOfAIcp9rFgE2Zc
	 EuIVzc2xnwGn6K4ODftGkzTFOze7qI7/GVscHmcLb1sl9CJyjSqu9j1uipQQ8f6wMN
	 xUZ4LtzPD3QvrjjyGFad2KXjP1B2Nw8nSunjisGekgF2FCuzbGNIUr0Tx8LiCl1Kr3
	 4stfDUii9n1TFqnRBOUvm+fm3N+qzRPi17APMecUw4ss/LQJgZgOSVOLU97uHK0Rwy
	 VSUBSeWVjFr/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 937AAC433A2;
	Tue, 14 May 2024 21:44:47 +0000 (UTC)
Subject: Re: [GIT PULL] regulator updates for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <969a662f066e8d49507ad947e3d7477a.broonie@kernel.org>
References: <969a662f066e8d49507ad947e3d7477a.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <969a662f066e8d49507ad947e3d7477a.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.10
X-PR-Tracked-Commit-Id: 4e70b26c873dfff317039458a6ea66314bbdce99
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 07bbfc6aba1efe332d9994b2995c9bea0cd3b25f
Message-Id: <171572308760.14334.16984411178205365202.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 21:44:47 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 10:38:55 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/07bbfc6aba1efe332d9994b2995c9bea0cd3b25f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

