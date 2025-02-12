Return-Path: <linux-kernel+bounces-511382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEE2A32A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345071885CEA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55A7211A2F;
	Wed, 12 Feb 2025 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1FVotCr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421F421129F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374694; cv=none; b=kUG/bEgo+5TKFfcKX0plfIvUG7uuUnUDlUz2ChPCGO6rA6nU+lmLvvzScMKGl5+xpTwrTT0949u3J7DlWEputop8DXSBAcWWZrx7FYBwVKUBIiq7zy9oRaVBGYuhmrQqJC1GLQzPmqiYg/7cYtCxM50AqjMKgnd85Xf2h7vKYKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374694; c=relaxed/simple;
	bh=8bYTQmJU4eBoHYix/6DX2o11jJubMEIyv3kTTLUVaUA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aKR0yBrkuU+eWaRFpz2UKFVJuZ3fFr/rr3SfYtidsc3aXI9zrZijap8fv0m8auzqKu50Mnwg5Bl6iox03c6SK537Qa1Ytfb/c2k3DJVQ64wcP1RQFn7mufArltXXO9PsjUwC64oOXKHu4cx9KUeMSF/pwhU8r4KwL8M3wMtww/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1FVotCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7459BC4CEDF;
	Wed, 12 Feb 2025 15:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739374694;
	bh=8bYTQmJU4eBoHYix/6DX2o11jJubMEIyv3kTTLUVaUA=;
	h=Date:From:To:Cc:Subject:From;
	b=V1FVotCrcuKtuE4agxbuXkNaDJF1IdvYj5c3h4jJYQ3Tiuxyfb521mT5X4R0Cv7v2
	 0juU0aVoiD1v29pFMvfRHY45981ceLyW3/trmn++TjEQEC9XxdIj0DjvAuED/u02wl
	 I+wF55HyBBZAhCzatQCuQQ0t6QvpPkSMGjgXi6lP57284j7ebUwBQ/HgPsgxpEU8Ss
	 J76vTu/Y4j/bqTSu5voxDhSYFuDq3XDCm0CW3XVMfOZWFBzStWNngsGRlCBOKvsqXj
	 3wOIgWEX/t5TtVzA1o0T9Ju/6++CdTvX2aaKLJ5YKgUAbPDlfMAZ99KYiZPzA/A9CD
	 mtiluoFR9tKCw==
Date: Wed, 12 Feb 2025 15:38:10 +0000
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD fixes for v6.14
Message-ID: <20250212153810.GB2274105@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Good afternoon Linus,

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-fixes-6.14

for you to fetch changes up to 5728c92ae112301936006c5e305677beb1a7f578:

  mfd: syscon: Restore device_node_to_regmap() for non-syscon nodes (2025-02-11 14:53:39 +0000)

----------------------------------------------------------------
- Repair Syscon users not specifying the "syscon" compatible

----------------------------------------------------------------
Rob Herring (Arm) (1):
      mfd: syscon: Restore device_node_to_regmap() for non-syscon nodes

 drivers/mfd/syscon.c | 29 ++++++++++++++++++++++++++---

-- 
Lee Jones [李琼斯]

