Return-Path: <linux-kernel+bounces-404198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 578D79C40B8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 15:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D602A1F22749
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D3B19F438;
	Mon, 11 Nov 2024 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="D4YnzTza"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104F219E994
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334746; cv=none; b=WLJlss/239OrIjP/oYLkhN+uhDXzM/4uT9Puj7GiwNh9l7FhPuZnJXlT0LalflvupO4NIo7pcuGThVNTmF0fIHnSJgUw8K1m0cZCzZj6dW9SNSZIoNYnpxRvZPXsA9yU5bhzakjbPGHeIvMMD2L+TOPARKd8+NvfDU8x05wUeLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334746; c=relaxed/simple;
	bh=lMzik5o2zBHszPj4x+VSYPUbKw9fMBzUfko7NQ0We7U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=OTAcTJ+P3oEdyVPQNz7UcXu3vtsPqFC6Id7h4ppjS+g5cuDWVPLveXAp2DBtfCQkEAL8UwHwz63ZvwCGJzsu9y4COxtWnym7i8T1sKqTJ+iWGxHGmiVJ/Nyq3PzAjIoNB8Zm/VvKdWFgtvUu3nzJIArVxbyUvnU/OtpBp3kdvzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=D4YnzTza; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 52B6042118;
	Mon, 11 Nov 2024 14:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1731334733; bh=lMzik5o2zBHszPj4x+VSYPUbKw9fMBzUfko7NQ0We7U=;
	h=Date:From:Subject:To:Cc;
	b=D4YnzTza0fBoik+WOmYIyrsxf8zA8ajYxQ0QtEMPHp2RzeP68lKmAszEPSlkblLM6
	 xP6lk1DLEKImX4ZrMMr6yNyjqagpss04e9sP1gISIG4tfyA8Om+DCoQ9aim3mIxpSp
	 YeX42KTwIWZRKhcLcd/TooOtsTKBkLXVI4SUuOOlzX4RhkSyHyqLY/kAj3VwlWrrIK
	 j6RgjIuBge/Vgde9HV+CoB26x/NGZRFp5pb+XnU2j2e7zaFpEZk/AUJlWEEMEanExS
	 tXZtzLO5KK57JA86E1LtuB2OjLv2mEMkr0QxQHu85qC/kJQMnuRUQbgsNJyjdEGmMM
	 bhGmXnY9NbSTg==
Message-ID: <a8a19596-5d46-4562-9555-3b3ae7a5a3e5@marcan.st>
Date: Mon, 11 Nov 2024 23:18:52 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hector Martin <marcan@marcan.st>
Subject: [GIT PULL] Apple SoC DT updates for v6.13
To: SoC Team <soc@kernel.org>
Content-Language: en-US
Cc: Asahi Linux <asahi@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi SoC folks,

Please merge these DT changes for v6.13.

This batch adds a bunch of pre-M1 Apple iDevice SoC and board device
trees. These are bare-bones right now, just basic bring-up.

-Hector

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  https://github.com/AsahiLinux/linux.git tags/asahi-soc-dt-6.13

for you to fetch changes up to 5c9de6f45db36b8a74c12e448cf9db87c97bf1e5:

  arm64: Kconfig: Update help text for CONFIG_ARCH_APPLE (2024-10-26 00:14:46 +0900)

----------------------------------------------------------------
Apple SoC DT updates for 6.13:

- Added base DTs for a bunch of non-Mac Apple iDevices (pre-M1)

----------------------------------------------------------------
Konrad Dybcio (8):
      arm64: dts: apple: Add A7 devices
      arm64: dts: apple: Add A8 devices
      arm64: dts: apple: Add A8X devices
      arm64: dts: apple: Add A9 devices
      arm64: dts: apple: Add A9X devices
      arm64: dts: apple: Add A10 devices
      arm64: dts: apple: Add A10X devices
      arm64: dts: apple: Add A11 devices

