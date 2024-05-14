Return-Path: <linux-kernel+bounces-178981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6768C5A07
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2847E1C215F9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AA11802D7;
	Tue, 14 May 2024 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAT/HXFU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C461802A3
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715706186; cv=none; b=GDNPKrvteyz5yXVKXPtB+3/z62Y8vObawJhZXJb2RUuE85rpFfS6ioVY6z3d1oMk2VqFYZvi2R+Yg+bOr5JGlkoxMEv0UXkHJKXGV/8SMfvkJOU0NckseY7wg8SjPsnXtqVTmJUh3IlU8OEA49SIWYdjLGYbKr5BhKwJq7ndBDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715706186; c=relaxed/simple;
	bh=4hC6Iwx5tRfH76nEQTKFqACWRj9xwEhYMl/vSKI6Njc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=i9SFcEJHUa01BrxIZDhslBrJfDC84Ptuw3D3ga3LoMWdhlPz3bjkdLQsiFAYZsDf0jVs4nuNEz12KphU01or9+2sTW6gzrT+y9BjBrCs7+B8f28NK2Zs9D3rd2XFlUxwD+FHyOlbITErUM/FVLk+KsVNiMI4jBi2OmnbXGU7fC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAT/HXFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54B32C4AF0D;
	Tue, 14 May 2024 17:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715706186;
	bh=4hC6Iwx5tRfH76nEQTKFqACWRj9xwEhYMl/vSKI6Njc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UAT/HXFUeE3cqSvbMv33OJBvcfs0wtQIXIwdAudp2Wn1zNOoXZi26kIJSQuGea/lO
	 MBJ3z0JRB1+/bwv5IrG/4b8LjvKWbaATYK/3QyOZ/j1y6la5dkCf1F1KmyHmH2lzDp
	 ufUNHjyi6XAgT2uh4RDNUvdCFByJsXvfk9e9ejGHYfeIRSV7Yg6mK/yPnPCH139B19
	 j+H1uKeYWPrgK3kTJyFhH3t1dyyMBSKlLIS5nEeacF36fjljvjUc+wk9dVM70/acuB
	 6434VaVFoRp72wA8hqncqtCtemDolb1I+MxDKz+KQfP95R3OKRYYk41bGyhLxqrGb/
	 ov098x4YWdtxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4AB3DC43339;
	Tue, 14 May 2024 17:03:06 +0000 (UTC)
Subject: Re: [GIT PULL] x86/alternatives for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240513174042.GAZkJQmuIGCVEfYCrg@fat_crate.local>
References: <20240513174042.GAZkJQmuIGCVEfYCrg@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240513174042.GAZkJQmuIGCVEfYCrg@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_alternatives_for_v6.10_rc1
X-PR-Tracked-Commit-Id: 8dc8b02d707ee4167fffaf3a97003bcdac282876
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 25c7cb05fa61078d99d56fda36bd6d0a1638139d
Message-Id: <171570618629.7410.15081723005577751900.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 17:03:06 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 19:40:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_alternatives_for_v6.10_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/25c7cb05fa61078d99d56fda36bd6d0a1638139d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

