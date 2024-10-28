Return-Path: <linux-kernel+bounces-384299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E448F9B290E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73DF51F22310
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABB11D1F7E;
	Mon, 28 Oct 2024 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zEtKjk2p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bKN2qSDv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A181917C0
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100888; cv=none; b=BQGbqoraqhfNOJhqc8F3JmCOSHIfVEZSUroFNQ27pXHlhNN0xbUHV2yoomYEiMTIjQEyWPo3krnheLH6VizX3eg8lfM4EBdcKsA9ra5AVYE8uWlTumXkh45iMkzzelgxuB7BY88xxM0Zsulc2EQyplyp7AXtpIGIWefewA1afLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100888; c=relaxed/simple;
	bh=I5Kfug3u7qnBL2+nabl+nApFgAU31T3O8vcI8StD3Kk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E38AF3yHVSjtC/Ful47xfwJcXoZ1rrZZJrsI8saDV8eqKA9ZE6zxw7m30kdIEwFhHyMeueY/leyMdriGuy3V6sVp92yq9ILvgw3LkltbyU4KpA7+8+ifztyPPH5wGmSn5uVrmOZjLXFWmuZWlLI8bHUQH8Bphr5Sh/rz65CuDVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zEtKjk2p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bKN2qSDv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g7pZWOX5wQf+9/aWn3jSKcGN1KgU812RkzI1UKAgOlg=;
	b=zEtKjk2pVicz0Aq8Qjvse3bVByY+rk9SYB5QhHK6oIhkYv6Kpom1WKy/ynOXf1hb5xtrw2
	gXzEtC5EwVuZdQr8wcG3nY3sqa8+gLhg2ygBAcyobZ4XBHIAPiblDv4t6yoUag07i39SPG
	V/03WVHcDDiRxDb8PNvdginievIKxrkrdUgDPdHPFIjDbv82l6sDZTho+TSPoXXeAHJHvA
	XAkf3EAiVRFoc15rCbwc9M2emmdiRHv1bpD596DgeIc6JWLlN8m5hH7VnyZv7tLAHnp8ch
	Rf1tSTiG8qkiKAgCMqGcy3fGHqcuRQRmh0DE7axuxlQ8tJnkX3cXIm7la+TBDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g7pZWOX5wQf+9/aWn3jSKcGN1KgU812RkzI1UKAgOlg=;
	b=bKN2qSDvUBnJ5h7459OOtFYSr3xdzGmJ+k2qqcmDlj0Zr9GXsr1/BKrE2lS2k9DheTm6EM
	+SAZ6MESzx33j/Bg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Neukum <oliver@neukum.org>,
	Kalle Valo <kvalo@kernel.org>
Subject: [PATCH 00/24] hrtimers: Switch to new hrtimer interface functions (3/5)
Date: Mon, 28 Oct 2024 08:34:13 +0100
Message-Id: <cover.1729865232.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is the third part of a 5-part series (split for convenience). All 5
parts are:

Part 1: https://lore.kernel.org/lkml/cover.1729864615.git.namcao@linutronix=
.de
Part 2: https://lore.kernel.org/lkml/cover.1729864823.git.namcao@linutronix=
.de
Part 3: https://lore.kernel.org/lkml/cover.1729865232.git.namcao@linutronix=
.de
Part 4: https://lore.kernel.org/lkml/cover.1729865485.git.namcao@linutronix=
.de
Part 5: https://lore.kernel.org/lkml/cover.1729865740.git.namcao@linutronix=
.de

To use hrtimer, hrtimer_init() (or one of its variant) must be called, and
also the timer's callfack function must be setup separately.

That can cause misuse of hrtimer. For example, because:
  - The callback function is not setup
  - The callback function is setup while it is not safe to do so

To prevent misuse of hrtimer, this series:
  - Introduce new functions hrtimer_setup*(). These new functions are
    similar to hrtimer_init*(), except that they also sanity-check and
    initialize the callback function.
  - Introduce hrtimer_update_function() which checks that it is safe to
    change the callback function. The 'function' field of hrtimer is then
    made private.
  - Convert all users to use the new functions.
  - Some minor cleanups on the way.

Most conversion patches were created using Coccinelle with the sematic
patch below; except for tricky cases that Coccinelle cannot handle, or for
some cases where a Coccinelle's bug regarding 100 column limit is
triggered. Any patches not mentioning Coccinelle were done manually.

virtual patch
@@ expression timer, clock, mode, func; @@
- hrtimer_init(timer, clock, mode);
  ...
