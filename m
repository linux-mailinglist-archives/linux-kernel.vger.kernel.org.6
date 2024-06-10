Return-Path: <linux-kernel+bounces-207821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6A7901CAE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 305D1B20DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D24E558B6;
	Mon, 10 Jun 2024 08:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lW0ACqbh"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2603858AB9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718007255; cv=none; b=lNqXP1gwvkN+m/yI4AaFpR1dADKZ46E/zGGK35EapuYZaShKLlGE6/XBGWPSJAwGchItiL67E/fSunIcwqgWT46YdOTemmW/s+qe0kp/RTz9L/HW3xJvP8DD125XaQmbzGq36egrwYqjfYNsig0aCrsPNJE9WSpxc/obKSjCTxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718007255; c=relaxed/simple;
	bh=J1o7GUOJzCSDHzhvzvHGZsnc3g+z5nolKVnnUTDks00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNL52316DtyIw4xMiW4XcT2htLiRCZeaxudap+F+Q99PgIQ0/btUIg+yJ35ecjnn6CpQjMRSyAOdn6xEefurbyxUjU3E1ckGwQbRpO71bGBCHwxUxF5KQmfnEOspkCewdJ13cudZIX1eZkbREn2j1kRkh0wIf2W1Suq8bBA4+HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lW0ACqbh; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718007252;
	bh=J1o7GUOJzCSDHzhvzvHGZsnc3g+z5nolKVnnUTDks00=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lW0ACqbhxTzXDV5cwzEwamHYYJWcHpT2kKhiPxWvzG/+zG0WyPKrb81HgJ/xCJ9lc
	 ZWPVNv4ULxyTfRPlBlM2BsMMPRpo2wugYVb5KNJYrhoWaqwAtUWFfYke+KQCDBrmmc
	 NnflFzlyqkxw8EwQ2TF8QzoCwAbqRAM5dHXOL3+fRvHNEOTv+JLQe5y14zygZHRH7k
	 UrFs+TQnKcj2SjXtT7Sg42aM55bqI52qBs9BZoRPd+D+Ffjbfcvq0E1u50oG4TW/19
	 Vs3JgJluo+szSnOV4yCaYFICrJNn7IUo+4y93SoeMBuvXXCxnqZgo77pxgOr0dQdnM
	 mChRDO1UKVhTQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 49BC53780575;
	Mon, 10 Jun 2024 08:14:11 +0000 (UTC)
Message-ID: <07a45bb1-4444-4ea3-a650-b42392c6fea9@collabora.com>
Date: Mon, 10 Jun 2024 10:14:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/16] drm/mediatek: Support more 10bit formats in OVL
To: Shawn Sung <shawn.sung@mediatek.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 Bibby Hsieh <bibby.hsieh@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
 "Nancy . Lin" <nancy.lin@mediatek.com>, Sean Paul <sean@poorly.run>,
 Jason Chen <jason-ch.chen@mediatek.corp-partner.google.com>,
 Fei Shao <fshao@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240606092635.27981-1-shawn.sung@mediatek.com>
 <20240606092635.27981-8-shawn.sung@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240606092635.27981-8-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 06/06/24 11:26, Shawn Sung ha scritto:
> From: Hsiao Chien Sung <shawn.sung@mediatek.com>
> 
> Support more 10bit formats in OVL.
> 
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



