Return-Path: <linux-kernel+bounces-332443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D4597B9B3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 445141C23BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4188C176FDB;
	Wed, 18 Sep 2024 08:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqjltCup"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CF81534E9
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726649851; cv=none; b=UMw9QnhmBeGwPg7s5C2NOJGzwudMOj2/kDdCjEQ6sWNCh2fQbfDlXjsW5VMu3fCwzIUFIiLhKRDT5Rd+Mmbog6yc1uljKhvLOnpyo+3h/8FTjhF5P6WR9VojRx9MwXXWyBI4DQBMC6UiBNYty1kIUC+NSV+8MgljZSLPw+NyHgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726649851; c=relaxed/simple;
	bh=pwtaSA6zXlbHbd4oCLlu4g4rv/ezyjrMIfI1sO8lHJI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uAkVf3qKjD2EKOHrlgbBkAYB+suwNSG5wcjQ06ad6WxA9ovrVXNQa+90p7Y5ox9RTzVhzMDnIou4l7jAqpRE7QWixuY7t3Gj+bDU5HOGSTenSnAQ9nvZHNwg+MR6cxfTj+IeMYzIlNl8U+NiN8l+DTwSXCMTbf5nAjuATcrK7oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqjltCup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778FDC4CEC3;
	Wed, 18 Sep 2024 08:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726649851;
	bh=pwtaSA6zXlbHbd4oCLlu4g4rv/ezyjrMIfI1sO8lHJI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JqjltCupoODY1mXycvsz0UCN93nLFBSLkZTnaVT7eW7dLiz8QWdB4PE9TPd7V6Zh2
	 6eUQR8nki3VUgMYC8/ttu1Dv2gZ6vchF6zLTAH/G7OTee1Vzu+lGhXIAJgrzNxldxz
	 Lw4LKPaHen1r+R0JDyKUWIQv8sRZlXX4O6PuYQfjTy5fnEGb/9vm6i5TODKdNv1Gou
	 RWmrTjFf6kaJwrbgWsyriKNmGlQhGvdUHt3SWn0eHODOPKiVZ5RkoLaRNSf++JLqcs
	 j0DbrSERU327pvwVYx93/jW60OYLCyOd50yddFjhU5mejRqXbKRSomhEoJMvWiUAcF
	 CoiCtlDDeHbiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E943806655;
	Wed, 18 Sep 2024 08:57:34 +0000 (UTC)
Subject: Re: [GIT PULL] mtd: Changes for 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240915125344.5a449216@xps-13>
References: <20240915125344.5a449216@xps-13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240915125344.5a449216@xps-13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-6.12
X-PR-Tracked-Commit-Id: 869acb874f2b61c34063b677c2bd29595bf446a1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2471d2b3b2b88802a66e9ff97b32387e1e233470
Message-Id: <172664985295.725883.835476543813600932.pr-tracker-bot@kernel.org>
Date: Wed, 18 Sep 2024 08:57:32 +0000
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>, Tudor Ambarus <Tudor.Ambarus@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>, Michael Walle <michael@walle.cc>, Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 15 Sep 2024 12:53:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2471d2b3b2b88802a66e9ff97b32387e1e233470

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

