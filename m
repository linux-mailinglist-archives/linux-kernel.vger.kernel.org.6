Return-Path: <linux-kernel+bounces-168836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7A28BBE4E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 23:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F9128220A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 21:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522BD84E02;
	Sat,  4 May 2024 21:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="bmJOHpxd"
Received: from mail2.andi.de1.cc (vmd64148.contaboserver.net [161.97.139.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B14F17578;
	Sat,  4 May 2024 21:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.97.139.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714859640; cv=none; b=flCYWkHXn4ePYrBKi2DV5JHNiDA4Xd8+v1wfhpCyRIAD8bUPqaiVvdMyUZe9EGKnaYxh+oXi4voDn/BW3OT6maXW3CHE2clwqCgCBEv8KK14W+Mtm5NsCmElypAKbLC/48CbwP78UiOnz2pOPhM+y2OWeBTaLlXbYMRZKEHWUNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714859640; c=relaxed/simple;
	bh=xxmBtKWGvdkIJdYjdgbPDF52rIe+e3/MBmvVib6SB4A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nOQ8M009oG51hxayBgCT9mt0SYh0bVTQwOZsj+ksSvnh8zy5+cBWDLc/cuEp137qBq+FL+qCFYHljW7p+4xoTiVyosRpELBDRb8rJBjpvOn6K+qK+9LWcfBYPgUDZ7EkEV5zCIZXWeDtGllhi21Tim0QWCskEvaojgnHK1cd0Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=bmJOHpxd; arc=none smtp.client-ip=161.97.139.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Received: from mail.andi.de1.cc ([2a02:c205:3004:2154::1])
	by mail2.andi.de1.cc with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s3NKI-005iKv-0e;
	Sat, 04 May 2024 23:53:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2RcawxP+jTrDT6qeee4zOoQzPnevlA0bkObGmQR6Z3Y=; b=bmJOHpxd5DQQvlxGcWBSpSAPsT
	5fND490WLv/7KpNaL2Mx93GZE5D8gJmGjh/e5xcukV/sgxXTlmEl4Pa4+Azizjl+TehTxVOQKjmAH
	nw5gxX4+8MVVpiqvE6fsBWCIfXZ9sEsneYTeHKDl4TyUyDHmH0/i281mkBVMA/BhIgTa+VK7ttY6e
	Yso/UtTF/+djGsy7tSUrWFs0yJNK9TvWeDXMeLJI+5m7mvR8n93aWLTheZoMdh+dPyIOriXs3VMNm
	4bV0DdxyxqZ3Q18bS1/rj+GiOmcnODHgd8gg27NwqL3QzKSyitntx/09H80cw0U0zbNWJ7GIo+fS6
	nzSqRVdw==;
Received: from p200300c20737c2001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:c2:737:c200:1a3d:a2ff:febf:d33a] helo=aktux)
	by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s3NKE-000aXc-2K;
	Sat, 04 May 2024 23:53:48 +0200
Received: from andi by aktux with local (Exim 4.96)
	(envelope-from <andreas@kemnade.info>)
	id 1s3NKF-003c4X-1X;
	Sat, 04 May 2024 23:53:47 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	marex@denx.de,
	leoyang.li@nxp.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 0/2] ARM: dts: mix: Add Kobo Clara HD rev B
Date: Sat,  4 May 2024 23:53:42 +0200
Message-Id: <20240504215344.861327-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apparently there exists another revision of the Kobo Clara HD
which has just different regulator setup. So add support for it.

For details: https://gitlab.com/postmarketOS/pmaports/-/issues/2356

Andreas Kemnade (2):
  dt-bindings: arm: fsl: Add Kobo Clara HD rev B
  ARM: dts: imx: Add Kobo Clara HD rev b

 .../devicetree/bindings/arm/fsl.yaml          |  6 ++
 arch/arm/boot/dts/nxp/imx/Makefile            |  1 +
 .../dts/nxp/imx/imx6sll-kobo-clarahd-b.dts    | 79 +++++++++++++++++++
 3 files changed, 86 insertions(+)
 create mode 100644 arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clarahd-b.dts

-- 
2.39.2