- timer->function =3D func;
+ hrtimer_setup(timer, func, clock, mode);

@@ expression timer, clock, mode, func; @@
- hrtimer_init(&timer, clock, mode);
  ...
- timer.function =3D func;
+ hrtimer_setup(&timer, func, clock, mode);

@@ expression timer, clock, mode, func; @@
- hrtimer_init_on_stack(&timer, clock, mode);
  ...
- timer.function =3D func;
+ hrtimer_setup_on_stack(&timer, func, clock, mode);

@@ expression timer, clock, mode; @@
- hrtimer_init_sleeper_on_stack(timer, clock, mode);
+ hrtimer_setup_sleeper_on_stack(timer, clock, mode);

Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Neukum <oliver@neukum.org>
Cc: Kalle Valo <kvalo@kernel.org>

Nam Cao (24):
  netdev: Switch to use hrtimer_setup()
  net/sched: Switch to use hrtimer_setup()
  mac802154: Switch to use hrtimer_setup()
  tcp: Switch to use hrtimer_setup()
  can: m_can: Switch to use hrtimer_setup()
  can: mcp251xfd: Switch to use hrtimer_setup()
  can: Switch to use hrtimer_setup()
  net: ethernet: ti: Switch to use hrtimer_setup()
  net: ethernet: cortina: Switch to use hrtimer_setup()
  net: ethernet: ec_bhf: Switch to use hrtimer_setup()
  net: ethernet: hisilicon: Switch to use hrtimer_setup()
  net: sparx5: Switch to use hrtimer_setup()
  net: ieee802154: at86rf230: Switch to use hrtimer_setup()
  net: mvpp2: Switch to use hrtimer_setup()
  net: qualcomm: rmnet: Switch to use hrtimer_setup()
  net: stmmac: Switch to use hrtimer_setup()
  net: fec: Switch to use hrtimer_setup()
  net: wwan: iosm: Switch to use hrtimer_setup()
  net/cdc_ncm: Switch to use hrtimer_setup()
  wifi: Switch to use hrtimer_setup()
  wifi: rt2x00: Switch to use hrtimer_setup()
  igc: Switch to use hrtimer_setup()
  octeontx2-pf: Switch to use hrtimer_setup()
  xfrm: Switch to use hrtimer_setup()

 drivers/net/can/m_can/m_can.c                 |  9 ++++---
 .../net/can/spi/mcp251xfd/mcp251xfd-ring.c    |  8 +++----
 drivers/net/ethernet/cortina/gemini.c         |  5 ++--
 drivers/net/ethernet/ec_bhf.c                 |  3 +--
 drivers/net/ethernet/freescale/fec_ptp.c      |  4 ++--
 drivers/net/ethernet/hisilicon/hip04_eth.c    |  4 +---
 drivers/net/ethernet/intel/igc/igc_main.c     |  4 ++--
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   |  5 ++--
 .../net/ethernet/marvell/octeontx2/af/ptp.c   |  3 +--
 .../ethernet/microchip/sparx5/sparx5_packet.c |  4 ++--
 .../ethernet/qualcomm/rmnet/rmnet_map_data.c  |  4 ++--
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  6 ++---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      |  9 ++++---
 drivers/net/ethernet/ti/icssg/icssg_common.c  |  5 ++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |  5 ++--
 drivers/net/ieee802154/at86rf230.c            |  4 ++--
 drivers/net/usb/cdc_ncm.c                     |  3 +--
 .../wireless/mediatek/mt76/mt76x02_usb_core.c |  4 ++--
 .../net/wireless/ralink/rt2x00/rt2x00dev.c    |  9 +++++--
 drivers/net/wireless/virtual/mac80211_hwsim.c |  6 ++---
 drivers/net/wwan/iosm/iosm_ipc_imem.c         | 24 ++++++++-----------
 net/can/bcm.c                                 | 16 +++++--------
 net/can/isotp.c                               | 10 ++++----
 net/can/j1939/bus.c                           |  4 ++--
 net/can/j1939/transport.c                     |  8 ++-----
 net/core/dev.c                                |  3 +--
 net/ipv4/tcp_timer.c                          | 10 ++++----
 net/mac802154/main.c                          |  4 ++--
 net/sched/act_gate.c                          |  3 +--
 net/sched/sch_api.c                           |  3 +--
 net/sched/sch_taprio.c                        |  6 ++---
 net/xfrm/xfrm_state.c                         |  4 ++--
 32 files changed, 84 insertions(+), 115 deletions(-)

--=20
2.39.5


