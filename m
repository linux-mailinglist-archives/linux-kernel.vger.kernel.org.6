Return-Path: <linux-kernel+bounces-340271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A0F9870B7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EBAC287B94
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EE11ABED2;
	Thu, 26 Sep 2024 09:51:48 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463761A4B8F
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727344307; cv=none; b=sMj/zqnF16ecJbqBYxN3LOdwX870IJ+aQZuNhI28aIVJnXLpfLt0NeadTAxW+6rQgHRM2DKjZ3mNIlf5Zi+eFXRLxbxKigwVr9ZNK/t3q22UQRljxkNnCj4MODCEktVeWA7bhtpii/qptN5yHLUnGjdm5zfZj5EJ8VD6s697+tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727344307; c=relaxed/simple;
	bh=MeZglqA06DnL1H7gm+Zs18dfjnpbHKT50cVInRoBADM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARXbieU1ius05x2Lbkry+vXOjzUaOKpxyZbO3X0br4QB+wGp1WIOatxzyySW5WlLJG48OmFYy6IufdIG3MhdY8Kpf4/cpDMGZrDTQqGHStSZkJefuLugtxubp7MQcUAlWB2v+45j3bixuWQT7YOc7CuhP8Deq7VyUQoEM2NZj8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1stl9p-00074F-OI; Thu, 26 Sep 2024 11:51:33 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1stl9o-001ekP-60; Thu, 26 Sep 2024 11:51:32 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1stl9o-00D9Vs-0H;
	Thu, 26 Sep 2024 11:51:32 +0200
Date: Thu, 26 Sep 2024 11:51:32 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH v7 4/5] firmware: imx: add driver for NXP
 EdgeLock Enclave
Message-ID: <ZvUupApT8q_TRJds@pengutronix.de>
References: <20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com>
 <20240904-imx-se-if-v7-4-5afd2ab74264@nxp.com>
 <Zt7n0AxGEw-ZXbui@pengutronix.de>
 <AS8PR04MB85932B4E47EFC519B0EF6D9A95632@AS8PR04MB8593.eurprd04.prod.outlook.com>
 <Zu1kUDb5dfB5dRbe@pengutronix.de>
 <AM9PR04MB86042C9BF315EF130FF0408A95692@AM9PR04MB8604.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR04MB86042C9BF315EF130FF0408A95692@AM9PR04MB8604.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Pankaj,

On Wed, Sep 25, 2024 at 12:00:28PM +0000, Pankaj Gupta wrote:
> >> Yes.
> >
> > > Don't do this.
> >
> >> Shall the retry counter to be removed, to make it predictable?
> >>Or am I missing something.
> 
> >Either compile the firmware into the kernel or the ELE driver as module.
> 
> Cannot compile as part of Firmware.
> There are OTA scenarios where the latest FW, that is downloaded to replace
> the image in RFS, and FW needs to be re-init with this new image, by putting
> the Linux to power-down state.
> 
> ELE driver is compiled as module only, by default. But if someone like to
> make it as in-line to kernel image, still it should work.

I am also not very happy with the situation that we can't compile
drivers into the kernel and just get the firmware later once it is
available. That's the situation we are in though and if you want to
change it you have to discuss this with the firmware maintainers.

What you've done in the ELE driver is a hack and I doubt that you get
this through.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