Nick Chan (12):
      dt-bindings: arm: cpus: Add Apple A7-A11 CPU cores
      dt-bindings: watchdog: apple,wdt: Add A7-A11 compatibles
      dt-bindings: pinctrl: apple,pinctrl: Add A7-A11 compatibles
      dt-bindings: arm: apple: Add A7 devices
      dt-bindings: arm: apple: Add A8 devices
      dt-bindings: arm: apple: Add A8X devices
      dt-bindings: arm: apple: Add A9 devices
      dt-bindings: arm: apple: Add A9X devices
      dt-bindings: arm: apple: Add A10 devices
      dt-bindings: arm: apple: Add A10X devices
      dt-bindings: arm: apple: Add A11 devices
      arm64: Kconfig: Update help text for CONFIG_ARCH_APPLE

 Documentation/devicetree/bindings/arm/apple.yaml   | 160 +++++++++++++-
 Documentation/devicetree/bindings/arm/cpus.yaml    |   8 +-
 .../devicetree/bindings/pinctrl/apple,pinctrl.yaml |   5 +
 .../devicetree/bindings/watchdog/apple,wdt.yaml    |   5 +
 arch/arm64/Kconfig.platforms                       |   4 +-
 arch/arm64/boot/dts/apple/Makefile                 |  53 +++++
 arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi         |  51 +++++
 arch/arm64/boot/dts/apple/s5l8960x-air1.dtsi       |  51 +++++
 arch/arm64/boot/dts/apple/s5l8960x-common.dtsi     |  48 +++++
 arch/arm64/boot/dts/apple/s5l8960x-j71.dts         |  14 ++
 arch/arm64/boot/dts/apple/s5l8960x-j72.dts         |  14 ++
 arch/arm64/boot/dts/apple/s5l8960x-j73.dts         |  14 ++
 arch/arm64/boot/dts/apple/s5l8960x-j85.dts         |  14 ++
 arch/arm64/boot/dts/apple/s5l8960x-j85m.dts        |  14 ++
 arch/arm64/boot/dts/apple/s5l8960x-j86.dts         |  14 ++
 arch/arm64/boot/dts/apple/s5l8960x-j86m.dts        |  14 ++
 arch/arm64/boot/dts/apple/s5l8960x-j87.dts         |  14 ++
 arch/arm64/boot/dts/apple/s5l8960x-j87m.dts        |  14 ++
 arch/arm64/boot/dts/apple/s5l8960x-mini2.dtsi      |  51 +++++
 arch/arm64/boot/dts/apple/s5l8960x-mini3.dtsi      |  14 ++
 arch/arm64/boot/dts/apple/s5l8960x-n51.dts         |  14 ++
 arch/arm64/boot/dts/apple/s5l8960x-n53.dts         |  14 ++
 arch/arm64/boot/dts/apple/s5l8960x.dtsi            | 113 ++++++++++
 arch/arm64/boot/dts/apple/s800-0-3-common.dtsi     |  48 +++++
 arch/arm64/boot/dts/apple/s8000-j71s.dts           |  15 ++
 arch/arm64/boot/dts/apple/s8000-j72s.dts           |  15 ++
 arch/arm64/boot/dts/apple/s8000-n66.dts            |  15 ++
 arch/arm64/boot/dts/apple/s8000-n69u.dts           |  15 ++
 arch/arm64/boot/dts/apple/s8000-n71.dts            |  15 ++
 arch/arm64/boot/dts/apple/s8000.dtsi               | 144 +++++++++++++
 arch/arm64/boot/dts/apple/s8001-common.dtsi        |  48 +++++
 arch/arm64/boot/dts/apple/s8001-j127.dts           |  14 ++
 arch/arm64/boot/dts/apple/s8001-j128.dts           |  14 ++
 arch/arm64/boot/dts/apple/s8001-j98a.dts           |  14 ++
 arch/arm64/boot/dts/apple/s8001-j99a.dts           |  14 ++
 arch/arm64/boot/dts/apple/s8001-pro.dtsi           |  44 ++++
 arch/arm64/boot/dts/apple/s8001.dtsi               | 133 ++++++++++++
 arch/arm64/boot/dts/apple/s8003-j71t.dts           |  15 ++
 arch/arm64/boot/dts/apple/s8003-j72t.dts           |  15 ++
 arch/arm64/boot/dts/apple/s8003-n66m.dts           |  15 ++
 arch/arm64/boot/dts/apple/s8003-n69.dts            |  15 ++
 arch/arm64/boot/dts/apple/s8003-n71m.dts           |  15 ++
 arch/arm64/boot/dts/apple/s8003.dtsi               |  21 ++
 arch/arm64/boot/dts/apple/s800x-6s.dtsi            |  49 +++++
 arch/arm64/boot/dts/apple/s800x-ipad5.dtsi         |  43 ++++
 arch/arm64/boot/dts/apple/s800x-se.dtsi            |  49 +++++
 arch/arm64/boot/dts/apple/t7000-6.dtsi             |  50 +++++
 arch/arm64/boot/dts/apple/t7000-common.dtsi        |  36 ++++
 arch/arm64/boot/dts/apple/t7000-handheld.dtsi      |  27 +++
 arch/arm64/boot/dts/apple/t7000-j42d.dts           |  31 +++
 arch/arm64/boot/dts/apple/t7000-j96.dts            |  14 ++
 arch/arm64/boot/dts/apple/t7000-j97.dts            |  14 ++
 arch/arm64/boot/dts/apple/t7000-mini4.dtsi         |  51 +++++
 arch/arm64/boot/dts/apple/t7000-n102.dts           |  48 +++++
 arch/arm64/boot/dts/apple/t7000-n56.dts            |  14 ++
 arch/arm64/boot/dts/apple/t7000-n61.dts            |  14 ++
 arch/arm64/boot/dts/apple/t7000.dtsi               | 125 +++++++++++
 arch/arm64/boot/dts/apple/t7001-air2.dtsi          |  74 +++++++
 arch/arm64/boot/dts/apple/t7001-j81.dts            |  14 ++
 arch/arm64/boot/dts/apple/t7001-j82.dts            |  14 ++
 arch/arm64/boot/dts/apple/t7001.dtsi               | 123 +++++++++++
 arch/arm64/boot/dts/apple/t8010-7.dtsi             |  43 ++++
 arch/arm64/boot/dts/apple/t8010-common.dtsi        |  48 +++++
 arch/arm64/boot/dts/apple/t8010-d10.dts            |  14 ++
 arch/arm64/boot/dts/apple/t8010-d101.dts           |  14 ++
 arch/arm64/boot/dts/apple/t8010-d11.dts            |  14 ++
 arch/arm64/boot/dts/apple/t8010-d111.dts           |  14 ++
 arch/arm64/boot/dts/apple/t8010-ipad6.dtsi         |  44 ++++
 arch/arm64/boot/dts/apple/t8010-ipad7.dtsi         |  14 ++
 arch/arm64/boot/dts/apple/t8010-j171.dts           |  14 ++
 arch/arm64/boot/dts/apple/t8010-j172.dts           |  14 ++
 arch/arm64/boot/dts/apple/t8010-j71b.dts           |  14 ++
 arch/arm64/boot/dts/apple/t8010-j72b.dts           |  14 ++
 arch/arm64/boot/dts/apple/t8010-n112.dts           |  47 +++++
 arch/arm64/boot/dts/apple/t8010.dtsi               | 133 ++++++++++++
 arch/arm64/boot/dts/apple/t8011-common.dtsi        |  46 ++++
 arch/arm64/boot/dts/apple/t8011-j105a.dts          |  16 ++
 arch/arm64/boot/dts/apple/t8011-j120.dts           |  16 ++
 arch/arm64/boot/dts/apple/t8011-j121.dts           |  16 ++
 arch/arm64/boot/dts/apple/t8011-j207.dts           |  16 ++
 arch/arm64/boot/dts/apple/t8011-j208.dts           |  16 ++
 arch/arm64/boot/dts/apple/t8011-pro2.dtsi          |  42 ++++
 arch/arm64/boot/dts/apple/t8011.dtsi               | 141 +++++++++++++
 arch/arm64/boot/dts/apple/t8015-8.dtsi             |  13 ++
 arch/arm64/boot/dts/apple/t8015-8plus.dtsi         |   9 +
 arch/arm64/boot/dts/apple/t8015-common.dtsi        |  48 +++++
 arch/arm64/boot/dts/apple/t8015-d20.dts            |  14 ++
 arch/arm64/boot/dts/apple/t8015-d201.dts           |  14 ++
 arch/arm64/boot/dts/apple/t8015-d21.dts            |  14 ++
 arch/arm64/boot/dts/apple/t8015-d211.dts           |  14 ++
 arch/arm64/boot/dts/apple/t8015-d22.dts            |  14 ++
 arch/arm64/boot/dts/apple/t8015-d221.dts           |  14 ++
 arch/arm64/boot/dts/apple/t8015-x.dtsi             |  13 ++
 arch/arm64/boot/dts/apple/t8015.dtsi               | 234 +++++++++++++++++++++
 94 files changed, 3298 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-air1.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-common.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j71.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j72.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j73.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j85.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j85m.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j86.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j86m.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j87.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-j87m.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-mini2.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-mini3.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-n51.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x-n53.dts
 create mode 100644 arch/arm64/boot/dts/apple/s5l8960x.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s800-0-3-common.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8000-j71s.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8000-j72s.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8000-n66.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8000-n69u.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8000-n71.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8000.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8001-common.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8001-j127.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8001-j128.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8001-j98a.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8001-j99a.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8001-pro.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8001.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s8003-j71t.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8003-j72t.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8003-n66m.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8003-n69.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8003-n71m.dts
 create mode 100644 arch/arm64/boot/dts/apple/s8003.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s800x-6s.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s800x-ipad5.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/s800x-se.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7000-6.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7000-common.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7000-handheld.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7000-j42d.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000-j96.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000-j97.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000-mini4.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7000-n102.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000-n56.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000-n61.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7000.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7001-air2.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t7001-j81.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7001-j82.dts
 create mode 100644 arch/arm64/boot/dts/apple/t7001.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8010-7.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8010-common.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8010-d10.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-d101.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-d11.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-d111.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-ipad6.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8010-ipad7.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8010-j171.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-j172.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-j71b.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-j72b.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010-n112.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8010.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8011-common.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8011-j105a.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8011-j120.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8011-j121.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8011-j207.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8011-j208.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8011-pro2.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8011.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8015-8.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8015-8plus.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8015-common.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d20.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d201.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d21.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d211.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d22.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-d221.dts
 create mode 100644 arch/arm64/boot/dts/apple/t8015-x.dtsi
 create mode 100644 arch/arm64/boot/dts/apple/t8015.dtsi


