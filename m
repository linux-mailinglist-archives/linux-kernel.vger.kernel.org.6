Return-Path: <linux-kernel+bounces-409659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 052719C8FD1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B04191F211C8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A9B189F39;
	Thu, 14 Nov 2024 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="DFxpS74M"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16CB185940;
	Thu, 14 Nov 2024 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601777; cv=none; b=IMVGVcfgcmVDr0mGm3b/aZNIeStqk1D8nPMAhz5S2/aDNukgTZ0cfzrz5dD7D2An842Zcou1h6VUYUF+Vi43tBBZ9HSqVlUasiKlP3GmyMA++9WDhl0dWEi6FrS+c1BuM0Wfu9qadawPO60dCaMQbZojNW/Mj3W8HdBWlf2PW6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601777; c=relaxed/simple;
	bh=A+ccMDY3cNPgQ7q1UDOiqkxn0oNKvGAxbY4GDo1WMKw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X+n7yUNY2Aeah+8e2Lzt2wIMlFmq22NmnaKRHfvaoyRlRVhPWFW2PeInUcZ+pZb1bCcWnR+J4NiEmYgo3q3tyb9D6NrPokpgAJhErPKHZVu8UXjbEiqOpq8lt3EJ4UlByPJO1hA3Umj0f89BTuJ4k0IQjffpSniYJLO5GlMrESA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=DFxpS74M; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id BD56D10000A;
	Thu, 14 Nov 2024 19:29:32 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru BD56D10000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1731601772;
	bh=GZw1ocqAf3SESs6AoLOS/AjZZcQZhWXXwDvFKs9mIIs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=DFxpS74Mp8yAY2ARaUr4JLNfd8z1s1Oe/NEo5eaGrNRh7bxsfjCO62Sa6ZoiIFiDY
	 QCOJGjDxVqfBIMwtMWyqI8a3QQT4wS6ns1KD0W0Ux4EuxJBYbxID2QhWSpZcrvf/cN
	 qoQ+0S8YjgYwKNofiVW5WDKa1iDyFsgm6rNdfM6rpjv08IxSqWuwmWo+UmO/hwrD01
	 m9D/8kXYjG0XLok7QgpykDGjGJ8vHoyLRX/aN2Rll2yL+IrEsvs3qjzgjp+ZZCGnva
	 A7Lavhcy8gAMcJ5s42dqneHcc/zAh/w1SjO2CSkGbEZYBwefV+S6pSGUXzG+ug1oUt
	 tUs9oieqjCalg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 14 Nov 2024 19:29:32 +0300 (MSK)
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Jerome Brunet
	<jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Martin
 Blumenstingl" <martin.blumenstingl@googlemail.com>, Michael Turquette
	<mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [RFC PATCH 0/3] Make several simplification of axg-audio driver
Date: Thu, 14 Nov 2024 19:29:23 +0300
Message-ID: <20241114162926.3356551-1-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189183 [Nov 14 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_smtp_not_equal_from}, smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:7.1.1,5.0.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/14 14:31:00 #26861614
X-KSMG-AntiVirus-Status: Clean, skipped

The series introduces several changes to axg-audio for Meson SoCs which makes
the driver little easier to read and allow to avoid possible errors.

Jan Dakinevich (3):
  clk: amlogic: axg-audio: use dev_err_probe()
  clk: amlogic: axg-audio: synchronize *_audio_hw_clks and *_clk_regmaps
    arrays
  clk: amlogic: axg-audio: get the rid of *_clk_regmaps

 drivers/clk/meson/axg-audio.c | 472 ++--------------------------------
 1 file changed, 24 insertions(+), 448 deletions(-)

-- 
2.34.1


