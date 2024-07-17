Return-Path: <linux-kernel+bounces-254712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 538669336BB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2DE1F243AF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E311400A;
	Wed, 17 Jul 2024 06:12:31 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD9F12E7F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721196751; cv=none; b=H4TJ7qYVf+gyL16MDSsgzYtgK1Nu7oK5YH7oKaxxaOxALfrJdNkthKi/DDseVA2zldAj6o+h0CcFrnllBmABEFxeki0Mhxj5leUIJMOSkJDVOLXHNE6mEFE7LF3tKb7WOVora+8bExMw1k9LrDktWftUbKsf5UTpcWbJsKvleRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721196751; c=relaxed/simple;
	bh=4f3fcVvU4gRFuVFMBNoTOgdn8pYdktibC9FrBSuVlg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUR6TeWYGs69m8rhR/b2I5P7ARmFSI52zGEFarbPLTLlkN4LAKKQKBSEmcid1rBpu2eCT3SJi/DksnWowTGAVg0VAzb5+BRtdXjo3OToKgNjwG5v2TAjIC9LBX0vmZPdg4/USxsEiSoZdNp4aqvG38GaL731LrR9woP+6sxfBWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1sTxth-0003EI-Rs; Wed, 17 Jul 2024 08:12:17 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1sTxtg-0009Jr-Vl; Wed, 17 Jul 2024 08:12:17 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1sTxtg-001s4c-2l;
	Wed, 17 Jul 2024 08:12:16 +0200
Date: Wed, 17 Jul 2024 08:12:16 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Brian Norris <briannorris@chromium.org>, Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] wifi: mwifiex: add support for WPA-PSK-SHA256
Message-ID: <ZpdgwCyoYPAFLBJI@pengutronix.de>
References: <20240716-mwifiex-wpa-psk-sha256-v1-0-05ae70f37bb3@pengutronix.de>
 <20240716-mwifiex-wpa-psk-sha256-v1-2-05ae70f37bb3@pengutronix.de>
 <20240716195731.GB85916@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716195731.GB85916@francesco-nb>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Francesco,

On Tue, Jul 16, 2024 at 09:57:31PM +0200, Francesco Dolcini wrote:
> Hello Sascha,
> 
> On Tue, Jul 16, 2024 at 01:33:28PM +0200, Sascha Hauer wrote:
> > This adds support for the WPA-PSK AKM suite with SHA256 as hashing
> > method (WPA-PSK-SHA256). Tested with a wpa_supplicant provided AP
> > using key_mgmt=WPA-PSK-SHA256.
> 
> Do you have any more details on which chip/firmware you tested?
> The change looks good, I am just wondering if there are reasons this
> might create issue on some specific chip/firmware combination.

I have a IW416 with firmware 16.92.21.p119. The change itself is derived
from the downstream driver. The downstream driver also sets the
KEY_MGMT_PSK_SHA256 bit unconditionally for all chip/firmware
combinations so I think this change should be ok.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

