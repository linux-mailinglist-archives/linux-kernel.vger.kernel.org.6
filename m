Return-Path: <linux-kernel+bounces-253210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992D7931E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13A7DB2226E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 00:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E267CF519;
	Tue, 16 Jul 2024 00:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3dIYqpe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C92EAD8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 00:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721091127; cv=none; b=AgYhEoxGNJEHB7S/9iuO9hzisoxgrFSDLuCJuLGSk96lx/VThR1Xe2Qt4OZCJWAFvF7Xl6a3rcjsWoausZiB9qfHyix6RjxeRi5HjqE/sMQyCZWQpuleG2YMB0H9TUuyWqKzzTAH2Zn8HGyciUSKCZDWNhvRBImXxZ3J7fPSmfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721091127; c=relaxed/simple;
	bh=WffmgfC5jVJEtCRzC/L3qEukZw10jGyLY+gfCtHjAXg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FJJB1mH1y3WH+w5Yy4cfKzLAeuaaGPA+70iHAIsc1Vy4J4wSLPAG0Y+Bln3GZQuzM1ozc0Ue0ZXUDI/acskuGu8dlO9/+3nhQYYaEBMiZACSleIdtEcxXM7UPOkWbvIol60DLiSyRhyRl+YoGBWXnvweyV741xBoSCbJwtxBUsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3dIYqpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7C78C32782;
	Tue, 16 Jul 2024 00:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721091126;
	bh=WffmgfC5jVJEtCRzC/L3qEukZw10jGyLY+gfCtHjAXg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=J3dIYqpe8jhDaVPZtAG/uVR5Z1gFvweCrkt2yg66EIoAOZAPkdkDkufPaKAqzYP1/
	 onpvh9VhaJXuCJHS8J5og2/lMmSBF3eEvL41eXUAJLghd8Sbo/Z7RR5l+3E7N+57xU
	 zzUCYi+ml03zph6oy02H6or/JgJI76nAFgPh9hkdXZMQAmNPo1MDzCOJzqQOLa5uUZ
	 sq2dnbadEAOyJBT+Sy6p9gx7rmVJpsftHWI84Pq4aB3EXlwjCafjqg8QHBA2MsDEl/
	 6fqn0tJRIs9+/edamAUNWbMzohnhLMD/Lg8L9vMIUaNY7bLIYazhc6P1c3b3aOunuJ
	 K1UeYqqfNUy9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD49FC43443;
	Tue, 16 Jul 2024 00:52:06 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 updates for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240711190353.3248426-1-catalin.marinas@arm.com>
References: <20240711190353.3248426-1-catalin.marinas@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20240711190353.3248426-1-catalin.marinas@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream
X-PR-Tracked-Commit-Id: 4f3a6c4de7d932be94cde2c52ae58feeec9c9dbf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c89d780cc195a63dcd9c3d2fc239308b3920a9a1
Message-Id: <172109112670.26590.1733604788025058828.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 00:52:06 +0000
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 11 Jul 2024 20:03:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c89d780cc195a63dcd9c3d2fc239308b3920a9a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

