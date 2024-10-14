Return-Path: <linux-kernel+bounces-364152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFF399CBD9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447501F23E7A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B741AB535;
	Mon, 14 Oct 2024 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbvpbFLG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8421AAE39
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728913646; cv=none; b=P8NVENaAnMyHsGpMmozJ7n7cAK5/FKhz0j6akbeQ0Ajyrk6GB129S6f1yfO/goisjVgNGJoTJtlJlbWglFxm+aeHRwJ0RagRXSWgmIA0DXGxzhZYRaT2rEYtJfOgUDiE6YaG9WoCeA2yrpmupST+C760CXIJH9dJnemOYG/Wym8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728913646; c=relaxed/simple;
	bh=nwwq7OHMaX1nC9S9saGAcAH78OrbUQ+EHs3XR03niTg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xan+9PDrRU1h4C+Klg9KLJ848bP7k2P00c+wLwjm+2D6HvbSkbd44rWTGjrmFDY4vB+wtj2tOJMFQ+LKLXLVNiyYT8hrpcHbM2cbF8qxC7N3clmlGVGf3CwBNjaOtJkv4FF3aVp3W7FOa+YNAjjgDk8LWc4FEZxkngGVHqTGSn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbvpbFLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CBEC4CED0;
	Mon, 14 Oct 2024 13:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728913646;
	bh=nwwq7OHMaX1nC9S9saGAcAH78OrbUQ+EHs3XR03niTg=;
	h=Date:From:To:Cc:Subject:From;
	b=fbvpbFLGJacz7KdskTSpqFr5dESrRgMLSudV03eEwOE4BWmMszKDkhE9Dc6HvVQmB
	 BObfvY03gdlnj5csdiKAZ+YCh/Vf1+fna4ecPxhyuqQtZIxd3xo+bolmddD4HGdTgk
	 MSj95NwsdWsQt8Yy7/R9IrSWxaQ2nvV1rU74FgXyHrBy7eXRiHfY3VSXdMLoDDwoAL
	 PWpIsayPhR5TP90B9XtJ/QWAPdJ5HpNSUB/2UmdCs/bWuzotr/vW0V+/GAXT4cuqcb
	 okXyEKXhUAENIBQhpH/98qS9M5jqYJOpEICzqKW+h1eaJ38dXTsJG9UEsIMT6B0lcE
	 pHLgCpJfAG7tg==
Date: Mon, 14 Oct 2024 21:47:19 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	chao@kernel.org
Subject: [GIT PULL] erofs fixes for 6.12-rc4
Message-ID: <Zw0g5xS5WXYve0Hj@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	chao@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

Could you consider these three fixes for 6.12-rc4?

The main one fixes a syzbot issue due to the invalid inode type out
of file-backed mounts.  The others are minor cleanups without actual
logic changes.

All commits have been in -next and no potential merge conflict is
observed.

Thanks,
Gao Xiang

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-6.12-rc4-fixes

for you to fetch changes up to ae54567eaa87fd863ab61084a3828e1c36b0ffb0:

  erofs: get rid of kaddr in `struct z_erofs_maprecorder` (2024-10-11 13:36:58 +0800)

----------------------------------------------------------------
Changes since last update:

 - Make sure only regular inodes can be used for file-backed mounts;

 - Two minor codebase cleanups.

----------------------------------------------------------------
Gao Xiang (3):
      erofs: ensure regular inodes for file-backed mounts
      erofs: get rid of z_erofs_try_to_claim_pcluster()
      erofs: get rid of kaddr in `struct z_erofs_maprecorder`

 fs/erofs/super.c | 13 ++++++++++---
 fs/erofs/zdata.c | 29 +++++++++--------------------
 fs/erofs/zmap.c  | 32 ++++++++++++--------------------
 3 files changed, 31 insertions(+), 43 deletions(-)

