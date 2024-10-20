Return-Path: <linux-kernel+bounces-373256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F9A9A545D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 15:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5C42B211D0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA996192B79;
	Sun, 20 Oct 2024 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BvOUCCkP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03170B674;
	Sun, 20 Oct 2024 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729431420; cv=none; b=pmhM0n/r01Agx95zC97rW8RYDpL+LoI0jWd9WlG9YunYUy6OeidieCQpjQqzjggp675lDy6rS74BSEeVQktAuXpBOCGEgX2vYMXbkHa323wL8Wi/WcILTH0P89DSYP3krzDBJUIj+uNqOb7OC9Fj1zjblN6es2EKvl0E6zFbDWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729431420; c=relaxed/simple;
	bh=eU3MmXCBLWtKtdd7ohkchgxxz4Ne2wwiApnaTpyBHLU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uCGZHb8glgvmA1hYK52W5t9Sl4g+QwH4zVQHknPsRHsM+zRtENMQ1iQnHf7RkNPoNLHwFGmQdUXJt6LNoFD0GV2yLI+BT6qJIXPxmw6fBnnve2scvZ9+Mc+Wp2vUaS4ZT3/vytyefPtEqkidq5vePFy0nADnjj7SvCEEgeW4B8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BvOUCCkP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3286FC4CEC6;
	Sun, 20 Oct 2024 13:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729431419;
	bh=eU3MmXCBLWtKtdd7ohkchgxxz4Ne2wwiApnaTpyBHLU=;
	h=Date:From:To:Cc:Subject:From;
	b=BvOUCCkPRRCiMFs5wIAyIlhlrAKYJXalJUAqtDQGnylduocOnhhOewIUGaDCsxzXH
	 /whgqXi9OeYp4P6abk0GKkEYa2vraieLC1n3e3MjVp5qvcVgvha8YV45w9gkPKcgZV
	 HYQ7J0qykukqwuucXxxrH8Ho9PlJJbZ4/xJiV6ss=
Date: Sun, 20 Oct 2024 15:36:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB fixes for 6.12-rc4
Message-ID: <ZxUHeLHqcv55AzHa@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 8e929cb546ee42c9a61d24fae60605e9e3192354:

  Linux 6.12-rc3 (2024-10-13 14:33:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.12-rc4

for you to fetch changes up to 1154a599214c655c8138b540f13845257f1952fd:

  Merge tag 'usb-serial-6.12-rc4' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2024-10-18 12:11:28 +0200)

----------------------------------------------------------------
USB driver fixes for 6.12-rc4

Here are some small USB driver fixes and new device ids for 6.12-rc4.
Included in here are:
  - xhci driver fixes for a number of reported issues
  - new usb-serial driver ids
  - dwc3 driver fixes for reported problems.
  - usb gadget driver fixes for reported problems
  - typec driver fixes
  - MAINTAINER file updates

All of these have been in linux-next this week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (1):
      USB: gadget: dummy-hcd: Fix "task hung" problem

Andrey Konovalov (1):
      MAINTAINERS: usb: raw-gadget: add bug tracker link

Benjamin B. Frost (1):
      USB: serial: option: add support for Quectel EG916Q-GL

Daniele Palmas (1):
      USB: serial: option: add Telit FN920C04 MBIM compositions

Greg Kroah-Hartman (1):
      Merge tag 'usb-serial-6.12-rc4' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Henry Lin (1):
      xhci: tegra: fix checked USB2 port number

Jonathan Marek (1):
      usb: typec: qcom-pmic-typec: fix sink status being overwritten with RP_DEF

Kevin Groeneveld (1):
      usb: gadget: f_uac2: fix return value for UAC2_ATTRIBUTE_STRING store

Mathias Nyman (3):
      xhci: Fix incorrect stream context type macro
      xhci: Mitigate failed set dequeue pointer commands
      xhci: dbc: honor usb transfer size boundaries.

Michal Pecio (1):
      usb: xhci: Fix handling errors mid TD followed by other errors

Prashanth K (1):
      usb: dwc3: Wait for EndXfer completion before restoring GUSB2PHYCFG

Roger Quadros (1):
      usb: dwc3: core: Fix system suspend on TI AM62 platforms

Sakari Ailus (1):
      MAINTAINERS: Add an entry for the LJCA drivers

Thadeu Lima de Souza Cascardo (1):
      usb: typec: altmode should keep reference to parent

 MAINTAINERS                                        | 11 ++++
 drivers/usb/dwc3/core.c                            | 19 ++++++
 drivers/usb/dwc3/core.h                            |  3 +
 drivers/usb/dwc3/gadget.c                          | 10 ++--
 drivers/usb/gadget/function/f_uac2.c               |  6 +-
 drivers/usb/gadget/udc/dummy_hcd.c                 | 20 +++++--
 drivers/usb/host/xhci-dbgcap.h                     |  1 +
 drivers/usb/host/xhci-dbgtty.c                     | 55 +++++++++++++++--
 drivers/usb/host/xhci-ring.c                       | 68 ++++++++++------------
 drivers/usb/host/xhci-tegra.c                      |  2 +-
 drivers/usb/host/xhci.h                            |  2 +-
 drivers/usb/serial/option.c                        |  8 +++
 drivers/usb/typec/class.c                          |  3 +
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c |  1 -
 14 files changed, 151 insertions(+), 58 deletions(-)

