Return-Path: <linux-kernel+bounces-574463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E7EA6E5A9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C823B8A94
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C72C1F12E8;
	Mon, 24 Mar 2025 21:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="VHbt574b"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846FD1EDA1E;
	Mon, 24 Mar 2025 21:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742851112; cv=none; b=FjxprbkvST9tGFQm0go0VQvG1/b1fYxv0DFjpL8foR010lTstRxXHPoaCQbLs77efhaqqWlxZGEZ1KQlK/gpazuMq0VaxMQLF5a/18oxoT6/P1qM8NuKXfTxj/05N3qpT1dx5wVckbJoVYBEDKcfq3o9ullNSR9JOj2jC4UPcT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742851112; c=relaxed/simple;
	bh=c4E++3f2MDMsNPMEJdXDfgwYQoGSbwjYzUZTLh3w6c8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=usiATzEEvqcGz+WsnHrAE8J6vJniXmnOv8CQ7I/SQEwd3oVJ1yl1a2iIYmuWwNeErD0Wp30/JPPg6kizcSDy6uQ5/NNylkDYymLfezwAH47YAX6ufibTZLqxIKGMjIuTewSwqTtt+avxDaPkEpRS9BUiShoUm6mzbJ1hXolWM04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=VHbt574b; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1742851108; x=1743110308;
	bh=6DixGtBaeZaFqPX3S+avGICBN1tFkPrHCpETt4l8pPk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=VHbt574by1tm+h6WWTttP9EZ0CDO0qnamTy58fhMkSXXhL58G4XT/HWkeVfmHTyAp
	 JDLhRYtRJeBPoSGj4+3ZMZttB842ZXOIATbw58O5j4kRra/u/YpnTIsw9gky12bj7t
	 LmDAr2CbIzHQJBybqGFJNAC4RZn2+5W+reYTT9v2Uv6yflv7Z4Vi8Y7OK68ymaTtDN
	 TPpIO5mSOcOVgnQr0GjxYYKrnytoqbCNsmtcoi0e2oRnlzRf0X9d26xtzt/l1OYzmF
	 TCQlyO/I1AG+2WrwQyy5MRdwfFziCDfpZ2P2ZMjF6oczeNVXX0jRezRep85IBlNvqx
	 F8w1dAoWSIACA==
Date: Mon, 24 Mar 2025 21:18:23 +0000
To: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH v2 5/6] USB: serial: ftdi_sio: Fix misaligned block comment
Message-ID: <20250324211619.166988-6-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20250324211619.166988-1-dominik.karol.piatkowski@protonmail.com>
References: <20250324211619.166988-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: f611cdb4109628a58b1b61b518af79d1bb384640
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

One of the block comments was misaligned. Fix it to align with code
style.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---

v2: Split the patch into smaller patches

 drivers/usb/serial/ftdi_sio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/ftdi_sio.h b/drivers/usb/serial/ftdi_sio.h
index 55ea61264f91..d671d2194c64 100644
--- a/drivers/usb/serial/ftdi_sio.h
+++ b/drivers/usb/serial/ftdi_sio.h
@@ -95,7 +95,7 @@
  *
  * The Purge RX and TX buffer commands affect nothing except the buffers
  *
-   */
+ */
=20
 /* FTDI_SIO_SET_BAUDRATE */
 #define FTDI_SIO_SET_BAUDRATE_REQUEST_TYPE 0x40
--=20
2.34.1



