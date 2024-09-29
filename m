Return-Path: <linux-kernel+bounces-343062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7475C989663
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 19:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A64F1C20A17
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 17:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A56181334;
	Sun, 29 Sep 2024 17:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pim9IcNf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D8217E00E
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727629474; cv=none; b=QE/vo2SP6a/lfCm2MX9Fr/OK+PPZP4vbVLj7nHzkIWIYGTzDOftD2oN/275TI7rLU8sk5R07KEDQ3jDOakzCv5PNWjKQrSV0H6se10FG35Iv229NZC0/NJok5MSU8M5qLVGPGtbqv2bqaQQ/qQWJwqXRZFEz5GY35ay0KVLrIqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727629474; c=relaxed/simple;
	bh=Ae7B43LmpYs3sfRNuNIyypBJ8+zlKL5s286IIWF9pZI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=luvdU9JuVqcuc+cvmCA6O83FLktn/a71po04Es0e5Q8J7/PfqSVP1OOfg65Yzz8bg/qdF9M5UJ5yRLKoZ9omIzVtOCRaIyQXBXiEP8DH5v0uLpj/NY+fs10tE02zQ6cOlr3SDe1d04I4wxIGtzhje4y7PjIinbI8ZhyD6p2G6is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pim9IcNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E5BC4CEC6;
	Sun, 29 Sep 2024 17:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727629473;
	bh=Ae7B43LmpYs3sfRNuNIyypBJ8+zlKL5s286IIWF9pZI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pim9IcNf0fWirbZZP03XqltfjKSszdl3hHGzmfdJsy9LCgXMO8Qr3V7F9Ul3Jll2I
	 qdJNOADXi3naYGDDQtjwLBYy/43k0TnzgtVu9+mF2dqaS8AcMaRo38UG9PTMlf1nRX
	 01qtPn2JbzW5Uu0M1a1nWrdty0k29oKTgZgQbjC5LnU+pgYVMwBmhS5bwpZ+GsM8r9
	 y/5v2hWIC6TbsjFV8d4WXCIfGU4/1lrgeneA3zaSbfc41nrhPVcKUsorF3SPh5qbgH
	 6TkT9kN8LjTRJ62BykEURV++Nd+y3EQeNlz+0HpGyc/KlK4Ec0HHP97yNgY4V74PXx
	 wBvwe5Bgq5ryQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF2F3809A80;
	Sun, 29 Sep 2024 17:04:37 +0000 (UTC)
Subject: Re: [GIT PULL] Mailbox changes for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY0_DC+usbp362+jSXF9p3y_XDcYV6MLO=kPCcnzThK8OA@mail.gmail.com>
References: <CABb+yY0_DC+usbp362+jSXF9p3y_XDcYV6MLO=kPCcnzThK8OA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <CABb+yY0_DC+usbp362+jSXF9p3y_XDcYV6MLO=kPCcnzThK8OA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git tags/mailbox-v6.12
X-PR-Tracked-Commit-Id: 54595f2807d203770ee50486cb23dc5763916d72
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e7ed343658792771cf1b868df061661b7bcc5cef
Message-Id: <172762947652.2558104.3437442087127481421.pr-tracker-bot@kernel.org>
Date: Sun, 29 Sep 2024 17:04:36 +0000
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 29 Sep 2024 11:03:07 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git tags/mailbox-v6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e7ed343658792771cf1b868df061661b7bcc5cef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

