Return-Path: <linux-kernel+bounces-253242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC19931E7F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 104352832B6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CE163A9;
	Tue, 16 Jul 2024 01:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biN8N6qg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F5A1876
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 01:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721093124; cv=none; b=eY8Ywg3EtXG+MMn7t2CYeuYpeNEn882M4s/Ea9MRt9w1DfyIho1elJHQDSr++0rgTDta1+tQrqACi7jF7NeGBF6AvCnSZ8rRUHSzdhfSlUmZthCgkScPcwZtq+BE/V5fnQW/W6FSjtmCeH3sfhXyhAzkh+3l6+ixAdYiiJy3Csc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721093124; c=relaxed/simple;
	bh=TRhJkFtrhdTEBXZh0Yjo7Ecz74xCi5IQUMT+HbjjwMI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ukggHusagYkavf5UPboS/SW7d40HDlerdUBLGcezqarH4xSbagmFM/r23h1rZHCe/jqgQlOa8X1kapS/fMr15EVF9cnCBvJmpvr4RN/2qlaP+6AkD4kXAEpbD2+i77APtEkmwrz6uU8meTUHpVyd0wn+JcbsF/KPumwWiqDGtrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biN8N6qg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DCB7C32782;
	Tue, 16 Jul 2024 01:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721093124;
	bh=TRhJkFtrhdTEBXZh0Yjo7Ecz74xCi5IQUMT+HbjjwMI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=biN8N6qgp2k8ejdCKnT4uZBO8iyKpMVhN93pgC992xCVgnvXYzg49F1EILNuJecSA
	 4EQrmRFAXwe0qHQlNGG2STc1WEUmqSzgds+EUv6pkL7tHtiL4k4ioqcmQQ/qmo+2RU
	 gb1+eFfOuZOWO9dqhd8yc1v2AQJXXf/Lh777+0UVe/kpAZIcss8Fc+bXwo9gefueQi
	 OApLxNy64y7wp6XSAd9GZGip9NOhTjKLbKtGdnyVqkiHROUR3YPUXeYNO1k3YjvSbF
	 V7OhLEh3rSOzB1cNLP8fPaQdc/Xyy9vjVFwHegcGR6BFf6/kdXvjPqNO9GeANW676D
	 o7Whr7a3TS6/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43AAAC433E9;
	Tue, 16 Jul 2024 01:25:24 +0000 (UTC)
Subject: Re: [GIT PULL] RAS updates for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240715104621.GAZpT9_YnUJpJAtq00@fat_crate.local>
References: <20240715104621.GAZpT9_YnUJpJAtq00@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240715104621.GAZpT9_YnUJpJAtq00@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip ras_core_for_v6.11_rc1
X-PR-Tracked-Commit-Id: 5b9d292ea87c836ec47483f98344cb0e7add82fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1467b49869df43c4ee51bdaa0ec1cb69e333407d
Message-Id: <172109312427.16804.7366664880192173974.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 01:25:24 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 12:46:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip ras_core_for_v6.11_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1467b49869df43c4ee51bdaa0ec1cb69e333407d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

