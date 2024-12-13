Return-Path: <linux-kernel+bounces-445657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ADE9F1928
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 23:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785EE188750C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4FC193436;
	Fri, 13 Dec 2024 22:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwq2bq5U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8F515573A
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 22:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734129275; cv=none; b=ELjHWa9VU3Qn1E5OlY0JvLER70kELQau6TeppfmqSiVDj6JpEWovwd+gz3qHCsXt/9upg1ziK2+LublY330fsVs760zEFgMfAyV6u0mLS1XCD3SPj0XEd2HmDrLJxBZuhlUqtmO8R8m3n5iJjyDJ+aDIIOm3gP84asJLdT5NsR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734129275; c=relaxed/simple;
	bh=4R1yhE9pAWNS67ycWv8EN0gZQwo2wTlHZFpGXsFka5g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=C3a42wKUl36wM5JED+PI160/ZkEiO6Bb7eJ51AZKysO39XW1+GxF3ge3UruACi3/xoxaeGnVKWNz+CpeB3Msahf7iKJN/HvKKGTSt4uilXBOk8YH4zlCV8yGneFgHlt6hF2KESrE6Yt1r99owqnFF2U16B/lDfVLJ61fqfWZVVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwq2bq5U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04900C4CED0;
	Fri, 13 Dec 2024 22:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734129275;
	bh=4R1yhE9pAWNS67ycWv8EN0gZQwo2wTlHZFpGXsFka5g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qwq2bq5U0lpZQy4fN3+HOnuf4mJXisILGw4y8TMyShwhH6pcix7cDqwmw2prP+fnm
	 j0ymYMQDzIXRg5Q/C9Z2kXXWyp8Mm8OtQLD7KvL2VFpDq4b8fFeQ0W8gewYeZKkJqk
	 aag/QMQQxn3n/VGFr94yFYnRRWzQDi3nUu3PNGsF1TCyoSBXEZ+sDD9/trfGIXTTmR
	 DkiEdTYcqBFOfpWB+Wb/ea3W8Hqp9GjE+Q4UwGJE0gUsqpVVOxc9/un0ZyOtJ+tZey
	 Rz6kD27IeMccqP2zytg+BikySdeJoSlX2hQrRz1ZdAcY0Ezx8jP+HpT0XLcPTcOmZr
	 uT9SgHa9tj5xw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE55C380A959;
	Fri, 13 Dec 2024 22:34:52 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 6.13-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z1xx0ha7lbKkdhRC@arm.com>
References: <Z1xx0ha7lbKkdhRC@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <Z1xx0ha7lbKkdhRC@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: ce03573a1917532da06057da9f8e74a2ee9e2ac9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01af50af760b5b796794282d997a3610f74039da
Message-Id: <173412929121.3178864.3766212521863822880.pr-tracker-bot@kernel.org>
Date: Fri, 13 Dec 2024 22:34:51 +0000
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Dec 2024 17:41:38 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01af50af760b5b796794282d997a3610f74039da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

