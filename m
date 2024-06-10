Return-Path: <linux-kernel+bounces-207822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4060901CAF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64E63B21FD7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D498E73473;
	Mon, 10 Jun 2024 08:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="zcAW5ht/"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C496057CB4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718007278; cv=none; b=mgBEe29tc9lLvgO4k9WIJfxKh14+Dlgo7HZc9F/XFu8PVfRliuT5RUWbJM2nc0lBigW8Ere3BBvmwr1M3d9uzSsxPJ3D74Wo+SIfrNJNBi/hmz5rVJRHwlO/Z1s2SliclSYObEbVnBgfl8agTUMoN7oXKLMD4In2SzXDYo47BvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718007278; c=relaxed/simple;
	bh=+iTjLS/qEuBXTSOPVFJFbWlAw9kHxOfyLrRcyOVzexM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o5XcRZ/VmrpWSeLD7Vi+RsViysVSG7l4vs84H3kQndZ8ocj/OiUMJHZGAzCpV9f6ZGVXVtXcZz90LDe8EIXuPRiQD3THkioVewIgmZwJ66FzIhLG4hJVhWOr47vHM5o8OIqXeWHBGviwh2Drw9Brz4fq2jyGQSw4knKby8QWIKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=zcAW5ht/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718007275;
	bh=+iTjLS/qEuBXTSOPVFJFbWlAw9kHxOfyLrRcyOVzexM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=zcAW5ht/EX2VhMVYZ37MiuPYen7/FSgG3ULfK5eQtYSUOE9l84TMjXaf7lCdj+8fU
	 ZW43FCuZKKTH0jXn2MfyJGISHr4BALL6OuP/JHhBl6f6yNQBSfLL8VfESa/yzv6vJ3
	 65H9OVItuOMNXD6kVgM3NSdRRU+IkZaB3n0LT4BdCLBEfcAcbMlpMn2b4DQzWENNOn
	 0Rzs7B0vzJ4zn2baI4/WVpDxkDnY42kf+SEgGbt2O995TEhqidD38WuoDFn5YyoxM7
	 38NoZa6gCdaCyF3QWSxpqHhnjhG1HaAXVfuFRqreE5BUQXlHxomfNoOZ/mtVeFefoX
	 jz5q8j+SVMMWg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 377F93780575;
	Mon, 10 Jun 2024 08:14:34 +0000 (UTC)
Message-ID: <e2dc83e5-041b-4c1b-bb0d-c8b0ee9d9c27@collabora.com>
Date: Mon, 10 Jun 2024 10:14:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/16] drm/mediatek: Support RGBA8888 and RGBX8888 in
 OVL on MT8195
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
 <20240606092635.27981-9-shawn.sung@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240606092635.27981-9-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 06/06/24 11:26, Shawn Sung ha scritto:
> From: Hsiao Chien Sung <shawn.sung@mediatek.com>
> 
> Support RGBA8888 and RGBX8888 formats in OVL on MT8195.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



