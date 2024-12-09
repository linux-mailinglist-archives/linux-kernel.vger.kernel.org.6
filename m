Return-Path: <linux-kernel+bounces-437191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E699E902D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60B5281B7C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2651D217667;
	Mon,  9 Dec 2024 10:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="H/rQsvNr"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A032165FD
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740305; cv=none; b=bgOGoSNjze+0Xn1NdNx1qFRmZ1sYmwK7bOJDAOAL7Xi0G4ZAKVPT4jN4SXOloPXtk4WKOLECE2JL7VnFau4mlWw5SRhCc1wYbtybc+UrnQ+DZ/kNgt04iVznTfTsthXkUKpvco2su74PNbTkNFgixsYoNjWkpCeAv1b8o5u3RLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740305; c=relaxed/simple;
	bh=U+WWAKmaH6IU4lWE0vkOIziLE7iYkDJyMK5lmAlWUE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UnzS99XL56vZ16/66AiVqrD2/T9tQ2dLJmlr/HDE7EV6BP+tVcn47LJ11D6jGzIpgBirRcobTCJB/6J2Ud8Fpf/LuW5m4/pmQ0wVwwu2bkg4ikHiEzvZXLqCco9rytvhxZIojFr7V5t7thEgFAmztUpRm5tId5PGRIqyVf7VKuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=H/rQsvNr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733740302;
	bh=U+WWAKmaH6IU4lWE0vkOIziLE7iYkDJyMK5lmAlWUE4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H/rQsvNr+g2+qxOWIl6wk0zt3S+H8ODR1B2p0n1OBpi0J3cdps9aZCBbXBDeWABXg
	 /Piei4i1Yoc/TlGpNEPzXNuH06YCvZVbK7ySnB/9Kz4b0WTLBk2z3LuTUwTmUdSvUt
	 6hsDEwMHnX13AmNx4fDLzZcwhpuBQpTOdE5cD1Q1G+2cOyBJ+M303SsbVZOusqhd8d
	 obtNr1muyAoSgfuRKqROdFxJVF/c6kWeiUquinCJGD6eTRbdJHgef4NWALSTVxO3D2
	 cFLYZ/DrIuZvPwHfFu2SkuLj+/jB0nddspCRprbVOSsUc0T7sBXUmr9oU5iQzhtvmm
	 Ct/hnad/iXKyw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 261E817E35D0;
	Mon,  9 Dec 2024 11:31:41 +0100 (CET)
Message-ID: <75b15251-f72e-4306-a90c-0b875f745b7d@collabora.com>
Date: Mon, 9 Dec 2024 11:31:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5,03/10] drm/tests: hdmi: return meaningful value from
 set_connector_edid()
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
References: <20241130-hdmi-mode-valid-v5-3-742644ec3b1f@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241130-hdmi-mode-valid-v5-3-742644ec3b1f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/11/24 02:52, Dmitry Baryshkov ha scritto:
> The set_connector_edid() function returns a bogus 0, performing the
> check on the connector->funcs->fill_modes() result internally. Make the
> function pass the fill_modes()'s return value to the caller and move
> corresponding checks to the caller site.
> 
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



