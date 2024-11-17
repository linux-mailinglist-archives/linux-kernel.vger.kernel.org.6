Return-Path: <linux-kernel+bounces-412206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420699D0536
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 19:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A2E281882
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 18:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A8E823DD;
	Sun, 17 Nov 2024 18:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3SH90mS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A362613AA5D
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731868851; cv=none; b=JjnummFZVdUOlRVY8JXH5iYY5lXy6VNuabCHgQYKRJh3MS2jeXw06XsxWhRMne9QnjQF3gWskBWb0oSV9CxF3c6xaIeTFDSYZfz23SwaAenhKTsRNNbLARMRKGe+NOqCgNmn0nAkJUkMvbxXz3GxvEMHuVX1RDygenPmyrxc/gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731868851; c=relaxed/simple;
	bh=uq+AudFrYpzpfsVnppxp71fYMy+dTmM7EoD1YUKAnSA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eYBEw0GWhQJjHsc2gpHScJq0eZAqic+Ze51wf8NdoLyEfJEYMyeyvredufd99UX5OqDBQrP86qvWe9ophPbOZeTQVMWNfGgN1qrLXntgzufGvX2nEwUSD5QpdnT2oyebtaf5+EPCiOlXkcSnJWK5mdym0pdCskF2VUok/UpMjYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3SH90mS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273D6C4CECD;
	Sun, 17 Nov 2024 18:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731868851;
	bh=uq+AudFrYpzpfsVnppxp71fYMy+dTmM7EoD1YUKAnSA=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=M3SH90mSGYt100isARSVUrvelndBKnxWTSoU9Frq6NT9zmjzvjlQH8yj6eiBJDcHq
	 G02D65aAR9yzA6qRX615zsyRKgOQymIwC384YtPxykGkVKiQnPe23bW/hjibyCUUPB
	 7/7OvzVmodCIvsZrYfj1h5z6DdupoPwklfp4EslnRpsddRpaFzPIhJhma/zT5aYwlx
	 YxZf+DHcAjr94R6zAD7lZfpjx2sWzKmeVS+IUYVVsl9Sx8XSGUCRcLZBIiAIyrmhB2
	 2o6vrX7ml9mmQO11q697BJ3i6KgmxNu/N8wqgkIqZSG8KeUR1A2WjBLNhRmTiFEfoT
	 6xkWi3R6Pp8Zw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 95149CE0885; Sun, 17 Nov 2024 10:40:50 -0800 (PST)
Date: Sun, 17 Nov 2024 10:40:50 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, w@lwt.eu,
	linux@weissschuh.net, skhan@linuxfoundation.org
Subject: [GIT PULL] nolibc changes for v6.13
Message-ID: <4df7ba8c-f373-4b22-9387-7674e5f903a7@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello, Linus,

Once the v6.13 merge window opens, please pull the latest nolibc
changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/nolibc.2024.11.01a
  # HEAD: ad0558f3883130954ca724697f2d19aef93967b3: selftests/nolibc: start qemu with 1 GiB of memory (2024-10-07 21:57:45 +0200)

----------------------------------------------------------------
nolibc changes for 6.13

Changes
-------

* Fix potential error due to missing #include on s390
* Compatibility with -Wmissing-fallthrough
* Run qemu with more memory during tests

----------------------------------------------------------------
Thomas Weiﬂschuh (3):
      tools/nolibc: s390: include std.h
      tools/nolibc: compiler: add macro __nolibc_fallthrough
      selftests/nolibc: start qemu with 1 GiB of memory

 tools/include/nolibc/arch-s390.h        | 1 +
 tools/include/nolibc/compiler.h         | 6 ++++++
 tools/include/nolibc/stdio.h            | 3 ++-
 tools/testing/selftests/nolibc/Makefile | 4 ++--
 4 files changed, 11 insertions(+), 3 deletions(-)

