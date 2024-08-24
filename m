Return-Path: <linux-kernel+bounces-299836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2172695DAA4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 04:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D061F22976
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 02:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D5018641;
	Sat, 24 Aug 2024 02:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKljsoRV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96127F4ED
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 02:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724466405; cv=none; b=YIptvcB3F2KortiFi+xqd1jfz1epC4/ramwUuswFRFr5MiqkhIaiMzd6nyJ33a7VhzmHSWm9beG1CGQXOqAfwG2ftGxZg7j5eP5I5xBnh5SNOsh7iN17ILAdpsL5SQ4IDfGDy61bESYB9gO9sc8sqUXfEuswuWvcmIAKYjlhrho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724466405; c=relaxed/simple;
	bh=+VXRdEbViTyZ1upxvFOeSJ9EfTDBjmiKLgR4KvAkS6A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TkHqQ8FbUT/RX1IjIE0LyeR9ow5YpFStdf7vltnlvisQMvGGsS0KHUXiVeshuUBuyWg9lyexOS57idlGwRctxP1puR5VeG92iqFdwgkgvMMasW2f1z66G15T8eXBEQn+uf31K8M3fzLV+cI94aKZFCVRjh1coEAtkIeE7cWU+Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKljsoRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B20C32786;
	Sat, 24 Aug 2024 02:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724466405;
	bh=+VXRdEbViTyZ1upxvFOeSJ9EfTDBjmiKLgR4KvAkS6A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hKljsoRVECInW5cxDaJu1laxJcQxWhEB3GXYdsON4IJ+hYTvLPFQSXbi0hr1UIAC/
	 vfobW8wOzPGIYnWgldto2SO9jLrD853t8nyKkFjbKbmil14QMf6zvsxZkXofN3uOh2
	 a2r5kkaVtgN4MnDslY0ecCU17/BMOiLtDEesCuine/G9nVQ/kEBtFuifsQjRWyv/AU
	 lXxOj72VxYSj9N4I7nA0FlEuEleOldARmtt59z5APLbmYW0XTg3E9K9zWKHkT6Azv0
	 kGDB7+tAfy1FkyjaO9t9pGRQc5/hoiX6Qvjd/rhAOBnswjeWGW7zBn61WBVPB75FEY
	 SwyNgTn1zULQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 30E4039EF647;
	Sat, 24 Aug 2024 02:26:46 +0000 (UTC)
Subject: Re: [GIT PULL] arm64/KVM fixes for 6.11-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZsjE6BXzDznbg6R-@arm.com>
References: <ZsjE6BXzDznbg6R-@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <ZsjE6BXzDznbg6R-@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 75c8f387dd16066a90c0928d00851edad0c8c519
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a8a8dcbd679e223cfdfec304d55287e07e4d0054
Message-Id: <172446640475.3135457.1450503625564706659.pr-tracker-bot@kernel.org>
Date: Sat, 24 Aug 2024 02:26:44 +0000
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 Aug 2024 18:20:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a8a8dcbd679e223cfdfec304d55287e07e4d0054

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

