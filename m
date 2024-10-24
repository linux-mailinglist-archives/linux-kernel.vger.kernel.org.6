Return-Path: <linux-kernel+bounces-379805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 621A29AE405
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0931F21BF6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27CA1C4A35;
	Thu, 24 Oct 2024 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Jhv2OSwn"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00238176AAD
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729769752; cv=none; b=kIYer6y+wZUdkNHS12LayX3jl4iF/SDMa151nRcja9cdHyLdzq6dauiNtRdpqQWwds+7YdgH6V8hSxaTd+H0cj2nEYyiz+kyebCUnsKiP/Az6LeooAiJbA9TLcYHjA5RAckO8GeRlvEEIGnAVLZYOwbT2vIKpJC3g4ZuRz1d9/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729769752; c=relaxed/simple;
	bh=BLP2qSk59XHygRuGtwvvviZHLismYalYrgP+lhwiV8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQ+JtPsQ6YuLWof04PuStzapKdmz3/vy7Q+mJhBwP8pafG7DqsWPkwI+PF+/Awst/VNPLNUqPjTY8V4avE0TnyyVvt9e28w6TBRt1bJESwzPFdhG697bhMDomFhV0d1OSC2ShLMGzLIQcwtkWd19qP+fez3B1YsfBHkEDBQ1B9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Jhv2OSwn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729769748;
	bh=BLP2qSk59XHygRuGtwvvviZHLismYalYrgP+lhwiV8k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jhv2OSwnszDSFGVPFqjILsZE1X2ReJHgp8WHeWdMv6Zsp6Ll1unmY9mgeJSKjxB9B
	 mEjNgsWWD0PT2cbTzMv0c3SSxNIpI8cXU9S6Oq/L8gALXkPeL+OU4O7rn4KmxyNJbr
	 dplZUqsXXvoPIdGhu/pBalDD5WIV5npfwPUGKyr15sjE+sg83nmft8tpN0i+7/39Vh
	 JEtm5uanLs3k5TyC1Habi76PiqfhLiP45fDsFlSBLCJoXV6dwWl1K31uuKqoYy30KK
	 qKKntmQnWevYFnGX9FJqETrcIs1gHtyOXUjSJPFs6o1Zc7mFlhlS1XFDx/nxPIbqxY
	 QVmqxnMDNBkuQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8697417E35D1;
	Thu, 24 Oct 2024 13:35:47 +0200 (CEST)
Message-ID: <f21fd6bd-b3d5-48f3-8693-48668ee5036a@collabora.com>
Date: Thu, 24 Oct 2024 13:35:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: display: Set fwnode for aux bus devices
To: Saravana Kannan <saravanak@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Jon Hunter <jonathanh@nvidia.com>, kernel-team@android.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241023191339.1491282-1-saravanak@google.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241023191339.1491282-1-saravanak@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 23/10/24 21:13, Saravana Kannan ha scritto:
> fwnode needs to be set for a device for fw_devlink to be able to
> track/enforce its dependencies correctly. Without this, you'll see error
> messages like this when the supplier has probed and tries to make sure
> all its fwnode consumers are linked to it using device links:
> 
> mediatek-drm-dp 1c500000.edp-tx: Failed to create device link (0x180) with backlight-lcd0
> tegra-xusb-padctl 3520000.padctl: Failed to create device link (0x180) with 1-0008
> 
> Reported-by: "Nícolas F. R. A. Prado" <nfraprado@collabora.com>
> Closes: https://lore.kernel.org/all/7b995947-4540-4b17-872e-e107adca4598@notapiano/
> Tested-by: "Nícolas F. R. A. Prado" <nfraprado@collabora.com>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Closes: https://lore.kernel.org/all/20240910130019.35081-1-jonathanh@nvidia.com/
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---

On MT8186, MT8192, MT8195 Chromebooks:

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


