Return-Path: <linux-kernel+bounces-544323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C72DA4E006
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE61717490C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFC72046BD;
	Tue,  4 Mar 2025 14:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="S8cuiZyj"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BC142A9E;
	Tue,  4 Mar 2025 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096921; cv=none; b=qVJgb7ITZuYIX2vmQQAlSmbLJMpNQO9fjVTEQZgs1olVg5Q9BHyXVNvkWafTiT6d4IPHdZQY1/hrJm1Gj6db3gZ+q21LkKiOS93nm2dKmrhbcwPKcSZUtzNpiZ18bILkqzxqy9ECyRygPqebC6CQ66/TQwXLFPxPisZV/no8tCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096921; c=relaxed/simple;
	bh=uiZsGkjVPALBqyMp/QBuYMSVQNJhd7VY33/kwzTcb58=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JK6bYaiUvA2yq2qScaD8OT11BSARJh+998xOhVGsBXo2oM6iQ2BGmoE559fRZAiIs4S9bevMOnFgAM3IkaMiGfysZvqszUb6cyJIaooWGrOWUsAOCBwfabR6b91SlY/f5gsnZYApyUW+fXFjgXMTwGuSHM5aza3MG4epcGp3reA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=S8cuiZyj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741096917;
	bh=uiZsGkjVPALBqyMp/QBuYMSVQNJhd7VY33/kwzTcb58=;
	h=From:Subject:Date:To:Cc:From;
	b=S8cuiZyjljT3JMmX+9hETnyOta6k0GRU4it8yY/35FwzmfIUlRkDOOAhB3hsbuCb1
	 bJWt2KEtORIXlLwHLjLrGKm0TxXbzfha3YVhR6sx39o1qsg4x+mMeKOfqTDoRTQm2R
	 L4PlWbdkq8dMTcfM7KKCwAd4JN0dvs6Z7O4tbDzrZH0GSamsZvQP1gb3aOCWyufwT9
	 dsmX42SS752HzjU0Jbk/BNMp6FtxXgIW56oGFCZPAfcvCdOVP0SuAjS9rZwTX66zoh
	 6qFqmCN4sLpwy0zFUAX5juohusVRIETqtOFOJv0EKiZziajDQLmsJ420rHem8BDpUe
	 1yavBZ+okHL5w==
Received: from apertis-1.home (2a01cb0892F2D600C8F85cf092d4Af51.ipv6.abo.wanadoo.fr [IPv6:2a01:cb08:92f2:d600:c8f8:5cf0:92d4:af51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 242AD17E087E;
	Tue,  4 Mar 2025 15:01:57 +0100 (CET)
From: Julien Massot <julien.massot@collabora.com>
Subject: [PATCH v2 0/2] mt8395-radxa-nio-12l: Add overlay for Radxa 8HD
 panel
Date: Tue, 04 Mar 2025 15:01:54 +0100
Message-Id: <20250304-radxa-panel-overlay-v2-0-3ee6797d3f86@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANIHx2cC/32NQQ6CMBBFr0Jm7Ris1FBX3sOwGNpBmlRKpqaBE
 O5u5QAu30v++xskFs8J7tUGwtknH6cC6lSBHWl6MXpXGFStdK3UDYXcQjjTxAFjZgm0om5U43q
 jjdEWynIWHvxyVJ9d4dGnT5T1OMmXn/3fyxes0XBrrq0beib3sDEE6qPQ2cY3dPu+fwFbL20Nu
 gAAAA==
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

Tested on top of linux-next tag:next-20250303

Signed-off-by: Julien Massot <julien.massot@collabora.com>
---
Changes in v2:
- Moved video pipeline enablement to the overlay (ovl0, vdosys0)
- Keep backlight disabled in the board dts, enabled in the panel overlay
- Test again on Linux next-20250303
- Link to v1: https://lore.kernel.org/r/20250226-radxa-panel-overlay-v1-0-9e8938dfbead@collabora.com

---
Julien Massot (2):
      arm64: dts: mediatek: mt8395-nio-12l: Prepare MIPI DSI port
      arm64: dts: mediatek: mt8395-radxa-nio-12l: Add Radxa 8 HD panel

 arch/arm64/boot/dts/mediatek/Makefile              |  2 +
 .../mediatek/mt8395-radxa-nio-12l-8-hd-panel.dtso  | 84 ++++++++++++++++++++++
 .../boot/dts/mediatek/mt8395-radxa-nio-12l.dts     | 45 ++++++++++++
 3 files changed, 131 insertions(+)
---
base-commit: cd3215bbcb9d4321def93fea6cfad4d5b42b9d1d
change-id: 20250226-radxa-panel-overlay-5424db95995c

Best regards,
-- 
Julien Massot <julien.massot@collabora.com>


