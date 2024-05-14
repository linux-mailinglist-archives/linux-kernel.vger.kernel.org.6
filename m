Return-Path: <linux-kernel+bounces-178272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AF98C4B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 04:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F004285D74
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B281C381A1;
	Tue, 14 May 2024 02:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agn96+xF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41F61EF1D
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 02:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715655090; cv=none; b=bL8R3RuVBWo3MtnSE/LNzG5qA5Li3NjiIxXDcZ8ilkFddQMu7hafPJIDgNixsHob81VOkwoo+Dh1VnmTs3evu7Q69orW43kLu2VYpXFSpWZtH5Ja6HPnZa7Ry6S+NFb68IuTKtido22UQSQJx9AfgYFhvIgt5KUQMAD3XMcB144=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715655090; c=relaxed/simple;
	bh=UQM5VYRMICosTK+gZytKDq+oZMDIwYZ39sKVkAft/1Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BVdFdBM6L6tFzafOVarvgindLLt9dkfqm/FAOt85y2H4HnTaJ8E9etEfBvfO1IAkYD3QWwO9wV5KTOOj/7aV2Pbrw6LStAmbJeEAoVZUEbyW6PIYvMLN2V9H9kLZGt28uqQsZI5AXqv3yRTcQbnk+sUyVjzsjbF8czhQCl4ZNA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agn96+xF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96F55C113CC;
	Tue, 14 May 2024 02:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715655090;
	bh=UQM5VYRMICosTK+gZytKDq+oZMDIwYZ39sKVkAft/1Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=agn96+xF7gnWGmp6278WOJts+s5bmGVxHnpxFXekNpiK1oOo732JXnjKOwR3zU1tV
	 IToPPPO8YTfflp+2wx/dVzPvpHNO1jGauv7lQTCA2wKvbLWTSpbKhWwy1+QyLviF1F
	 yMx6IJwv94owZCDrQn5O8+8emTkqYsjA8YADliN1zSFxbExv+/kDYNQwkzT4stWbq3
	 phvTvkCVDiWY/Lho7JK/z4RKJrRds0Eu7sjCD55REZSMjL9EpCVBBGopz0v1YYa4f8
	 jlR3sHuNT2FIaZ3p0gGuocn8cuvWqmqbq3eLKe3pZxv18xzMyBWsFl+nf7LWTqSh2A
	 Rorrj0phAzosQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D8EFC433F2;
	Tue, 14 May 2024 02:51:30 +0000 (UTC)
Subject: Re: [GIT PULL] x86/fpu changes for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZkHEHFVzn8bhhGIl@gmail.com>
References: <ZkHEHFVzn8bhhGIl@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZkHEHFVzn8bhhGIl@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2024-05-13
X-PR-Tracked-Commit-Id: af813acf8c06db58c6e21d89d9e45e8cd1512965
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 963795f7583c5bd1a93a041b0dc382505bf82d60
Message-Id: <171565509057.649.2702937966507910739.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 02:51:30 +0000
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 09:41:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-fpu-2024-05-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/963795f7583c5bd1a93a041b0dc382505bf82d60

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

