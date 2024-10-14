Return-Path: <linux-kernel+bounces-364465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E315099D4FB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29D51C226C4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484101AF4F6;
	Mon, 14 Oct 2024 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDxIQvYk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0905198A1B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728924703; cv=none; b=H3ygL+5pkEsYPW9q4cMo6VPv615U9TwUm5cveFLcWJ8d3Z5c5vOy1r84h3Wi2h2HWk4ZveuPLi0oruXAdh7e1z6iFnvbPls8P47PhDVYZZk1toyB5w5WIvmOwwxUJIx53F9Ffo0Ec2CiCQsbIQsp2qiB7hROMs6GofDxT4TvQzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728924703; c=relaxed/simple;
	bh=xSiLdWCKW0d4kOhTcAew6y0uEJ0fLcClKUQ6HGQMe7s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F2VGTd6Cs+3uOGgQO6URaqiQVPtaJpmPi63WkvWkvh0lMqduWJnYYCEF/Hkhv2htziTjt+ZR56D6zKLN3Mf91/BC9otuA9tfC09/kYPz+nh3DvMomqBUgBuxtJxAkF49kfvK3DQCQIl19wAMjMzAWxsAd5/6RIYU4tdPeKB2BPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDxIQvYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9BCC4CEC3;
	Mon, 14 Oct 2024 16:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728924703;
	bh=xSiLdWCKW0d4kOhTcAew6y0uEJ0fLcClKUQ6HGQMe7s=;
	h=Date:From:To:Cc:Subject:From;
	b=CDxIQvYkzps2tEUA1nid3QnaaScefKoVsxxJ/YsVq2hJw/Tm8jEvmgFq4DLcghoib
	 UDO/d0S4UNBUGlje6uldHURjTnWlwEIhjy7v5QrAdTZyJje1Fkzof1xe8vcR+u/APY
	 gMhg/dDM+jytA2ZIJeyh3Jww9h68fUWGLJm7BCwey1C2Ut6ycKBH3BYH7Fm9n+lXvR
	 4lGGpqUMxbGJd0AoQIvEfZFiGSgXlxwLTbLn5CthzykzH2brR6CypieYyNT6s27/Z5
	 bfSctjGEBQMajfb6hPrFIcSaqE33Zbyv0jXGN2hEUqgcQoCEn47PXyflXogDEiO8hx
	 LooI8mqA6TMmw==
Date: Mon, 14 Oct 2024 16:51:41 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] f2fs fix for 6.12-rc4
Message-ID: <Zw1MHWwr3fRgJpLr@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Could you please consider applying this patch in f2fs?

Thanks,

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-6.12-rc4

for you to fetch changes up to 332fade75d0ecd88cd19556fce0f9cc8322de434:

  f2fs: allow parallel DIO reads (2024-10-11 15:12:07 +0000)

----------------------------------------------------------------
f2fs fix for 6.12-rc4

This includes an urgent fix to resolve DIO read performance regression caused by
0cac51185e65 ("f2fs: fix to avoid racing in between read and OPU dio write").

----------------------------------------------------------------
Jaegeuk Kim (1):
      f2fs: allow parallel DIO reads

 fs/f2fs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

