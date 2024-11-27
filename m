Return-Path: <linux-kernel+bounces-423894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A48DE9DADF5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA1D282170
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D0B201259;
	Wed, 27 Nov 2024 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iD+alSBc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F027200BA4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732736266; cv=none; b=YyPjpyxPIyt+uEOdFjkLX3klud80jWJ+6tumriExfK8FtWdYldR/k7QWs5o8GR50SbFx8vTegFKmc9OXTryKXdC342KJbuRjepTbmMuk3dQBYK2E7B7CjrNHKpQ7jm4pybd1QBRQZevIjieDePRKmH7AqS6l9yQcqphz7TR+1XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732736266; c=relaxed/simple;
	bh=xOy4gHNO5JIJFgfga3dQs7yqxGP6WQS/t+SkkuLBS7c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tU+suSiMGWGyRdveDDknRVOTIfkDLNVqg6I1vNSrT/dQAp3MN/ywkVmUE8k866f5tM7G0W1IPNPzmJ7ZOQ5Be5zjHt5qw7vt+KWZrnP74nhb6ow0H+0UYAAOxEvDaTPZqMsr17MvYVDRWcn45iNO5ZNkVPCXkbHzpmR5sBJKknI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iD+alSBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25575C4CECC;
	Wed, 27 Nov 2024 19:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732736266;
	bh=xOy4gHNO5JIJFgfga3dQs7yqxGP6WQS/t+SkkuLBS7c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=iD+alSBcaxQ5qSC634aXXGlziELBaajTF2haTCcvnUA7iJPCmhgT3M85okY0E9/Mb
	 ygIBaNiM+ojUe3k0EKm72bQ5Yg2PvglVfHKvXeVoggJG4PZ5KMSHPHdG2VO1xIcP0q
	 9EPSu8xMzPoytWVwW/L5oLMKang48KOl+bxMyKNUpxCauHeqKCH4NMRxP5mOmLocep
	 hiKs1pM25GcSfPEq2DN08z4MLUeSVOBiRxa1fi4xXVIQH+wrdGjjojzttTGqwBkplC
	 BxszWiOVc1Pw3/86OT6aHWnFJ6asoJ3n7Yg/rzGWmeJ+w8MnoTGhnSIkgvUrT5txau
	 rm1QjAm0sNJ+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FA7380A944;
	Wed, 27 Nov 2024 19:38:00 +0000 (UTC)
Subject: Re: [GIT PULL] memblock updates for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z0bTBc6aoyOpuhU1@kernel.org>
References: <Z0bTBc6aoyOpuhU1@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z0bTBc6aoyOpuhU1@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v6.13-rc1
X-PR-Tracked-Commit-Id: 98b7beba1ee6fb4ee755812e6c06cfc9084e7430
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab952fc5c736c54e3ffd577c3ffd54a2a1eb7803
Message-Id: <173273627912.1191875.4832554107621692281.pr-tracker-bot@kernel.org>
Date: Wed, 27 Nov 2024 19:37:59 +0000
To: Mike Rapoport <rppt@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Hua Su <suhua.tanke@gmail.com>, Mike Rapoport <rppt@kernel.org>, Thorsten Blum <thorsten.blum@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 27 Nov 2024 10:06:29 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab952fc5c736c54e3ffd577c3ffd54a2a1eb7803

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

