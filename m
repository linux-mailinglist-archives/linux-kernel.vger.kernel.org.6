Return-Path: <linux-kernel+bounces-437058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0F79E8E94
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F0F1883F04
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDD9215F44;
	Mon,  9 Dec 2024 09:21:46 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D1E1EB3D
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733736106; cv=none; b=YI7u6jdGXNa/M0CoaGEOqQk9uno4Yvvl7aNfzbWPz2E7I00LqQEZaQRYh3Rcbm9rjR4ATte7ZPFJMpBNJqPwiAaly6hdyMdi4xQtIjMvDY4M+xxoeOnui4A5J1WLdpWwxX8odDDWkX/SsqDEOovxQFknl7YybYn9TcGU0oEnGeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733736106; c=relaxed/simple;
	bh=hh2354hlp1VuyDijMDkpJeNyikhjTkcRkAr5qoYK+0M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CCEKEuxuAXLFFeDPQhvlKipZukxpXC4K7xp7OVxzqGIFlSBniLgqvn2S/fBr27KDhoq1THF6I0kH941pNFUa7uBh2a7kKVk/DLqq36jSsvwMbP/vwDNtQgYuNVi1afmXRE+MIhplOEKQXN82Q0fPGfyNRFhYRSlZIihqHl4/qmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.pengutronix.de)
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1tKZxM-0001JS-54; Mon, 09 Dec 2024 10:21:32 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>,  Dinh Nguyen <dinguyen@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Michael Turquette
 <mturquette@baylibre.com>,  Richard Cochran <richardcochran@gmail.com>,
  Rob Herring <robh@kernel.org>,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org,
  linux-clk@vger.kernel.org,  kernel@pengutronix.de,  Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 0/6] ARM64: dts: intel: agilex5: add nodes and new board
In-Reply-To: <dee94bf85dd158e4f0846617ba20d2d8.sboyd@kernel.org> (Stephen
	Boyd's message of "Fri, 06 Dec 2024 14:13:05 -0800")
References: <20241205-v6-12-topic-socfpga-agilex5-v3-0-2a8cdf73f50a@pengutronix.de>
	<dee94bf85dd158e4f0846617ba20d2d8.sboyd@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.0.92
Date: Mon, 09 Dec 2024 10:21:30 +0100
Message-ID: <87seqxus85.fsf@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 2024-12-06 at 14:13 -08, Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Steffen Trumtrar (2024-12-05 01:06:00)
> > This series adds the gpio0 and gmac nodes to the socfpga_agilex5.dtsi.
> > As the the socfpga-dwmac binding is still in txt format, convert it to
> > yaml, to pass dtb_checks.
> >
> > An initial devicetree for a new board (Arrow AXE5-Eagle) is also added.
> > Currently only QSPI and network are functional as all other hardware
> > currently lacks mainline support.
> >
> [...]
> > Steffen Trumtrar (6):
> >       dt-bindings: net: dwmac: Convert socfpga dwmac to DT schema
> >       dt-bindings: net: dwmac: add compatible for Agilex5
> >       arm64: dts: agilex5: add gmac nodes
> >       arm64: dts: agilex5: add gpio0
> >       dt-bindings: intel: add agilex5-based Arrow AXE5-Eagle
> >       arm64: dts: agilex5: initial support for Arrow AXE5-Eagle
> >
> >  .../devicetree/bindings/arm/intel,socfpga.yaml     |   1 +
> >  .../devicetree/bindings/net/socfpga-dwmac.txt      |  57 ---------
> >  .../devicetree/bindings/net/socfpga-dwmac.yaml     | 126 +++++++++++++++++++
> >  arch/arm64/boot/dts/intel/Makefile                 |   1 +
> >  arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi     | 109 ++++++++++++++++
> >  .../boot/dts/intel/socfpga_agilex5_axe5_eagle.dts  | 140 +++++++++++++++++++++
> >  6 files changed, 377 insertions(+), 57 deletions(-)
>
> Why are clk framework maintainers Cced on this patch series?

Oops, sorry for the noise. Forgot to update the Cc list :(


Best regards,
Steffen

--
Pengutronix e.K.                | Dipl.-Inform. Steffen Trumtrar |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

