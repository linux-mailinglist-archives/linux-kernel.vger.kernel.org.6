Return-Path: <linux-kernel+bounces-427088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F00049DFC44
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4F0728317F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A468A1F9F76;
	Mon,  2 Dec 2024 08:45:18 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238C21F941B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733129118; cv=none; b=uVUGAVxDav3c4lA0IM+Cau/A7KbYVNy3hmd84MMqJDJd8pMhEv732gevIkPRqUBmYo2A+1lzOHsAi8vFkedxaDdhzPBAlSgud2wxyVVpbDXuE45meOo6lBirPxQSMJ4HRv/Gnd7tEOikh3qZAw3ej1qZrUYZunYWzsB24LYCB50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733129118; c=relaxed/simple;
	bh=8uv53xupTrNP2ieMkOQogRXWVx9INQ9I9BIT46nEVHY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TmBOCpUbfX7ImeqfqXqEtDuBYcKw8RbZJ+8hRZ3RcceQDI1g4t3U2tuDIfyWZSbpoaXXzEtons4p8H2zgqlZBwXWlvR3Gvff5DorhDmY2mBgg0PFo7QBwkTxe+kTieCTAOiTOOp2RRlAi2WAn0qGu0CtG81SyIwFoQxsV/KDXZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.pengutronix.de)
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1tI23I-0005AI-BF; Mon, 02 Dec 2024 09:45:08 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Richard Cochran <richardcochran@gmail.com>,
  Michael Turquette <mturquette@baylibre.com>,  Stephen Boyd
 <sboyd@kernel.org>,  devicetree@vger.kernel.org,
  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org,
  linux-clk@vger.kernel.org,  kernel@pengutronix.de
Subject: Re: [PATCH v2 2/4] arm64: dts: agilex5: add gmac nodes
In-Reply-To: <14110c3d-4aee-49a9-8cc2-fbeac298f1ff@kernel.org> (Krzysztof
	Kozlowski's message of "Mon, 25 Nov 2024 11:51:04 +0100")
References: <20241125-v6-12-topic-socfpga-agilex5-v2-0-864256ecc7b2@pengutronix.de>
	<20241125-v6-12-topic-socfpga-agilex5-v2-2-864256ecc7b2@pengutronix.de>
	<14110c3d-4aee-49a9-8cc2-fbeac298f1ff@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.0.92
Date: Mon, 02 Dec 2024 09:45:07 +0100
Message-ID: <87o71u8odo.fsf@pengutronix.de>
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

On 2024-11-25 at 11:51 +01, Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 25/11/2024 11:33, Steffen Trumtrar wrote:
> > The Agilex5 provides three Synopsys XGMAC ethernet cores, that can be
> > used to transmit and receive data at 10M/100M/1G/2.5G over ethernet
> > connections and enables support for Time Sensitive Networking (TSN)
> > applications.
> >
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > ---
> >  arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 87 ++++++++++++++++++++++++++
> >  1 file changed, 87 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> > index b1debf0317d0576f7b00200e9593481671183faa..647ccd0b5a66b68fab745d443b975c12d6ce63df 100644
> > --- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> > +++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> > @@ -141,6 +141,93 @@ soc: soc@0 {
> >  		device_type = "soc";
> >  		interrupt-parent = <&intc>;
> >
> > +		gmac0: ethernet@10810000 {
> > +			compatible = "altr,socfpga-stmmac-a10-s10",
>
>
> That's odd compatible, this is not Arria10 SoC, neither Stratix 10.

Yes, it is. The socfpga-dwmac.txt says "Arria10/Agilex/Stratix10 SoCs" should use "altr,socfpga-stmmac-a10-s10".

So, how to proceed? Adding a "altr,socfpga-stmmac-agilex5" to the binding doc and driver?
And converting the txt to yaml, because touched it last?


Best regards,
Steffen

--
Pengutronix e.K.                | Dipl.-Inform. Steffen Trumtrar |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

