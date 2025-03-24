Return-Path: <linux-kernel+bounces-574458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01B4A6E59F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90583B083E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5461EEA4A;
	Mon, 24 Mar 2025 21:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="W3u3psfV"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D961C84A6;
	Mon, 24 Mar 2025 21:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742851081; cv=none; b=TVKAOXaNhDy7Jps+GXAYmGEOmn6dZOdXPhsQ3XBzLKwTZSlOHI4nai+NEiVWG7f19FC7VZAEFnzRfwfdNmJV0X/BO4DsEpngCgKZZmGh7HkaO0uwNHrBRaNifFZ8GYGIAyHlpM8va9F/GVyrp7dRpOUvVD07/4h+PSOrDbZgOgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742851081; c=relaxed/simple;
	bh=mJsv2tM/I8C66voig+fQdm4mxuvEjmzB9vpmbCCufdw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=i7xp+uvUmAq5LEOZrxhHfyzDLDO6wSaNCynGnJ6Wn20RDBJfzM8Rr6y3LrEEI95BQIIv0LJzE3n30UtlpuI1NvAI8LHJ8SQGJ4eq6pL3yPeXtP2b5pFmj51eMB7nz6vijKKTSkT/GFvRRzk+dWDJ2XDYgFtl1wyASkTAgjg6mTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=W3u3psfV; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1742851078; x=1743110278;
	bh=5qEU6hzSwCnesMZRIBLEpCHkGx+ziAMm4+Nl/oZk6/U=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=W3u3psfVFNmlYr2QRKE+T28JwhbnUMZWpr5pvtgrL1FVnuP6/dVgLo/HXPlxu7SNZ
	 a3EFq4dxuKD3uGbD37eLHYuJZIQ0gEgWuu1COpZMddFKUAYgqMa+W4PgIBx8kk7c5F
	 lyaKivdhAptV0Tl4vT/VYbSBWpMrBq5Q7xLAKE6WvkNEn9BA8eZN+pWWkBxOJnXE2y
	 UuwO6w+dnJ+1yvfjySNuSmRqEUceYd0Ouz6anflVEC3UyczF385Zz9iUwXB9FCRiO+
	 VRwI12xLS/MaOIPSqhozjdZK9h2xuzEaFa73oyx+AkaBnQ0XNYtTZYtdeWipEfEcnB
	 jAzIYbINkMBAg==
Date: Mon, 24 Mar 2025 21:17:51 +0000
To: Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH v2 0/6] USB: serial: ftdi_sio: Code style cleanup
Message-ID: <20250324211619.166988-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 48665214b25ed0d05a716823232cb0476881dae4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series fixes spotted code style issues in ftdi_sio driver.

v2: Split the patch into smaller patches

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>

Dominik Karol Pi=C4=85tkowski (6):
  USB: serial: ftdi_sio: Remove space before comma
  USB: serial: ftdi_sio: Add missing blank line after declarations
  USB: serial: ftdi_sio: Remove superfluous space before statements
  USB: serial: ftdi_sio: Fix indentation made with spaces
  USB: serial: ftdi_sio: Fix misaligned block comment
  USB: serial: ftdi_sio: Remove space before tabs

 drivers/usb/serial/ftdi_sio.c     | 16 ++++++++++------
 drivers/usb/serial/ftdi_sio.h     |  2 +-
 drivers/usb/serial/ftdi_sio_ids.h |  4 ++--
 3 files changed, 13 insertions(+), 9 deletions(-)

--=20
2.34.1



