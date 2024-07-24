Return-Path: <linux-kernel+bounces-261489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9668A93B7EC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33E97B231C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA74E16D9B7;
	Wed, 24 Jul 2024 20:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBb9sfY+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CA216B72D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721852329; cv=none; b=n0Y84CtkjnhKIla1OgssgnyguloGCSYCo0hPxl6MemImKzrnVC2Jo5IrL13mqlQnj/5hOwcAujQ8swqZl8BZ0LM+/VV8s7ZBnoNtjVg7zGWvN2+oX+kKafMhuyNKf6QBLQ3D2s++IEadYLDD83Kw8ZLSRqKGuMCIXvsP58AmSx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721852329; c=relaxed/simple;
	bh=2faSg8LcPf7OJ44R/fS34n1mIwMtXOoL87WT6yHsKqk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=sIJUMVK5pjcijtnr4LEcC02hFLrjOa+8it7/eIUDc91BvWrFz4ufZ5dlg2ECe88sJl/Ws24lLX2554g2bOZKE0fOTftLf7fOX9BoIbS+tHHqLuXBGpkJ6iZn/enLfBicNr1B5e4OBleaZ6pnDHxIag/C5MYD6NiBvC5k49vXb7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBb9sfY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B5F2C32781;
	Wed, 24 Jul 2024 20:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721852329;
	bh=2faSg8LcPf7OJ44R/fS34n1mIwMtXOoL87WT6yHsKqk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ZBb9sfY+TCGbu9SXfWLdxD42P2QALut567y/jxWPmroRiG6BA44y/G8zrVpKHZTd1
	 t/kY50xUlAvbz5KQR82iHTe3tDReBad4mOzYtoYM0XYBMNS/LYbJbhdUopQacOtLMQ
	 C7img6HjKsFuUbBKC58nTkL5lrzuCPqu/47P6BJ0S9wgnE8HB0T4Wvy+hWVL9ibY1+
	 D6FLq7OY7CRZeOnPN7/T5Nidr9VgPGKrGpbWlhi6zS3qfIKoX4hD+Z5kiQ5X3s7Obu
	 gqCORIFYtloLx4UKHxOHqIp/JyOXHkqZAJsZzs83mRn5NSsIhsK/2uRYrfvW47y77F
	 3yuN9RLXbbr3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F89DC43443;
	Wed, 24 Jul 2024 20:18:49 +0000 (UTC)
Subject: Re: [GIT PULL]: Soundwire updates for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZqCySVLF6zqfnG_C@matsya>
References: <ZqCySVLF6zqfnG_C@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZqCySVLF6zqfnG_C@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.11-rc1
X-PR-Tracked-Commit-Id: fdd3d14ca3c8c5269174f10d33d6181173cbd0b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad7b0b7b87bb19ea7ee71e165e597f5fbfac76ab
Message-Id: <172185232905.2896.18245918617697889784.pr-tracker-bot@kernel.org>
Date: Wed, 24 Jul 2024 20:18:49 +0000
To: Vinod Koul <vkoul@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 24 Jul 2024 13:20:33 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad7b0b7b87bb19ea7ee71e165e597f5fbfac76ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

