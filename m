Return-Path: <linux-kernel+bounces-261057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F4193B241
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 16:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A127F1F24785
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5B81591E2;
	Wed, 24 Jul 2024 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aspAjsYT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C92158862;
	Wed, 24 Jul 2024 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721830086; cv=none; b=B4JhQha+71huv2xkUOT/gdUj9oWYjhr9JYu8vZF/qaInunkkX2zceXN6S6nVpfHFbfU23h9BZ2/0Jo7FS4laIWa6qyIfkxeznq82yebfvwLhHEedoF7WGep29GFxXmjtgOx/hXxV+z0I29+vDdo8sHCDz+9T/tPKtmivXHUUCpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721830086; c=relaxed/simple;
	bh=Rx4hpTTYYqVSZdC8XTwnfXY5UsSWi7uSuGAt/czcwwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZBNgWVZLoijgPCOtzt9FTDHw1FDAjyI61wj9+82iWQBTyCN6OhX7Vz3yDtK2yjD3Xm/dNuA1XgYMo8LM16eRHGPtKzAklw0znHYDAc78vRHh1Zk/1kTsvHLzTxD7W+UeZAhqdOeA6m0bQP4lNwyTijOta+YLFQyykj19CpPNB/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aspAjsYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940E1C32781;
	Wed, 24 Jul 2024 14:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721830086;
	bh=Rx4hpTTYYqVSZdC8XTwnfXY5UsSWi7uSuGAt/czcwwg=;
	h=From:To:Cc:Subject:Date:From;
	b=aspAjsYTmBLpF7+qDaH4Q55VVsLjdKkHcbcoRN15KRnfSxi1O5oFt0wNVAbXfr5yJ
	 GbemUNgLhG34yN2AFIgAy+0Iqg3pKxd3EMY0Mgeo4aYv+6iePXxXOzZlhRJvMrPsGu
	 qK5Mx0bK47kQECROYjYIb4pRBxbAP/MZvP1cTg7c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.10.1
Date: Wed, 24 Jul 2024 16:08:00 +0200
Message-ID: <2024072401-barmaid-profusely-6d62@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm announcing the release of the 6.10.1 kernel.

All users of the 6.10 kernel series must upgrade.

The updated 6.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                    |    2 -
 drivers/char/tpm/tpm2-sessions.c            |    5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c |    7 +++
 drivers/thermal/thermal_core.c              |   51 +++++++++++++---------------
 drivers/thermal/thermal_core.h              |    3 +
 drivers/thermal/thermal_helpers.c           |    2 +
 fs/ext4/ext4.h                              |    2 -
 fs/ext4/ioctl.c                             |    2 -
 fs/smb/client/cifsfs.c                      |    2 -
 fs/smb/client/file.c                        |   21 +++++++++--
 fs/smb/client/smb2pdu.c                     |    3 -
 include/sound/cs35l56.h                     |    2 -
 io_uring/kbuf.c                             |    4 +-
 sound/soc/codecs/cs35l56.c                  |    6 ++-
 14 files changed, 68 insertions(+), 44 deletions(-)

David Howells (4):
      cifs: Fix missing error code set
      cifs: Fix missing fscache invalidation
      cifs: Fix server re-repick on subrequest retry
      cifs: Fix setting of zero_point after DIO write

Greg Kroah-Hartman (1):
      Linux 6.10.1

Hao Ge (1):
      tpm: Use auth only after NULL check in tpm_buf_check_hmac_response()

Kees Cook (1):
      ext4: use memtostr_pad() for s_volume_name

Pavel Begunkov (1):
      io_uring: fix error pbuf checking

Rafael J. Wysocki (1):
      thermal: core: Allow thermal zones to tell the core to ignore them

Richard Fitzgerald (2):
      ASoC: cs35l56: Use header defines for Speaker Volume control definition
      ASoC: cs35l56: Limit Speaker Volume to +12dB maximum

Steve French (1):
      cifs: fix noisy message on copy_file_range


