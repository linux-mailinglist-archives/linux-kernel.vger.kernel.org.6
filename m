Return-Path: <linux-kernel+bounces-393795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7219BA555
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 13:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9E00B218C1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 12:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C864B1632F8;
	Sun,  3 Nov 2024 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2q5UG8ip"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0517080C
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730635309; cv=none; b=T+uVsR+e0cFCGrqu+ryRKdfSCU5D5jaOofVvf8yZ7t+tJJbwW0x4yVvato1vUzPDx6KE8MrQXAyZ9jj8RTDmJVvbqgQxkD0yvlzvQe1SrULvIzlQ/cZN8lAXIhdy+1JGCW5j/52g81au18dPGgk67HHOjDdgRg4oZ4rSclpGjg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730635309; c=relaxed/simple;
	bh=OqyUnj8QMtmUIXWMeTwSrqs7RThDBKbxYt+KNitYA2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q/mlD/7uCazYh2Nkulv6aTcmYHVhL143YnKK28iXl/W6HQqd5ZkYMJHX0m9Ea/s8GqYFRqZ+kW3ApQXx5dmgq2yq4DQkGIwmIIgQBKz0W/i487NP0usxuZLG5dhdF5Y6+a/JGk61dr6jGY5G4S4WRHtI2x8OU2xLHUi8hJwAJg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2q5UG8ip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC75C4CECD;
	Sun,  3 Nov 2024 12:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730635308;
	bh=OqyUnj8QMtmUIXWMeTwSrqs7RThDBKbxYt+KNitYA2Y=;
	h=Date:From:To:Cc:Subject:From;
	b=2q5UG8ipwLU6DeBJcisce2ol5Y4izBEODnvjeCPuXVX/R5fjg+o1nDhDFE+cauNxA
	 XTXzoM9NjgJvbL81oHq6VqbGlYEnbwQUogY1qqsEJFNBivE5Pde5GkgGANpF8RB5CU
	 k7o4z7Hqo+EAwEa+00HlFrE2JzuRJUJ0GKRrRQbU=
Date: Sun, 3 Nov 2024 13:01:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc/IIO driver fixes for 6.12-rc6
Message-ID: <ZydmHKdMoOr4tMgM@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 42f7652d3eb527d03665b09edac47f85fb600924:

  Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.12-rc6

for you to fetch changes up to d0bc3b92fb9b2c3c981984d52fffe8cca77165dc:

  Merge tag 'iio-fixes-for-6.12b' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next (2024-10-29 04:10:12 +0100)

----------------------------------------------------------------
Char/Misc/IIO driver fixes for 6.12-rc6

Here are some small char/misc/iio fixes for 6.12-rc6 that resolves some
reported issues.  Included in here are the following:
  - small IIO driver fixes for many reported issues
  - mei driver fix for a suddenly much reported issue for an "old"
    issue.
  - MAINTAINERS update for a developer who has moved companies and
    forgot to update their old entry.

All of these have been in linux-next this week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Abylay Ospan (1):
      MAINTAINERS: add netup_unidvb maintainer

Alexander Usyskin (1):
      mei: use kvmalloc for read buffer

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-6.12b' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next

Javier Carrasco (1):
      iio: light: veml6030: fix microlux value calculation

Jinjie Ruan (3):
      iio: gts-helper: Fix memory leaks in iio_gts_build_avail_scale_table()
      iio: gts-helper: Fix memory leaks for the error path of iio_gts_build_avail_scale_table()
      iio: dac: Kconfig: Fix build error for ltc2664

Julien Stephan (5):
      dt-bindings: iio: adc: ad7380: fix ad7380-4 reference supply
      iio: adc: ad7380: use devm_regulator_get_enable_read_voltage()
      iio: adc: ad7380: add missing supplies
      iio: adc: ad7380: fix supplies for ad7380-4
      docs: iio: ad7380: fix supply for ad7380-4

Zicheng Qu (2):
      staging: iio: frequency: ad9832: fix division by zero in ad9832_calc_freqreg()
      iio: adc: ad7124: fix division by zero in ad7124_set_channel_odr()

 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    |  21 ++++
 Documentation/iio/ad7380.rst                       |  13 +-
 MAINTAINERS                                        |  54 ++++++++
 drivers/iio/adc/ad7124.c                           |   2 +-
 drivers/iio/adc/ad7380.c                           | 136 ++++++++++++---------
 drivers/iio/dac/Kconfig                            |   2 +-
 drivers/iio/industrialio-gts-helper.c              |   4 +-
 drivers/iio/light/veml6030.c                       |   2 +-
 drivers/misc/mei/client.c                          |   4 +-
 drivers/staging/iio/frequency/ad9832.c             |   7 +-
 10 files changed, 177 insertions(+), 68 deletions(-)

