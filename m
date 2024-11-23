Return-Path: <linux-kernel+bounces-418902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F269D6708
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 02:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4CFE1616FB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 01:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A0B33062;
	Sat, 23 Nov 2024 01:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CA+3W4rz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BE914A91
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 01:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732325450; cv=none; b=C7VNoxaItxZUbjcv6cwuEz6RTIlKTVeZ6gvyOxExm7Df+Fwj/1YqTWMDvCvnJN5W0DAyM6LQ/z3puSx9ev1gLlvITrBA/NOY7ReLy+j6zCHWBCSV/DrbZKu/3u7kEM2Y83R3TI4C+/Uud6P8o2OmOysn7y1gxWx+6hJKa2fp5O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732325450; c=relaxed/simple;
	bh=ae3C7Svz8Y7Pb0EvUNXc1MEHZDBPlJwEMr7JsxCjn/8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YUy4Wlt3KLvdQVfDLU5OWc0rba35O220gb/5RnXSldSEfU90JzT6lHEZpS/9BxrO5tt9ok0QYM4C3SkhreBuEUIsJItkOBOPudZ/evlAVl+xIaivvF8za6B2SMETfgAtAmBjV+CETGo7i3JKQP14bdQo4rc5uUbVFBlBuypdVRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CA+3W4rz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C948FC4CECE;
	Sat, 23 Nov 2024 01:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732325449;
	bh=ae3C7Svz8Y7Pb0EvUNXc1MEHZDBPlJwEMr7JsxCjn/8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CA+3W4rz/zAHXACDv4J2qXouiI5f8PTdqdVyXDWnQ1CN499ZvCuoVW89Enty5/qMw
	 sIqEJoj1stwarVF2NMQhv/GWLOXQN08ljN8958YQG4xNY7d7hBqSKsac3oNFEdQ9E9
	 NADjqKbYGWwpWZQjv39aQavs5lo/DTY7yzMXssVt9y9oHf4sVwi4ZJLYxQFPKHheo+
	 UoZ3nSrdQyI98/hnUt4hJy+Wu/r1MxC+FpHaXCfQtTA1fCtMG27znMtOXSk28kZoSp
	 8WnXJdrjr3OCvwIPtJLZfG9uJxMKG09qd8TXfLL+63wrc+NvK/1NHAWsR6vd2oUr/q
	 xxsT8TqFJv2tw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D303809A00;
	Sat, 23 Nov 2024 01:31:03 +0000 (UTC)
Subject: Re: [GIT PULL] MFD for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241121124020.GA7052@google.com>
References: <20241121124020.GA7052@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241121124020.GA7052@google.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-6.13
X-PR-Tracked-Commit-Id: 8ece9d248b851b97e1e0779caa2ca98df9bc41f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80739fd00c7ea1315d362ce889bef499452913ef
Message-Id: <173232546181.2863978.811434663536608594.pr-tracker-bot@kernel.org>
Date: Sat, 23 Nov 2024 01:31:01 +0000
To: Lee Jones <lee@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Nov 2024 12:40:20 +0000:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80739fd00c7ea1315d362ce889bef499452913ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

