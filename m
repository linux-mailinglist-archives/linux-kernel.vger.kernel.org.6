Return-Path: <linux-kernel+bounces-384849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2C49B2F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA8F1F213DD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1CA1D6DC5;
	Mon, 28 Oct 2024 11:52:03 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C17F1BDA8C
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730116323; cv=none; b=FOgC9LaU+en+iaCyYlz2+BbxRByr5S4GSwwUYhKl8XGK2/BJvRs+upivyaRMRxTcriPlM2kQ9MUDgnvhrzZm+J7zLctrFIwOwJvaSwzxj/hYU7hhG+XU44DHM49d6AQZ7pMIWbnGE33+uAnJudsgc7HOoYIJbUK7r4Zh/hAXDZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730116323; c=relaxed/simple;
	bh=ockJI5gQqJl3+aKvbH6g8LQa7g/Ahc7oUF9YmohijpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLqcnRhyxwhH4EXHXptOM5fcXFFblzdTQpX5FwcD9IvxBnNAfDpD/EfikQh3tII6l8DqPmillwUEHHVE+xsCPetLvCVGtnBDUDwLgR5bDCaQPRkiZSZiqleVYnEqhw6zBzJEivVMtW/J9DzEElpHfli8l3nhWZ5+oFrp5uP4ZIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1t5OHm-0004LV-MX; Mon, 28 Oct 2024 12:51:50 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1t5OHm-000qGG-0g;
	Mon, 28 Oct 2024 12:51:50 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1t5OHm-000jgu-0J;
	Mon, 28 Oct 2024 12:51:50 +0100
Date: Mon, 28 Oct 2024 12:51:50 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: POPESCU Catalin <catalin.popescu@leica-geosystems.com>,
	Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support for
 supply and reset
Message-ID: <20241028115150.fgvqaem36lwxwvjh@pengutronix.de>
References: <20241022072311.ubh2sia5lwgvebsg@pengutronix.de>
 <DB9PR04MB8429657FCB48ACAD74FDD471924C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241022082256.nzfxqp67tdaxtn56@pengutronix.de>
 <DB9PR04MB84292445D0FEDB8211ED52C3924C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <9b09774e-d0ed-4c97-b6a0-e976580b5bb5@leica-geosystems.com>
 <DB9PR04MB8429CF700571FE42C997FB9C924D2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <1b8864e5-0ec7-49c4-932a-89cfbaeacc9f@leica-geosystems.com>
 <DB9PR04MB842929186683C1DF13DCBD92924A2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241028090028.x6rzopvpcdvgouqv@pengutronix.de>
 <DB9PR04MB842960A18BB8570B04A64BEA924A2@DB9PR04MB8429.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR04MB842960A18BB8570B04A64BEA924A2@DB9PR04MB8429.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 24-10-28, Sherry Sun wrote:
> 
> > From: Marco Felsch <m.felsch@pengutronix.de>
> > 
> > Hi,
> > 
> > On 24-10-28, Sherry Sun wrote:
> > >
> > > > From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
> > > >
> > > > We use the NXP downstream driver mwifiex which doesn't have support
> > > > for regulator or PDn.
> > > >
> > > > However, regulator is already supported by the MMC core (vmmc-supply).
> > > >
> > > > For PDn, we use mmc pwrseq simple driver that has been patched to
> > > > add support for reset-control.
> > >
> > > Ok, thanks, the mmc change looks good for me, so there is no problem
> > > with the NXP SDIO wifi.
> > >
> > > But how do you plan to handle the NXP PCIe wifi? We also need to make
> > > sure the BT patch won't break the PCIe wifi function.
> > 
> > Can you please elaborate how this could break the PCIe use-case?
> 
> Similar to the SDIO wifi, if no corresponding reset control for the
> PDn pin in PCIe wifi driver, the wifi part will be unexpectedly
> powered off when removing the BT driver.

Nope it's not that easy for PCIe case since the phy + link layer
handling is much more complex compared to the MMC case. For the PCIe
case the intial handling is very strict according to the PCIe spec and
we can't handle the BT device independently.

_BUT_ this patch doesn't cause any regression for the PCIe use-case
since the support added by Catalin is optional which means that the user
don't have to use these options.

To sum up:

WLAN (PCIe) used + BT (UART) used -> no independent handling
                                     possible. BT depends on WLAN.

WLAN (PCIe) not used + BT (UART) used -> This patchset allow us to
                                         handle BT. Without the patchset
					 this is not possible.

WLAN (SDIO) + BT (UART) -> This patchset and the mmc-power-seq patchset
                           allow us to handle WLAN and BT independently
			   regardless if BT or WLAN is used or not.

Regards,
  Marco

