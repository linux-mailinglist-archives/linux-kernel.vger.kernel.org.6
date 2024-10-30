Return-Path: <linux-kernel+bounces-388065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDD99B5A12
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 03:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657782842F9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365AA1946C9;
	Wed, 30 Oct 2024 02:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVe/c0tr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B161946C8
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 02:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730256272; cv=none; b=LE+PQruc/468vpTunKSX6fjBFEArZXIVvTuo4jybZLqV8hLXgi4WiiXtKMK6qSkXR+Y9wYt0IoxveyrCQGyGjzbjoCr3NmGFkMlads6toTq79jqNXFXRdN+FffEeALciEAaKrWt5cZvP2QULIk8kh05op6/N/ZSOGphpUFVLB+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730256272; c=relaxed/simple;
	bh=FXPaMceouqWc+7ze6VAp+WSn2GibZ4ui+arZXL1ORlA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Yu05cekD/CcyzhpArP2ALk/tfZyXRIFz7Fz1fvuzUpl3nv56HuE8U4liIhlvbOlwZbttzOD6cCOWl8WYzM6eTs/52b+mwOtw1NOWj82t7kXe8rdl8azvn+zSMZdaYvDSxfuoDNm6ovOMHOT3E+nwF5h9PbdOp7XsBz3+Jn1IEA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVe/c0tr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F148C4CECD;
	Wed, 30 Oct 2024 02:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730256271;
	bh=FXPaMceouqWc+7ze6VAp+WSn2GibZ4ui+arZXL1ORlA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EVe/c0trEHpINDPSFlGALqBhGt4fd5SSATxQdFuC+TP7Jek7aVMGP37eWzDcJC2VI
	 pMjZ2UsyBEGGlcJ7Xp1X/RqDrLEwfJ4Tzl+ay9Q/MUnHmjPNukFxwhAE+hmuS3PDCN
	 zLJvgnkro9xqLkVJNPd6QCHrhwxIj0gdPyrFibYxD6B7238EP70D/X1PLvL4vJo30T
	 +3Uhie8HqsYnwtG0LfZ1xmci1bBQIFnzqldyuKBA2lCBCVnZRXrC+VUC5fUz9nNMUp
	 yhq/6cTjJFDdwRsgP5Icr0qRFJipm0nUXxPbrzgWKq0blOdYy/U0jJeUtzAdF06f5i
	 imcJV5qiXOwsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB040380AC00;
	Wed, 30 Oct 2024 02:44:39 +0000 (UTC)
Subject: Re: [GIT PULL] slab fixes for 6.12-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <fcd42c5a-0350-4073-951f-4a8332b7b3de@suse.cz>
References: <fcd42c5a-0350-4073-951f-4a8332b7b3de@suse.cz>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <fcd42c5a-0350-4073-951f-4a8332b7b3de@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.12-rc6
X-PR-Tracked-Commit-Id: 704573851b51808b45dae2d62059d1d8189138a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7fbaacafbc55c56ca156a628a805f79a2cbe7103
Message-Id: <173025627841.893735.8830277317058083878.pr-tracker-bot@kernel.org>
Date: Wed, 30 Oct 2024 02:44:38 +0000
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, "Uladzislau Rezki (Sony)" <urezki@gmail.com>, Guenter Roeck <linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Oct 2024 10:54:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.12-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7fbaacafbc55c56ca156a628a805f79a2cbe7103

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

