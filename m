Return-Path: <linux-kernel+bounces-250563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4409E92F914
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6762C1C22301
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70F415AADE;
	Fri, 12 Jul 2024 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LGPXQqTQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1256D512;
	Fri, 12 Jul 2024 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720780847; cv=none; b=ScT9f18NsXLLcaBt0Ex0kCB+AkK8QjnuxPb2D0+d2fubfmx9AuGDKCprOsrBMnupwnIMVTiSWEb4srEZWuZssENmtosEZpPXPcWUt6xVsOq17+olRyenmUOCnCRoPyGMl8D+pzA0Hdy8TpFS8qYX4qANHCvfeMU7dSFwe9eCwng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720780847; c=relaxed/simple;
	bh=BeQ5Tpqe7jOTh8LbBx54d3MCNITtjyrTsQPu6CZecoA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZNT65oAOXDeQINzk4yWSEKTngDn8ziLGm0TZhUZLUsvCoC/+rXAgP8gGcrtO9c+sJjXu1+mWEDveGdZ5iszIWDse0UwneXrCRMsLaY17pUN0ks1DkdjpfJ03mOb1kjuxXKITl7ROnQW6bZ247RiEohshzrcy/jiFL1KYREko/K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LGPXQqTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0289CC32786;
	Fri, 12 Jul 2024 10:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720780846;
	bh=BeQ5Tpqe7jOTh8LbBx54d3MCNITtjyrTsQPu6CZecoA=;
	h=Date:From:To:Cc:Subject:From;
	b=LGPXQqTQkciMOmCO5MbkCg837HDpVLbrPAceblmpJlhj7Fm0mnicU4lGq0QcuR7X0
	 h7Hqdrxckird5WFoLR/n7/KyMPSjHNe6v7kKItoeVw/fAQqMB8JhN2zmnqr8WWpxIK
	 wHxn8DxALVVVVGOCcScweWpCV7xVEzib1whLo7Jk=
Date: Fri, 12 Jul 2024 12:40:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.10-final
Message-ID: <ZpEIK6JklAx8aZ08@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 22a40d14b572deb80c0648557f4bd502d7e83826:

  Linux 6.10-rc6 (2024-06-30 14:40:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.10-final

for you to fetch changes up to 70c8e3944063a83b7fae1996db7971e9b858c635:

  Merge tag 'usb-serial-6.10-rc8' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2024-07-10 19:55:07 +0200)

----------------------------------------------------------------
USB fixes for 6.10-final

Here are some small USB driver fixes and new device ids for 6.10-final.
Included in here are:
  - new usb-serial device ids for reported devices
  - syzbot-triggered duplicate endpoint bugfix
  - gadget bugfix for configfs memory overwrite
  - xhci resume bugfix
  - new device quirk added
  - usb core error path bugfix

All of these have been in linux-next (most for a while) with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (1):
      USB: core: Fix duplicate endpoint bug by clearing reserved bits in the descriptor

Bjørn Mork (1):
      USB: serial: option: add Fibocom FM350-GL

Daniele Palmas (2):
      USB: serial: option: add Telit FN912 rmnet compositions
      USB: serial: option: add Telit generic core-dump composition

Dmitry Smirnov (1):
      USB: serial: mos7840: fix crash on resume

Greg Kroah-Hartman (2):
      Merge tag 'usb-serial-6.10-rc6' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus
      Merge tag 'usb-serial-6.10-rc8' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Heikki Krogerus (1):
      usb: dwc3: pci: add support for the Intel Panther Lake

Javier Carrasco (1):
      usb: core: add missing of_node_put() in usb_of_has_devices_or_graph

Lee Jones (1):
      usb: gadget: configfs: Prevent OOB read/write in usb_string_copy()

Mank Wang (1):
      USB: serial: option: add Netprisma LCUK54 series modules

Mathias Nyman (1):
      xhci: always resume roothubs if xHC was reset during resume

Slark Xiao (1):
      USB: serial: option: add support for Foxconn T99W651

Vanillan Wang (1):
      USB: serial: option: add Rolling RW350-GL variants

WangYuli (1):
      USB: Add USB_QUIRK_NO_SET_INTF quirk for START BP-850k

 drivers/usb/core/config.c     | 18 ++++++++++++++---
 drivers/usb/core/of.c         |  7 +++++--
 drivers/usb/core/quirks.c     |  3 +++
 drivers/usb/dwc3/dwc3-pci.c   |  8 ++++++++
 drivers/usb/gadget/configfs.c |  3 +++
 drivers/usb/host/xhci.c       | 16 ++++++++++++---
 drivers/usb/serial/mos7840.c  | 45 +++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/serial/option.c   | 38 ++++++++++++++++++++++++++++++++++++
 8 files changed, 130 insertions(+), 8 deletions(-)

