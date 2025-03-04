Return-Path: <linux-kernel+bounces-544559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 506E9A4E2F9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492FB8826FD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CD227CCC0;
	Tue,  4 Mar 2025 15:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="MzcQ5mKa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="HFuLYNrg"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0D727C146;
	Tue,  4 Mar 2025 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100437; cv=none; b=pWQTho3qh6fhfgL7RLPbJe/rhAs/pa7n7/5RtI1+nlWts3h48FqZVHI3xEUbtxEGut5WhLYqtQIfSG8Oy/oBZ3A9q3lt8DFODOfzCUF6u1Wpk2cH87u8ofgyXOaPugjOSuCLxMOT8cxEeL3ovWMZohsj6lqtDmFYtMwRUZH7X7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100437; c=relaxed/simple;
	bh=FCdoMzdIxtjx6atflHN6tGfAB//3d8FOd2Je98QRTkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WfMu6b+tmkGVum8qaVEqTx0jrI3wAE1L3K7pgLZkvwt+jT/z02QL220Wn5LJ7YcBxHVWLrtnW88Clg/PeSvuQzSoqv00U21kf5CyK5JOfR9MaFFnvJKeJ6dcGmpZxB1ixv8DrkHiiQ7kfZrJaF58T9iTV9vag2QcJMgx7ZKBwsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=MzcQ5mKa; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=HFuLYNrg reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1741100434; x=1772636434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lykf3xaLUig9uEA0bAfwrVFURjMxGoC8WA1DRVWsg3U=;
  b=MzcQ5mKacxJb2BmRkRDI52x2nrGwu2cGi3Oy8jetvJFiKNY4vMpt7N95
   p995XuZBNUw5ygLGXu07rjXupgkEVwafdr2rrEdLMvvLp722Ne+KiHqfl
   B1RWN6o9GI4h3SDi52KHIujZg1FTDM8upx3vX3N1b2lLuqpdtxuG8Jtr/
   rEkJSpbMYBDsel5Zc1y6zHKYMbHV/eyOYQb0HYpkecdmQpfSTkLRK/lJx
   kQk90uWEbT8iTTrz0JMEdBeWYXf07w94tewjtAuDfahThUFQWtXt6HnT7
   QbXv7c1oRdT5uSYL7r+Hye/GfQhXEYdude9Oi6JP9yfsF8F6BoUPmDbxy
   g==;
X-CSE-ConnectionGUID: IRExU1k4THu6QG+Ybe9BqA==
X-CSE-MsgGUID: XSWG8FDkRNmak4xANBU0ww==
X-IronPort-AV: E=Sophos;i="6.14,220,1736809200"; 
   d="scan'208";a="42271641"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Mar 2025 16:00:30 +0100
X-CheckPoint: {67C7158E-1E-903EAEAC-E04C76C8}
X-MAIL-CPID: C2F7047D101734CC6A65597C5FF5C1BA_5
X-Control-Analysis: str=0001.0A006369.67C71591.004C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0CA0B16C670;
	Tue,  4 Mar 2025 16:00:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1741100425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lykf3xaLUig9uEA0bAfwrVFURjMxGoC8WA1DRVWsg3U=;
	b=HFuLYNrgATor3X44V0mhFXFM9yZTVQYOs9nf9eofeFEt8zh0aiX6SnpTHWS3ZjKzmQT3wk
	NPSksgs1prE95SLty+lkXiYQ6CCVGQf5Um7WehPNb+T5bjgHVCzCETclsaMeveuErfTBUJ
	Qqg/sqoxcYfwue0/+SaQqjkibmA4TIMY66ysDHmCAawZanMhtbljZY5rliBEccHwV20nEa
	L+WkFqpeuklmPkuWL1JQ5UfEm/7+bDk2tdwaLw4Kc96sOM41pSeRhBOs2RLAOCKc757ahi
	BHfILKL/SCJp0JiRygtITE/CgoJke523+rJeXxMFj+fvxtiF0EpkKvimBEBHMQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, Liu Ying <victor.liu@nxp.com>
Subject:
 Re: [PATCH 0/5] drm/bridge: simple-bridge: Add DPI color encoder support
Date: Tue, 04 Mar 2025 16:00:21 +0100
Message-ID: <22618349.EfDdHjke4D@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250304101530.969920-1-victor.liu@nxp.com>
References: <20250304101530.969920-1-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Dienstag, 4. M=E4rz 2025, 11:15:25 CET schrieb Liu Ying:
> Hi,
>=20
> This patch series aims to add DPI color encoder support as a simple DRM
> bridge.  A DPI color encoder simply converts input DPI color coding to
> output DPI color coding, like Adafruit Kippah DPI hat[1] which converts
> input 18-bit pixel data to 24-bit pixel data(with 2 low padding bits in
> every color component though).  A real use case is that NXP i.MX93 11x11
> EVK[2] and i.MX93 9x9 QSB[3] boards may connect a 24-bit DPI panel through
> the Adafruit Kippah DPI hat.  The display pipeline is
>=20
> i.MX93 LCDIF display controller(RGB888) ->
> i.MX93 parallel display format configuration(RGB666) ->
> on-board Raspiberry Pi compatible interface(RPi)(RGB666) ->
> Adafruit Kippah DPI hat(RGB888 with 2 low padding bits in color component=
s) ->
> 24-bit "ontat,kd50g21-40nt-a1" DPI panel
>=20
> [1] https://learn.adafruit.com/adafruit-dpi-display-kippah-ttl-tft/downlo=
ads
> [2] https://www.nxp.com/design/design-center/development-boards-and-desig=
ns/i.MX93EVK
> [3] https://www.nxp.com/design/design-center/development-boards-and-desig=
ns/IMX93QSB

Thanks for this series.
Actually I was about to create a similar (dumb) bridge. My use case is wrong
wiring on hardware for DPI displays. The current workaround was to use a
"new" display compatible with bus_format changes from
MEDIA_BUS_FMT_RGB666_1X18 -> MEDIA_BUS_FMT_RGB888_1X24.

I added this new bridge and changed my DT and it works flawlessly.

Best regards
Alexander

> Liu Ying (5):
>   dt-bindings: display: Document DPI color codings
>   drm/of: Add drm_of_dpi_get_color_coding()
>   dt-bindings: display: simple-bridge: Document DPI color encoder
>   drm/bridge: simple-bridge: Add DPI color encoder support
>   drm/bridge: simple-bridge: Add next panel support
>=20
>  .../display/bridge/simple-bridge.yaml         |  89 +++++++++++-
>  .../bindings/display/dpi-color-coding.yaml    |  90 ++++++++++++
>  drivers/gpu/drm/bridge/Kconfig                |   1 +
>  drivers/gpu/drm/bridge/simple-bridge.c        | 132 ++++++++++++++++--
>  drivers/gpu/drm/drm_of.c                      |  43 ++++++
>  include/drm/drm_of.h                          |   7 +
>  6 files changed, 348 insertions(+), 14 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/dpi-color-c=
oding.yaml
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



