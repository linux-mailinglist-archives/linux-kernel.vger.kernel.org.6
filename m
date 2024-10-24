Return-Path: <linux-kernel+bounces-380689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA5A9AF495
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B5F0B2112F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01441AF0BB;
	Thu, 24 Oct 2024 21:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiZuyVTr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7E31A0BEE
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 21:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804701; cv=none; b=j43DtmZkNZfX1CmJ3uIGWHY+UD7JlySt1/938Mzut6vrL0o5r5gZZmJpbPUnGW95KhP2B99dJETDwFaVpr6GuzhxFnNOF93wl6DuvYhaMmX01gVBAyMQ8JpgLvROe8p8lYtbjTXbkLJIbySxEv10auElP8KQvMtA7R4CtcMrRIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804701; c=relaxed/simple;
	bh=esxodwYqIk5VnVairndrbcO99U0DwgH7WyMRKBU9U/Y=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=VrgL2bfjr5BtU9fw1f8JV3CAs5rqlmSj8GOhvRkzE/3uXOT9L+FsCiotudyDfQ2B2T4t/mzvilclLV2rXD1Gfk9ysc2PYyT029rayKGgCzFjY7dbvxmYvntWJ0JDLyZOiLnwq3bcUDm0WU0Q2gzUj+55m8tH4o6LPOK0o3ANGUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiZuyVTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59552C4CEC7;
	Thu, 24 Oct 2024 21:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729804697;
	bh=esxodwYqIk5VnVairndrbcO99U0DwgH7WyMRKBU9U/Y=;
	h=Date:From:To:cc:Subject:From;
	b=XiZuyVTrghY91CNgE6kdgT91KFG3aL6YuEWc+qzEK7zwPCs3R4FWz152Zw2vVewEG
	 aLm/l4t4Rr5PE5Loqfuww+E7M/W7JSc9w4MrQDYg9RIyFkAOW7Jwg/k4OvqnQ4Gaq2
	 1sjufTJMKDnxHwHgusvQMP31EDCgQuxt0v3wI39Pxzbjbp2QsJV7jYtuVqN5ECXReJ
	 vN10qDXdrm1ONTF6VWVYHjxoS8oZUflKBMDiwELhjG1IzWWl9nuxty4aBwC+3XmwmV
	 45zeVT/fKdTQUtIRxLLJNUO2Dvbg4X25ry/1/Ecevom4CAUB6VmRU5ApOjNQa7hOA3
	 o5eVX7BwKCMHA==
Date: Thu, 24 Oct 2024 23:18:15 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Subject: [GIT PULL] HID fixes for 6.12
Message-ID: <nycvar.YFH.7.76.2410242314380.20286@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

Linus,

please _*ignore the trolls*_, and then pull from=20

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-li=
nus-20241024

to receive HID subsystem fixes:

=3D=3D=3D=3D=3D
- device-specific functionality quirks for Thinkpad X1 Gen3, Logitech Bolt=
=20
  and some Goodix touchpads (Bart=B3omiej Mary=F1czak, Hans de Goede and=20
  Kenneth Albanowski
=3D=3D=3D=3D=3D

----------------------------------------------------------------
Bart=B3omiej Mary=F1czak (1):
      HID: i2c-hid: Delayed i2c resume wakeup for 0x0d42 Goodix touchpad

Hans de Goede (1):
      HID: lenovo: Add support for Thinkpad X1 Tablet Gen 3 keyboard

Kenneth Albanowski (1):
      HID: multitouch: Add quirk for Logitech Bolt receiver w/ Casa touchpa=
d

 drivers/hid/hid-ids.h              |  2 ++
 drivers/hid/hid-lenovo.c           |  8 ++++++++
 drivers/hid/hid-multitouch.c       |  4 ++++
 drivers/hid/i2c-hid/i2c-hid-core.c | 10 ++++++++++
 4 files changed, 24 insertions(+)

--=20
Jiri Kosina
SUSE Labs


