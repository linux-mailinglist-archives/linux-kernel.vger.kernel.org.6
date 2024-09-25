Return-Path: <linux-kernel+bounces-339514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D90986636
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 20:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34461C23618
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7EA12F5B1;
	Wed, 25 Sep 2024 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvEWHW4k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4251D5ACD
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 18:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727288617; cv=none; b=rbZCOVHT5d4ivJIIVdYgNtH9UWizWQCND1o/etlfmoYCMi8ZJFYIemroTHkL183e4JhltUsZyG6ubyWYB1Y6RqhQrye1mwz4++HrQsMjXF2bgzELY4Gxx36MGxLd0D8H3Pkl3OKzSVJl8XygDd7Be1k1RSUeqZQP690R20ZypWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727288617; c=relaxed/simple;
	bh=4yC3BGD2UG7DeOQV7XaJ2jf2pgDJZgO+NZf9LaD78GU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RRUa4Ra8NHEU9W148Rz3Gi2SEOnrRCI9guxhhg1aC5k5+eifzYhDWrHsW3syIZi+wSQQiHnqnLHzJgXJieTvQh4pmgjsbUz16CaI/b3cxFXV9uf1hA/C9yH/CaUe/kgWrzcldPduLTswGX7lY4G4PtXPNpUq7U4/890mtgLi/30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvEWHW4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1D3C4CEC3;
	Wed, 25 Sep 2024 18:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727288617;
	bh=4yC3BGD2UG7DeOQV7XaJ2jf2pgDJZgO+NZf9LaD78GU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IvEWHW4kQahvID7vQ0Ka6Jq4ts7DG/dtSbPsDoCs6qjkbA9tLjXRfnqracsttz98m
	 o4cmTer6s8/6lnWK1jG6qN6mYfJLXCo2sWv5H2YfnENOQv8jh/Fd2EssE9slF0UpIf
	 nwNutaDMAJtnGTnAnMhZmnD6Xn3+R/kbky/SvlPXn+4lWyZ482pGfnhd6/PVezMelW
	 wO3Dc0Ge5AZFhqgjm/medKRCfGf6qocc1T/QBLtU601W6rnPm7ge7lhmCBzF+bw+Ec
	 JCRungXdWHW9kEN5c1cpHJPfsKKVYqUrnW39PbY8ri56MqkROLHfpT7yERLN1O3/Ea
	 gQluUq62BOl1A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341473809A8F;
	Wed, 25 Sep 2024 18:23:41 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.12-2 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87y13g10wf.fsf@mail.lhotse>
References: <87y13g10wf.fsf@mail.lhotse>
X-PR-Tracked-List-Id: <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87y13g10wf.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.12-2
X-PR-Tracked-Commit-Id: 3af2e2f68cc6baf0a11f662d30b0bf981f77bfea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ffc45808373e32112500756d6f02fe56c42f371
Message-Id: <172728861970.682824.16261305010107069086.pr-tracker-bot@kernel.org>
Date: Wed, 25 Sep 2024 18:23:39 +0000
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, nnmlinux@linux.ibm.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 25 Sep 2024 20:30:08 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.12-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ffc45808373e32112500756d6f02fe56c42f371

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

