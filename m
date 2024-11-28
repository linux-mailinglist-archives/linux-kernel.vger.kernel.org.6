Return-Path: <linux-kernel+bounces-425010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE3B9DBC70
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 20:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35ED3281D28
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 19:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F05D1C2432;
	Thu, 28 Nov 2024 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1mGFGO2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3981C2304
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732821581; cv=none; b=c+icYUKgeYE1sy5huWbuoAjPIAFPDksSCBnytGrZFSavyvIUq1pjdPeJ5a+5MyrEP070WNXpo9X9YwDvNFMou0POcn3cK5eXGnGxGyH3R17is41KXrZdKApNMnouwNWukMI0xdubrrLvbv9W+6cYQBhgvcz7X9IcAj5ueP5XVZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732821581; c=relaxed/simple;
	bh=va68yZVX6v0y4PoZ3c2YXRojFYSLy8ucY/gcyNdnyDA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LwCmZ6/8w4GDELNQmME510bStblefRsRkU27LQ+8t3MNHuoTXoGp/C6xWbLXc25sQoDqUTaxBfOcFNQk9Gyp+0hOvp019Mw3IPsYNtd/iTLP6cwf23Dhwfr8uwBHFXe/BhpVVuACDS2JuEtBKt8xwahShSawaPI6mzXH9r566j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1mGFGO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32D3C4CED3;
	Thu, 28 Nov 2024 19:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732821580;
	bh=va68yZVX6v0y4PoZ3c2YXRojFYSLy8ucY/gcyNdnyDA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=W1mGFGO2RAOdoXSVdFjJz+EMYuYOYUh8neKaAnVgzLCAisA8MhoIURpnHyvc1yPNY
	 tpxGxlZAckCtbErZuL3ZHCxOgCQMykKwPLHK4zSlTtEEtmAjRfgNoCZ675uym2C9kv
	 6kWV7P2PWy6KnQx8I05g2EwzTLGyIiNmjzd0t7fVzCgxKMydZIedRfqyhv1v+v1dYQ
	 FucDhGM7Dcuio3e9B2Q6T72IY3HtzflUxzztsCURxar+H9PpaEh/r0u7mDYEKl7nwQ
	 y3RKzyPcRBknjCtO46Xx5jacpMZn15JBQSbYkhE0/qOn3j8sXgnStmdBZq21m5txZ/
	 jB/RyJF2VxrCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BFC380A944;
	Thu, 28 Nov 2024 19:19:55 +0000 (UTC)
Subject: Re: [GIT PULL] exfat update for 6.13-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAKYAXd9nv9eEHgt55sWBWo98bkOXctDJGjQo+FSJYtVGwtKOhA@mail.gmail.com>
References: <CAKYAXd9nv9eEHgt55sWBWo98bkOXctDJGjQo+FSJYtVGwtKOhA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKYAXd9nv9eEHgt55sWBWo98bkOXctDJGjQo+FSJYtVGwtKOhA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.13-rc1
X-PR-Tracked-Commit-Id: 8a3f5711ad74db9881b289a6e34d7f3b700df720
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8170a99c0bc6109566f001e3a6f3c76b672c9fad
Message-Id: <173282159403.1826869.9432634384592582990.pr-tracker-bot@kernel.org>
Date: Thu, 28 Nov 2024 19:19:54 +0000
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, "Yuezhang.Mo" <Yuezhang.Mo@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 28 Nov 2024 10:15:05 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8170a99c0bc6109566f001e3a6f3c76b672c9fad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

