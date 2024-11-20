Return-Path: <linux-kernel+bounces-416209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39A99D420D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 19:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABD311F22EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DC21C6F6D;
	Wed, 20 Nov 2024 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlXDcCnz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9FF1C5799
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 18:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732127520; cv=none; b=Nx5azUDCP4De8X7OMST0ZygAJvCPy7+5VlrL8m/nTKMhODhl08DZdurPxlut3dlQgs8RL7FMhPuDZMrmjbDLdx0wBSEqfxOPkeQZaTz0/QaogYztkiRP98wGNyr/T+/dvTjIpUnMwNI7EpyfxF7vHimlpAszmvno+bX9gNoQNCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732127520; c=relaxed/simple;
	bh=oySrsS2zs15wAldFJT8/7eC5Tt32/3jp/F7ASMUgMDE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FIHJYfZ8NfP3Peqx+srif8rbO5sDyCuBsdVLToyNzp6RmEPSMgFAqZFZtVuvGq17vzL3TJmhxT+xkmGupJJg1o3v+mBksj1Rsi4yEmVbGtJu+P5YVv6tcMAaRfyqjzY3i7+myE5n9ehmammctM1uWnD4iCezDrdCp562RtwmYdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlXDcCnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4481C4CED0;
	Wed, 20 Nov 2024 18:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732127520;
	bh=oySrsS2zs15wAldFJT8/7eC5Tt32/3jp/F7ASMUgMDE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WlXDcCnzKntYpNYtTyZVAWJsp1LqK50HyLE6qek24Beytmt7bNSyg2sEnuKtUX+33
	 CsC+GLjiyvYNFo5CX8XXL4SnzYLA7K7plNFc8E6RX9H3gQF2v14EXHHnzXsTkTX0U7
	 z3kLH790dHSgLLxuIPt1rnlwgkSwIHK+ikdgyyE8G0A0IuUGxBP95FL6hYT5M+immD
	 Ewkfu4mOWU8BOcUPXA7DblhKsP9cm0lhJmtmIHGMl/SYFw4lWs1g9M+LTIjeCz2MB4
	 GmvLAKhwkMH+/3S1X6cOpAJX5RipVUxZgLAhQPBL6takwFJtQ1Q6Yl7YupOTL5AEIR
	 0UxdN59+xmIzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0083809A80;
	Wed, 20 Nov 2024 18:32:13 +0000 (UTC)
Subject: Re: [GIT PULL] sched_ext: Changes for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZztvH1-v1W4eDGDU@slm.duckdns.org>
References: <ZztvH1-v1W4eDGDU@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZztvH1-v1W4eDGDU@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.13
X-PR-Tracked-Commit-Id: 6b8950ef993bcf198d4a80cde0b2da805b75ed70
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8f7c8b88bda4988f44e595a760438febf51c92c8
Message-Id: <173212753222.1310468.5650452126202507699.pr-tracker-bot@kernel.org>
Date: Wed, 20 Nov 2024 18:32:12 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Nov 2024 06:45:19 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git/ tags/sched_ext-for-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8f7c8b88bda4988f44e595a760438febf51c92c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

