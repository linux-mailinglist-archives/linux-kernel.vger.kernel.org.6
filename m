Return-Path: <linux-kernel+bounces-305187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1EB962AAC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90EC31C20CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A34199FB9;
	Wed, 28 Aug 2024 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Az+KiR/+"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380C6175D28
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856426; cv=none; b=AZYUAX++Drc2DTwt7t+cC75A30Dd8mwBlV01c+I6fsmfMrCwoauNMCIp2u0rtEjFn9S2fJzyjUMl1TBSwcnhVTBGViqFmnFYxpvmejM0D6REWGTq6BSQgH4xtNzPsbOTkjRf5Sud8mXxuRMTlb5O6zhLfUV3kG7l4Uf6bGNa8TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856426; c=relaxed/simple;
	bh=eZO/kARPCirTZtVtx+L9XRGl0bLl8QfAxru2P/VZsHE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=g4mGBHtDZNLsEH9bD19B+k0+FAPo0lqb+rrRVH2iWh6hWslHEub4L0TDkQPSpSKS4odVIBf4BBRXwoeSvpZNauKUHCoM0MfxzMtRl2l3mwy0775TX6eEALEZWNY8Kwp7oLOI/5XYLbkFk0djCVjv+6KCaNb4o2LXHRDfyNPHwf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Az+KiR/+; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1724856422; x=1725115622;
	bh=eZO/kARPCirTZtVtx+L9XRGl0bLl8QfAxru2P/VZsHE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Az+KiR/+vpQjrGpHc15J0018Dde49koHtW/u6tH2vGdDNho5xjjHjq/EPU+EAO4tw
	 KGO2Kicv7mgyskULnDZ+OZMu32G0GsUxBQPY1dYt0qUQhAYgn7AqXt8WmoTK0qBFVi
	 laDFYfbo5QKvLTbSSnoCl8lOWf2c7WzCDEm2f1ApX54cokH+9Q5anx7M//pMPTgkts
	 4dDXt0Zb27YhPW/41p5dWhfijuzRyVYpxAIt4cRFA4b4Wqaw/oVIRWhMnp9gsSkWNj
	 NFt7pv0MZAXjVIZaH2QEfNxYYjvDti3G/Ns9d9WlYeCjFqspI2o3w3ym7576O26mYS
	 AD0oteh/MJgcQ==
Date: Wed, 28 Aug 2024 14:46:56 +0000
To: philipp.g.hortmann@gmail.com, gregkh@linuxfoundation.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH] staging: vt6655: Update maintainer in TODO
Message-ID: <20240828144545.76022-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 1573afea486796004b2505f0265401162278c3ad
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Commit ed394dbf5371b03a5335a7ba1973ba124c0ced3d replaced Forest Bond
with Philipp Hortmann as vt665X maintainer in MAINTAINERS, but
drivers/staging/vt6655/TODO was not changed, rendering it stale. This
patch fixes it.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/staging/vt6655/TODO | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vt6655/TODO b/drivers/staging/vt6655/TODO
index 63607ef9c97e..529bc22cd608 100644
--- a/drivers/staging/vt6655/TODO
+++ b/drivers/staging/vt6655/TODO
@@ -18,4 +18,4 @@ TODO:
 - integrate with drivers/net/wireless
=20
 Please send any patches to Greg Kroah-Hartman <greg@kroah.com>
-and Forest Bond <forest@alittletooquiet.net>.
+and Philipp Hortmann <philipp.g.hortmann@gmail.com>.
--=20
2.34.1



