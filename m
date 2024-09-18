Return-Path: <linux-kernel+bounces-332378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D7D97B906
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9C51F253D1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1E9188583;
	Wed, 18 Sep 2024 08:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3TXZ4d6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BCA185E7B
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 08:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647011; cv=none; b=QG3pFxxzUl66Uim9OAut4oTMrsQ1vVpIPwf0EDhd0akhxpG09rdZ0+lXcX5VP71jckQUcvapEWIR9PSKaYF6MMkS5OkgJw1HPHIUs2ozXff0BI1h2VBbFu4PhzZgC5brNEb+nq2oxNFtozQpexkgUsHletAEsC9bsZrQ0a9skzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647011; c=relaxed/simple;
	bh=q3jde1iFgjPFsEar33UhgZxcGgBukWf35EG7GR94Nzc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aJPU4WL+eoxY/ujIzbRXYz0JuPi/SpUhSgjvoHWI4EO496APemBQLYNaVeWV35DCcxHEHU9cH631wCDfNtQk+GKZOXTXOKG+V6xP6QbBp7expBBmiWLVzguQZxPWCkvhSrCgBlBsyOtmLCM+n2edVFJ58SL5FMdvkVedo9nUNWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3TXZ4d6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46AEC4CECF;
	Wed, 18 Sep 2024 08:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726647010;
	bh=q3jde1iFgjPFsEar33UhgZxcGgBukWf35EG7GR94Nzc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=a3TXZ4d6QbPaCltvoL0+JsG5cMtEZ4lJaO7/HnyW3S4Flp8UZvmLijvboiz3hgS/j
	 9K5N7J4COlCAHtb/CGvmBlDDFfkjA+vJGpkjDlf8qk+miUT9Dnq4c+/kGmUJKyUVyC
	 YSaQbO/Sz9kI+6u8odLbpOqYYQSNhGsS7mYp5s+pNVy/aOjFfs8UKAFEoPAViVbLq7
	 HCZxpzM825lDZCsOrHH8a9oc37KmNq2nCBlntkf0hV9EJIhOm7oLA91zwW+vuCJB1Q
	 R92LgS6Nu0GGPTNX9fkUXO/CAvtGA8XA5aMhA0TaAhOPcbVIA1l6J+WWD7IY4TW2XR
	 y3x9mGHURAkxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D32153806657;
	Wed, 18 Sep 2024 08:10:13 +0000 (UTC)
Subject: Re: [GIT PULL] exit/core-dump non-urgent sleep for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <bb2c5f74-2f89-4bb5-9d49-3061c218dde9@paulmck-laptop>
References: <bb2c5f74-2f89-4bb5-9d49-3061c218dde9@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <bb2c5f74-2f89-4bb5-9d49-3061c218dde9@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/misc.2024.09.14a
X-PR-Tracked-Commit-Id: b8e753128ed074fcb48e9ceded940752f6b1c19f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d450d120f0a9f661cd78cfa4bcdf5c6e31e4b31
Message-Id: <172664701261.684502.2705041889040353759.pr-tracker-bot@kernel.org>
Date: Wed, 18 Sep 2024 08:10:12 +0000
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, oleg@redhat.com, axboe@kernel.dk, brauner@kernel.org, akpm@linux-foundation.org, willy@infradead.org, clm@fb.com, riel@surriel.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 14 Sep 2024 01:16:38 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/misc.2024.09.14a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d450d120f0a9f661cd78cfa4bcdf5c6e31e4b31

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

