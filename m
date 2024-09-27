Return-Path: <linux-kernel+bounces-341394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D29987F70
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20E91C20B1C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 07:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C74D18800E;
	Fri, 27 Sep 2024 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NU6bNFyK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BDB165EF1
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 07:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727422204; cv=none; b=uboliGM3195TSSjluWfQa/HuB2II/+lBN2FNkBgOkhoJrzO6vKZYruMZ8tfrr7fH2P6LRC+AsQzOkFpDGnvZ13fKLx7LYRqTAxGA3HGZwpCVjoE/HIdQtgm0WZRbaumnstbE731ZDTDJFBn1tgx7LmrVfPAjLmtiY+WnXqUq0x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727422204; c=relaxed/simple;
	bh=75P1+FkwfrhA+nc+gMZONlm4DJ+b9tTbwaEl7CaM2lY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BkJM3QgT90T4O0bYEknppcMaqy/77XPVf4m5t0dsJTLuiDOXFfUrAXtNOwBXjOCginVXEL2fRYR1xnlllxDke67eOV6BrI3aKLEWFV+YSl8dbmH5Kn3feQNdFdhso4dDrNqFo9JlHXH/1tTDQNLa8ZM4ecKj7wtMnxb1O99TEcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NU6bNFyK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A48C4CEC4;
	Fri, 27 Sep 2024 07:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727422204;
	bh=75P1+FkwfrhA+nc+gMZONlm4DJ+b9tTbwaEl7CaM2lY=;
	h=Date:From:To:Cc:Subject:From;
	b=NU6bNFyKNJI927X38EjR1ERVurW8b3+bSGgZTc1XLlJDpvsxLvK87mnKm9UlqCvJc
	 6sqJ3FzeLyUU2z++ohRVfuTcC7WBjYs7KqXEbxFOSCqx3MwtjAc4tf3DhVOhyhNi4+
	 4sCxpOWVmMQr2C8mNYcE0fmvd1Q+yAPzLalI9L0Q=
Date: Fri, 27 Sep 2024 09:29:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core changes for 6.12-rc1
Message-ID: <ZvZe76mpNqBp18Ts@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.12-rc1

for you to fetch changes up to eb46cb321f1f3f3102f4ad3d61dd5c8c06cdbf17:

  Revert "driver core: don't always lock parent in shutdown" (2024-09-25 11:01:34 +0200)

----------------------------------------------------------------
Driver core update for 6.12-rc1

Here is a small set of patches for the driver core code for 6.12-rc1.

This set is the one that caused the most delay on my side, due to lots
of last-minute reports of problems in the async shutdown feature that
was added.  In the end, I've reverted all of the patches in that series
so we are back to "normal" and the patch set is being reworked for the
next merge window.

Other than the async shutdown patches that were reverted, included in
here are:
  - minor driver core cleanups
  - minor driver core bus and class api cleanups and simplifications for
    some callbacks
  - some const markings of structures
  - other even more minor cleanups

All of these, including the last minute reverts, have been in
linux-next, but all of the reports of problems in linux-next were before
the reverts happened.  After the reverts, all is good.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (5):
      driver core: Sort headers
      driver core: Use kasprintf() instead of fixed buffer formatting
      driver core: Use guards for simple mutex locks
      driver core: Make use of returned value of dev_err_probe()
      driver core: Use 2-argument strscpy()

Dr. David Alan Gilbert (1):
      driver core: attribute_container: Remove unused functions

Greg Kroah-Hartman (7):
      Merge 6.11-rc3 into driver-core-next
      Merge 6.11-rc4 into driver-core-next
      Revert "driver core: fix async device shutdown hang"
      Revert "nvme-pci: Make driver prefer asynchronous shutdown"
      Revert "driver core: shut down devices asynchronously"
      Revert "driver core: separate function to shutdown one device"
      Revert "driver core: don't always lock parent in shutdown"

Jann Horn (1):
      firmware_loader: Block path traversal

Jinjie Ruan (1):
      driver core: Fix a potential null-ptr-deref in module_add_driver()

Kunwu Chan (2):
      platform: Make platform_bus_type constant
      bus: fsl-mc: make fsl_mc_bus_type const

Stuart Hayes (5):
      driver core: don't always lock parent in shutdown
      driver core: separate function to shutdown one device
      driver core: shut down devices asynchronously
      nvme-pci: Make driver prefer asynchronous shutdown
      driver core: fix async device shutdown hang

Uros Bizjak (1):
      devres: Correclty strip percpu address space of devm_free_percpu() argument

Yuesong Li (1):
      driver:base:core: Adding a "Return:" line in comment for device_link_add()

Zijun Hu (10):
      driver core: Fix size calculation of symlink name for devlink_(add|remove)_symlinks()
      driver core: Fix error handling in driver API device_rename()
      driver core: bus: Return -EIO instead of 0 when show/store invalid bus attribute
      driver core: Remove unused parameter for virtual_device_parent()
      driver core: bus: Add simple error handling for buses_init()
      driver core: bus: Fix double free in driver API bus_register()
      drivers/base: Introduce device_match_t for device finding APIs
      driver core: class: Check namespace relevant parameters in class_register()
      driver core: Make parameter check consistent for API cluster device_(for_each|find)_child()
      driver core: Trivially simplify ((struct device_private *)curr)->device->p to @curr

 drivers/base/attribute_container.c  |  48 +----------
 drivers/base/auxiliary.c            |   2 +-
 drivers/base/base.h                 |   2 +-
 drivers/base/bus.c                  |  19 ++--
 drivers/base/class.c                |  14 ++-
 drivers/base/core.c                 | 168 ++++++++++++++++++------------------
 drivers/base/dd.c                   |   2 +-
 drivers/base/devres.c               |   2 +-
 drivers/base/driver.c               |   2 +-
 drivers/base/firmware_loader/main.c |  30 +++++++
 drivers/base/module.c               |  14 +--
 drivers/base/platform.c             |   2 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c     |   2 +-
 include/linux/attribute_container.h |   6 --
 include/linux/auxiliary_bus.h       |   2 +-
 include/linux/device/bus.h          |   6 +-
 include/linux/device/class.h        |   2 +-
 include/linux/device/driver.h       |   2 +-
 include/linux/fsl/mc.h              |   2 +-
 include/linux/platform_device.h     |   2 +-
 20 files changed, 165 insertions(+), 164 deletions(-)

