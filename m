Return-Path: <linux-kernel+bounces-437193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B8C9E902F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123EF162B9F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AA5217F3F;
	Mon,  9 Dec 2024 10:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="i6Qk+uw1"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223A021771E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740308; cv=none; b=GlYU1BxiHtV5ubp9O795BKOCr8p02/e3I9POU/I6/PCjn8Zk3DDwM9pe+CetvYlhCEk6WgYAYNTwB6X8RjvmlCZUmVnFXqevTJ4TC1YdkPj0jQNvMDBSVDL2gKRn7VUFOg16ZAU5X3bHv0gxMcKxwExLWN0gV+jvOsVITt/0vG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740308; c=relaxed/simple;
	bh=uNhmgnve4luc+D5B5WQIKlrwApKmXukvG8Co3IvHWcI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ae50IInR4Ui0rJ4n8CqAAD/IhGccKT3DdrXnS0jm3UZv9oFI0LuQhWJZQiofOT7BWE1m0dffugbNzz+E9Zw0hQ9gdxfZPiPXiZbeqOrLHfv4vicpLyst9vjI28ibqfvbt8Pv24M6h10cOyPD03Rf4s+ptJu6lpM7SNTDpgiY3vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=i6Qk+uw1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733740305;
	bh=uNhmgnve4luc+D5B5WQIKlrwApKmXukvG8Co3IvHWcI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i6Qk+uw166U0n2OxUOVNIeLG4tCa9HLt1XZDlIlP5VHKFPHT+Pb0pyMO8/FO7DYFn
	 miWtsy6yggg3ENn8ZPO1RYMi1rJzaxfMZ8FGvMBYawOr4IB5wvEjBquHF/n4Y7e4Dx
	 EuOc58RgutPN6G9hyVIRpLrGPB/ExwPmxnXwVPgnZmtufnG1wC1e/Tmg2NEtGfZnJM
	 CAHLd6WOMAAxb5qnoq2cZ9Q24rRCGX7IuqbMPwRlfUW2ny7MLAFD2ArFHFXEVFr2x7
	 IMAlba8F02Tv3O2jBUCiGDUmBUoXObSE58FU4eKe9DLsbJJRA4Lk0kpqeyZUd7IKhc
	 4BaNJXyFdaOFA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8E75817E35FC;
	Mon,  9 Dec 2024 11:31:44 +0100 (CET)
Message-ID: <a1153976-41ce-43c8-b6c1-14b055e05e9f@collabora.com>
Date: Mon, 9 Dec 2024 11:31:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5,02/10] drm/tests: hdmi: rename connector creation function
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
References: <20241130-hdmi-mode-valid-v5-2-742644ec3b1f@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241130-hdmi-mode-valid-v5-2-742644ec3b1f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/11/24 02:52, Dmitry Baryshkov ha scritto:
> As pointed out by Maxime, the drm_atomic_helper_connector_hdmi_init()
> isn't a good name for a function inside KUnit tests. Rename it to
> drm_kunit_helper_connector_hdmi_init().
> 
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


