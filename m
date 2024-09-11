Return-Path: <linux-kernel+bounces-324245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C53974A18
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32DFB28859F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 06:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ED974059;
	Wed, 11 Sep 2024 06:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFxIeYVn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B36F40849;
	Wed, 11 Sep 2024 06:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726034709; cv=none; b=gJwjpz1jLVzx4UwW1FquxNp/Nx4NDAFlbRjT2D0K5O4Nu9Q6w7fy0ttzw+e5NBgMdTGCHRddQ722kdse3vXBNSyQGQVU2/GXf9bVB3dVTgxULZjelLCOF4mqu+LD1gi/DFHutdyPwMzJ/IY8tjLJjsa7opaTJCMFiJfvcDWleJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726034709; c=relaxed/simple;
	bh=oS6W6RuD01zziSDUkNdAa9V8LFDpaby7DxbfQdP+WyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KeWmxVKfOpH+ngLpJlVKtI/zJkH6NMBbbuLR5SxIC5M6pD+bKmMQ5a3zRHrO2CDzRIZVmHigcDR+P8vCHM2TJmQxhQGmHx66xps8/yEktFXUqKr8oxs1v3ln8rFbTmyPia24G6Fc7aw6cAlTinBF56vxbinMWLHRZ3Lgkt4h6fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFxIeYVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29B1C4CEC5;
	Wed, 11 Sep 2024 06:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726034708;
	bh=oS6W6RuD01zziSDUkNdAa9V8LFDpaby7DxbfQdP+WyQ=;
	h=Date:From:To:Cc:Subject:From;
	b=ZFxIeYVnrkP5hegcl50Fe4tO2Bl8UnO1W+s0h2TOgm6f18RWhlm5ejUcJ6GFsRQ/E
	 QZjltk8XovkjcMBlKtadpgiQvmnrG+oa8NuFQ9qQY43rGyMWlc+SSWODNoHl+Csroz
	 x8B27WAmyOcY53lcCJBolvzHMsLd+ftz7K6WodZcks1JPNeEBwV7XEY+jvuDzECL0Y
	 DUk8L1KRKkBEVF+HvZbSlC0J7U6Xt+Ti6CG007xlhXGisYmtxWAxeS2roWUM4GiBX1
	 Dgt+c7S3WHKJd+CGEQvvTp+HiKzYypAZRnhCr69kPOFvgQsbOTNpZV4a49mXrnehkA
	 AQYha9KfPWrPA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1soGTm-000000005SH-3toq;
	Wed, 11 Sep 2024 08:05:26 +0200
Date: Wed, 11 Sep 2024 08:05:26 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial updates for 6.12-rc1
Message-ID: <ZuEzJgTKeD0RscpX@hovoldconsulting.com>
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

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.12-rc1

for you to fetch changes up to 4c0d9477ba69a417c698aec1d3012e188cf97add:

  USB: serial: kobil_sct: restore initial terminal settings (2024-08-26 15:29:27 +0200)

----------------------------------------------------------------
USB-serial updates for 6.12-rc1

Here are the USB-serial updates for 6.12-rc1, including:

 - fix kobil_sct initial terminal settings
 - set driver owner when registering drivers

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Johan Hovold (1):
      USB: serial: kobil_sct: restore initial terminal settings

Krzysztof Kozlowski (2):
      USB: serial: set driver owner when registering drivers
      USB: serial: drop driver owner initialization

 drivers/usb/serial/aircable.c          |  1 -
 drivers/usb/serial/ark3116.c           |  1 -
 drivers/usb/serial/belkin_sa.c         |  1 -
 drivers/usb/serial/ch341.c             |  1 -
 drivers/usb/serial/cp210x.c            |  1 -
 drivers/usb/serial/cyberjack.c         |  1 -
 drivers/usb/serial/cypress_m8.c        |  3 ---
 drivers/usb/serial/digi_acceleport.c   |  2 --
 drivers/usb/serial/empeg.c             |  1 -
 drivers/usb/serial/f81232.c            |  2 --
 drivers/usb/serial/f81534.c            |  1 -
 drivers/usb/serial/ftdi_sio.c          |  1 -
 drivers/usb/serial/garmin_gps.c        |  1 -
 drivers/usb/serial/generic.c           |  1 -
 drivers/usb/serial/io_edgeport.c       |  4 ----
 drivers/usb/serial/io_ti.c             |  2 --
 drivers/usb/serial/ipaq.c              |  1 -
 drivers/usb/serial/ipw.c               |  1 -
 drivers/usb/serial/ir-usb.c            |  1 -
 drivers/usb/serial/iuu_phoenix.c       |  1 -
 drivers/usb/serial/keyspan.c           |  4 ----
 drivers/usb/serial/keyspan_pda.c       |  2 --
 drivers/usb/serial/kl5kusb105.c        |  1 -
 drivers/usb/serial/kobil_sct.c         |  4 +---
 drivers/usb/serial/mct_u232.c          |  1 -
 drivers/usb/serial/metro-usb.c         |  1 -
 drivers/usb/serial/mos7720.c           |  1 -
 drivers/usb/serial/mos7840.c           |  1 -
 drivers/usb/serial/mxuport.c           |  1 -
 drivers/usb/serial/navman.c            |  1 -
 drivers/usb/serial/omninet.c           |  1 -
 drivers/usb/serial/opticon.c           |  1 -
 drivers/usb/serial/option.c            |  1 -
 drivers/usb/serial/oti6858.c           |  1 -
 drivers/usb/serial/pl2303.c            |  1 -
 drivers/usb/serial/qcaux.c             |  1 -
 drivers/usb/serial/qcserial.c          |  1 -
 drivers/usb/serial/quatech2.c          |  1 -
 drivers/usb/serial/safe_serial.c       |  1 -
 drivers/usb/serial/sierra.c            |  1 -
 drivers/usb/serial/spcp8x5.c           |  1 -
 drivers/usb/serial/ssu100.c            |  1 -
 drivers/usb/serial/symbolserial.c      |  1 -
 drivers/usb/serial/ti_usb_3410_5052.c  |  2 --
 drivers/usb/serial/upd78f0730.c        |  1 -
 drivers/usb/serial/usb-serial-simple.c |  1 -
 drivers/usb/serial/usb-serial.c        | 12 +++++++-----
 drivers/usb/serial/usb_debug.c         |  2 --
 drivers/usb/serial/visor.c             |  3 ---
 drivers/usb/serial/whiteheat.c         |  2 --
 drivers/usb/serial/wishbone-serial.c   |  1 -
 drivers/usb/serial/xr_serial.c         |  1 -
 drivers/usb/serial/xsens_mt.c          |  1 -
 include/linux/usb/serial.h             |  7 +++++--
 54 files changed, 13 insertions(+), 78 deletions(-)

