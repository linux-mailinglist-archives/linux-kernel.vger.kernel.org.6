Return-Path: <linux-kernel+bounces-250566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DDC92F91B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 12:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE971C224AE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C8815DBAE;
	Fri, 12 Jul 2024 10:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U43CWkMP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B385315444E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720780880; cv=none; b=B5P8HQ6qUMnVl1YdNfsBg++EDqykLXeNmX5gujAsXI+f2TBIzQoROsnA4tM3gwlUW6RsHkZILacUghC38LDpaP4CA82Lfih3/RSYWpXBbyqQ3UlOSva/CzBUn5xfN2/AAdKT4t264Fqi0rVV+FJJLmztqmZmdHTJEOKYEjUbNGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720780880; c=relaxed/simple;
	bh=3JBxB+8aAIWkFmOcwe4JZKV6hy3OlMkyOh+gyKFrnWA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JuZ2XHE72vZz8ioIWd0eUrVhC/eScHS4Y38NTtKLdsYlzRpsjeyfxW7fdgzVhG4SWqbnvsZR9di/gkg9WXMV9meSeJZg0Fg67LVDAuuNY0gk1j9iYTya1eGxWjCyxdRiddSTsNf5BWigKW9IVi5vkWpzYuSpsaSsd6q5qy6BXjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U43CWkMP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB9EC4AF07;
	Fri, 12 Jul 2024 10:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720780880;
	bh=3JBxB+8aAIWkFmOcwe4JZKV6hy3OlMkyOh+gyKFrnWA=;
	h=Date:From:To:Cc:Subject:From;
	b=U43CWkMPuxIvjD+p35xDCDePAObdp1uzkJCHffIsBAI2GxIQU+JhT+R/UOuus7c6l
	 QOE99/A9PWrtviTXwutdApPiNDH7W5/CX08UayNwMOP7eWZgWEcbNwzbX5BvHNUbia
	 nj+H3cJvGtQ0ulqAUtkumN4Dw22VPtYEYMHqPtYc=
Date: Fri, 12 Jul 2024 12:41:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.10-final
Message-ID: <ZpEITX2fIM6KpL1h@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.10-final

for you to fetch changes up to 389637d4fb5fee40e8a0f2bfd31583f6768ef792:

  mei: vsc: Fix spelling error (2024-07-04 12:21:39 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 6.10-final

Here are some small remaining driver fixes for 6.10-final that have all
been in linux-next for a while and resolve reported issues.  Included in
here are:
  - mei driver fixes (and a spelling fix at the end just to be clean)
  - iio driver fixes for reported problems
  - fastrpc bugfixes
  - nvmem small fixes

Again, all have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ekansh Gupta (6):
      misc: fastrpc: Fix DSP capabilities request
      misc: fastrpc: Copy the complete capability structure to user
      misc: fastrpc: Avoid updating PD type for capability request
      misc: fastrpc: Fix memory leak in audio daemon attach operation
      misc: fastrpc: Fix ownership reassignment of remote heap
      misc: fastrpc: Restrict untrusted app to attach to privileged PD

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-6.10c' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus

He Zhe (1):
      hpet: Support 32-bit userspace

Joy Chakraborty (3):
      misc: microchip: pci1xxxx: Fix return value of nvmem callbacks
      nvmem: rmem: Fix return value of rmem_read()
      nvmem: meson-efuse: Fix return value of nvmem callbacks

João Paulo Gonçalves (1):
      iio: trigger: Fix condition for own trigger

Mudit Sharma (1):
      iio: light: apds9306: Fix error handing

Thomas Weißschuh (2):
      nvmem: core: only change name to fram for current attribute
      nvmem: core: limit cell sysfs permissions to main attribute ones

Wentong Wu (5):
      mei: vsc: Enhance IVSC chipset stability during warm reboot
      mei: vsc: Prevent timeout error with added delay post-firmware download
      mei: vsc: Utilize the appropriate byte order swap function
      mei: vsc: Enhance SPI transfer of IVSC ROM
      mei: vsc: Fix spelling error

 drivers/char/hpet.c                               | 34 ++++++++++++++++---
 drivers/iio/industrialio-trigger.c                |  2 +-
 drivers/iio/light/apds9306.c                      |  4 +--
 drivers/misc/fastrpc.c                            | 41 ++++++++++++++++++-----
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c |  4 ---
 drivers/misc/mei/platform-vsc.c                   |  4 +--
 drivers/misc/mei/vsc-fw-loader.c                  |  2 +-
 drivers/misc/mei/vsc-tp.c                         | 18 ++++++++--
 drivers/nvmem/core.c                              |  7 ++--
 drivers/nvmem/meson-efuse.c                       | 14 +++++---
 drivers/nvmem/rmem.c                              |  5 ++-
 include/uapi/misc/fastrpc.h                       |  3 ++
 12 files changed, 103 insertions(+), 35 deletions(-)

