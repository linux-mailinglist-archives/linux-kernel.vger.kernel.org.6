Return-Path: <linux-kernel+bounces-259391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD665939536
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989BC28262A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5708745007;
	Mon, 22 Jul 2024 21:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoBjXHda"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B153BBF2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 21:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721682548; cv=none; b=IMgtmBBF4vtPSVjRTlTyBnB/1r57NSvVJ21Y55gkVvAyaBYc5OOIi/DBFvazyOMa9rFafTmZpXxbMc3VUL0LWLHQsBYyFQL9fR9DGAtguf9ApyNIpQ7wbIA2pzURzMlyl8LqyQljXq77FSww55YRHcad+MByaZe+UiOW9IvjgJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721682548; c=relaxed/simple;
	bh=Bxozw88qfE/9BhYobVZ97SjlEmeK33Mi2VK5spHeL6w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=H27OIbX5nzqtGg8Jm29Y9u4hrVNNd1hR3sr0A7+v4hZcXxLfQ0SF9IELS+Lhoiy58QBQFF99mkezO7R3teV7zs4pwtJfUuu36AnpvoqvIYuVOpvA431+J6zR5Qw/E2HgoeOT/i4Ub4X9EehDZmqD+T1g8q5XmBIlCfxSmr7R2ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoBjXHda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78070C116B1;
	Mon, 22 Jul 2024 21:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721682548;
	bh=Bxozw88qfE/9BhYobVZ97SjlEmeK33Mi2VK5spHeL6w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=XoBjXHdaO8kTdqqya1sp0EKUH4WTgjm7jumMnAg0otZam4mGAlApUm1j9WvOjaP2l
	 bk5+dX0IBepUVswg38WBRVVF4Vht9Qy22YGhre4GIwlkl19rMgMfIwxkRsZqIcK4RC
	 CAmbTjZT03EqQMWukwJqOLSaZ4uxuGc2zPmQNDNjAfRp8YpKPtzYdfaKlUxQwrbgOK
	 1WxhZjDdn8IGRW1tdHeZy9gB9sXhHxK2+SYkiJ7m8+VZhwbRA1zXNKC9y0OAXBROST
	 /jKbyL0gU5ypkNX8TMfmUalcBe1GUfo242J3fEt9OHiIyw40a4CRfa6a+uYYlFq9l9
	 KH/rzNzDu8vDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 696D6C43443;
	Mon, 22 Jul 2024 21:09:08 +0000 (UTC)
Subject: Re: [GIT pull] irq/msi for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <172167641899.62829.14888511482116338560.tglx@xen13>
References: <172167641737.62829.15719424739961406637.tglx@xen13> <172167641899.62829.14888511482116338560.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <172167641899.62829.14888511482116338560.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-msi-2024-07-22
X-PR-Tracked-Commit-Id: c9b4f313f6b83ac80e9d51845d092c32513efdb4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66ebbdfdeb093e097399b1883390079cd4c3022b
Message-Id: <172168254842.16066.10165999405902286983.pr-tracker-bot@kernel.org>
Date: Mon, 22 Jul 2024 21:09:08 +0000
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 22 Jul 2024 21:27:20 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-msi-2024-07-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66ebbdfdeb093e097399b1883390079cd4c3022b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

