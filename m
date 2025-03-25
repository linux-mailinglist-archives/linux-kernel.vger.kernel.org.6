Return-Path: <linux-kernel+bounces-576170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A10FDA70BFC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5CBF3BD9F8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E642B1A38F9;
	Tue, 25 Mar 2025 21:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTElVlNE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5563226980C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 21:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742937477; cv=none; b=rweUwejwp0wQugn8HCdjxX3AVQvFkMFNENwKbVsIfoIBhD6V+DDJJDLiEOLDRfJKEuQ23JeqW9ZO4c0POOqBXWdSnMdcNhtwbTD38GunGLXjqCi/YxhRmA9zd/Q59pHfAvRZKSbVEv6twbx0KwcfyrdyUjfEj1qRErKnmQA+cGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742937477; c=relaxed/simple;
	bh=P61/YxyKUkdLSTpLgnfE2Scl4VbNYpjN1yyRuXN24B8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LkEqV/ODMInU3Z54aX7ZphyF1ZmeDbq6dzaTtM7DYr60CBoXQdBPTME8Uy9YlLU7kCAkeG6bnSZRUlH060jP+OXRtH0eitJwQjq3zFaGjXIFRBDcOnzIqff4WBs6Orj2iv4wxBL61w8phzEinxsZpI0b4nund/gFPXeyVOGbTv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTElVlNE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BF8C4CEE4;
	Tue, 25 Mar 2025 21:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742937477;
	bh=P61/YxyKUkdLSTpLgnfE2Scl4VbNYpjN1yyRuXN24B8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NTElVlNElXtIOBOObucjunXPEykkvk6ESOOUJaHaO/oESax6XoCGkRE6WiR+njCdi
	 yNkHSu7DYcEtWYDTjdHeV1iLOsUGRuvWzj3ee8sdjb/HUY8lTqek2RYhxAORmLe6Ua
	 hkMruMLCtuWOlFW4y1lH3nd5pfLC3CAiiHMVBe9DzrFc1vM8hqvUHyTSp9v3sB93ph
	 pP8CdwJACs9lat2ZT64pNhxa1Ij6UCi0F3bNKdtja0ImNLoocglXi6nifOPxlualIN
	 AAT9KQ4O4E2VcqFvJXXvSJckmn1H0iTO708ucl+9yl6caALPqenpNxku4CVHCwvsCj
	 y9dtPt7ZdEFow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC6A380DBFC;
	Tue, 25 Mar 2025 21:18:34 +0000 (UTC)
Subject: Re: [GIT PULL] x86/bugs for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250325161653.GAZ-LW9WpsQrJgWx16@fat_crate.local>
References: <20250325161653.GAZ-LW9WpsQrJgWx16@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250325161653.GAZ-LW9WpsQrJgWx16@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_bugs_for_v6.15
X-PR-Tracked-Commit-Id: 98fdaeb296f51ef08e727a7cc72e5b5c864c4f4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 906174776c0eb539e4d65c54a8019d954a6fb35d
Message-Id: <174293751337.732113.3779811583529416475.pr-tracker-bot@kernel.org>
Date: Tue, 25 Mar 2025 21:18:33 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 25 Mar 2025 17:16:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_bugs_for_v6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/906174776c0eb539e4d65c54a8019d954a6fb35d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

