Return-Path: <linux-kernel+bounces-330162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7F9979A81
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 06:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54541F235E3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 04:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3858D1CF93;
	Mon, 16 Sep 2024 04:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMcfAeD8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F26131BDD
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 04:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726462519; cv=none; b=An6ojy56JoZfaLwNnPMcA71OyeVhTQoAUbKBeP66Q0tn/bowdPfkJaq54gPBVnhjNNPtx1btcssbvt2MXLyjINCTIHrU5VgdyRTseUDI3JVm8w+Okm+L8Hl2Qi+hkcbuaXB+Dv2RbzfMIE3yyqRdKBfdRncJ5/CAMToR/vF/JoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726462519; c=relaxed/simple;
	bh=Ogts7Eomz6vhMWboSzIhS+R8XY4F5pOPwwrBnsjYGxU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ucdiSwc5g4Ri6ib6pWwEYnDYs9fFLx6WY+Ys63+rvI+44VqDe86XN3omJ8eZkNt8QtThwSBQEnqiORH+EvLQfcl+VtVsPBkdu6XBrg7dL1gzgkW/ou7+1AFlFwthPL7av661Trepn2LXt7zC3BAics+/Ur8bnyvenXOzWYVmX+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMcfAeD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A80C4CEC4;
	Mon, 16 Sep 2024 04:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726462518;
	bh=Ogts7Eomz6vhMWboSzIhS+R8XY4F5pOPwwrBnsjYGxU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lMcfAeD8WgiLMHbStAgRwUt22E636YzELZEQ0sElpIIDj4z8SsOArTN8yUm9mMAQj
	 oKDy5+UgULvVWCnfmlhrkbBlkSw/fJP5koASJRw3kWW05+476kLYIFXmqJg+HD0g16
	 dkg8po6NAenav5VH0PpzMlBawiMEt7mkDO+5qw8hIHp5U/rNHtnio5TdUnfheEU124
	 E9ANM4Quw9E5+lmun277VNh6Ycap8bs/2CqioFy39ybRmZpYsrFwNCxUbuVOF4azm8
	 thof4t1gUu4DcbQQ4Weu6+knT5KxIR9FJWgXBkt7Y7dUQPsU2o5vUr+3rkalZPCV2H
	 qtZFMtH2tpUZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCBA3809A80;
	Mon, 16 Sep 2024 04:55:21 +0000 (UTC)
Subject: Re: [GIT PULL] x86/sgx for 6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240911220228.4051834-1-dave.hansen@linux.intel.com>
References: <20240911220228.4051834-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240911220228.4051834-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_6.12-rc1
X-PR-Tracked-Commit-Id: c8ddc99eeba5f00b65efeae920eec3990bfc34ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4ebad655b98c91c10cf0690e66c11b0891c76ee
Message-Id: <172646252038.3235832.424475464159699804.pr-tracker-bot@kernel.org>
Date: Mon, 16 Sep 2024 04:55:20 +0000
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: torvalds@linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 11 Sep 2024 15:02:28 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4ebad655b98c91c10cf0690e66c11b0891c76ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

