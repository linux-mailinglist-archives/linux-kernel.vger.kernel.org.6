Return-Path: <linux-kernel+bounces-540724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC419A4B43B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182B716D148
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 18:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E03B1EB9FF;
	Sun,  2 Mar 2025 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="zgr8VpMs"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBE8AD39;
	Sun,  2 Mar 2025 18:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740941879; cv=none; b=mrl6R7Mj21khkl84hkT4GuqX+CDgE7OB9rGkMfucMDcQojywLYrZplYQGr4aTS+oX9l5ccZBcQoPKCrd71y5sZyLqhCKX+PyQls9R0ZQVioPxySu9ZCUE0x3hREUuugzRl2VdI7vtiQIvhn0sIDF4KRD5njJfZ6cZ4SPvdBumvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740941879; c=relaxed/simple;
	bh=6f3nE4+hMUhuJGhAonwOZkstOaLpys8RfLEpGJOsxFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyXCVEH3akaZeRkjK6fTqFYJKNGg/hMGik6rCTyVccgMN1YqFpczU+A0W7/jR4nwOJuKGFVKjPac5EJ1K6sg/zNfEeJ505m26hdvIofAR/W9O1x6Zrvhh9DdSHxqWFgGaNR5O4ll5a7xAb7r/z2xnYbSWIlNKSWLjMD2myKFAmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=zgr8VpMs; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pPjgLLKWy2wvQvaiR+uGJguXDw1skCmohUdLq/bT13M=; b=zgr8VpMs2oAvmtSCdLZNlyiimz
	8LpNFXehoTksa2gEf3aQkohP09ro+0qaqjvYXaQu+KxZB+sIKlyUbvUikUssDkhX7/7AP7k3KfEaz
	CAyKltObROv4gAMOa6xExAlm0l0aEKhoX+c9Pu1qTiFRRCfGJmEIJqtREfcq73tx7Ws1YbwXRGKdw
	WnzTTKVSCtKDSdIL8G1CshPaA0/1AhvPCLPnbygN/m2VtmmRPHGF/nWchoU07/hqyZW/BJqwtS6iH
	00V1WJLr3B0KvowzlMahZEFATeTzBlelY/WUcLfEdDewwy1pfGP6nsBKk3XlXNJTeRn5QvR3q8al7
	Q/n2u9kw==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tooVb-0004sB-28; Sun, 02 Mar 2025 19:57:51 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: hjc@rock-chips.com, krzk+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 derek.foreman@collabora.com, detlev.casanova@collabora.com,
 daniel@fooishbar.org, robh@kernel.org, sebastian.reichel@collabora.com,
 Andy Yan <andy.yan@rock-chips.com>,
 Michael Riesch <michael.riesch@wolfvision.net>
Subject:
 Re: [PATCH v15 07/13] drm/rockchip: vop2: Register the primary plane and
 overlay plane separately
Date: Sun, 02 Mar 2025 19:57:50 +0100
Message-ID: <2759797.BddDVKsqQX@diego>
In-Reply-To: <20250218112744.34433-8-andyshrk@163.com>
References:
 <20250218112744.34433-1-andyshrk@163.com>
 <20250218112744.34433-8-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Andy,

Am Dienstag, 18. Februar 2025, 12:27:34 MEZ schrieb Andy Yan:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> In the upcoming VOP of rk3576, a Window cannot attach to all Video Ports,
> so make sure all VP find it's suitable primary plane, then register the
> remain windows as overlay plane will make code easier.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> Tested-by: Michael Riesch <michael.riesch@wolfvision.net> # on RK3568
> Tested-by: Detlev Casanova <detlev.casanova@collabora.com>
> 
> ---

patches 7-9 look good to go, but ...

this needs a rebase to adapt to
"drm/rockchip: vop2: Consistently use dev_err_probe()" [0]

[0] https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/b06d1ef3355571383cdb463cf0195b7a02efdfbf


> -		if (win->type == DRM_PLANE_TYPE_PRIMARY) {
> -			vp = find_vp_without_primary(vop2);
> -			if (vp) {
> +			if (vop2_is_mirror_win(win))
> +				continue;
> +
> +			if (win->type == DRM_PLANE_TYPE_PRIMARY) {
>  				possible_crtcs = BIT(nvp);
>  				vp->primary_plane = win;
> +				ret = vop2_plane_init(vop2, win, possible_crtcs);
> +				if (ret) {
> +					drm_err(vop2->drm, "failed to init primary plane %s: %d\n",
> +						win->data->name, ret);

should also use dev_err_probe


Heiko



