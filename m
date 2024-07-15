Return-Path: <linux-kernel+bounces-252505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F05A7931424
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 14:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 715291F215A8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EEB18C17F;
	Mon, 15 Jul 2024 12:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjNbc7dU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ACF18787F;
	Mon, 15 Jul 2024 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721046212; cv=none; b=BQwBAjOUHjU+6scnQ3KKOlAenf1WqOGKCgzvn29KO4mlOp5WVkv+HsBIzID5g5tYS3HPOflPVLRCIUdV42kyIwfrzRFJJv3LfiYcoIqUH8zuJqcROgqIEi289pr08auZIVaSj61zJM0KAoPKKEg5Z0WJxViQ5Er6pEv8gHHDkgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721046212; c=relaxed/simple;
	bh=t6723AQNf/YQrYz1eVjW0ufSQyLk7R1O+zDaPu5mrZw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gf73PhFePnvdZ0RNLw+tLriBOV+cYqBkkXigumB3HM6HtDjH/dU3QBRRW0/BxoKd0dltzwRFGnGDamHUeRXFnYJYPZz/ngj6c5sBARxre9PbGBeLVr5zqJbeqjIHCVrFOmhien9PYN1YhwU5ydgR6OK+N+1ElyZ6HChruof3d/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjNbc7dU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26420C32782;
	Mon, 15 Jul 2024 12:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721046212;
	bh=t6723AQNf/YQrYz1eVjW0ufSQyLk7R1O+zDaPu5mrZw=;
	h=Date:From:To:Cc:Subject:From;
	b=BjNbc7dU1CzCLdyM3zjisiEfr3PjU+OKOJ89yy0JzhMrVYdtzWLOh0NExU4cgS/7p
	 50XuNNw2kg/c4H7YFLDPCnhdP+FBsKYlh4HxcOVvYQChOC3KjHvHrf+uEcm217bYkh
	 Yw7UPCEfwGoqgXsnjiF5cwQoJxOsdpU1rS2vNT/QQuAW63TRFuCvhfk1AIOdBTFaqf
	 TMHBX0gkHKnFOZXxq22aNg1gaLGqs6ZVe8NPyZoKVrkkpgKYQlZlLGVVbX2sYfUGJA
	 21vqVb22gbEYASaR0bjaw/mmm3JLF2i0Il67JO0QMykXJvCHKgf3C+JKQy/WBFyI1d
	 sfJ52KZIz2x5Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sTKjq-000000007Rr-2EPZ;
	Mon, 15 Jul 2024 14:23:30 +0200
Date: Mon, 15 Jul 2024 14:23:30 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial updates for 6.11-rc1
Message-ID: <ZpUUwvgpSEj8mojg@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 22a40d14b572deb80c0648557f4bd502d7e83826:

  Linux 6.10-rc6 (2024-06-30 14:40:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.11-rc1

for you to fetch changes up to df8c0b8a03e871431587a13a6765cb4c601e1573:

  USB: serial: garmin_gps: use struct_size() to allocate pkt (2024-07-05 14:01:43 +0200)

----------------------------------------------------------------
USB-serial updates for 6.11-rc1

Here are the USB-serial updates for 6.11-rc1, including:

 - add missing module descriptions
 - add flexible array annotation in garmin_gps

Included are also various clean ups.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      USB: serial: spcp8x5: remove unused struct 'spcp8x5_usb_ctrl_arg'

Javier Carrasco (2):
      USB: serial: garmin_gps: annotate struct garmin_packet with __counted_by
      USB: serial: garmin_gps: use struct_size() to allocate pkt

Jeff Johnson (1):
      USB: serial: add missing MODULE_DESCRIPTION() macros

 drivers/usb/serial/ch341.c             |  1 +
 drivers/usb/serial/garmin_gps.c        |  5 ++---
 drivers/usb/serial/mxuport.c           |  1 +
 drivers/usb/serial/navman.c            |  1 +
 drivers/usb/serial/qcaux.c             |  1 +
 drivers/usb/serial/spcp8x5.c           | 10 ----------
 drivers/usb/serial/symbolserial.c      |  1 +
 drivers/usb/serial/usb-serial-simple.c |  1 +
 drivers/usb/serial/usb_debug.c         |  1 +
 9 files changed, 9 insertions(+), 13 deletions(-)

