Return-Path: <linux-kernel+bounces-337709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BA8984DE0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92DB6285910
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A9F1AD9F5;
	Tue, 24 Sep 2024 22:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+NmjY0u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786741AD9EC
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 22:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727217146; cv=none; b=TkIV2JVD6MCIGaNEvT/p3bPtXwMRDse0oYHzqAxJcby6Y56xb+ZBQ/3XVi0nl4mYZJYFxVs7KyUIHXqKQCFZV7IaeMeqCaPkmwX7phTZJW1GvnnuLbZz8OeZQexehTwAscuBH/BhJ1yL4uWJIRGKsOpuq+MMweoVMPeCQoNiy/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727217146; c=relaxed/simple;
	bh=sQR86oCKiMDDsem4O0SPT3D9Ha3uJ7V8VqCZtYG+N0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UUPTwWDAvOGS/Dh0CjE1eQeWflbJb5s7NoS2/9AGNNKL+QUlHXDaEgkGc3ZHHDWAXRIMFLHPGgdpTWQqm4XfemHquCjK+owRVgTeZ+OwojnfTvYbwGj8jcm5Vt6DDphTMToEdOqUfBSQozdd6SQMhAV+h0/aKL8FmKzUiWTQRn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+NmjY0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6F2C4CEC4;
	Tue, 24 Sep 2024 22:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727217146;
	bh=sQR86oCKiMDDsem4O0SPT3D9Ha3uJ7V8VqCZtYG+N0g=;
	h=From:To:Cc:Subject:Date:From;
	b=g+NmjY0ugsplXpnf1IgEgLzULtYXovQl+qDVPOUk/iWLSRJlFWr/Tuid3enBYiwXD
	 dLE4XN0xJnFRwpWV7kGerMOOxvQJebObDNG7WYCY5xwh5EqdquyuVUtnHAf96cejDS
	 0AYD3VGnAxkYNfzc4vSEvEjcExVZNwPNRc1d8i78gdWNd14BPFZr0Y7zN5fQDu5RCd
	 beXkffUIVn/nyn/Cahk85FlB01eb533QxaAaNlI5nVfTINkSZLsAe7D3w9gsZmWJYx
	 +QrvYJVv8xSlV0P5Y0oNQnCjSaGhtDUWm1bQJZ73dFV2p5yuF4tO7b5v06d0h8JmGL
	 bJg1JYcZ2j7gg==
From: Miguel Ojeda <ojeda@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] clang-format for 6.12
Date: Wed, 25 Sep 2024 00:32:10 +0200
Message-ID: <20240924223210.204379-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

A routine update for clang-format -- we did not have one for a while.

All the commits have been in -next for a month. No conflicts expected.

Please pull for v6.12 -- thanks!

Cheers,
Miguel

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/clang-format-6.12

for you to fetch changes up to c147f663b6a5813b9860f3917cc473fb2c462d8d:

  clang-format: Update with v6.11-rc1's `for_each` macro list (2024-08-02 13:20:31 +0200)

----------------------------------------------------------------
clang-format changes for v6.12

A routine update of the 'for_each' macro list.

----------------------------------------------------------------
Javier Carrasco (1):
      clang-format: Update with v6.11-rc1's `for_each` macro list

 .clang-format | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

