Return-Path: <linux-kernel+bounces-262621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048F993C9B3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9199281A95
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F21148833;
	Thu, 25 Jul 2024 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmKJweH2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FB4143C5F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721939826; cv=none; b=BArmc6GvE6AczIrwL3Vp+TpAIscq/5piBxl1kj+IoBJ+71e3vRw174K8BtohACxjSJKi5y0OO2n2nh++9hJSUqHzcLpc0SCEKQ8VFSNLaTgFZ52KdRkXq+ElaEFGZpht9RinO3h2cz5g2eLeMfdAgnxovi2NQdq5gZ3/CVUtPZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721939826; c=relaxed/simple;
	bh=sS+XhOLRBa14NFeaFWJcXb+ZwLV7seE5f2RRaVM6zFU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=U5OmVjGRZJtbvKG8/bm03J7jpRKjdaXGWXZlanTNVxl7WmMVAMOKEg+YvmTH3rvItMlRYGyh91ikRTCdmYK2DnrctbEebGDcMdBcOP2I4hiz4teklyhuV/7S4a8CM1VUkkIfMhMzjFPL/6W1vVRyAl5FrmueHemEljTCocn7V6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmKJweH2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 338EDC116B1;
	Thu, 25 Jul 2024 20:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721939826;
	bh=sS+XhOLRBa14NFeaFWJcXb+ZwLV7seE5f2RRaVM6zFU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GmKJweH2Xbr8e8JnMAHdy7tf0QjJPxpiQlOFgTRuEVkLRcCIPt/uBdjHua6X2Jnbn
	 MvehX83mXdHWfpJxM/86kTpdZsgjRwISfSHTnpGqLGrai8B1tgWajmbBzMi3/z8MT4
	 6zYKKeBnG21kd1H57Nu449QGfeEtGye00362KJdy+O7VRX9PmDdOveS+tAIYqkPbKb
	 880IrB17H1wT/VfE7CblnPbf+PbE/X8XC6yjlcH/5eUTrQg//NEpaqmKGwi1JgyVuk
	 QEW0zFdOnPFG70U8a66+tdYIU4RcZoTUEuX71VMp//lbsuCsQGaBB5Fj4VvpdnzIo5
	 3eiNOpW2SREaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1E8FAC43445;
	Thu, 25 Jul 2024 20:37:06 +0000 (UTC)
Subject: Re: [GIT PULL] trivial printk changes for 6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZqJajyj-qaf6eCk8@pathway.suse.cz>
References: <ZqJajyj-qaf6eCk8@pathway.suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZqJajyj-qaf6eCk8@pathway.suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.11-trivial
X-PR-Tracked-Commit-Id: a930fde94ae5fbcb178c1330268f15f2c893c507
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8bf100092d60bf586bbc1a3a2cd833bb212d9d53
Message-Id: <172193982612.17931.6386808938521050529.pr-tracker-bot@kernel.org>
Date: Thu, 25 Jul 2024 20:37:06 +0000
To: Petr Mladek <pmladek@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, Jeff Johnson <quic_jjohnson@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 25 Jul 2024 16:00:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.11-trivial

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8bf100092d60bf586bbc1a3a2cd833bb212d9d53

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

