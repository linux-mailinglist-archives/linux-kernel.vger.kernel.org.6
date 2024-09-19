Return-Path: <linux-kernel+bounces-333140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CE497C472
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC731C2384C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD91118E054;
	Thu, 19 Sep 2024 06:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKdaTHyy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476A318EFF6
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 06:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726728498; cv=none; b=pBGki/hRH2hgt5KXuyCWik1sUfEpdJxdkvf44TLVgvkUB7t2yQ6pLUFZE0JETeulAGSDSb4ew7gjHCz4v9rMjIyfjQTn77j9VtvHLPXAlwZ47A4XnZ+2ruP2iLo9lpmasIy+6avbMqmjLRrzNbzEIe/kB3q7QHlxjC3iUeb87gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726728498; c=relaxed/simple;
	bh=qG9KokqnsOoSkRgt3TLzw35lk0ryg2+BH319dWedFcw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Efl5q61DkQk7LBC2nbUV5ynPnUWdbxxttTK+CFyIo4/SwONTNhK+tisAHfsS1tm67jxAXBddX8BAkZrpweiaeC+m19CPqPAM0RcgCtGeRglchQdSiSPaXFWaygYuW4TTnDCPtaKLVA2BA2GBefO5NK1CZ+8lHDrE0TGLXryy1s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lKdaTHyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C55C4CEC5;
	Thu, 19 Sep 2024 06:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726728498;
	bh=qG9KokqnsOoSkRgt3TLzw35lk0ryg2+BH319dWedFcw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=lKdaTHyyqw+3n+54/mJZv9Lxz05ACnbG2K08jcfBZ5QjW7p6GKfLnkcObXKjFbTZw
	 sbwd5cH4wuVZAzhBdNdY+Vc0Taws13lQtGw31xDMEfH+zLeH6u0fhjZRq+pL4vqAvM
	 WyEdWPTQWDhaHCZ9X+kLUJ3ZdXhT0qmnm1AGb8tLUZxBqoj9YaGyPdeyWVbcFQLYJZ
	 LtCIgAD4ePqVZoA1kKPrnckLmi5/403fq6nXqpD8PcmcDWhh+3LiAAMNg/BV1O8dZs
	 e+w660erXbvC4roRWP9GIFs2ov6L/MWobJgAMfvVHMfB3mJ4tTH5jXJsEDshsZyfus
	 wsAPfDp3bjXuQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F653809A80;
	Thu, 19 Sep 2024 06:48:21 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240919060641.14017-1-jgross@suse.com>
References: <20240919060641.14017-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240919060641.14017-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.12-rc1-tag
X-PR-Tracked-Commit-Id: c3dea3d54f4d399f8044547f0f1abdccbdfb0fee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 19a519ca87b59a0031e1295674b1af0d6da83f70
Message-Id: <172672849966.1360580.3806860916913196562.pr-tracker-bot@kernel.org>
Date: Thu, 19 Sep 2024 06:48:19 +0000
To: Juergen Gross <jgross@suse.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, sstabellini@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 19 Sep 2024 08:06:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.12-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/19a519ca87b59a0031e1295674b1af0d6da83f70

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

