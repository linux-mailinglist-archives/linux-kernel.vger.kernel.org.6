Return-Path: <linux-kernel+bounces-437189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5871E9E9029
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07819281A95
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94134216E2A;
	Mon,  9 Dec 2024 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DOSzIIbx"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDA621639E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740303; cv=none; b=I3xqwLG4XhKE3a2mw7Vl4kUAakmiUTUb2HdyvXN76XGvwNdu2+auLXfPdCKd+nbEjHJCXVqyJyuPcb7Jlbwi84rZFZPtYubMv+WT93YgeGu+BunJ0APHE3P4tVki/0ISX56hwdi1B/MA8S5vu/l9gfAlUopOcr3ze5/zE+UGQcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740303; c=relaxed/simple;
	bh=k0uZ2UEiQzgNKBRrB48UKpg6beGJR/i+NshtGEJDMvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eA9QP8BhagGp2v1bsbVBA8Ft5INbzJOhxO6rCxzRwj5kT0dnpygg8TmEPn4YRDJpjmlclcBFJlogmUD0H/8/3XENsft3wV96eY0FEnDOoVaJXji6ZBlJ87PJggT0H7/wLlBzV9zzDZ1DxqMIlAU5q70NTmbl57vNBcu44uKf2ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DOSzIIbx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733740300;
	bh=k0uZ2UEiQzgNKBRrB48UKpg6beGJR/i+NshtGEJDMvA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DOSzIIbxNs4m/3Mx4eetw8fASpCfbWVS8J/to0FOK37EpAjqQpT//KZQ6ws7Yr2nZ
	 3He80xCGICgu2tUehGh4YwyO6Ola5AwNN0q4mEwR6Hc4dxR6K8qTpQpS1PQS2uqyrI
	 T2TEoT7mvCYR9l90aBs6w4pYB0/i0Qzn5wPt75XgIgTUqdzkPHVBHKVaf+pHOz+aj+
	 sbeijpuLLkSiggw6x4tTrTURF0LzQ/q22GzB7u8UOxYv0Rtuvw16NIYOpbvresYkcr
	 Kna8YTPCkXCmHQd1pcDO4cK6QEslLYCMbhK922NP8JfYW08kQKUbFdbTY/GD2qqvnM
	 qnJwUDAF0JKbQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 73B1117E09C0;
	Mon,  9 Dec 2024 11:31:39 +0100 (CET)
Message-ID: <5d722361-5ea3-4734-a2af-41aa8c2eab0b@collabora.com>
Date: Mon, 9 Dec 2024 11:31:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5,07/10] drm/display: bridge_connector: use
 drm_bridge_connector_mode_valid()
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
References: <20241130-hdmi-mode-valid-v5-7-742644ec3b1f@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241130-hdmi-mode-valid-v5-7-742644ec3b1f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/11/24 02:52, Dmitry Baryshkov ha scritto:
> Use new drm_bridge_connector_mode_valid() helper if there is a HDMI
> bridge in the bridge chain. This removes the need to perform TMDS char
> rate check manually in the bridge driver.
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


