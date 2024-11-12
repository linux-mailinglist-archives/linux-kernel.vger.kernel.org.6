Return-Path: <linux-kernel+bounces-406824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3281A9C64AA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7811F236E0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D6821A708;
	Tue, 12 Nov 2024 23:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="iodAhEWj"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F146121B427;
	Tue, 12 Nov 2024 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731452477; cv=none; b=bOg0q9dNzwt/UkVUPXpZEfeGjy2UOENFGOneLaIjQjQ5KHSPQlhWtKmrAymYPObvJoXzwxC3ajYzQCvEJuplgA7+SrOxdfO/TgEmRCSdG2wP8tXNBNqss3mkG4xG1SKrqipb9w3GQqVpcm28g9U7exMmLP2V+rShCZ1mHXkj5cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731452477; c=relaxed/simple;
	bh=84DyWoendiTxjZK4MJlhCTBE67aF1AwiwuzRg6/FQIk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lvSZuma4DXhxltZ+3nng/rsZtpKZnI5qQalbTyppZN/NzqI2/qDIdoNWZi2+UsRjr58un0IMzZZVkb5Pl+MLC+UFl8OeiHOoPFhiVp4IqLWH1ZcDhajdygQCxcpidQxwAU6ehosTatYf/8CJjVGz4uvlwL3pCHC+fFfe3bXz74A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=iodAhEWj; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 1ED1D12000C;
	Wed, 13 Nov 2024 02:01:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 1ED1D12000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1731452463;
	bh=gMt6xiNUzbP586OUi3bpRznhicbRyyZqkrZh8cOiBiw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=iodAhEWjWIjWyDbzoAX42ObmnYWHz8n0F7KcKy6V5cPR3Wq8kRNxf3SsgPkelm4v5
	 23ijXgTZZ0vOFqbuQiiFcbkLpOO77GuMgDnTNyLsonikc4tW4AuSueW1lGbIgKZw8E
	 E6TiK7A/p5V5gYp41C+Grbq0tK5TqjPqspNrMq0Xc9oVLgNob3yiXaZEox0K7HbReC
	 XAwVf5chP0q1w7CP5j/FF7l+6lGbH2v/JQl9wJsH7UnHc2UOiRzmXn9Cmot6fNtOCp
	 KYqvMnz/a/xWywNDNqpskUQtAHjVEDoPFnNTNOMEM8s2gj+Ni6su6Nr9Nuj6ms7v8y
	 gaiW8ePE9O2KQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 13 Nov 2024 02:01:02 +0300 (MSK)
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, "Rob
 Herring" <robh@kernel.org>
Subject: [PATCH 0/2] Add support for A1 SoC in auxiliary reset driver
Date: Wed, 13 Nov 2024 02:00:54 +0300
Message-ID: <20241112230056.1406222-1-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189131 [Nov 12 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, lore.kernel.org:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/11/12 21:28:00
X-KSMG-LinksScanning: Clean, bases: 2024/11/12 22:50:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/12 21:10:00 #26864167
X-KSMG-AntiVirus-Status: Clean, skipped

This was a part of series [1]. Comparing to original series, reset functionality
on top of 'audio-vad' clock controller also is added.

Links:
  [1] https://lore.kernel.org/all/20240913121152.817575-1-jan.dakinevich@salutedevices.com/

Jan Dakinevich (2):
  dt-bindings: reset: add bindings for A1 SoC audio reset controller
  reset: amlogic: add support for A1 SoC in auxiliary reset driver

 drivers/reset/amlogic/reset-meson-aux.c       | 18 ++++++++++
 .../reset/amlogic,meson-a1-audio-reset.h      | 36 +++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h

-- 
2.34.1


