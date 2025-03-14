Return-Path: <linux-kernel+bounces-560817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F945A609CB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73962880EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1108A1F76A8;
	Fri, 14 Mar 2025 07:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LS/bSaW5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6277A1F63C1;
	Fri, 14 Mar 2025 07:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936362; cv=none; b=fFz0TR5mDKTKDG/ZH0GWIelrlxARzj4SOCwONZM/wub/mWOX2solkX9BLrNgkOZxPrfE6HheECLGS6UWwlgKSYUqA6Rz5K9r2vjC+3DtGAov0IakcIXYsK0fr76euSH4xncbqUrR/6Xv4GJbxW/Lyb2C7scmqqT4kJ9eI4exi8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936362; c=relaxed/simple;
	bh=nS/cziBIvv+b35t6+Auwrud3hAAQAUm55EYNaw5/odE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V2CsDKP5TNbB3Ok9hOvtLV0PSH68rKugUqNRkWunXnsz/8PEfW9VfYnDoa0aG1atr/AECj+gtv51ii28GnO7MTk6m0bpFSpOBSIr3ZjRWOkpKGwU0gy6tr58SnZCnmMyzLdX9eLzkvXdvDpGrQrVviZWQ80GKul1TBjWKEH/C4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LS/bSaW5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF024C4CEE3;
	Fri, 14 Mar 2025 07:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741936359;
	bh=nS/cziBIvv+b35t6+Auwrud3hAAQAUm55EYNaw5/odE=;
	h=Date:From:To:Cc:Subject:From;
	b=LS/bSaW5/rXOiR1sLi3fUKjWbJ2VTVEeRS8Wq6yVmsX+CgndTmRBcE0FbLLaChBIV
	 MgGHgPvI30nwsdAlivTdaChobcr00HpfYtB6+UMJ/i89LcKAZBpiki5zEvGvdWp0T3
	 2kpkzIWopiUFsVwBVcgqkIhRZ4Jwj0pkUOWLXYzuA3k+Rtsa3vkbmdtJ2KKjFSRN7X
	 2pKjE8wlF1Rs75kGZk+koyx59s6IWn+xYQNEdx3PuvS9A12SHTRQTbwYvGlkmOWcFl
	 gx7GLCbdhYb2A2T0gbJu2nUyDWZUyzl4AaP5fZgjwJkuEAbguTPJAZXQCLbnUf5GXC
	 yClN5szZWT6yg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tszDi-000000001Lq-09ns;
	Fri, 14 Mar 2025 08:12:38 +0100
Date: Fri, 14 Mar 2025 08:12:38 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial device ids for 6.14-rc7
Message-ID: <Z9PW5tkuTH6oRG6X@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 0ad2507d5d93f39619fc42372c347d6006b64319:

  Linux 6.14-rc3 (2025-02-16 14:02:44 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.14-rc7

for you to fetch changes up to 18e0885bd2ca738407036434418a26a58394a60e:

  USB: serial: ftdi_sio: add support for Altera USB Blaster 3 (2025-03-12 17:51:16 +0100)

----------------------------------------------------------------
USB-serial device ids for 6.14-rc7

Here are some new modem device ids and a couple of related fixes, and
support for Altera USB Blaster 3.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Boon Khai Ng (1):
      USB: serial: ftdi_sio: add support for Altera USB Blaster 3

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FE990B compositions
      USB: serial: option: fix Telit Cinterion FE990A name

Johan Hovold (1):
      USB: serial: option: match on interface class for Telit FN990B

 drivers/usb/serial/ftdi_sio.c     | 14 ++++++++++++
 drivers/usb/serial/ftdi_sio_ids.h | 13 +++++++++++
 drivers/usb/serial/option.c       | 48 ++++++++++++++++++++++++++-------------
 3 files changed, 59 insertions(+), 16 deletions(-)

