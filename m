Return-Path: <linux-kernel+bounces-448040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34309F3A37
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B81B163F47
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7306320C488;
	Mon, 16 Dec 2024 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="U2vTbyMT"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE52205AA8
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734378695; cv=none; b=u/Bfek5MwtXK5O5Yxjudv7jatOSLGWXzsBUjNOMt8WPDAkWT3OpN78+U/vUazLXgV76pdmBjDFeZS4LDcVMxF26NqFwXLsGXN24G3J59oVxNKYIc1nSwkjlQxQfAWAu9wMXhYRRbIW1QWupxv2Ts+M/ckz6QapitytHS+kFrsNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734378695; c=relaxed/simple;
	bh=vBX2Vf+dMmYBxIYAXJDj1ffDK4+bTutXNq5/laHlFvo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CSYbGayQvAq72DMQi+hqc9QpJUy/hZJKHxqK7ER0nOvGSmJfAezvdlBYPWYZdsEyaOxzcdd2d1/rxfaO7/4aLPePqVSYhVJ3E420uT3+jGH9Wc9sPjZq3097/S3kmipZstQelnCvtPyBf9OQp/u1Z6F4UQv5EsaSYCVkxWjeG6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=U2vTbyMT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734378691;
	bh=vBX2Vf+dMmYBxIYAXJDj1ffDK4+bTutXNq5/laHlFvo=;
	h=From:Subject:Date:To:Cc:From;
	b=U2vTbyMTixp52uXDeCeVDxyQ5nBLdG7oDCDgTR0gLZK+wYw77LuUoeSV8d4gQivJI
	 MyAb/2XenzfhshV4NW7k0B63gWrAhDjbDP1jEnrrUUeCP58VxETQgfQAhpzu5FWKmm
	 syzZya6tnFEgHIuafS+bIUCDat/3OD6D+jRK/yTGkIU7l3V1yZLe+H0qDaNdhICfYe
	 Sk1U6qhwoO7fc8DL0CwsIarOgNaifAklKDHwm0fvhcOJV6Jt346Dsh8PAt9PRTcy1E
	 3Q3XlTXSl2o9aHXBANbyby3XzVG2S6AFbVoLgbEe1uG+JIzRgYgaHOewhgvEkGOWqV
	 0QMMcF/eYpGpg==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1000])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2736917E3778;
	Mon, 16 Dec 2024 20:51:28 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Subject: [PATCH 0/2] arm64: defconfig: Configs for MT8188
Date: Mon, 16 Dec 2024 16:51:24 -0300
Message-Id: <20241216-genio700-configs-eth-sound-v1-0-04a719035d6e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALyEYGcC/x3MQQqEMAwAwK9Izgba6lbZr4gHqbHmki6NilD8u
 2WPc5kCSplJ4dsUyHSxcpIK2zYQ9kUiIa/V4IzrrbMeIwmnwRgMSTaOinTsqOmUFcdx8KHvPt4
 bBzX4Zdr4/ufT/Dwv9URWS2wAAAA=
X-Change-ID: 20241216-genio700-configs-eth-sound-8876c4356602
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: kernel@collabora.com, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

This series contains a couple configs needed for MT8188 platforms to get
working ethernet and sound.

Tested on the Genio 700 EVK.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Nícolas F. R. A. Prado (2):
      arm64: defconfig: Enable sound for MT8188
      arm64: defconfig: Enable MediaTek DWMAC

 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)
---
base-commit: e25c8d66f6786300b680866c0e0139981273feba
change-id: 20241216-genio700-configs-eth-sound-8876c4356602

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


