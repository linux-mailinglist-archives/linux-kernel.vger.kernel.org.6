Return-Path: <linux-kernel+bounces-437190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D339E902B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08591886216
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9418D216E2C;
	Mon,  9 Dec 2024 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AsDRNMVZ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F2112D758
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740304; cv=none; b=neyxpfNp1Lq0bT64TFvsliOqvcTHJM7vlXacSTv9N4Ie9wu05u6yTEpZt/skKiT5veUfcyfa2sm8PYj3kxS2rZX5MQA0v2JHCBWS3mYUNptL9XgVMwv/OcxFo8KnAAcekjjxv5aveBd5z7T1gbhJFjnYHS0I6GJhSyAWtay5wd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740304; c=relaxed/simple;
	bh=5R7UJvpnNZvpK9L14WEHsC1kTWlkvqH3tZDrqX5OaAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VB8qklb907OLu03wQsvBEDVUkep32AehG8XBfR9xQ3WGJqUrCeNOe6vfvbbtgaXV4U8UXVfhNpqA58L87nV2DOOt0wx/xHNCZ473rZ0QMiri07DMfFPnOygkXMEX1ehIGwqzhiDN5fk6lhL+pQVey1XJXRQAng4yEj5QSW5tc5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AsDRNMVZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733740299;
	bh=5R7UJvpnNZvpK9L14WEHsC1kTWlkvqH3tZDrqX5OaAI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AsDRNMVZSOiJ1zMNL+H3MTL59YGIgcxr41pSwJBzP8V0OEBd7hAyOn5nMVaocM1up
	 6TH9hACou9PFnPYdtFpahta0sBenIzXDvJF+IYtgQq/bZof/Dif8M+mvzhcYHdU59c
	 BxO/9glV7TaWKyn1lc3seme6Iuu6jWR1A17RkaZzY6qOikd2Vl1TGG9ubHvTbHmeNt
	 VeuicXVAdN1JRiDCNiEIUi3WZYwqF+1VmMnRPksd3f6Tk2n02Q2izlDZyo1lfT2Zm/
	 7msumAgYdq6I6j0cROANvBPVKio8J29E2Rx3utlESZL948TILuwQHM1dCfHri0YcTN
	 dXgldygaYP41g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4862E17E09BE;
	Mon,  9 Dec 2024 11:31:38 +0100 (CET)
Message-ID: <2484261d-5589-4707-b3f9-7df78b2935eb@collabora.com>
Date: Mon, 9 Dec 2024 11:31:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5,08/10] drm/bridge: lontium-lt9611: drop TMDS char rate check
 in mode_valid
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
References: <20241130-hdmi-mode-valid-v5-8-742644ec3b1f@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241130-hdmi-mode-valid-v5-8-742644ec3b1f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/11/24 02:52, Dmitry Baryshkov ha scritto:
> Drop manual check of the TMDS char rate in the mode_valid callback. This
> check is now being performed by the core.
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



