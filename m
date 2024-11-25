Return-Path: <linux-kernel+bounces-421678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044F19D8E71
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 23:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD021689AB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 22:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792181CDFC1;
	Mon, 25 Nov 2024 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dEygpnwj"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE9A156F3A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 22:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732573220; cv=none; b=Xbr57Q8efk+9HECWVJDKOeGIUMgrOa6VuzQtuRqS3X0LjQnFckT/faeWjhjd4qNWIyd8tSNJO4UM+VxTj13Ds2NuH/agG8eZikZqO7gCi5aItpngfYZhQO9Bv3NN62yo7GOHO10xL1kPa916HTkHe6NVVEE3FDbqr7aax12f7l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732573220; c=relaxed/simple;
	bh=KpkNvWIPw49nwdfT8JAi/eOZnaP/ydrVXq/9nmh8Xnc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jj8xsaHaNn3DH6JmvJn/+gmw+/bINFu3MQEsbB6TuDLRZnNURkHHXwUujTHK4ejOKpJlDGoXtj+5ChhiWJB3qMcv0mTfL2yxZEPCyTid/x9zgltEl8sfmma75M5YzCEVOZQXRgUxaV0DRH2IisDtlZHE4p5QUQymszsoZRLcqpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dEygpnwj; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 95107240004;
	Mon, 25 Nov 2024 22:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732573209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=z/T6JIcs6kCMugL/OWzdZUfqiERU3nioemsHcX00saU=;
	b=dEygpnwjG6+IXZroahb25YZY8xFPBLauGRYEnGg9JjQj0Nh3QXkWtolZW2xObFXzQq65Ca
	yiRkj4EEfbZd1ABft4RCGPnJDtc+1aRzenoikOEzM5vauJKOlHfIii4Yn5sg1gAXAFrwh2
	+8AaGWg2Eb/RDhW+VmwxT2sq6GafNeJEQ0Gfr05aV8lLih/4xoA09w4pIA07omUbg3DaC4
	yFBVfsf5ikySLItVUTeHpIAS7JenlIScaqTNtO3x77BpygCRDO+R8xyyMdEMBjjPPoO/8o
	UGfuiZVA+xh0phPdOfLKcEEtXPH0kI9h7laAD2M5n9Y19IFn0l/WIPepm1zJSw==
Date: Mon, 25 Nov 2024 23:20:07 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] I3C changes for 6.13
Message-ID: <20241125222007aae382d8@mail.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GND-Sasl: alexandre.belloni@bootlin.com

Hello Linus,

Here is the i3c subsystem pull request for 6.13. We get support for
another I3C HCI controller used on AMD chips. We get more fixes for the
MIPI HCI and Silvaco drivers are they get more widespread testing.

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.13

for you to fetch changes up to 6cf7b65f7029914dc0cd7db86fac9ee5159008c6:

  i3c: Use i3cdev->desc->info instead of calling i3c_device_get_info() to avoid deadlock (2024-11-18 14:29:13 +0100)

----------------------------------------------------------------
I3C for 6.13

Core:
 - avoid possible deadlock on probe
 - ensured preferred address is used on hot-join

Drivers:
 - dw: add AMD I3C controller support
 - mipi-i3c-hci: fix SETDASA, DMA interrupts fixes
 - svc: many fixes for IBI and hotjoin

----------------------------------------------------------------
Alexandre Belloni (1):
      i3c: Document I3C_ADDR_SLOT_EXT_STATUS_MASK

Billy Tsai (1):
      i3c: mipi-i3c-hci: Support SETDASA CCC

Defa Li (1):
      i3c: Use i3cdev->desc->info instead of calling i3c_device_get_info() to avoid deadlock

Frank Li (12):
      i3c: master: Replace hard code 2 with macro I3C_ADDR_SLOT_STATUS_BITS
      i3c: master: Extend address status bit to 4 and add I3C_ADDR_SLOT_EXT_DESIRED
      i3c: master: Fix dynamic address leak when 'assigned-address' is present
      i3c: master: svc: use repeat start when IBI WIN happens
      i3c: master: svc: manually emit NACK/ACK for hotjoin
      i3c: master: svc: need check IBIWON for dynamic address assignment
      i3c: master: svc: use spin_lock_irqsave at svc_i3c_master_ibi_work()
      i3c: master: svc: wait for Manual ACK/NACK Done before next step
      i3c: master: svc: fix possible assignment of the same address to two devices
      i3c: master: Remove i3c_dev_disable_ibi_locked(olddev) on device hotjoin
      i3c: master: Fix miss free init_dyn_addr at i3c_master_put_i3c_addrs()
      i3c: master: svc: Modify enabled_events bit 7:0 to act as IBI enable counter

Jarkko Nikula (2):
      i3c: mipi-i3c-hci: Mask ring interrupts before ring stop request
      i3c: mipi-i3c-hci: Handle interrupts according to current specifications

Jinjie Ruan (1):
      i3c: master: svc: Fix pm_runtime_set_suspended() with runtime pm enabled

Shyam Sundar S K (2):
      i3c: dw: Add support for AMDI0015 ACPI ID
      i3c: dw: Add quirk to address OD/PP timing issue on AMD platform

 drivers/i3c/master.c                   | 100 +++++++++++++++++-------
 drivers/i3c/master/dw-i3c-master.c     |  34 +++++++++
 drivers/i3c/master/dw-i3c-master.h     |   1 +
 drivers/i3c/master/mipi-i3c-hci/core.c |  19 ++---
 drivers/i3c/master/mipi-i3c-hci/dma.c  |  10 +--
 drivers/i3c/master/mipi-i3c-hci/hci.h  |   2 +-
 drivers/i3c/master/mipi-i3c-hci/pio.c  |   2 +-
 drivers/i3c/master/svc-i3c-master.c    | 136 ++++++++++++++++++++++++---------
 include/linux/i3c/master.h             |  10 ++-
 9 files changed, 225 insertions(+), 89 deletions(-)

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

