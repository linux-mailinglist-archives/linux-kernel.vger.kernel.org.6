Return-Path: <linux-kernel+bounces-435242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7A39E74F3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0073286760
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 15:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9EE206F05;
	Fri,  6 Dec 2024 15:55:56 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58D11494B2
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 15:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733500556; cv=none; b=t2Nemtdv4/h1PqzH0w1zO2/t2bn0Vn7zPLeEw14XbIst4OgSEhagzpaM+DkKx1A8TYKY207dmRzcthabc3dR06UocK8NY/g7xvTxRquyf39HyJTvPmuY8SrmD4HdM10q6P+YPDz96gkXJQokT3wgjAhzmd7ylP4MSUnhUplKAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733500556; c=relaxed/simple;
	bh=dp6VZPPRUVzxcZi2OMWend/D2dVJfn0Cvo9NJ2iqv4w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=leHWq9TDZwF0yX7hdQ7Obv1vv1ZV1f+YYLsXaslR8Fkv/tQXQ4tTVWqxUlao6wUhiy0VNEQKEuVD7wg0/j8ezUF3l7hWJakLkuC4UZ7qqiXv/9ZISBevYZMvxh/bYVxL9svLDgc6/20tgxoUCV/h6AVs8YaWdQ9WrVsCT05HQcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tJagI-0004qC-40; Fri, 06 Dec 2024 16:55:50 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tJagG-0021Re-0o;
	Fri, 06 Dec 2024 16:55:49 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tJagG-000B5z-35;
	Fri, 06 Dec 2024 16:55:48 +0100
Message-ID: <363d23dfb6a6835273f8919cebe1884ede87f203.camel@pengutronix.de>
Subject: Re: [PATCH] reset: rzg2l-usbphy-ctrl: Assign proper of node to the
 allocated device
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Claudiu <claudiu.beznea@tuxon.dev>, broonie@kernel.org, 
	biju.das.jz@bp.renesas.com
Cc: linux-kernel@vger.kernel.org, jbrunet@baylibre.com, Claudiu Beznea
	 <claudiu.beznea.uj@bp.renesas.com>
Date: Fri, 06 Dec 2024 16:55:48 +0100
In-Reply-To: <20241119085554.1035881-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241119085554.1035881-1-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Di, 2024-11-19 at 10:55 +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> The platform device named "rzg2l-usb-vbus-regulator", allocated by
> the rzg2l-usbphy-ctrl driver, is used to instantiate a regulator driver.
> This regulator driver is associated with a device tree (DT) node, which
> is a child of the rzg2l-usbphy-ctrl DT node. The regulator's DT node allo=
ws
> consumer nodes to reference the regulator and configure the regulator as
> needed.
[...]

Applied to reset/fixes, thanks!

[1/1] reset: rzg2l-usbphy-ctrl: Assign proper of node to the allocated devi=
ce
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D1f8af9712413

regards
Philipp

