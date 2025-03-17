Return-Path: <linux-kernel+bounces-564127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D04A64E26
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F143B3251
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B10243953;
	Mon, 17 Mar 2025 12:07:52 +0000 (UTC)
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1B224290C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742213271; cv=none; b=B4OMKViszX7+tiOI9yD5ooHupiGd/sDpTw3hzRyGvSqEZj/sc8VY132gz04r6wZV/hofsNZYvbAjrC84mqhAOf9PoD0M2uQ8GvdcJZ5/gpOSd6EGBCJdM8e+vvUD+O3oIGFLM3QNmkFi4Xmxi/DetSGDyvNgGhGWOHkbnnME2fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742213271; c=relaxed/simple;
	bh=73vrbXVGsCmOtAsR8R2dh8FZRfQxfkbOvNreIJaNnoU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Yx2TsmMwQUb3k2PSdsgxX7PUgz4XBDUJoAoOeOccFMvzrReZEIlsrT9wP3nmDqVnyadoOOVRddQODwGIdCxG/HUNHoEXBJ6h5nTSSTjIWDORrQ3IrzHKtOwsc/0dplXGxj1j3RDGbX11bbg6qZpUyEvXQXxcLmzdzpsRAeHx6z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZGYd82wt6zJ20;
	Mon, 17 Mar 2025 13:07:40 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZGYd75JMlzJG0;
	Mon, 17 Mar 2025 13:07:39 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Subject: [PATCH 0/2] arm64: dts: rockchip: enable HDMI audio on RK3588
 Jaguar and RK3588 Tiger Haikou
Date: Mon, 17 Mar 2025 13:07:25 +0100
Message-Id: <20250317-tsd-rk3588-hdmi-audio-v1-0-0b8ceb9597a6@cherry.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH4Q2GcC/x3MTQqAIBBA4avErBvQpLKuEi0sxxqiH7QikO6et
 PwW70UI5JkCtFkETzcH3rcEmWcwzmabCNkmQyGKUihZ4xks+kWVWuNsV0ZzWd5xFGSEk2aodAO
 pPTw5fv5v17/vB93IqlNnAAAA
X-Change-ID: 20250317-tsd-rk3588-hdmi-audio-c0ea0f1ab689
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha

Both have an HDMI TX port and can carry audio, therefore let's simply
enable the nodes required to get HDMI audio on that port.

This is based on next-20250314 and the following series needs to be
applied in order to reach userspace:
https://lore.kernel.org/linux-rockchip/cover.1741886382.git.robin.murphy@arm.com/

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (2):
      arm64: dts: rockchip: Enable HDMI audio output for RK3588 Jaguar
      arm64: dts: rockchip: Enable HDMI audio output for RK3588 Tiger Haikou

 arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts       | 8 ++++++++
 arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dts | 8 ++++++++
 2 files changed, 16 insertions(+)
---
base-commit: da920b7df701770e006928053672147075587fb2
change-id: 20250317-tsd-rk3588-hdmi-audio-c0ea0f1ab689

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>


