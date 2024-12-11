Return-Path: <linux-kernel+bounces-441247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF4A9ECBB7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3361681E2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F4721505B;
	Wed, 11 Dec 2024 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="z+m6LVNC"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9285F238E2A;
	Wed, 11 Dec 2024 12:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733918699; cv=none; b=mFpkOQZVPsavfYZJoiJq2B5ThHfwYdzqMcj4OEPIi517jRO16wNo71OArFHC6nkiTvsceS98TBBL/YE5t2AXl6yc9kOJpfv0H3VbQ3puzPMd6DjzTJFO1YBQwuLa9DpthyTHA4CBuZpgixLhSej6N8WOtlfOWebxDX3ubfIQasA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733918699; c=relaxed/simple;
	bh=1Yd5D9BJyOtyfIb8dJrBUAsYwwwWUWP+TpbR9XJzO0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VK2mT07T1sozj7iUNjfBZMsz8+UU67BKBPva2WO4Unv8BjXEDA2WqVyNErhdM6km0JFN8kRRfZXbOwGvTplRy7xh0N1MeIugGxbSp0dKWyrolKGw01rU2mdGduCNAaqHZ16in4HSQr3C57PKxCc6VYXEn4UsPkmohPba/TQjmyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=z+m6LVNC; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733918697; x=1765454697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1Yd5D9BJyOtyfIb8dJrBUAsYwwwWUWP+TpbR9XJzO0A=;
  b=z+m6LVNCl/Ad2Gup/EXr01DmMGjsicJoeEmAEjNvXjag4KZliKl2s84U
   Ek7ju0+XRFxnRMmeQvC8nx2pE8caMWas3N2MvSB91cT7urJ/l2LEyAM46
   ADMM/AHElYSu1Z2G6+Xxfi/4u0+SP/P+9MRiDNcrsByhQ0GHEhkAV49mJ
   j8OstjBi7izithstgdBE7qYWiJGpEqdwJdqJ+Y3orLbg9jmks2j8tJFeB
   38a6JN4Xi4nxiELKetH5qzxNZXkEaPVfFRGOT2gOd5lvLtjKleBobg8ME
   GKnQUwmLYPCfiFAmyfNtSorsdjUzY1tkOi1f1+QK4S9X0bWFHRDGHSy5r
   A==;
X-CSE-ConnectionGUID: Ptjd/tA+SRiWFGe/ObcJTg==
X-CSE-MsgGUID: v4RVO+SvRWyQH0g/1OUQug==
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="39094712"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Dec 2024 05:04:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 11 Dec 2024 05:04:16 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 11 Dec 2024 05:04:13 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <balakrishnan.s@microchip.com>
CC: <alexandre.belloni@bootlin.com>, <andrei.simion@microchip.com>,
	<broonie@kernel.org>, <claudiu.beznea@tuxon.dev>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <krzk+dt@kernel.org>, <lgirdwood@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, <nicolas.ferre@microchip.com>,
	<robh@kernel.org>
Subject: Re: [PATCH v2] ASoC: dt-bindings: sound: atmel-at91sam9g20ek: convert to json-schema
Date: Wed, 11 Dec 2024 14:03:17 +0200
Message-ID: <20241211120316.22494-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211-sound-atmel-at91sam9g20ek-v2-1-86a0e31e6af9@microchip.com>
References: <20241211-sound-atmel-at91sam9g20ek-v2-1-86a0e31e6af9@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Hi,

On 11.12.2024 11:46, Balakrishnan Sambath wrote:
> Convert atmel-at91sam9g20ek-wm8731-audio DT binding to yaml
> based json-schema.Change file name to match json-scheme naming.
> 
> Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
> ---
> Changes in v2:
> - Add missing CODEC pin options to 'atmel,audio-routing' items.
> - Drop 'minItems' from 'atmel,audio-routing' since enum defines valid connections.
> - Add subsystem tag to subject.
> - Add blank line between properties and fix typo.
> - Add audio complex description.
> - Link to v1: https://lore.kernel.org/lkml/20240214-at91sam9g20ek-wm8731-yaml-v1-1-33333e17383b@microchip.com
> ---
>  .../bindings/sound/atmel,at91sam9g20ek-wm8731.yaml | 70 ++++++++++++++++++++++
>  .../sound/atmel-at91sam9g20ek-wm8731-audio.txt     | 26 --------
>  2 files changed, 70 insertions(+), 26 deletions(-)

I recommend you to remove from title the word 'sound'.
You can check the commit history of the Documentation/devicetree/bindings/sound/
before you write the commit title.

Best Regards,
Andrei Simion




