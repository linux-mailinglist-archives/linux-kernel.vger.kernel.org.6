Return-Path: <linux-kernel+bounces-423498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6569DA86A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CCF2B22887
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6271FCFC7;
	Wed, 27 Nov 2024 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Z1by+KWf"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685DE1FAC5F;
	Wed, 27 Nov 2024 13:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732713836; cv=none; b=UZ2/kqKCxPrr5oRcwRb5iobV7/2suQR9KdR46JZMiUOC1CD2WSZQlArcUnMLjRuyiMQlTDxYVAIDC8bbEcNEnU5y5lXoBu7alcRilI4pRTrkElHVhb2i3fgpRnkecSo95/ty+REyra1bWa31Br6L1Xc6AqB3eu9KCxQlDi7AzqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732713836; c=relaxed/simple;
	bh=4PWf5BX25DlYJv4Gy2uPbPq/angyB6Ks1Q7dI2dA/K4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLwYZpmhBDeiqvC5QyhJSNPKj/X1px/PX+CiTficvH10/csG+XLX1z/8dwmFSYaJ1Vh6b6B+PCSoQb2q/l4pQZ105us1lXZcvdQJNJvRFonxGmD1vgc1Gud/wI6XKmF9HzEOGBEYYYY0Is5OnXSLdgtXOpibsJjxtivTtWlVzkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Z1by+KWf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732713832;
	bh=4PWf5BX25DlYJv4Gy2uPbPq/angyB6Ks1Q7dI2dA/K4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z1by+KWf8JcCPAhP3H2Sq4S/s4XGhgKFM0FoTy6rCKufkDu4xFkp4gNH7iY2tRqnl
	 rGxKpvsDErMi83fPQYj0YZJ2KYrlryVyozyr6C5I2/N+nN0VOYTk5D+Mss9QRV7AZc
	 t3eHO/34tehyxJcYmdhROz5QsBsXpUXHQQ+x4VC3EQjU2nx1ExHvciaDvy5R6wH66M
	 r9bgwrij87X+C2cwFQ93LYegsDfI45LxR9F5C56QBLkolvgbjhYEAaIqd+efb8yxVn
	 QPodYBcMVZgwmkRJOEW5QNwNptoA7UR5UqReLQWOmUV5v1P2ytL7rbrsPRQ9x81VBd
	 X8OZ453k2sR6w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0551517E36FE;
	Wed, 27 Nov 2024 14:23:51 +0100 (CET)
Message-ID: <4549f33c-90d2-4b28-ab7a-1576c587c8cf@collabora.com>
Date: Wed, 27 Nov 2024 14:23:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Aw: Re: Aw: [PATCH v3 1/2] arm64: dts: mt7986: add dtbs with
 applied overlays for bpi-r3
To: frank-w@public-files.de, robh+dt@kernel.org, matthias.bgg@gmail.com
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, daniel@makrotopia.org, linux@fw-web.de,
 leith@bade.nz
References: <20240608080530.9436-1-linux@fw-web.de>
 <20240608080530.9436-2-linux@fw-web.de>
 <trinity-82c94d49-2a78-4470-83cd-3c6747e01849-1719434738199@3c-app-gmx-bs52>
 <726f2ed3-675f-45e8-94f0-d392181e7f92@collabora.com>
 <951E802C-1B53-45C4-B3E6-4A3400F47214@public-files.de>
 <CAPDEroWUeR3iUFnjVr6WFLg3=dkML+5cbRPph9bj64F=zc1UWA@mail.gmail.com>
 <trinity-ef654aa8-f10a-4195-82c8-65b3ea654c7b-1730918975868@trinity-msg-rest-gmx-gmx-live-c75c5fb4b-p29nc>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <trinity-ef654aa8-f10a-4195-82c8-65b3ea654c7b-1730918975868@trinity-msg-rest-gmx-gmx-live-c75c5fb4b-p29nc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 06/11/24 19:49, frank-w@public-files.de ha scritto:
> Hi
> 
> any new state on this??
> 
> https://patchwork.kernel.org/project/linux-mediatek/patch/20240608080530.9436-2-linux@fw-web.de/
> 
> regards Frank

I had a look at this one - and this is the situation:

  1. Your bootloader supports loading DTBO, so you can indeed use DTBOs
  2. Validation of the DTSO can still be done during kernel build without adding
     all of those possible X+Y+Z pre-joined DTBs
  3. What if your hardware had more than 20 possible configurations?
     Would you write 20 different Makefile entries? "sd+nand+nor",
     "sd+nand-withoutnor", "emmc+nand+nor", "emmc+nand-withoutnor",
     "emmc+sd+nor", "emmc+sd-withoutnor", "ufs+emmc", "ufs+emmc+sd",
     "ufs+sd+nor", "ufs+emmc-withoutnor", "ufs+sd-withoutnor", ......

Looks messy and unfeasible.

However, this is not a *global* no: I'm happy that your bootloader does support
loading DTBOs and, as far as I remember, even uses straps to vary the DTB(o) to
actually load - which is something proper and great... so it's a *no* for you,
but more than just a no, this is "why are you treating your proper bootflow
like it was a broken one?!?!" :-)

If anyone finds themselves in a situation in which there's no way to update a
bootloader (and that unfortunately happens more often than anyone would like
to see...) and in which the only way to apply DTBOs is to pre-overlay them
during the kernel build, then that's fine and I would (if nice and clean)
accept that.

But again, you're not in this kind of situation - and you're lucky that you're
dealing with a fully open device with a proper bootloader and bootflow: don't
ruin it like that!
Instead, if necessary, update the userspace tools that you're using to deal with
multiple DTBOs during system upgrades: that's the right thing to do at this point.

Cheers,
Angelo

