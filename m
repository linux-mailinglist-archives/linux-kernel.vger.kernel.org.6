Return-Path: <linux-kernel+bounces-178983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A248C5A09
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAEE11C21650
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7525D181337;
	Tue, 14 May 2024 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ziq/oUD3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF131802D0
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715706187; cv=none; b=WFLTeUqm5h8c2Ur51x1YBHrbx1GTCFtlVX4FQ5INfhMBZvlxXevXA50lurWYKhK6JwHj0t+bJL3Tc9YqA5Ju6p4JWni6FwUbiGAVrmooLLkWomvEYbNaN/d/OtiWbOQtsfIe1eyP61WQKvRomnRH3eqYEL+bmEfGFi5KHj8Scks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715706187; c=relaxed/simple;
	bh=zqgVphdBMzidRP48usgn3eto+65dNzzuVpYcSCltSCM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dGFkKMLiPE/HCsaPGg6oJLsP/8e58VMtFYZeTe7W5G3G+NPBd0hiDnlQpL65XmVMPW37BmnqjZDeWF51G0rZ4Pk/rvwO0ja8lwh0biSCr3h4jKTGJ7emLuJ4iAPRfRUjNjyp212FxMfV4T6NgphoF5OGSKNdCiNckPEGrJFODqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ziq/oUD3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7186C4AF08;
	Tue, 14 May 2024 17:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715706187;
	bh=zqgVphdBMzidRP48usgn3eto+65dNzzuVpYcSCltSCM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ziq/oUD3qVoiy5R4+mUzHivnKRm0AG5KTPpH295wgqRbAgjCzE/z5yfpr2HjYWAqC
	 DrmKo32N+aaym/AxaxUHOmMaFk9mMvWmxLYD21gOSwTSUH7PKNNJzarlrVYZqsDSZV
	 G6AAV4F0iDaAYdc/Mm2xK85/YmV5n38FJ4QX5UT00Wc7k2e4H5VwFtmrAnXSCd+hvm
	 5x8cTrlhfCZ9LXW7RiCc9s2IF0vuBFZNnGYjTUvjwDPCBogptfVgxvSj0xhA1w4tgG
	 PRdxEKwscCVcoWFzhNoKCcVKFhlvtcg59drqIJPzsElo7w9+qY3kAj2lS1skqfU5nY
	 pJkIKbyn/uCRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2F3DC43339;
	Tue, 14 May 2024 17:03:06 +0000 (UTC)
Subject: Re: [GIT PULL] x86/microcode for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240513192035.GAZkJoA5i9naOdgz7_@fat_crate.local>
References: <20240513192035.GAZkJoA5i9naOdgz7_@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240513192035.GAZkJoA5i9naOdgz7_@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_microcode_for_v6.10_rc1
X-PR-Tracked-Commit-Id: 57f6d0aed7b0a6829044c7f1cea57b1e3ddb9a47
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1907ccdfe4a35265f6572e4b8c2da6d1f0a663e
Message-Id: <171570618685.7410.11388053909708576922.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 17:03:06 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 21:20:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_microcode_for_v6.10_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1907ccdfe4a35265f6572e4b8c2da6d1f0a663e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

