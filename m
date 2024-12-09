Return-Path: <linux-kernel+bounces-437194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA9F9E9030
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA0B1886296
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FF3217644;
	Mon,  9 Dec 2024 10:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gLTgnQnB"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F48216E18
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740317; cv=none; b=L7XIVzdnD0im79TbJTVMejwM0nyqIKHjPUITipuStUGRbOt+ICR33l87q8ezq8OSsMlgHmawygR/tMxTjJJBrQf+0s2xdH695hjdyLr8eBNlfJynu5lmii9zih2kyHx+VZL6Y/ol2wibtQSMtf/D1nEtjfGuVcXi7AjX9F1nNRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740317; c=relaxed/simple;
	bh=eoxD+MuxeUWnPi1TZIMlO0bSaVXPjRZntQfrGLycbFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uvu0Xh13pfXNNdm2bEvzW8Ioz36usgNXuNt5Hy4iM8hGIkuwYy4rLkT+36PA1wQEc3NA8KRxVL4IaAiRQT7vmk3uRpb5y3G1cVL+n0R9HAh53qJLQFHV9/BERLRLgHaq8BeeccxTLIi5XnRx0lWdvrVqJnsamffIUrJr+OSLw5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gLTgnQnB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733740314;
	bh=eoxD+MuxeUWnPi1TZIMlO0bSaVXPjRZntQfrGLycbFM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gLTgnQnBrQOHXgTiFEqwaP4J7pXZPhJWiHMKVa35ctJD/pScumBvQ1i89CcDXlDbe
	 uN2VLWMSOdsVPLLkxto2GuhU6oPFn3FReMvaKz8dXEu9OSjcSWIyLtoIbWkS0jmfUv
	 SrElDBoxZBKSTdZRW0qmmqQrsprgejfg4Oj2hPgiC5BPZcqSV82TQnplbEp0bSSIRp
	 CKac8ygzUqjD23HO22QD6DVSWHbt5jLvG9SY/ysVJ1yPVpQOfB9h4FHomPHe4WhnSy
	 Tf3osirrGWXboRb3hJ59yPQeodODSsWp2RJppVS+b1IWGusHJ77QteY45S1ijSCSfT
	 Z1ybLX9ITLpxg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 51B1A17E360E;
	Mon,  9 Dec 2024 11:31:53 +0100 (CET)
Message-ID: <2cafa6a4-1f18-4891-9626-f7e5b83a4a3e@collabora.com>
Date: Mon, 9 Dec 2024 11:31:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v5,01/10] drm/tests: hdmi: handle empty modes in
 find_preferred_mode()
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
References: <20241130-hdmi-mode-valid-v5-1-742644ec3b1f@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241130-hdmi-mode-valid-v5-1-742644ec3b1f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 30/11/24 02:52, Dmitry Baryshkov ha scritto:
> If the connector->modes list is empty, then list_first_entry() returns a
> bogus entry. Change that to use list_first_entry_or_null().
> 
> Reviewed-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


