Return-Path: <linux-kernel+bounces-263247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E530793D32C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155D51C22F33
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C3817C21C;
	Fri, 26 Jul 2024 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VhkCY6le"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786CA17C219
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721997569; cv=none; b=V+jk9nZNNl+PXdPT8V0G0LZB/FFvz99iloFJt3u5sJGd0Yde7HkvrQ9UVS3bES2AzlYesfFf02sv6NfdDMbPIxvtd61Q/1K7A9jxJURFN2aDHQsl6CRIOg1W59nCDPH7nMK+Fg2Z3dc/vXWfhAlZwT5XamkNSJT9lYkzC0GRdfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721997569; c=relaxed/simple;
	bh=WPI1rFqZH5PARX4YG9zes9VyJKXlV+4tAZd8jesoKmE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r9lqZsQhlTowZHsbCog0koH/DBV8BEghL1QGCnrNemY31/wOwGUxwIxqRSe9DTj4b6yMwmlYAkgX79AtQbEUB/orCz7gkI69w9y3IxigAz4EeBx2wkgx3S3ZDjQ+313doK7n22aMrwBLon/UUYQMzqS9g2m/RRtUKODfz9UDP+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VhkCY6le; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 43D29FF807;
	Fri, 26 Jul 2024 12:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721997564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=SLfP/QyZ752p6HUH/YkDyZyK8Oli7bXcnIr/09d8Rv8=;
	b=VhkCY6leCvbvNB2v72ZbhCuL76fp6G4yJ8OP6auTQtq4MxlIXezhCvT0IO1nctFkIG52n0
	LBli53/gXIqQDwaczvAeKg8Y/GiB1uK6aRsmmiDDuyQ0m+C2DfmuvJhfmQM5RDBcnkwma5
	5/nxFvwVvQ3Vioq6Cjl9AJkehQRVufHDwZPzLfWm/BYZkGtGo/3ki0kF7faovlAv5555Hi
	S4THXyjJkjJmH8ayiCod0LMurIo5fGg+UtDZ5mwhtDZjcqfMsibLQpG7t4T2zWpNWIFrT4
	A8tFUEzmwrWjV1UbbYgYYFR+ECB1oqDZN1l2s2WWN3n7kn5uUL+W4N/y+TUa/A==
Date: Fri, 26 Jul 2024 14:39:24 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] I3C changes for 6.11
Message-ID: <20240726123924fec081e4@mail.local>
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

Here is the i3c subsystem pull request for 6.11. This cycle, there are
new features for the Designware controller and fixes for the other IPs.

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.11

for you to fetch changes up to 24168c5e6dfbdd5b414f048f47f75d64533296ca:

  dt-bindings: i3c: add header for generic I3C flags (2024-07-26 14:21:30 +0200)

----------------------------------------------------------------
I3C for 6.11

Drivers:
 - dw: optional apb clock and power management support, IBI handling fixes
 - mipi-i3c-hci: IBI handling fixes
 - svc: few fixes

----------------------------------------------------------------
Aniket (9):
      i3c: dw: Fix clearing queue thld
      i3c: dw: Fix IBI intr programming
      i3c: dw: Remove ibi_capable property
      dt-bindings: i3c: dw: Add apb clock binding
      i3c: dw: Use new *_enabled clk API
      i3c: dw: Add optional apb clock
      i3c: dw: Save timing registers and other values
      i3c: dw: Add some functions for reusability
      i3c: dw: Add power management support

Bhoomik Gupta (1):
      i3c: master: Enhance i3c_bus_type visibility for device searching & event monitoring

Carlos Song (1):
      dt-bindings: i3c: add header for generic I3C flags

Chen Ni (1):
      i3c: master: svc: Convert comma to semicolon

Dan Carpenter (1):
      i3c: master: svc: Fix error code in svc_i3c_master_do_daa_locked()

Frank Li (2):
      i3c: master: svc: resend target address when get NACK
      i3c: master: svc: Improve DAA STOP handle code logic

Jarkko Nikula (5):
      i3c: mipi-i3c-hci: Fix number of DAT/DCT entries for HCI versions < 1.1
      i3c: mipi-i3c-hci: Switch to lower_32_bits()/upper_32_bits() helpers
      i3c: mipi-i3c-hci: Set IBI Status and Data Ring base addresses
      i3c: mipi-i3c-hci: Error out instead on BUG_ON() in IBI DMA setup
      i3c: mipi-i3c-hci: Round IBI data chunk size to HW supported value

 Documentation/devicetree/bindings/i3c/i3c.yaml     |   5 +-
 .../bindings/i3c/snps,dw-i3c-master.yaml           |  11 +-
 MAINTAINERS                                        |   1 +
 drivers/i3c/internals.h                            |   2 -
 drivers/i3c/master.c                               |   1 +
 drivers/i3c/master/ast2600-i3c-master.c            |   1 -
 drivers/i3c/master/dw-i3c-master.c                 | 349 ++++++++++++++++-----
 drivers/i3c/master/dw-i3c-master.h                 |  14 +-
 drivers/i3c/master/mipi-i3c-hci/core.c             |   8 +
 drivers/i3c/master/mipi-i3c-hci/dma.c              |  44 +--
 drivers/i3c/master/svc-i3c-master.c                | 121 +++++--
 include/dt-bindings/i3c/i3c.h                      |  16 +
 include/linux/i3c/master.h                         |   1 +
 13 files changed, 431 insertions(+), 143 deletions(-)
 create mode 100644 include/dt-bindings/i3c/i3c.h

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

