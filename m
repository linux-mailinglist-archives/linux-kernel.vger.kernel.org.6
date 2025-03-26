Return-Path: <linux-kernel+bounces-576466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF7EA70FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 04:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A01E1883F80
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 03:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8551624DD;
	Wed, 26 Mar 2025 03:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtYrxoaP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FFD2E338B;
	Wed, 26 Mar 2025 03:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742961530; cv=none; b=KElVTV5jBtzSe4xAr3aqX+VXHL/ixEhpCnuKybeYY9C23gTBuwuU/Vj+8D/pWz8xXWPe89HtKOXLuwrqvNmCyvL9yCpyW4Anna7xwiaWDsOn8rSrY17ZtuSTkW/tp/Xye0Qceakv2DyjnUIxG7//6weG92x7OBGIy2nn1gLzhG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742961530; c=relaxed/simple;
	bh=euURHPx8+CVKjYbd83rY8AnJs/KTwk6/t53y8Btpz1c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=A5JHnIOGLEbjNvbVG36L2f8Bq2RM9hP8XPpxoHASUQN5Mof/eYHSQ5sXBXsLw6q6K6Hka2j4wEWfXPrmF3iiOYNbexxZXJOY5KYyV1hFZj8b1KkdY5nysKFQEeDA7fen42JjggrwToRbAu/pmDKcDOi28+okSqf2QhXw9g9Tyls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtYrxoaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F184C4CEE2;
	Wed, 26 Mar 2025 03:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742961530;
	bh=euURHPx8+CVKjYbd83rY8AnJs/KTwk6/t53y8Btpz1c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CtYrxoaPa68/Rn9Uz9n7ZzPmZ8p1acb6yd7IkRenK0SXaz5MHOr4bkxMucDT6roBc
	 T71ouHutNpVyqDX90xk59usHp0b/dZaMUEU6IxPIF0Eg5QGwOxF58L9QI1b4Z0MWVY
	 Nq42N5PlMvanoMzGw8UUwIkalifEfuf9Bg30N0T/NAoQkr8TDLGhkpq4fpRbrXkEfX
	 jNU+DB9BKbfXg3dLiwpXUYlwk1W1WasDzszLP9CjncTH7hofwlQdCoxG0mmsUQrAhg
	 PW9o2zyCq/UXfi+7lA4zG2+SKq+69seT5YrZor21KNVM9XqrxfFgxIwbaNbSjyi9fI
	 I65vC+gGEuLEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF95380DBFD;
	Wed, 26 Mar 2025 03:59:27 +0000 (UTC)
Subject: Re: [GIT PULL] chrome-platform updates for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z-H-ruKeKIiX0CEk@google.com>
References: <Z-H-ruKeKIiX0CEk@google.com>
X-PR-Tracked-List-Id: <chrome-platform.lists.linux.dev>
X-PR-Tracked-Message-Id: <Z-H-ruKeKIiX0CEk@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/chrome-platform-v6.15
X-PR-Tracked-Commit-Id: 9fc83373f0ffb8834da48b1446a5c2fef9525bb1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b23d8a07abed9fef3d1b15fe05f671bae511c853
Message-Id: <174296156619.837738.17418081546893200417.pr-tracker-bot@kernel.org>
Date: Wed, 26 Mar 2025 03:59:26 +0000
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: torvalds@linux-foundation.org, bleung@chromium.org, tzungbi@kernel.org, linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 25 Mar 2025 00:54:06 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/chrome-platform-v6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b23d8a07abed9fef3d1b15fe05f671bae511c853

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

