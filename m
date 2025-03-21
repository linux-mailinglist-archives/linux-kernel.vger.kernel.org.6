Return-Path: <linux-kernel+bounces-572072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2C0A6C649
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 00:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2EB1899ED4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAA01EF0AD;
	Fri, 21 Mar 2025 23:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcieY/Y/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5E71ACED2;
	Fri, 21 Mar 2025 23:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742598940; cv=none; b=Vg0e5wcWVB4oTwvj5uXyqAlMvU5MULH1gkq8nWLDRvE8sccNziJ4eqCjqPT0hmh4RovTzVnsx05bEaCsViu44txsCUUTZghnQ9vmBfCWkQLxBqWnU81X91LnLDDJztlTd2Vit42dxGyhZ5igR/r7H2TwT+mroDE91Yes8VGo38M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742598940; c=relaxed/simple;
	bh=4/l0zHJK3QMkErAg/IuioCZM6Qu/eCsO8OfUJsP7z00=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rkhlXJDUh0wm7sQwrTEftUKHTsGm+L1LNFXYhUfY/jXGLm1CytAtOxBr+HHb/AG2TsfuMGCejqMwo5kcDCoYDGLV6DMoAJTYrMY7iikXxsZEb3WRPEL7Os2IOvupWYmzYrM6uuMaxvNjE5fjWbR0YXg8aF/jNdWsB1gMyK9/3ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcieY/Y/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A947C4CEE3;
	Fri, 21 Mar 2025 23:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742598939;
	bh=4/l0zHJK3QMkErAg/IuioCZM6Qu/eCsO8OfUJsP7z00=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=bcieY/Y/6M5M+IhOxP6WlyaVD8bCJw8fYIm9eV0ONB/XXRGGWbPzKhP6K3tQW6lg5
	 t/WdivjP1QGEuctGPlMmB99s8NvVUGaFYszBiqvG05G0YChGm4PYRJBFvCaNfZ8XNz
	 7rDyJfgk18SrVNAP53nzbGXqCGY6JtYrFkLN1MygQo6Zp5JH8yer4IPMq+Bg0sGucd
	 Qje5hAiLZReZ9rEH6zOtHJ5uXHq4sPJv1wz4xmmOEELkCTwKQMJ39A0ddPUurRhIzs
	 QfjD1PW+1Mr3zHhM5IX5NriAtGZT33uFq/kGxZgD0Jt2wgBSiITrGDIGKb5kUYMalK
	 L8SnHOfvH8p1A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1EBDBCE0D1D; Fri, 21 Mar 2025 16:15:39 -0700 (PDT)
Date: Fri, 21 Mar 2025 16:15:39 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lkmm@lists.linux.dev, puranjay@kernel.org,
	jonas.oberhauser@huaweicloud.com, akiyks@gmail.com
Subject: [GIT PULL] LKMM changes for v6.15
Message-ID: <dbfe09b5-e5a4-4bf8-96eb-9fb6b98e2fb6@paulmck-laptop>
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

When the v6.15 merge window opens, please pull this LKMM update from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu tags/lkmm.2025.03.21a
  # HEAD: a2bfbf847c96196d62c9a59bd32e1fdafd1c205c: tools/memory-model: glossary.txt: Fix indents (2025-02-25 10:22:34 -0800)

----------------------------------------------------------------
lkmm: Add more atomic operations, rework tags, and update documentation

Changes
-------

* Adds additional atomic operations (Puranjay Mohan)
* Makes better use of herd7 tags (Jonas Oberhauser)
* Updates documentation (Akira Yokosawa)

These changes require v7.58 of the herd7 and klitmus tools, up from v7.52.

----------------------------------------------------------------
Akira Yokosawa (2):
      tools/memory-model/README: Fix typo
      tools/memory-model: glossary.txt: Fix indents

Jonas Oberhauser (5):
      tools/memory-model: Legitimize current use of tags in LKMM macros
      tools/memory-model: Define applicable tags on operation in tools/...
      tools/memory-model: Define effect of Mb tags on RMWs in tools/...
      tools/memory-model: Switch to softcoded herd7 tags
      tools/memory-model: Distinguish between syntactic and semantic tags

Puranjay Mohan (2):
      tools/memory-model: Add atomic_and()/or()/xor() and add_negative
      tools/memory-model: Add atomic_andnot() with its variants

 tools/memory-model/Documentation/glossary.txt      |  32 ++--
 .../Documentation/herd-representation.txt          |  49 +++---
 tools/memory-model/README                          |   4 +-
 tools/memory-model/linux-kernel.bell               |  33 ++--
 tools/memory-model/linux-kernel.cat                |  10 ++
 tools/memory-model/linux-kernel.cfg                |   1 +
 tools/memory-model/linux-kernel.def                | 169 ++++++++++++---------
 7 files changed, 178 insertions(+), 120 deletions(-)

