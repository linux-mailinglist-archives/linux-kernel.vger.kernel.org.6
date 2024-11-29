Return-Path: <linux-kernel+bounces-417488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8C79D54A7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97632B23E46
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231BF1DDA34;
	Thu, 21 Nov 2024 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/KlMoet"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2641DB527;
	Thu, 21 Nov 2024 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732224032; cv=none; b=VwcTgDj8J7QCwuteCvx8Q8axYX61VCuaiWZe4/6gs4WfdHyf/y2BkC+xC8UrjLbzq8jzYhpKJjMuTEgriJzcniL24muhVYY0rDFZRGd95bLy5xxQxACDYfbyDl8v55/GaHyWJNrNIkoPLSYEiIiTwzzWJrJ5mV8MTEjmokSzttg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732224032; c=relaxed/simple;
	bh=IxpblIWqpZu0HbLvgLE974vg5LATqEGl+Zie56CjbZY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bi2p/S5965L9CHvPbjW0ixJ8MTgav8+Agr022agtW0ESUrPgEibpOC1vnzvn0TxRi2/rNNTHUVZUHdHdmnlqcJepoZozezpWYu3hH4qfvkcsgXwr/9lInKHrmOqnBH2FyElITSnuAEz9Hb+EL1BJS6ZfUBT5+SzlnD5iMy4Dc94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/KlMoet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C881C4CECD;
	Thu, 21 Nov 2024 21:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732224032;
	bh=IxpblIWqpZu0HbLvgLE974vg5LATqEGl+Zie56CjbZY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=s/KlMoetYJnMJv75UPtPWSwZuDphRNn70VS5B/Tm9n0Fo4+/sx3iahCp8t51VI5rk
	 TZ6p02lSbOHgk+FeoD38oJEImmzLxNSN4ZLPoXC2DQIG6Z9FZm7nUFoLo51cqReTEL
	 bk9B8ZEuEjsmU4Y1xdbJpGxn93t5BjGKj8qJ5HTfFi3pUDgfMbSLAM7VxL1VCW22eM
	 0aS4F+IjOLgQX2OaqJlugaHxOzvRbc+IGT7wfOVMBe/xtdrJwwrtHC5e5i+srQv737
	 OUO0Mn/gWzcmvuOqXyMBN5NOXtgMW8vZedq16h3hER/B3Ql5Ej7ePDLhnTI7odLbWu
	 iimSCHesVbTYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EE63809A00;
	Thu, 21 Nov 2024 21:20:45 +0000 (UTC)
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZzzFkZHDxrgq2B9i@infradead.org>
References: <ZzzFkZHDxrgq2B9i@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZzzFkZHDxrgq2B9i@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.13-2024-11-19
X-PR-Tracked-Commit-Id: 22293c33738c14bb84b9d3e771bc37150e7cf8e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51ae62a12c242e49229db23b96d03ecc15efc0d1
Message-Id: <173222404422.2113184.4949658627908161059.pr-tracker-bot@kernel.org>
Date: Thu, 21 Nov 2024 21:20:44 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Nov 2024 18:06:25 +0100:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.13-2024-11-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51ae62a12c242e49229db23b96d03ecc15efc0d1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

