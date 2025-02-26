Return-Path: <linux-kernel+bounces-534119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C31A462FD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A421898265
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E01221712;
	Wed, 26 Feb 2025 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="J5zYn80V"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B471A238B;
	Wed, 26 Feb 2025 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580554; cv=none; b=V1J9SBwtnpk5WsLl80FQG4yIsXITLSECrLC5f+lBV5WMImIhEKNx7wAn18C1jgGO2RcTNFlnDBddT2BlhqJVAMI7fcBfmZs7GvFHqekRgzFr2keDOZzwy3InlNzFFl9hB51ceTxw/mXifNCP2+FRkICSaUI81qec2Xly1X04haA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580554; c=relaxed/simple;
	bh=A5VQdEengpn4Lj83aQmBrB3YzBMuMsERvJHgZH4EMC4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E0COlo6WI7fngrwk9VnoWl7ED+cU2Yut/iUEP/91/zBsYF0IQhNA82d6rSgrjsoBm1/eCtR6S7SB08V+nAyMsjYfIt/477+BwMOoGsGXv1f0CHQ6n9vXF0wy1H8tdcmQzhANgCf7dpQO8VsTLsP4OKvvvsIfQNTTpBz5+j1tD9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=J5zYn80V; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740580550;
	bh=A5VQdEengpn4Lj83aQmBrB3YzBMuMsERvJHgZH4EMC4=;
	h=From:Subject:Date:To:Cc:From;
	b=J5zYn80VWULdUPgpp5pVm0O+ha4PKogDNV6tqzCssMLhjqbjR1Nu/2Ih3PFhjrpb6
	 5hayY+ce8nQhjBvmVxs8+MhPYg52cXMM07StOREaDyi2QrFjpA3JVmalM3OEpVq5db
	 xea5RGYe7hG5ndBbMe8Gcy3dQsmnA6yEQlANteKT2lQkYJ19yGlkZq4vm+TY9k2Xtq
	 LgMMiUJZ1BFNxlAsqyWxw/uwI0sUX3w5aDeRVGKZTjgveTXl2P4ncyIc8bVCiQqZQX
	 JWmFYqgvTvCHV20as0YQ9AkUfoKFbSpWSF3gvsBmzExufywuMfFV7eZyEqgPDU3soO
	 Hb1bS26StSg0A==
Received: from apertis-1.home (2a01cb088CcA73006086F5F072c6a07a.ipv6.abo.wanadoo.fr [IPv6:2a01:cb08:8cca:7300:6086:f5f0:72c6:a07a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5789817E05C1;
	Wed, 26 Feb 2025 15:35:50 +0100 (CET)
From: Julien Massot <julien.massot@collabora.com>
Subject: [PATCH 0/2] mt8395-radxa-nio-12l: Add overlay for Radxa 8HD panel
Date: Wed, 26 Feb 2025 15:35:26 +0100
Message-Id: <20250226-radxa-panel-overlay-v1-0-9e8938dfbead@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK4mv2cC/x3MwQpAQBCA4VfRnE0xWbVeRQ7DDqa0NFsieXeb4
 3f4/weSmEqCrnjA5NSke8yoywKmleMiqCEbqCJXEbVoHC7Gg6NsuJ9iG9/oGmrC6J33boJcHia
 zXv+1H973AysLjMxlAAAA
X-Change-ID: 20250226-radxa-panel-overlay-5424db95995c
To: kernel@collabora.com, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 kernel@collabora.com, Julien Massot <julien.massot@collabora.com>
X-Mailer: b4 0.14.2

Hi,
small series to enable a DSI panel on Radxa NIO 12L.

The first patch adds missing dts nodes to expose some
feature of the DSI0 port.

The second patch adds the Radxa 8 HD panel as an overlay.

Tested on top of linux-next tag:next-20250226

Signed-off-by: Julien Massot <julien.massot@collabora.com>
---
Julien Massot (2):
      arm64: dts: mediatek: mt8395-nio-12l: Prepare MIPI DSI port
      arm64: dts: mediatek: mt8395-radxa-nio-12l: Add Radxa 8 HD panel

 arch/arm64/boot/dts/mediatek/Makefile              |  2 +
 .../mediatek/mt8395-radxa-nio-12l-8-hd-panel.dtso  | 64 ++++++++++++++++++++++
 .../boot/dts/mediatek/mt8395-radxa-nio-12l.dts     | 60 ++++++++++++++++++++
 3 files changed, 126 insertions(+)
---
base-commit: 8433c776e1eb1371f5cd40b5fd3a61f9c7b7f3ad
change-id: 20250226-radxa-panel-overlay-5424db95995c

Best regards,
-- 
Julien Massot <julien.massot@collabora.com>


