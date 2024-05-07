Return-Path: <linux-kernel+bounces-172504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6041B8BF2CE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 01:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2B4CB27936
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 23:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD35E13AA54;
	Tue,  7 May 2024 23:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="MOaqecEa"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8433212B148;
	Tue,  7 May 2024 23:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715124007; cv=none; b=rI5vxonSf0NCMU9VXfjbYZ3be+ns5cVLRIhaSPl4RbX9fyl4lPAU4/t+A29kAIK4SXV0YvF3YBhgBr70R5dmXR9iqIWpFxqNY8RxTZgfWb3c7jlkwWWBk+1iHscUWD1v8S2CEMNx8m04zAx0n/tROJpkheQSq7nnvVlMd1EbLFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715124007; c=relaxed/simple;
	bh=b/0FkzHkilB95lUbP7MEunDu86ZpEsqHeKZVNfq+xIQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MXKKs87FIjwrV8lqELe+BqW0DDvAlK/FPyKjJSM/vDVHuuD3Pw49k6aPw3JLfte9mkAzzQipLH5tJrUxWpKM9U/fHbvGBvSSJTJiEOOkbY29n+EVBCuOcMfY1KiezzsZmaueSVUYVtUOGdH+16o/3E8wLCj14V5RQJ/VeHfFspY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=MOaqecEa; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 99472120005;
	Wed,  8 May 2024 02:19:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 99472120005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715123999;
	bh=FTEc3DcCrnODzUlI904uenRxffR/nTndkV7UF8lCKs0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=MOaqecEa7KzpL1uHnPOVQMAfm++G+nohFnyBcWYFaRlh/G0AO9QWjk82Et1kkHApv
	 YDOkYJZt5Aar9dxZo5Cy2Hms33xkHc+AGcUS07i8C2OSlSQGZTiB8KaZtJUSzTqAnG
	 OP7pLGOXuyUQ8V9w/tThPVtkNlrt7QEDoOyC8izhFQzAodLGoiZjafSqOEXq98jBqd
	 R0zSh/eyDeuDttGiM+DeL9OoAXyWWIyJ/OxNWSfbvEaCbYwvkHHey23l5Sv1ktgK8P
	 2vy/Cz2tPB5M2HcbRB7gN+zCXH6TuwS+v+TtKXddyXVo+uzjmJJ4g14mGMg2FjlDwx
	 FvZ2+VVkv5mMA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed,  8 May 2024 02:19:59 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 8 May 2024 02:19:58 +0300
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>
CC: <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <oxffffaa@gmail.com>,
	<kernel@sberdevices.ru>, Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: [PATCH v6 0/3] Meson: R/W support for pages used by boot ROM
Date: Wed, 8 May 2024 02:09:00 +0300
Message-ID: <20240507230903.3399594-1-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.35.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185123 [May 07 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 19 0.3.19 07c7fa124d1a1dc9662cdc5aace418c06ae99d2b, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/07 17:58:00 #25118681
X-KSMG-AntiVirus-Status: Clean, skipped

Amlogic's boot ROM code needs that some pages on NAND must be written
in special "short" ECC mode with scrambling enabled. Such pages:
1) Contain some metadata about hardware.
2) Located with some interval starting from 0 offset, until some
   specified offset. Interval and second offset are set in the
   device tree.

This patchset adds R/W support for such pages. To enable it we can setup
it in dts:

    nand-is-boot-medium;
    amlogic,boot-pages = <1024>;
    amlogic,boot-page-step = <128>;

It means that each 128th page in range 0 to 1024 pages will be accessed
in special mode ("short" ECC + scrambling). In practice this feature is
needed when we want to update first block of NAND - driver will enable
required mode by itself using value from device tree.

Changelog:
 v1 -> v2:
  * Rename 'meson,boot-page-XXX' -> 'amlogic,boot-page-XXX'.
  * Add words that 'amlogic,boot-page-step' is measured in pages.
  * Remove words that 'amlogic,boot-page-XXX' depends on 'nand-is-boot-medium'.
  * Make both 'amlogic,boot-page-XXX' depend on each other also, in
    addition to 'nand-is-boot-medium' dependency.
 v2 -> v3:
  * Add quotes to 0001 in dependencies. This fixes 'make dt_binding_check'
    warning.
 v3 -> v4:
  * Rename 'amlogic,boot-page-last' to 'amlogic,boot-pages'.
 v4 -> v5:
  * Update 'description' fields in bindings.
 v5 -> v6:
  * Split patch for meson_nand.c to 2 patches: first is refactoring of
    scrambling mode handling, another is support for special pages for
    boot ROM.
  * Update description and commit message in the bindings patch.

Arseniy Krasnov (3):
  dt-bindings: mtd: amlogic,meson-nand: support fields for boot ROM code
  mtd: rawnand: meson: refactor use of 'meson_nfc_cmd_access()'
  mtd: rawnand: meson: read/write access for boot ROM pages

 .../bindings/mtd/amlogic,meson-nand.yaml      | 18 ++++
 drivers/mtd/nand/raw/meson_nand.c             | 86 +++++++++++++------
 2 files changed, 77 insertions(+), 27 deletions(-)

-- 
2.35.0


