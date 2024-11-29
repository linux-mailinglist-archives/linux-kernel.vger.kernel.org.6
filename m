Return-Path: <linux-kernel+bounces-425933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8B69DECB2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 21:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07E37B22415
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 20:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A281A42D8;
	Fri, 29 Nov 2024 20:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kARm5Qii"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B1114D428;
	Fri, 29 Nov 2024 20:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732912193; cv=none; b=FMFHOzV7jQgqwia4F44t917HoYGyWVS1U2NZAktC12IL6ptYV0oIVswehuGXQHNmwmItfyHQb8+3m0pTwNEC5p7Zmxbad6fY/Ljb10+4+ICdSg3km7oWzZJqGHhsJo8zi9xEgKXe74Wn3/HFSUPXzJtkx6MyHBY6oaIbijvtJbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732912193; c=relaxed/simple;
	bh=rWEnkmOmLKrIWmr8fSGn+TsaJWT6PdMtrdxPh+EMHFw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SaKm4BrTFi3dCXqSWCzoJu0unhA2Ofl5/DXxM4erW8GTPALrCbLfqlXa8xNzMTbcgmcJqDG08B/G77kc/wC74jeKTyqpL+QO/wTj7vywluv2aYnrIuvgyuavvDfmVDdSJyWpU7YMVdzjN0V7H360fYRJFEiSN6yzCRo2xDWhmNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kARm5Qii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064DFC4CED2;
	Fri, 29 Nov 2024 20:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732912193;
	bh=rWEnkmOmLKrIWmr8fSGn+TsaJWT6PdMtrdxPh+EMHFw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=kARm5Qiigg45FU+Lf6mMv9jdZlt0jDxbrjtoBBPQfLMYR18hZQ7sdpbEanWeuoCv7
	 mPwEHNBpKcaTpTsFXVg/2Bp2OTyD4cVABr63o5BnCqU+Hp7kB4W48YvxA0ADZIpz9N
	 Uzw4Fd6hN4I3pUBf57WrQAorvQrYUYvw9o8qp5kKVfATz3mZKgvKKQZW1Q/FK6otRN
	 frFNYPQSjhqETHiHiEMq5lxz8JqdUGGXMTqlDqoIQCBuep1Gyhf7rxLYSW3WTGXgLA
	 GvXwW0FSn4d59kaUcO2kqfLv9LOWN89O0zr0b7v53CYp4crvFDXFhVGeQqkm5tcT+E
	 tTssta4+SFs3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id A3C1B380A945;
	Fri, 29 Nov 2024 20:30:07 +0000 (UTC)
Subject: Re: [GIT PULL] USB / Thunderbolt changes for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z0lCp08uUj3Jx5o3@kroah.com>
References: <Z0lCp08uUj3Jx5o3@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z0lCp08uUj3Jx5o3@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.13-rc1
X-PR-Tracked-Commit-Id: 237d4e0f41130a5ff0e1c7dc1cb41ee2fe21cd2a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e33a6d83e1786d5e310ae746c67f5f4e2f93ba35
Message-Id: <173291220650.2175272.1417540514247740537.pr-tracker-bot@kernel.org>
Date: Fri, 29 Nov 2024 20:30:06 +0000
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 29 Nov 2024 05:27:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e33a6d83e1786d5e310ae746c67f5f4e2f93ba35

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

