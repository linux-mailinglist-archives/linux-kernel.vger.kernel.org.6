Return-Path: <linux-kernel+bounces-551911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CD6A572DB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6417B17337F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13E02417D4;
	Fri,  7 Mar 2025 20:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kw+BkJku"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADE4183CB0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 20:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741378715; cv=none; b=IHEwAQq8xujc4ZBIVbkXS0GypztdPocUpsLc2gVdKOVAXlQ5YXVoECHdlJ2rdDwlJg1fsuuYdZBrArEoO3TETcUKWVEAM7xILO/alt0868atyNaaWVNwaHvjX85qP6oLe9HYu5fW7pPlnxGPu8OarZP8lHfgHI/x76V/5vM5IXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741378715; c=relaxed/simple;
	bh=Aax7p2XzmYWqG8ZGaFbdp5iCfKtBndPvlo82/Qc6fnc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NkM7jx39x9WzInxXLyXAnNI569w/i+R+QWOXrNWwxG7SG+c35D8tNRUtqwyyxuaHDCsZEpMWqgL10721cIsjEuEFazBKHc2hVCk1Vz0sJQN1BFnocrqsimJR02rNKf9DIi/fZlF6ZmYHpNGM+5l23x6simYBGSNtGS2GGE6GTGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kw+BkJku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7906C4CED1;
	Fri,  7 Mar 2025 20:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741378714;
	bh=Aax7p2XzmYWqG8ZGaFbdp5iCfKtBndPvlo82/Qc6fnc=;
	h=Date:From:To:Cc:Subject:From;
	b=Kw+BkJkuNo2IP7E+RbzqEqul/EQ0GgTNUwEpn1FMWpfWU0CXlr7Xu/EqVffmTg4lc
	 Nw3UwqPSE5bYqv3kQ1z9AkgqdPuMh1TEaLfYz19LKi+BLdjUCTc/gAY1NawB0nzC26
	 610/GZUzzD702xhjqrJKey/HrpobSILt+2t2MzPXoOd9LRrC2idNFz4Mcx81duzAAq
	 zBQMkz6EAjCdQRkjmRD+B52lEABSphPzF/qA+lIRRQ4PdOflRyRqBCaQ6c+LZzeHi8
	 TjDSYsuFdyNW/QwuOezKFHiJI65WYPbS1UUd0ljFzH8uBgaPTl79loG1hVG6rRsG7f
	 hgBrAgoO6SBgQ==
Date: Fri, 7 Mar 2025 12:18:31 -0800
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
	Michael Stapelberg <michael@stapelberg.ch>
Subject: [GIT PULL] execve fix for v6.14-rc6
Message-ID: <202503071218.21B5CA1@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull this execve fix for v6.14-rc6.

Thanks!

-Kees

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.14-rc6

for you to fetch changes up to 39ec9eaaa165d297d008d1fa385748430bd18e4d:

  coredump: Only sort VMAs when core_sort_vma sysctl is set (2025-02-24 10:51:57 -0800)

----------------------------------------------------------------
execve fix for v6.14-rc6

- coredump: Only sort VMAs when core_sort_vma sysctl is set

----------------------------------------------------------------
Kees Cook (1):
      coredump: Only sort VMAs when core_sort_vma sysctl is set

 Documentation/admin-guide/sysctl/kernel.rst | 11 +++++++++++
 fs/coredump.c                               | 15 +++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

-- 
Kees Cook

