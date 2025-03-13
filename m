Return-Path: <linux-kernel+bounces-559006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C9CA5EE3F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503C0189E844
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4C6261578;
	Thu, 13 Mar 2025 08:44:06 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73960261563
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741855446; cv=none; b=DUMdoGWpCmhQs9vmKPUXNrqDqi023xA6klbNgIIEQERC5o6e5Xs4NWVIwxlDLIKJbhKt9c35ecDK3O8TTaDk2RjDyIXi1ojSaiunRWdRhOwGfhu0pdmS5RmFCfEDDvEAqkPnJGo9MXVn/26ZKgFV63xk7V41J1+HV756b6wWWxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741855446; c=relaxed/simple;
	bh=B8xrWGXh47flZMBc4OynPt52HdDVE8wfQf9Ggqdg8nc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k3wty4qVTRyzBjivmNVKVhOeYaYJ1a9sOTQvH9r5mxWk7Rimm636WmNQGX4maagryQjIx0dPyqvs9UvkQe0MzIIqvMf0nRE27irtM1tCHq6BJswf7JNBbmwYsw4y4cWkRcKd62dWp62Bch1xrXopn2y3eNnngyx505vcF4ccpHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tseAQ-0000KT-Qn; Thu, 13 Mar 2025 09:43:50 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tseAP-005VQo-17;
	Thu, 13 Mar 2025 09:43:49 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tseAP-0003az-0x;
	Thu, 13 Mar 2025 09:43:49 +0100
Message-ID: <5824eaa53054cfd9886c6ba745bd5cd8914c26c0.camel@pengutronix.de>
Subject: Re: [PATCH] dt-bindings: reset: fix double id on rk3562-cru reset
 ids
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Heiko Stuebner <heiko@sntech.de>, sboyd@kernel.org,
 mturquette@baylibre.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	kever.yang@rock-chips.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, kernel test robot
	 <lkp@intel.com>
Date: Thu, 13 Mar 2025 09:43:49 +0100
In-Reply-To: <20250312215923.275625-1-heiko@sntech.de>
References: <20250312215923.275625-1-heiko@sntech.de>
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

On Mi, 2025-03-12 at 22:59 +0100, Heiko Stuebner wrote:
> Id 173 was accidentially used two times for SRST_P_DDR_HWLP and
> SRST_P_DDR_PHY. This makes both resets ambiguous and also causes build
> warnings like:
>=20
> drivers/clk/rockchip/rst-rk3562.c:21:57: error: initialized field overwri=
tten [-Werror=3Doverride-init]
>    21 | #define RK3562_DDRCRU_RESET_OFFSET(id, reg, bit) [id] =3D (0x2000=
0*4 + reg * 16 + bit)
>       |                                                         ^
> drivers/clk/rockchip/rst-rk3562.c:266:9: note: in expansion of macro 'RK3=
562_DDRCRU_RESET_OFFSET'
>   266 |         RK3562_DDRCRU_RESET_OFFSET(SRST_P_DDR_PHY, 0, 8),
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/clk/rockchip/rst-rk3562.c:21:57: note: (near initialization for '=
rk3562_register_offset[173]')
>    21 | #define RK3562_DDRCRU_RESET_OFFSET(id, reg, bit) [id] =3D (0x2000=
0*4 + reg * 16 + bit)
>       |                                                         ^
> drivers/clk/rockchip/rst-rk3562.c:266:9: note: in expansion of macro 'RK3=
562_DDRCRU_RESET_OFFSET'
>   266 |         RK3562_DDRCRU_RESET_OFFSET(SRST_P_DDR_PHY, 0, 8),
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> To fix that issue give SRST_P_DDR_PHY a new and now unique id.
>=20
> Reported-by: Stephen Boyd <sboyd@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202503121743.0zcDf6nE-lkp@i=
ntel.com/
> Fixes: dd113c4fefc8 ("dt-bindings: clock: Add RK3562 cru")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> The original patch did go with the reset of the clock controller code
> into the clock tree, so this patch should of course also go that way.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

