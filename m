Return-Path: <linux-kernel+bounces-299874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FDA95DB7E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 06:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2C228426E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 04:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2970614B06E;
	Sat, 24 Aug 2024 04:34:42 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0852182B4
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 04:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724474081; cv=none; b=BQLkXxK/9I69eg7lwuaZ2b4fKZm+l+RI1af98aESHI5OaibD7aM+SPmuMa/WmpmG0+4PGX6fqhGsLn4EbmkokXS0wTBa3FZlUUwJK3YOxlJId224pqMFBAxyFKMqxDEQcBWHCfl8qobWeTLG9ZtEfoECFg80XGkMsceLyZuH2tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724474081; c=relaxed/simple;
	bh=S+sp4bbVPHXJSqQ8KuHmmGCojzoNyTNW57Ae46JcphA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ME/Y78BaORgeYwSU7wMlra+t/XNLZtzl98a8uVuOSlZW+cZdtaj2rcbv8jmH5sJmXrk7QojJ1U2BR6TlsjIaN8xAsy+GXpKHfPOd+YmUWdgenDkBtiZpW5aPZpURRb3XRDeS0SSj3qfOHQhOG0jLm/+qDj4lDYQN2lN/V09xCv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1shiTc-0001RR-9Q; Sat, 24 Aug 2024 06:34:12 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1shiTZ-002dhJ-Qd; Sat, 24 Aug 2024 06:34:09 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1shiTZ-003MQL-2E;
	Sat, 24 Aug 2024 06:34:09 +0200
Date: Sat, 24 Aug 2024 06:34:09 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tristram.Ha@microchip.com
Cc: Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
	olteanv@gmail.com, pieter.van.trappen@cern.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	marex@denx.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/2] net: dsa: microchip: Add KSZ8895/KSZ8864
 switch support
Message-ID: <ZsliwRqz2zH9Mkr4@pengutronix.de>
References: <BYAPR11MB3558F407712B5C5DFB6F409DEC882@BYAPR11MB3558.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BYAPR11MB3558F407712B5C5DFB6F409DEC882@BYAPR11MB3558.namprd11.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2024 at 11:07:06PM +0000, Tristram.Ha@microchip.com wrote:
> KSZ8895/KSZ8864 is a switch family between KSZ8863/73 and KSZ8795, so it
> shares some registers and functions in those switches already
> implemented in the KSZ DSA driver.
> 
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

