Return-Path: <linux-kernel+bounces-437192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CC89E902E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C40D162B29
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0091B217739;
	Mon,  9 Dec 2024 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="EaNtCQpg"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49B0217659
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740307; cv=none; b=gt6wM2b8p1dIrc4qEP0Nee7KFKVqcMG6UkXQPEvwmmZj8Wum3NOAK7NZgcT2+DAbjz61Nu9J7YV59y0d25cYlNNfQkTDHaw5EQ55HgOnNwR2Oi6E4uw1RaA/Vnj7uuKj3A2tN3eczEme7FCP53XtoTZZn8M1EWyl443fVYWgMjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740307; c=relaxed/simple;
	bh=5FD+3+YGg66Kmg6Pb8md4YNs9r8XETLZGOR+KRhv8QA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHPouWLmf1Os99ICGxfhnebGtuIJXke+mx5/GhnUp2Pt3NwjReHiJQ/bIE9prigODoIJDnX36KieiOUPyHgUrFaqLVMU4kAPCCKLYBITWRliPyVU/WvEzTzQWImOVPKLOCslL8lGg8pVAgpF+IX2gaKTiLe1kHAf5fhEmw64ppw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=EaNtCQpg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733740304;
	bh=5FD+3+YGg66Kmg6Pb8md4YNs9r8XETLZGOR+KRhv8QA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EaNtCQpgyCPk0+4dHGkKhWhTdHGQNvGnLSeZ8De8z7kk8FfSPaT9qfsaGE9xPzc/8
	 4rq+IkOPuV434wXqQ9OBXRbZpM2g0fjWtpSIlpE1luurwphiPGgMAKOW6bW/olK3te
	 djaMne1S2nmnHT7SWdf6auM/yT4IPdJVPzn6DwKYLSQtNdptU7F3jouBElJ80b0gHt
	 d5vNswk+6jck15aLq/OagzA6EsPw286buniN/bo8X+/BHFlK9Mr3AQMoYvJdeYWZp6
	 CG5oPPdxPw2LvxlI7NIj1xZYh9sLEDTV2mZscHZM1lRnjgOIXGLmh4RZc+6Eds3IRD
	 qUiJb68WP7V/Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1EE5E17E35F4;
	Mon,  9 Dec 2024 11:31:43 +0100 (CET)
Message-ID: <0b5cbe50-12f8-4f7d-a410-811fc4063889@collabora.com>
Date: Mon, 9 Dec 2024 11:31:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5,04/10] drm/display: hdmi: add generic mode_valid helper
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20241130-hdmi-mode-valid-v5-4-742644ec3b1f@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241130-hdmi-mode-valid-v5-4-742644ec3b1f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/11/24 02:52, Dmitry Baryshkov ha scritto:
> Add drm_hdmi_connector_mode_valid(), generic helper for HDMI connectors.
> It can be either used directly or as a part of the .mode_valid callback.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


