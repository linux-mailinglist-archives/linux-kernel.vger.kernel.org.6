Return-Path: <linux-kernel+bounces-178984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2A48C5A0A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708551F228C5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A731181339;
	Tue, 14 May 2024 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZSLEhoj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF43180A61
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715706187; cv=none; b=evTNUm4Cn8tv0UOMG3VpBDpf8rWUPtlKkDQQpNs0yrkCjkpeugImOgG420ri+ho+7I8B/kBDYKQ8piCeP5TcojAOk9G4mtg4e/02HFTllwCP6CkrIE8WTyy75sbC5FY0kCuoDr9EOBHtMx77ZvhuYnm6WmlKfNmMrNkw276I00w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715706187; c=relaxed/simple;
	bh=ErHpqK7us8CjYZwwGv+npPAXosQF/16hrPfLmcnziHk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=HS1ZGl3Ti9At5EdZZedbTDxSxkVh4L4KMY4Od+29Hjq0YLEIWm4hzJCJMqaBm4dMnLxDfHynkJk2PvNjkW4jjP8WJ6HWiIwlpw3HJFEnoHgwwfynoelhI59wRbHmR59QURs0EEzG/c8kRO4EDzoTlxT86JxuUrT5X7PVstBsCnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZSLEhoj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CCF1C32782;
	Tue, 14 May 2024 17:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715706187;
	bh=ErHpqK7us8CjYZwwGv+npPAXosQF/16hrPfLmcnziHk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cZSLEhojJ09zwRZDiqzQ6HKjO3JqqzaiAM50h1RL1YjhZzuvl2ZvGFihE1v/JEUo/
	 yj2I6V/k4t6bCOGrL/BDN/RNGPXmUKJ4qHqVLHFhQ0Nx/8t0rEKOyAwBxlQpEUaJ1u
	 vl1PtlqDiNuh2oRpp/tkMbskDQ83yAlhTeMaplRzgJxwkkIuIEDisaivpYg3s4bVGp
	 aAfbOtJExmMOdf4SPFYL0k4yak06vqdOY1a5CyipYO5ZzLwsvUKOVCSnaH1RKbbZ9j
	 lIixaPl0psIv0i99EfQtIhn9zFTEr31OmDEP+oVrHxeGNRColTQGq7ClJefXwuUNAi
	 fJ1XNbQkcSVTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E0CEC1614E;
	Tue, 14 May 2024 17:03:07 +0000 (UTC)
Subject: Re: [GIT PULL] x86/apic for 6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240513194720.456299-1-dave.hansen@linux.intel.com>
References: <20240513194720.456299-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240513194720.456299-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_apic_for_6.10
X-PR-Tracked-Commit-Id: 0049f04c7dfe977a0f8f6935071db3416e641837
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 61deafa9ecf3f6d00c570774b0b38f439be543ac
Message-Id: <171570618724.7410.14167817563828079922.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 17:03:07 +0000
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: torvalds@linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 12:47:20 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_apic_for_6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/61deafa9ecf3f6d00c570774b0b38f439be543ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

