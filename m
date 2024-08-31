Return-Path: <linux-kernel+bounces-309996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0CB9672DD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 19:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56BCE28246C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 17:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFB913CFBC;
	Sat, 31 Aug 2024 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ru1e95e+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB33658210;
	Sat, 31 Aug 2024 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725126036; cv=none; b=ur+5UovBJN1ehcb59rPflwmbPEYKOAKoUQPKm3esROLPsw8cERAu3oBQNZ5/6/2cjhJ0yMCfRndDyy4kBbBFcWRk7tqpXBB62PqpVong/EvhIdLanQRKCzCEuZUynr6VDlzLUAfYQaAh4P7Nqj90kQ4Fm09nUlocQg4kdlX/cnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725126036; c=relaxed/simple;
	bh=ORjGi1B5GDaQ1sDMRdEoxtlFCpvT84o6WBVy+2WSyQI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fgjYpgEa6qiAgpuVqBg0dvjD3bxft0/e2zLx17ItbFHYTGnIeVIzUYNAmNeJaWxF8KUYGBYI+RxYCB9HfAzAqMuKKMPzyojj0ycFFPreSl0zJTV0766Kdh9/PEshog7IZgG89nuEd8jvIiV+9DRfK/D66U0SkeItZact9EhlQzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ru1e95e+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4AB5C4CEC0;
	Sat, 31 Aug 2024 17:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725126036;
	bh=ORjGi1B5GDaQ1sDMRdEoxtlFCpvT84o6WBVy+2WSyQI=;
	h=Date:From:To:Cc:Subject:From;
	b=ru1e95e+VWn2TyQ/mOkG6rpnFiRAyiSb9p8FrcX/Vy7mqhwcqqcL1qADZxkKukrIu
	 kltxpuMcP4u60l4YGJq8kFhVq4qhl8lhc/NMcoidunYTgPNj0Buy94mgJVE4fzuBw/
	 2Py67eH0mXy9pJktVE1GSZZDxvjQud6gbWPb2vpI=
Date: Sat, 31 Aug 2024 19:40:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB / Thunderbolt driver fixes for 6.11-rc4
Message-ID: <ZtNVkRAgDKh7q0Nn@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.11-rc6

for you to fetch changes up to 58c2fa54257d640c83137b44e12c174fd660a485:

  Merge tag 'usb-serial-6.11-rc6' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2024-08-30 15:41:18 +0200)

----------------------------------------------------------------
USB fixes for 6.11-rc6

Here are some small USB fixes for 6.11-rc6.  Included in here are:
  - dwc3 driver fixes for reported issues
  - MAINTAINER file update, marking a driver as unsupported :(
  - cdnsp driver fixes
  - USB gadget driver fix
  - USB sysfs fix
  - other tiny fixes
  - new device ids for usb serial driver

All of these have been in linux-next this week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Stein (1):
      dt-bindings: usb: microchip,usb2514: Fix reference USB device schema

Greg Kroah-Hartman (1):
      Merge tag 'usb-serial-6.11-rc6' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Ian Ray (1):
      cdc-acm: Add DISABLE_ECHO quirk for GE HealthCare UI Controller

Krzysztof Kozlowski (4):
      usb: dwc3: omap: add missing depopulate in probe error path
      usb: dwc3: xilinx: add missing depopulate in probe error path
      usb: dwc3: st: fix probed platform device ref count on probe error path
      usb: dwc3: st: add missing depopulate in probe error path

Laurent Pinchart (1):
      MAINTAINERS: Mark UVC gadget driver as orphan

Luca Weiss (1):
      usb: typec: fsa4480: Relax CHIP_ID check

Michael Grzeschik (1):
      usb: dwc3: ep0: Don't reset resource alloc flag (including ep0)

Pawel Laszczak (2):
      usb: cdnsp: fix incorrect index in cdnsp_get_hw_deq function
      usb: cdnsp: fix for Link TRB with TC

Selvarasu Ganesan (1):
      usb: dwc3: core: Prevent USB core invalid event buffer address access

Xu Yang (1):
      usb: gadget: uvc: queue pump work in uvcg_video_enable()

ZHANG Yuntian (1):
      USB: serial: option: add MeiG Smart SRM825L

Zijun Hu (1):
      usb: core: sysfs: Unmerge @usb3_hardware_lpm_attr_group in remove_power_attributes()

 .../devicetree/bindings/usb/microchip,usb2514.yaml |  9 ++++++-
 MAINTAINERS                                        |  4 +--
 drivers/usb/cdns3/cdnsp-gadget.h                   |  3 +++
 drivers/usb/cdns3/cdnsp-ring.c                     | 30 +++++++++++++++++++++-
 drivers/usb/class/cdc-acm.c                        |  3 +++
 drivers/usb/core/sysfs.c                           |  1 +
 drivers/usb/dwc3/core.c                            |  8 ++++++
 drivers/usb/dwc3/dwc3-omap.c                       |  4 ++-
 drivers/usb/dwc3/dwc3-st.c                         | 16 +++++-------
 drivers/usb/dwc3/dwc3-xilinx.c                     |  7 ++++-
 drivers/usb/dwc3/ep0.c                             |  3 ++-
 drivers/usb/gadget/function/uvc_video.c            |  1 +
 drivers/usb/serial/option.c                        |  5 ++++
 drivers/usb/typec/mux/fsa4480.c                    |  2 +-
 14 files changed, 78 insertions(+), 18 deletions(-)

