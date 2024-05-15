Return-Path: <linux-kernel+bounces-179356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CD38C5F32
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60DB2831D7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 02:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77A9381AA;
	Wed, 15 May 2024 02:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WO+Uwp60"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17190376E9
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 02:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715740784; cv=none; b=DNk0GqB5Xd4bFEfwCl6N+uSAX6BZNX7G2lPStJRTbxz+8I8jnS/HEGWyXBpKNee0hGuRZMJwqOyxdjpgX8m5Q0ojGDPnlOjuZiXzZu9ilKGq/N15KSS9FsA5TKmGx38RMtxvQ5TZ6SOUFJBIhT+iwsPajQ0PVm4Xx4YZAkj9i3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715740784; c=relaxed/simple;
	bh=xtD2Io43OH/rxTyqMsj5eVS7ek6KM7r3q6oUbfhqcSM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kPL4IDjYqcj1bwyvPQwvOOqPXMQ1FB3wYfCJL8oOGdQpNEu94ACiq6oE9Dgm8MjEI4mjFAZjVQzivEplqB1z2s6lbCoQo+jVCSVR83mPYgjhi3JT80YgU8daU4S43Ro5GMWFGZEaSoGylYH8nKQqBEWnpsbU7jr3cybILaUQ+Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WO+Uwp60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBA3BC2BD10;
	Wed, 15 May 2024 02:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715740784;
	bh=xtD2Io43OH/rxTyqMsj5eVS7ek6KM7r3q6oUbfhqcSM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WO+Uwp60/NrHIg17LxZ8vkq2QlxvUaji+w5OpWPA/77pXqBLy4kIHPj8XvnAjGkix
	 v8cewEtDoawCVfbQl3n1UUHUxeCuubWpFhu9SEO+bPmJAva0UGMNuD7dIivjLLjEuX
	 gXzvH/AjCruiE3Y67qzzyNid8oY76LP/AV0JUwcUbY6kK/FYtnA0IYxXeHz/Zkmsol
	 7NL8EjhVnPQO5MTFLv7zIXZlg0xEamlkUHs0u9bf+YCRldP79Se378VoB7HXd2qEWD
	 BElc/ZsydH/vsjUne8W36mgKEO63k0ozl4lhEzOIs6BJYp5xkh2SzmZaNKqi9B/Ym2
	 WTPu2qxthwHLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E34AFC43339;
	Wed, 15 May 2024 02:39:43 +0000 (UTC)
Subject: Re: [GIT PULL] firewire updates for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240514100418.GA198864@workstation.local>
References: <20240514100418.GA198864@workstation.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240514100418.GA198864@workstation.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-updates-6.10
X-PR-Tracked-Commit-Id: 21151fd8f0ea5dcff27e8db25b65bf892d408bdc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b850dc206a57ae272c639e31ac202ec0c2f46960
Message-Id: <171574078392.17365.12930725732053503423.pr-tracker-bot@kernel.org>
Date: Wed, 15 May 2024 02:39:43 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 14 May 2024 19:04:18 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-updates-6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b850dc206a57ae272c639e31ac202ec0c2f46960

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

