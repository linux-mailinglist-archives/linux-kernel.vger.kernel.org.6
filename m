Return-Path: <linux-kernel+bounces-413751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A6D9D1E37
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 03:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA793282FCA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B7E149C7A;
	Tue, 19 Nov 2024 02:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfE+VMza"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CBD1547E4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 02:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731983051; cv=none; b=HNycDiZHPzYBJ65+ow2nE9XDViNpNkdaXXPOeWtnUdxRsXINN1mSTd9HMUbT5FBY2uemclsDU/YZIima9NNKfh9qd6W0Dvh561CYhFX2cD7J3QnBlXK53z1kl6SLHeTn/dm/CKUauHviPcw6S3aI0XqTOF1u4REOyWBAoNddhkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731983051; c=relaxed/simple;
	bh=AFk3dEW7eoqSSrKBTMYIRluZEfqiDOKQAs/9HVWgNnk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=b4k3qdPP+78aoNKoZUtQ33zolOv/mdClCBCowBGMNFCWDeSJ2LbTcXUgo2WboRRXMdN3VwM+pXQW49Tkbkf3uWUzF8LrGBvdut2XoDUpk3BVeAqScmKG4WsLJWhoVHHL/0QitmUw0boiuqr9teubTJ+LMkisd/h5NFJTY+NmcKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfE+VMza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C709FC4CECC;
	Tue, 19 Nov 2024 02:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731983050;
	bh=AFk3dEW7eoqSSrKBTMYIRluZEfqiDOKQAs/9HVWgNnk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GfE+VMzaj4WpfFZA3ECg82W3xAIJAmcM+oXd2eouyKgEdHZrnnXDUzwb4YdTMp2xJ
	 5VE0xM3DNQKCyWXD8EQYkMCk/vAFvmO76knHzKQfbivjhYCjCRi4IBXsnE+k6QiT6q
	 lBl642msZh+LwwytKbJMGl/wC2cfIVAYRq3lNM7WKqA59Qxg0q4P0XsxuLFIPuFk65
	 kGkuvNDMpt3wSCExMeH0NBKZOjiVKTEHhoz0DJQq8T5cruHlOPoYBpxoyhUjFp0AWY
	 etfFTl6bSmABhDksJJCVGLSGivY2tnXmFpqcv8cnu/Ys0SSB/MKyMy8XHc7v5k+D47
	 d60n/xChRVSMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EA33809A80;
	Tue, 19 Nov 2024 02:24:23 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 updates for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241118100623.2674026-1-catalin.marinas@arm.com>
References: <20241118100623.2674026-1-catalin.marinas@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241118100623.2674026-1-catalin.marinas@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream
X-PR-Tracked-Commit-Id: 83ef4a378e563d085ddd7214c2a393116b5f3435
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba1f9c8fe3d443a78814cdf8ac8f9829b5ca7095
Message-Id: <173198306214.73657.9794916659616465087.pr-tracker-bot@kernel.org>
Date: Tue, 19 Nov 2024 02:24:22 +0000
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 10:06:23 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba1f9c8fe3d443a78814cdf8ac8f9829b5ca7095

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

