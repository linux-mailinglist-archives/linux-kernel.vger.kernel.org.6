Return-Path: <linux-kernel+bounces-292666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A54957288
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E351E1F22AEC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F7016CD0C;
	Mon, 19 Aug 2024 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnUvw4Gp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BA1146D6B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724090250; cv=none; b=BlD+yUprDE+oe6EbKClfHxVy2FLOLvG/ZbWYV1pSg9jPcXvlQKhmTgD4sD6yy7OTOrf9vVzB1sxpbuPqA7ymjL4QJPfBdk+Als7pYcNkHjzZkAv0xhsS8mV1PbFrmdelpDvK/dIww2+Wa23z+JzHEYGTXKGVy3ymfv6A0+AMEbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724090250; c=relaxed/simple;
	bh=uzgGxLCt6TJynDYTPsd6A2gdrm7HMgjeQpQukbtAVgE=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=TjMG1v8Cu3rSVD+SC70J3IKyESOXZu0kbCJJJXtbqnFF8hTIKs/Kb9IYT+cQ8KZM+ASGlWkthLHnBvy4Qr0VKACKY/qmn4pMED3paHiwDSV73K8lpmd4keIJzImNLYcskjPmXum2vmpfj45kk5m2i8A3vi/skl2d87YG4/ORS9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnUvw4Gp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D666C4AF0C;
	Mon, 19 Aug 2024 17:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724090249;
	bh=uzgGxLCt6TJynDYTPsd6A2gdrm7HMgjeQpQukbtAVgE=;
	h=Date:From:To:cc:Subject:From;
	b=FnUvw4GpZ3xPjhTY3/yFSwOriQCYERk05fjrummtgmk2p+iHydNj83F+iqlvJM/lB
	 3PjPL+sA25Gb9p7n/jK8xUtjWAuibNUKidqPX7/Ay/PgJcWjCb1T8jlev5Vx9Wmt0E
	 Lt4Rzge5X6Bum9cvX3xcZTzJCehZYHBkJd6Wj3zyj4Yus36tA0/ph9hfbmWP6O86ag
	 ul6tA9gbZ4wWIwSL4qemhYDoFFzT2T0TRWIu+bH7oRpjrHJl2UXV9DkhkQBAewAZrH
	 KWrxKxWgPkzj7Dqjn7WPrd0XJei7pORYU0id804RG9AxbJgpp2j4ox2IqJZSOnlWoc
	 KP5MJXvpO02Ow==
Date: Mon, 19 Aug 2024 19:57:27 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes for 6.11
Message-ID: <nycvar.YFH.7.76.2408191951550.12664@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024081901

to receive HID fixes for 6.11, namely:

=====
- memory corruption fixes for hid-cougar (Camila Alvarez) and hid-amd_sfh 
  (Olivier Sobrie)
- fix for regression in Wacom driver of twist gesture handling (Jason 
  Gerecke)
- two new device IDs for hid-multitouch (Dmitry Savin) and hid-asus (Luke 
  D. Jones)
=====

Thanks.

----------------------------------------------------------------
Camila Alvarez (1):
      HID: cougar: fix slab-out-of-bounds Read in cougar_report_fixup

Dmitry Savin (1):
      HID: multitouch: Add support for GT7868Q

Jason Gerecke (1):
      HID: wacom: Defer calculation of resolution until resolution_code is known

Luke D. Jones (1):
      hid-asus: add ROG Ally X prod ID to quirk list

Olivier Sobrie (1):
      HID: amd_sfh: free driver_data after destroying hid device

 drivers/hid/amd-sfh-hid/amd_sfh_hid.c |  4 +++-
 drivers/hid/hid-asus.c                |  3 +++
 drivers/hid/hid-cougar.c              |  2 +-
 drivers/hid/hid-ids.h                 |  3 +++
 drivers/hid/hid-multitouch.c          | 33 +++++++++++++++++++++++++++++++++
 drivers/hid/wacom_wac.c               |  4 +++-
 6 files changed, 46 insertions(+), 3 deletions(-)

-- 
Jiri Kosina
SUSE Labs


