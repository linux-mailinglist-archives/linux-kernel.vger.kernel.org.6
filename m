Return-Path: <linux-kernel+bounces-313350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF9F96A44A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BACBE286F63
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC7718BC11;
	Tue,  3 Sep 2024 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7zc3eXb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9869A18BC00
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725380972; cv=none; b=moxsMRUmWjNOyzlDMZNe93ZH0hvZ1dqZ2nO81uBMnE2NriI/hp8q3e3O2ibN+o/ctnucGdJ3OYe0bdFozh9H86H1KAoa+n5A1chxjWnirpXAIl9Xd6h4LASxhoGe4afBozHjmz57FgzFNs1p0Kcp82JdKNvb/ZVKYm7tBeg77IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725380972; c=relaxed/simple;
	bh=EJ6Qf87LF+8EEuxbRvNJ7RXNZ9lSq9Z1jt1pM/CA0DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wz6l5ejss7AUki8BCBz24yerKduia+Pc5ALncNqA4VAY07+9Poe1Yv1tMLONlyhcvjJZcC/YyRROd1IfPTyyEljsWIOsgZlTyjTlom36DuG3vhcZ/hS97nF5VrEPNvtEv48VOdmp/xSrRBz7WZZuSzVpD4VeP1mujz8VZtDDT0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7zc3eXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2E8C4CEC8;
	Tue,  3 Sep 2024 16:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725380972;
	bh=EJ6Qf87LF+8EEuxbRvNJ7RXNZ9lSq9Z1jt1pM/CA0DI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T7zc3eXbphsEbKYxwNbQdLIaLm6GjCC8A3CYECftE8c8++uAYSOXmPebtZ1SvlBcN
	 8+kaFR2E52gOgpcOpPYa9pMSp07q8bpuulsarniDXsnF3QZu2OLMT6QFAWbcIEmpFo
	 jkAkAikjSDaQB3jLs8vRZ5G5n02j3Y8wzW9pmKS+HQFyN+XC43LbkBAqUSIipDvKwB
	 DuA8nJopOoGjvjJavbPSAkgddgtwtrc/nZJhO84il/3fDAFMRWaqtoFy5MNRnUbt23
	 Y55ErbW/KqIk9VXD53olQds6nbEPxXhJYcy6R+8ZlZIMrLPtefEQykfdoTqwPo1v5i
	 hKH+QEZHg7HPw==
Date: Tue, 3 Sep 2024 09:29:30 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Wu Bo <bo.wu@vivo.com>
Cc: linux-kernel@vger.kernel.org, Wu Bo <wubo.oduw@gmail.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 00/13] f2fs: introduce inline tail
Message-ID: <20240903162930.GA2743@sol.localdomain>
References: <cover.1725334811.git.bo.wu@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725334811.git.bo.wu@vivo.com>

On Tue, Sep 03, 2024 at 02:54:44AM -0600, Wu Bo via Linux-f2fs-devel wrote:
> The inode in F2FS occupies an entire 4k block. For many small files, this means
> they consume much more space than their actual size. Therefore, there is
> significant potential to better utilize the inode block space.
> 
> Currently, F2FS has two features to make use of the inode block space: inline
> data and inline xattr.
> 
> Inline data stores file which size is smaller then 3.5k in inode block. However,
> for slightly larger small files, there still have much waste.
> For example, a 5k file requires 3 blocks, totaling 12k of space, which is
> more than twice the size of the file itself!
> 
> Additionally, the end of a file often does not occupy an entire block. If we can
> store the end of the file data within the inode block, we can save an entire
> block for the file. This is particularly important for small files.
> 
> In fact, the current inline data is a special case of inline tail, and
> inline tail is an extension of inline data.
> 
> To make it simple, inline tail only on small files(<64k). And for larger files,
> inline tails don't provide any significant benefits.
> 
> The layout of an inline tail inode block is following:
> 
> | inode block     | 4096 |     inline tail enable    |
> | --------------- | ---- | --------------------------|
> | inode info      | 360  |                           |
> | --------------- | ---- | --------------------------|
> |                 |      | extra info         | 0~36 |
> |                 |      | **compact_addr[16] | 64   |
> | addr table[923] | 3692 | reserved           | 4    |
> |                 |      | **tail data        |      |
> |                 |      | inline_xattr       | 200  |
> | --------------- | ---- | --------------------------|
> | nid table[5]    | 20   |
> | node footer     | 24   |
> 
> F2fs-tools to support inline tail:
> https://lore.kernel.org/linux-f2fs-devel/20240903075931.3339584-1-bo.wu@vivo.com
> 
> I tested inline tail by copying the source code of Linux 6.9.7. The storage
> space was reduced by approximately 8%. Additionally, due to the reduced IO, the
> copy time also reduced by around 10%.
> 
> This patch series has been tested with xfstests by running 'kvm-xfstests -c f2fs
> -g quick' both with and without the patch; no regressions were observed.
> The test result is:
> f2fs/default: 583 tests, 6 failures, 213 skipped, 650 seconds
>   Failures: generic/050 generic/064 generic/250 generic/252 generic/563
>       generic/735
>       Totals: 607 tests, 213 skipped, 30 failures, 0 errors, 579s
> 
> Wu Bo (13):
>   f2fs: add inline tail mount option
>   f2fs: add inline tail disk layout definition
>   f2fs: implement inline tail write & truncate
>   f2fs: implement inline tail read & fiemap
>   f2fs: set inline tail flag when create inode
>   f2fs: fix address info has been truncated
>   f2fs: support seek for inline tail
>   f2fs: convert inline tail when inode expand
>   f2fs: fix data loss during inline tail writing
>   f2fs: avoid inlining quota files
>   f2fs: fix inline tail data lost
>   f2fs: convert inline tails to avoid potential issues
>   f2fs: implement inline tail forward recovery
> 
>  fs/f2fs/data.c     |  93 +++++++++++++++++++++++++-
>  fs/f2fs/f2fs.h     |  46 ++++++++++++-
>  fs/f2fs/file.c     |  85 +++++++++++++++++++++++-
>  fs/f2fs/inline.c   | 159 +++++++++++++++++++++++++++++++++++++++------
>  fs/f2fs/inode.c    |   6 ++
>  fs/f2fs/namei.c    |   3 +
>  fs/f2fs/node.c     |   6 +-
>  fs/f2fs/recovery.c |   9 ++-
>  fs/f2fs/super.c    |  25 +++++++
>  fs/f2fs/verity.c   |   4 ++
>  10 files changed, 409 insertions(+), 27 deletions(-)

This is disabled on encrypted files, right?

- Eric

