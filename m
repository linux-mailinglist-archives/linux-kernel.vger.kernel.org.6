Return-Path: <linux-kernel+bounces-384376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 708899B295D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA957B20BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8FD206518;
	Mon, 28 Oct 2024 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MUF6CDIs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eTVcrcct"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882B6191F94
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100969; cv=none; b=Van6fwxJXhIF7uDxqIsJcCA1iBAsWUbBaQM0iNhsos4OzmSIYFUZibKB1pobHwr3GJj7pxgQqkO3hyJkr+6kyxge0LsHn3HwOsh2t2OIqUOKwikBb0MmdAY0t30XEIzgrRbFc7oLgvBBHfPEtkxhGd2NlK4p3HLAYhc8In83a6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100969; c=relaxed/simple;
	bh=OjHzWioM8hIrXm1v3A44UMPocRE/3JNbbpKfV+RGQns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jA+8CdB/RCq0IzRMcO8Zzpq/cPBGJ32uCITcn0LE7/aEWTIkO4/uX5zogjnOqPYDwyWNDM5qm8s0UlbNRyygMn7J8fKDLJGjc8ocLlZXb06Oe42lBYFtSyyoLyWBebOZjXmw3YCESuMKGYp0sEKRqXWx8k/g2xy5wrn8BhXmZUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MUF6CDIs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eTVcrcct; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yki5e5oO4izSs6rd2/tDNyuThhIlQsX5cTWT4NrlmH8=;
	b=MUF6CDIsBsg4CWz9OLJXgAA77P7kVQxl2fugjwQW08t5r01+tZovuvZ6Kt7RCc/9HyzRls
	DG7a1LPqYfkzl2TyrRCNIUc6l2kScVC7p/TAVyYUd9tZw6FVokajsLNKOrnwKhLgb0ouBt
	N2nvgacymq6ZhCVWHyy0AUFNJNjOoSiY4+N7c6zZa/RPZu04B9PBkQXOlH6CcnJIJlMjSv
	4h1uRoJBe3ylpInmsL65NSmXDU/wOq9rMkDL/qRj55RdO0ijLCO/Rqtbg8MeK5sgL2llH0
	KG6PLJf2Ngw7JWpBZ53zmoO8x/bV4xvnSHjJoVHhQstRu8AnEU6rJNo3AskGRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yki5e5oO4izSs6rd2/tDNyuThhIlQsX5cTWT4NrlmH8=;
	b=eTVcrcctnpn12jTcZJV7BVFSZ6qHeLrint9d3KbBoFbsTsD8y6AO2DjHNbgg6ArLxOJXIB
	Edd0QDUOj/BbE6Dg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 04/12] serial: xilinx_uartps: Use helper function hrtimer_update_function()
Date: Mon, 28 Oct 2024 08:35:48 +0100
Message-Id: <54e35633347affb842c064dcad8d4b654bb112c6.1729865740.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865740.git.namcao@linutronix.de>
References: <cover.1729865740.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a new helper function hrtimer_update_function() to change the
hrtimer's callback function, which also performs additional runtime check
that it is safe to change the callback.

Use the helper function instead of accessing 'function' directly.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/xilinx_uartps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx=
_uartps.c
index 4e9a63590c82..680db4830ab5 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -454,7 +454,7 @@ static void cdns_uart_handle_tx(void *dev_id)
=20
 	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED &&
 	    (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port))) {
-		cdns_uart->tx_timer.function =3D &cdns_rs485_rx_callback;
+		hrtimer_update_function(&cdns_uart->tx_timer, cdns_rs485_rx_callback);
 		hrtimer_start(&cdns_uart->tx_timer,
 			      ns_to_ktime(cdns_calc_after_tx_delay(cdns_uart)), HRTIMER_MODE_RE=
L);
 	}
@@ -734,7 +734,7 @@ static void cdns_uart_start_tx(struct uart_port *port)
=20
 	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
 		if (!cdns_uart->rs485_tx_started) {
-			cdns_uart->tx_timer.function =3D &cdns_rs485_tx_callback;
+			hrtimer_update_function(&cdns_uart->tx_timer, cdns_rs485_tx_callback);
 			cdns_rs485_tx_setup(cdns_uart);
 			return hrtimer_start(&cdns_uart->tx_timer,
 					     ms_to_ktime(port->rs485.delay_rts_before_send),
--=20
2.39.5


