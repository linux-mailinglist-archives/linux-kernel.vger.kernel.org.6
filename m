Return-Path: <linux-kernel+bounces-384334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016059B2934
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7891C2175B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D611F472C;
	Mon, 28 Oct 2024 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HBG2TeAY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xbd6A/Xp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064D21E25F6
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100940; cv=none; b=JuAwQnQeNPa3+9wNQTwFQTn/2pBslOmkgvVZQA9oQKguj4rEHXWg4N2jlaaCXJmTllhKvbFETu4NUzZrvCr4DZepKGXrMstizur8Qmc9ZqPmVINiAWtcrkQRsTduUuBy7wR0WW8qEvVVIZeOjsYA2FSOMj/tceuNbO4IjBjerhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100940; c=relaxed/simple;
	bh=jwCoo4G8+sru4QpULFH1Gt1qFNp5mlI4VBikKVY3srA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z+7K71sItwUsQuzpRJV/5Y6UQZ6TAvG/th/u7SxnKfkfR5mAfwPGrw+qx/p23qRe1rCN7uGpqcC82ijJkAc2bZuw33MLeG6sz4Vy7SJVPggIrPZdSRxMIaXN5vpAi0U2lE7611HLwKNACrpfKeoF762wwrJhxnfXGuhfmEPktvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HBG2TeAY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xbd6A/Xp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h49iAgyP9GxJPZCVix3xERtV73NW1YoYxvNa4f7RK9k=;
	b=HBG2TeAYdc6KO0y8lORTD4n9MCqmspa6yJwcJxe/9svvDjmlZJA9br/RHmFz4UFgQTTW8m
	t+o1qpDved3pGwGn8QqoUb0ITyAAhCY8ZDWBe6tbNyOfmYI9K8VbAyqbN0C++NSH7Q2Qqc
	SVynFcpI7QybSPCHe2sPWG19BkYXCMZ8If4/SpVGbBEZZLXvVhk4N2HQqBE0ohB78i/z2H
	AjmcRGw+iBnv/QxrePdTY30lXCCPlNIOSgBkqdc3iAUNVdCjwfyxSP+Ovlu/cxAboHXG2y
	EiwB29g33NhMQy2m2JoWqGODiDi1bHnZkLb/qjVeEnMtlSzN4j3ji1xBqk00yA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h49iAgyP9GxJPZCVix3xERtV73NW1YoYxvNa4f7RK9k=;
	b=xbd6A/XpphtzKbE3ratDbubr2LIj99NQN/djfj6dA+Vkx9MMcWCRHC7UCd4eIBGgwNeJWJ
	Qk9FDPkscoA4yGAw==
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
Subject: [PATCH 11/44] serial: xilinx_uartps: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:47 +0100
Message-Id: <c5943b3680b8599065a735a21d44f5688b4aae53.1729865485.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865485.git.namcao@linutronix.de>
References: <cover.1729865485.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a newly introduced hrtimer_setup() which will replace
hrtimer_init(). This new function is similar to the old one, except that it
also sanity-checks and initializes the timer's callback function.

Switch to use this new function.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/xilinx_uartps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx=
_uartps.c
index 777392914819..4e9a63590c82 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1628,8 +1628,8 @@ static int cdns_rs485_config(struct uart_port *port, =
struct ktermios *termios,
 		writel(val, port->membase + CDNS_UART_MODEMCR);
=20
 		/* Timer setup */
-		hrtimer_init(&cdns_uart->tx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		cdns_uart->tx_timer.function =3D &cdns_rs485_tx_callback;
+		hrtimer_setup(&cdns_uart->tx_timer, &cdns_rs485_tx_callback, CLOCK_MONOT=
ONIC,
+			      HRTIMER_MODE_REL);
=20
 		/* Disable transmitter and make Rx setup*/
 		cdns_uart_stop_tx(port);
--=20
2.39.5


