Return-Path: <linux-kernel+bounces-253230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E0D931E64
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 03:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D761C2220A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 01:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0050BAD53;
	Tue, 16 Jul 2024 01:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8GnqxUz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F6417565
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 01:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721092654; cv=none; b=RQeKWVFHtsUwBCDwbm22yKFUECvn63Aq/rPCXjgHnGArc0SWwJvA6xF1z9zgO9yIDsY62bFhH0x+xFCMEZZfSrmUtZeAvWu3r3mryaTLlF4+EZZxeQ/A2cKHdMECVAvjg0u1o7a+q1waYIppYlW3DRDvXdOlHEidTjkIoCoRy+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721092654; c=relaxed/simple;
	bh=q5y381HbfdXHRBlPskUS7O8oaN/ESmDsxmRX/wBvi40=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=B8I0anf2NNSMG2ChTFVd324jiAFwxWzkAd7psVS/ybckmvBfVMRotJd6NiPppnB5eT2a8f2WUunmyW8DcTuiTQb8rb2cNPIvFfZdZoRUinLIxZQ+rKFGAYjo0hGJPI2lOYTqSq8ArTT4mZBEueHnpwQXIldLqR0BPz25jZgZC6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8GnqxUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19F42C4AF0E;
	Tue, 16 Jul 2024 01:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721092654;
	bh=q5y381HbfdXHRBlPskUS7O8oaN/ESmDsxmRX/wBvi40=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Q8GnqxUzXglp0ye/v7nNHALpYm/6qiB1UhDXQPrgAAMxrEpaGPYYLWEYr0pxYwCJq
	 h/WjywOPpLULHzuDYJnPxbhgpsW7S/zAx6maQjUInzuggY+HUXDKENdCumOCGNpH0/
	 GPtEAMFmlGLz9cSjkw1L+jBdE1hEwnPeXzwuVawGdV9N7CXSWV3lDyf3T6liM/B+bJ
	 hJ97Zy9znrEOvSrf0XYARMFilzkFNQ1U1AVhiH8KDh1ICFqO+Cd7R3GzJj50+87Iqa
	 F/ibeF6Nf1aJLIjNIyQ02Ig6Gt98YaX+OcofGZpI/iLPU27gyO2THt3RuraaH9eurf
	 Dn1iKPmQvo29w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B7D6C43443;
	Tue, 16 Jul 2024 01:17:34 +0000 (UTC)
Subject: Re: [GIT PULL] regulator updates for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <3ada1d9c3010145c1dcfd5c65f12a3fd.broonie@kernel.org>
References: <3ada1d9c3010145c1dcfd5c65f12a3fd.broonie@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3ada1d9c3010145c1dcfd5c65f12a3fd.broonie@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.11
X-PR-Tracked-Commit-Id: ef0b29e744965e8abc14260503a559366219035c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 584aeccc0b717f447505cc738d8c2f292d9d1a66
Message-Id: <172109265404.10916.12393540719848974564.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 01:17:34 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 15:14:59 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/584aeccc0b717f447505cc738d8c2f292d9d1a66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

