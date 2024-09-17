Return-Path: <linux-kernel+bounces-331766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A6397B0F8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43E5EB2712B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F961741D0;
	Tue, 17 Sep 2024 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pf6ZadLr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A523915C14D;
	Tue, 17 Sep 2024 13:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726580948; cv=none; b=D3fmAmDpFGlsPpTVE6VP9ayS+9YvklS7RdF58tnFk9goAmXFSH+3pXp9b2p02cyzgYKZzVe9qln61kwj7E07nwuimBeAXAaE77eOL1oWeIQMnzZmeWKVTaD2Ug4LmPp7Ib0fc3IwDWjSpb+RvflsEI6TTU/Uo7zh5pv7Pypx+zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726580948; c=relaxed/simple;
	bh=pRHFas6Nd62vPzByTiCSlPk2IN/k7lp11mG1EK/0PoA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=T8Ctq7UmU2GB2ck1nhPoQw24tmT08lg19mekm8eCFh91QZcqaTE35jWjdv7Cq5iaSRedwNx8jZ3KE7iGAXW3fuw7NzyyoJxJNS6IdHT1cK5ddsTucpAzD0Hqql8sYXAdq7dj15WHr2HG0C729Y3pUsrYwMft2VzuKE6nCj8dw04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pf6ZadLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA2FC4CEC5;
	Tue, 17 Sep 2024 13:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726580948;
	bh=pRHFas6Nd62vPzByTiCSlPk2IN/k7lp11mG1EK/0PoA=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=pf6ZadLrcmJxWZi7HUdbZpVJfg/qMW4gln/SFbJU/VCBKYzup2Xku6ngBI/InmTmc
	 NH9q2L3lSjCj4xShE4KHr+cn7Re9+HDEY+oR0CadOI8LPpz4Jb3bcTkW4ZlyqGWanf
	 /+z1Hxbjg14KRcANGtkhvP1OYoc3Uo096sS9qyFocH8tVgEtM/tZj0HVon6DTMlAM6
	 I94Thll8cZJ7rHaeD2n6LlrZ4HYCv7DoA2pwMfskH1tSaojWiAudbN1crTS4zlfjGl
	 wJfexERsFySPjmDKhaS4tc0+Uk3EMgtqFgfwhqM/DwgiQMsmAFlKfNT6o8yoSeu4pb
	 3m9zmvXmpZdcA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 141FFCE0F73; Tue, 17 Sep 2024 06:49:05 -0700 (PDT)
Date: Tue, 17 Sep 2024 06:49:05 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lkmm@lists.linux.dev,
	parri.andrea@gmail.com, akiyks@gmail.com, boqun.feng@gmail.com
Subject: [GIT PULL] LKMM changes for v6.12
Message-ID: <acd68abf-715b-46b9-9e9b-818c40df1402@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello, Linus,

Please pull this LKMM update from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/lkmm.2024.09.14b
  # HEAD: a49f48cc7d26270bee727d30ce830d4129b33d4a: MAINTAINERS: Add the dedicated maillist info for LKMM (2024-09-13 23:56:44 -0700)

----------------------------------------------------------------
lkmm: Add documentation and mailing list

This pull request contains documentation updates from Andrea Parri and
Akira Yokosawa.  Also, there is now an lkmm@lists.linux.dev, and Boqun
Feng's update adds this to the LKMM MAINTAINERS entry.

Not included in this pull request are a couple of more commits from
Puranjay Mohan adding more atomic operations to LKMM, but these await a
herdtools7 release that includes tool-side support for this functionality.
With luck, I will send a separate pull request for these later in the
merge window.

----------------------------------------------------------------
Akira Yokosawa (3):
      tools/memory-model: Add locking.txt and glossary.txt to README
      tools/memory-model: simple.txt: Fix stale reference to recipes-pairs.txt
      docs/memory-barriers.txt: Remove left-over references to "CACHE COHERENCY"

Andrea Parri (1):
      tools/memory-model: Document herd7 (abstract) representation

Boqun Feng (1):
      MAINTAINERS: Add the dedicated maillist info for LKMM

 Documentation/memory-barriers.txt                  |   3 -
 MAINTAINERS                                        |   1 +
 tools/memory-model/Documentation/README            |  24 ++++-
 .../Documentation/herd-representation.txt          | 110 +++++++++++++++++++++
 tools/memory-model/Documentation/simple.txt        |   2 +-
 5 files changed, 135 insertions(+), 5 deletions(-)
 create mode 100644 tools/memory-model/Documentation/herd-representation.txt

