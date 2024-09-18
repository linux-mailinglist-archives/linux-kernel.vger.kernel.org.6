Return-Path: <linux-kernel+bounces-332377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE3E97B905
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7911CB26E54
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F2917E014;
	Wed, 18 Sep 2024 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tm6xn8VQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8453A17DFF7
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 08:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647009; cv=none; b=OEMC+SsHCZHjRwl+nW8NdVYR9f5rfYlhHH/Mb7yn/wKNlAu07NJFTsLZ9BdumcnSErpaMtlgapcEgEKG3oBtxaCHm/Qtf7h1w3L9yQi8RmHndpFK7jizKHFoO3jOb0sOXgiCJtBSCZ57xjmqWnzXr3q8qjlKVWTaxakcmQL66BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647009; c=relaxed/simple;
	bh=JL3A4Ysb1taNTycvvaDPxNYMwszpeLF6BiqqTzjpjTg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UkztOp/xuAuKZSm6hwz3oy+sFopBcJzkitkpJpYRg5Y1rB+AwxcsWwhL81QvM43zPtW9pUM3h2sFLCdUPYGFRykaGwQwWwK9R62WELQ+FRSFhN9Jucv7dJzPS1oC2Ta816qJ7lhT/MItrUrcJC5bGBpWHMgZmX2p8f0qxeK6q9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tm6xn8VQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60262C4CECD;
	Wed, 18 Sep 2024 08:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726647009;
	bh=JL3A4Ysb1taNTycvvaDPxNYMwszpeLF6BiqqTzjpjTg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tm6xn8VQ7bI3zDMg2Mf9DmXscbNLmxMcbZnrOUBVznC3/prf/Lqk9eaV6N+9mge5x
	 yifnXdPhXgHo2UKawNCvkyWhaaoqXkfdb8cKJy/PHM0tbrscqOUsghYl2ocv7PFFfS
	 Ip3MHSgbP6HrCNTqfSbiwq1uLoJANCll7++Ur6K0IMyIBqQL3CiUfxi7aTDQfrt9DO
	 ZQO9xTvPg/qvxxM4MOAUxVj438/hUvIyA8/MLzrIW5cgxnopKqpOKj67edcRbZ3R7w
	 Eqn4jwFl4ZyrHyeeCvERuT7uQcMINYwdT+Sx6EUFw9l+cIFCb5KZjBpOg9AaENtqh4
	 OxfP0znh4zoRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 67D053806657;
	Wed, 18 Sep 2024 08:10:12 +0000 (UTC)
Subject: Re: [GIT PULL] KCSAN changes for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <65bb8a3e-9d52-4f2a-9123-a4e310c88d10@paulmck-laptop>
References: <65bb8a3e-9d52-4f2a-9123-a4e310c88d10@paulmck-laptop>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <65bb8a3e-9d52-4f2a-9123-a4e310c88d10@paulmck-laptop>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/kcsan.2024.09.14a
X-PR-Tracked-Commit-Id: 43d631bf06ec961bbe4c824b931fe03be44c419c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e651e0a47348cea260837ed5b463a489b1e8095e
Message-Id: <172664701118.684502.7882226897741505059.pr-tracker-bot@kernel.org>
Date: Wed, 18 Sep 2024 08:10:11 +0000
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, kernel-team@meta.com, elver@google.com, thorsten.blum@toblux.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 14 Sep 2024 01:10:36 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/kcsan.2024.09.14a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e651e0a47348cea260837ed5b463a489b1e8095e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

