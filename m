Return-Path: <linux-kernel+bounces-187417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991218CD182
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7491C21AD0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3167313BC0A;
	Thu, 23 May 2024 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWKOsFVD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781261D6AA
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 11:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716464917; cv=none; b=KK8bA8Qb2b2aUaeEW+kFUM6Wg5Cqw7EdmfMcQ+25doYPvG9wlOwf0u6etLcLu10mN06jxE0H1VOHVhaOUZdQAQ9II0LFYBsYxppT22sE1Sbk9SgB3fSF0ZKJG3GB7hCoKnPPBZkCbcfh+luKaWPvTq9SDs1F8YlYdgyjsRnQTYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716464917; c=relaxed/simple;
	bh=9RfAy/uwi35SvVSDtdvgzu2Xj2egb9k/oBLfQ8zseAI=;
	h=Message-ID:From:To:Cc:Subject:Date; b=sf08CwGa9FGdO6bJL28OMo8UDpbHdWLsZWam2lJU5zshVuRd5b7WzEsRM91nBiBhgyREL/se0/MDyyFEKTRkSwDg0U7p4+/RqYBqKpL9Kbbo7lohsYkH9TUdB8Qyi2xbG5oIfrqSs79lXiYX7EKprLNs2G+EqZ+TDW7dZTIjmBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWKOsFVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D699DC2BD10;
	Thu, 23 May 2024 11:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716464917;
	bh=9RfAy/uwi35SvVSDtdvgzu2Xj2egb9k/oBLfQ8zseAI=;
	h=From:To:Cc:Subject:Date:From;
	b=BWKOsFVDu4Fhe9gWSCkQqYxjGZFwtj3hOzLkfftc8NZkGs4EMesmbUZpE4+N4Yr9k
	 mytardbkCqXfXfwegI8292b7EtsM4NoestPaLXMW1phuV4HeZTnLK+UiOfHcE4rxeq
	 f2T9CKjDp7i+9Tqjd3Dnxw6hGG2W6mH9U98Gwsvxm8wsHz8yuMZMbhCqrWWfbjYylN
	 bn1hchHaCNTBcWY0q+GEXmi/hRSsJ3cCzCOW8iD246+o9EemkogfdJLkA9gxRKKv24
	 rXrBp0I5c8Ft9ujilimXC7Ckm6kkeTHy457Ze7wjma5O2hey58BOSkVkXUnuMW2sb/
	 jAM4lmZHEJQhA==
Message-ID: <e6c886a96dc7945fa3a03d37d73a9392.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v6.10-merge-window
Date: Thu, 23 May 2024 12:48:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 4e70b26c873dfff317039458a6ea66314bbdce99:

  regulator: sun20i: Add Allwinner D1 LDOs driver (2024-05-09 17:44:01 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v6.10-merge-window

for you to fetch changes up to 74b38cd77d3eb63c6d0ad9cf2ae59812ae54d3ee:

  regulator: tps6594-regulator: Correct multi-phase configuration (2024-05-21 12:27:36 +0100)

----------------------------------------------------------------
regulator: Fixes for v6.10

A bunch of fixes that came in during the merge window, Matti found
several issues with some of the more complexly configured Rohm
regulators and the helpers they use and there were some errors in the
specification of tps6594 when regulators are grouped together.

----------------------------------------------------------------
Matti Vaittinen (4):
      regulator: bd71828: Don't overwrite runtime voltages
      regulator: rohm-regulator: warn if unsupported voltage is set
      regulator: pickable ranges: don't always cache vsel
      regulator: tps6287x: Force writing VSEL bit

Neha Malcom Francis (1):
      regulator: tps6594-regulator: Correct multi-phase configuration

 drivers/regulator/bd71828-regulator.c  | 58 ++--------------------------------
 drivers/regulator/helpers.c            | 43 +++++++++++++++++--------
 drivers/regulator/rohm-regulator.c     |  4 +++
 drivers/regulator/tps6287x-regulator.c |  1 +
 drivers/regulator/tps6594-regulator.c  | 16 +++++-----
 include/linux/regulator/driver.h       |  3 ++
 6 files changed, 48 insertions(+), 77 deletions(-)

