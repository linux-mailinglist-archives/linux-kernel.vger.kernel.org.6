Return-Path: <linux-kernel+bounces-256471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618F8934F09
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6567B20BA6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04A9140E30;
	Thu, 18 Jul 2024 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="gntoFL0+"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E26CDDB8;
	Thu, 18 Jul 2024 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721312523; cv=none; b=Be8yc5Tv+Q1tYxlKn25UPslSUtT+Q6bjJyy9kMhpukYSOaBsOgb12H4eyQ33aoGX12hirCVaKCl3Bdtnr0BP6qA+GNlP8/6CLx7X2CS77Mn62VoLnpn/1m3Fk+T6WNCloizpLctoR5YnL2zlDVjZM2uKROrRg4BM4iHefyOllOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721312523; c=relaxed/simple;
	bh=6Awzt8JGBUCfQi3+vkxjv14KSnCTjlN2BZqHQGDoIxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OEeJtySEwpUvb0qS+X90jKtza+Zv47F97ZCkI0OI47nAeIpZMluenPAQ7Bu7dslJEJov9LK8Q+ZOyrcrRfAtdwzIX/H6BrOW9JJ1fFSEHh8hpOCNoQ9NH559Yrt11GdficWGfkUEiMztZnpT7T94fjpXHd42oeHuCloJoZbpr+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=gntoFL0+; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 049A2100023;
	Thu, 18 Jul 2024 17:21:49 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 049A2100023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1721312509;
	bh=hv9yQJjhlaFavYGxLanR/jVIoSKLN0ySNfyS5FHaCQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=gntoFL0+4pb9iNHyZVdyAuF8qCor5uemLXT6B+t56M67fAySsNPyvsuIBc3jh5DoW
	 0JNDFZsQIn97aB0sHHcNziJSwHxwuVcSB8uLddEdePbO+EWmp4/HqiJyQ82qFs7YV9
	 JZfBuyfMxwOAFIYtDh5x2RPBKsZ9j/INfCN70bI+IRJguoKroYGqHn2qzjJREJr2H1
	 lXu2WSaoJkONNTFyQXmcA/Kvh9qRSwLSUynLczb8xypGHy9ZU7Q97xSYlu0HvN5Kcd
	 iNoKqd4dirhYI65hmGCAKLjRDGqb65m1c0gKhvTgjHShflY/Xdd4OgWi/1oTdSlNsN
	 FJF9FHs9t9vOw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 18 Jul 2024 17:21:48 +0300 (MSK)
Received: from [172.28.192.11] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 18 Jul 2024 17:21:48 +0300
Message-ID: <07b4e6b9-7448-45fb-b5a0-d069addb5dc2@salutedevices.com>
Date: Thu, 18 Jul 2024 17:20:32 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] reset: amlogic: move audio reset drivers out of
 CCF
To: Jerome Brunet <jbrunet@baylibre.com>, Philipp Zabel
	<p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-clk@vger.kernel.org>
References: <20240718095755.3511992-1-jbrunet@baylibre.com>
Content-Language: en-US
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <20240718095755.3511992-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186588 [Jul 18 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: n, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/18 08:50:00
X-KSMG-LinksScanning: Clean, bases: 2024/07/18 08:50:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/18 08:29:00 #26061289
X-KSMG-AntiVirus-Status: Clean, skipped

In previous series there was a patch "[PATCH 8/8] clk: amlogic:
axg-audio: use the auxiliary reset driver", but I don't see it here. Did
you removed it, or I missed something?


On 7/18/24 12:57, Jerome Brunet wrote:
> This patchset follows the discussion about having reset driver in the
> clock tree [1]. Ideally those should reside in the reset part of tree.
> 
> Also the code of the amlogic reset driver is very similar between the 2
> trees and could use the same driver code.
> 
> This patcheset alignes the reset drivers present in the reset and clock
> then adds support for the reset driver of audio clock controller found in
> the  g12 and sm1 SoC family to the reset tree, using the auxiliary bus.
> 
> The infrastructure put in place is meant to be generic enough so we may
> eventually also move the reset drivers in the meson8b and aoclk clock
> controllers.
> 
> Changes since v1 [3]:
>  * Fixes formatting errors reported by Stephen.
>  * Changed parameters type to unsigned
>  * Fix usage of ops passed as parameters, previously ignored.
>  * Return 0 instead of an error if reset support is absent
>    to properly decouple from the clock and have a weak
>    dependency
>  * Split the platform and auxiliary modules in 2 distinct modules
>    to fix the COMPILE_TEST error reported by ktest robot.
> 
> Change since RFC [2]:
>  * Move the aux registration helper out of clock too.
> 
> [1] https://lore.kernel.org/linux-clk/e3a85852b911fdf16dd9ae158f42b3ef.sboyd@kernel.org
> [2] https://lore.kernel.org/linux-clk/20240516150842.705844-1-jbrunet@baylibre.com
> [3] https://lore.kernel.org/linux-clk/20240710162526.2341399-1-jbrunet@baylibre.com
> 
> Jerome Brunet (9):
>   reset: amlogic: convert driver to regmap
>   reset: amlogic: use generic data matching function
>   reset: amlogic: make parameters unsigned
>   reset: amlogic: add driver parameters
>   reset: amlogic: use reset number instead of register count
>   reset: amlogic: add reset status support
>   reset: amlogic: move drivers to a dedicated directory
>   reset: amlogic: split the device core and platform probe
>   reset: amlogic: add auxiliary reset driver support
> 
>  drivers/reset/Kconfig                         |  15 +-
>  drivers/reset/Makefile                        |   3 +-
>  drivers/reset/amlogic/Kconfig                 |  27 ++++
>  drivers/reset/amlogic/Makefile                |   4 +
>  .../{ => amlogic}/reset-meson-audio-arb.c     |   0
>  drivers/reset/amlogic/reset-meson-aux.c       | 136 ++++++++++++++++
>  drivers/reset/amlogic/reset-meson-core.c      | 140 ++++++++++++++++
>  drivers/reset/amlogic/reset-meson-pltf.c      |  95 +++++++++++
>  drivers/reset/amlogic/reset-meson.h           |  28 ++++
>  drivers/reset/reset-meson.c                   | 153 ------------------
>  include/soc/amlogic/meson-auxiliary-reset.h   |  23 +++
>  11 files changed, 455 insertions(+), 169 deletions(-)
>  create mode 100644 drivers/reset/amlogic/Kconfig
>  create mode 100644 drivers/reset/amlogic/Makefile
>  rename drivers/reset/{ => amlogic}/reset-meson-audio-arb.c (100%)
>  create mode 100644 drivers/reset/amlogic/reset-meson-aux.c
>  create mode 100644 drivers/reset/amlogic/reset-meson-core.c
>  create mode 100644 drivers/reset/amlogic/reset-meson-pltf.c
>  create mode 100644 drivers/reset/amlogic/reset-meson.h
>  delete mode 100644 drivers/reset/reset-meson.c
>  create mode 100644 include/soc/amlogic/meson-auxiliary-reset.h
> 

-- 
Best regards
Jan Dakinevich

