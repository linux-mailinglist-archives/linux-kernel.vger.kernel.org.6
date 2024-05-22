Return-Path: <linux-kernel+bounces-185842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF268CBBC1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 09:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A013D1F222CB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 07:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730F77BB13;
	Wed, 22 May 2024 07:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KkFRQKz0"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BCE44374
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 07:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716362021; cv=none; b=pjIeGHC5UGgA+VWhqqByHRoWfMlpg3Qsyrmhm/tPA6dFkbVGVzhEnh7C/B6/8sP+z5urgqIsng+TeoFEemyxbI7s2ZnvbbduMlzwWKaSataQKhsl/urGKcqCnX4S/PLbbU365weKnrz5fpdIvVSHNSr7qh2MT/CJz2y6KIQsKYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716362021; c=relaxed/simple;
	bh=ovjsPfFfFox4+imrFSPnYzf2/8RO117uDA2zkRXNfwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LqNeXja+iGwdm4vKs8LENKF3y6mHZPgnwziJdYC+90OdpqHRzaxn7Xw3QCZFLioe6YQXp98wTZYFrWHMhFC0oj4L4SGlgjtwJx2jaSIBzQI8aDEYa5fP6LYeljIARDdOkq5teF0u3dRUB4/BdNyfK8Urx0Gwp5wE2hbEBGx04DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KkFRQKz0; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716362017;
	bh=ovjsPfFfFox4+imrFSPnYzf2/8RO117uDA2zkRXNfwA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=KkFRQKz0MxzG22OOPEO8j67lNYRPlqtfyMac+UsYjN4SRbp3Xa5KiRCexxYiKyLAy
	 EUAwRR4/QxCU+H6QkD/HrDOcMBU31d58wVIIIWz4ls5Z4Mg3qk2b1MSfDnFmd9ZH/K
	 P9LhoXe0Ne5BsbYtzAw5nfHIAhwEwIjOko8f49go1pG0pvYY8T14A9QBamezgl7eNN
	 299ya3lanlzRA3SyuskG0aQmnWVkspFZ26QN2IGCD4dnvfV/PJ+xGUDIuoevhnDM4d
	 U0beMYKzKSE/zBLjcMX3Xj4xiVHieKNofMi9rQYYWOWKJxjwKwnAmGz9WPZshe16dh
	 6kOBl4NFY8yQw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1B2B23782157;
	Wed, 22 May 2024 07:13:36 +0000 (UTC)
Message-ID: <36052284-6b17-4b3f-ab99-a01beed4c601@collabora.com>
Date: Wed, 22 May 2024 09:13:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13] drm/bridge: it6505: fix hibernate to resume no
 display issue
To: kuro <kuro.chung@ite.com.tw>, Pin-yen Lin <treapking@chromium.org>,
 Kenneth Haung <kenneth.hung@ite.com.tw>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Hermes Wu <hermes.wu@ite.com.tw>, Allen Chen <allen.chen@ite.com.tw>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240522065528.1053439-1-kuro.chung@ite.com.tw>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240522065528.1053439-1-kuro.chung@ite.com.tw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 22/05/24 08:55, kuro ha scritto:
> From: Kuro Chung <kuro.chung@ite.com.tw>
> 
> When the system power resumes, the TTL input of IT6505 may experience
> some noise before the video signal stabilizes, necessitating a video
> reset. This patch is implemented to prevent a loop of video error
> interrupts, which can occur when a video reset in the video FIFO error
> interrupt triggers another such interrupt. The patch processes the SCDT
> and FIFO error interrupts simultaneously and ignores any video FIFO
> error interrupts caused by a video reset.
> 
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Signed-off-by: Kuro Chung <kuro.chung@ite.com.tw>
> Signed-off-by: Hermes Wu <hermes.wu@ite.com.tw>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



