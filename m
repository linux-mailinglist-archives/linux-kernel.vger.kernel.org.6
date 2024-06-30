Return-Path: <linux-kernel+bounces-235240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BF091D1FE
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 16:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2717B20D1D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 14:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1588914D2AC;
	Sun, 30 Jun 2024 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zUJnp7rB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A2A1474B4
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 14:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719756772; cv=none; b=crrppsWCd7vIRr7N5bHbvYCi1URvMman3nB/X+VF4aAOzwEo26LNQuxwKztwveHh2UasJO918qRuZZJc6OxIe2sXQjZkdKk088IjJtFv4N1JBh2kXqCI2yAvrCN+qBPZm12uxTIiJ1/Y13osi3OHd85y1dItmYXhx7MNnAbxLJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719756772; c=relaxed/simple;
	bh=KI/zhPaBRnnC7OM39K5ZZDR+faQvjDPOyPmyOyUwh8k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l/Fl3uNgRpplSqGbSb6TTAnNvCns7Jp9U3+lm8k7HyZ2ryws9hE7Bb4TkQ9togY++O/sMSGtnsFXMeiAgbSLH4VPIebY0J49im44F1vAYe2cD9iZJusdh0tVd4C2GIPKe4NGzzfEgHxyTfRC0xQzjgEBF/CtRTahrm/09zKG7/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zUJnp7rB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A10DC2BD10;
	Sun, 30 Jun 2024 14:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719756772;
	bh=KI/zhPaBRnnC7OM39K5ZZDR+faQvjDPOyPmyOyUwh8k=;
	h=Date:From:To:Cc:Subject:From;
	b=zUJnp7rBusgMC7x9/wSeXiWX5guCx/azU7NtQgYJBvvqDrKTFZbjR+sKZD1PS5XrP
	 KBEDxUNobsjDzwxlh3LxvyMWtPnfzx5aqHTKh96N2bfKgpZc90+aSVcf9Vp+vwj8+r
	 uLuXcyo8PErt74J7JeKLxou2CIwei1a0bvQcxjK0=
Date: Sun, 30 Jun 2024 16:12:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.10-rc6
Message-ID: <ZoFn3eQvziKriKTG@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:

  Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.10-rc6

for you to fetch changes up to 06ebbce9c3a84e5632fa3cd0864ce07093793e32:

  Merge tag 'counter-fixes-for-6.10' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/wbg/counter into char-misc-linus (2024-06-24 12:59:56 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 6.10-rc6

Here are some small driver fixes for 6.10-rc6.  Included in here are:
  - IIO driver fixes for reported issues
  - Counter driver fix for a reported problem.

All of these have been in linux-next this week with no reported issues

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Sverdlin (1):
      iio: accel: fxls8962af: select IIO_BUFFER & IIO_KFIFO_BUF

David Lechner (1):
      counter: ti-eqep: enable clock at probe

Dimitri Fedrau (1):
      iio: humidity: hdc3020: fix hysteresis representation

Fernando Yang (1):
      iio: adc: ad7266: Fix variable checking bug

Greg Kroah-Hartman (2):
      Merge tag 'iio-fixes-for-6.10b' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus
      Merge tag 'counter-fixes-for-6.10' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/wbg/counter into char-misc-linus

Ke Sun (1):
      iio: dac: fix ad9739a random config compile error

Sean Anderson (1):
      iio: xilinx-ams: Don't include ams_ctrl_channels in scan_mask

Vasileios Amoiridis (4):
      iio: chemical: bme680: Fix pressure value output
      iio: chemical: bme680: Fix calibration data variable
      iio: chemical: bme680: Fix overflows in compensate() functions
      iio: chemical: bme680: Fix sensor data read operation

 drivers/counter/ti-eqep.c          |   6 +
 drivers/iio/accel/Kconfig          |   2 +
 drivers/iio/adc/ad7266.c           |   2 +
 drivers/iio/adc/xilinx-ams.c       |   8 +-
 drivers/iio/chemical/bme680.h      |   2 +
 drivers/iio/chemical/bme680_core.c |  62 ++++++-
 drivers/iio/dac/Kconfig            |   2 +-
 drivers/iio/humidity/hdc3020.c     | 323 ++++++++++++++++++++++++++++---------
 8 files changed, 321 insertions(+), 86 deletions(-)

