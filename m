Return-Path: <linux-kernel+bounces-384508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 814199B2B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154781C217E2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629371990A2;
	Mon, 28 Oct 2024 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FZJFkmy/"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18C81925A3
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730106593; cv=none; b=XO6ewVpn2HxDt1Z/vrW0rP8rqQ+GRRnw5U8x6NE9lGihjl+PU+6fCQnYg5ABwdDzAgX+zv8QdGCg6pZm8ChP+vymVVmw4enm45IxVtXmWNfeCDN6TZhlWEx99YtViPh85jr7Cpt7HSOsGmGQzXuflYASqT+CDePiY5NR0Z7j6QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730106593; c=relaxed/simple;
	bh=qbDABT2Z+Hm3SckfMFDCYI4eg+29z9RV470Z0JIO1Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BiKKz02wXdAQE7MwsE0pS1XkV+jHQIFPftkd9fAlUnx+/5eHUM2m/fgVHJiTd54ytvLmkO0vRSMRZ+bjCZffs+f49cJ8xTFnP41J6CX4Uo6ZsPVYGWXNT7Gbn3J/zDRIbZV5j+bo65R8NlQCLE9hiixwMjg4PAKPPdi4on+uvwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FZJFkmy/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730106583;
	bh=qbDABT2Z+Hm3SckfMFDCYI4eg+29z9RV470Z0JIO1Ow=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FZJFkmy/CZGDMoWGPLr/Imi9VzeOfV6jRL+DNCZklfPNZiSGYd7vmJqrQLGfak9vx
	 KywcSbX/zh6R4+mF4LJNWNuIFrRoa7tSSdtfEXioffKbYT65raQctoNBD50jrI6nBH
	 BA6Kx3oW5YPXbbgJTEO0nTv+i1AMJozDcQtcQSxzT2jlumQuO0ZI4TQHmLm4Su0Tu+
	 HziNnpKLd0OvenQqLTK3DLxyMUBBv07oDbQLsjN6a0ota0qufqzzubluruEPHWH7O2
	 1UtWwLBI9rzrLbj/80MdIkrmdi7gLvqFZf/PxNokDVBQ38hauTqxlvOIA6zoCRLi9m
	 BJMnYxeERYhzQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 476BC17E10FC;
	Mon, 28 Oct 2024 10:09:43 +0100 (CET)
Message-ID: <edafc004-999d-4ace-8f0e-1b8c711423eb@collabora.com>
Date: Mon, 28 Oct 2024 10:09:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/mediatek: Switch to
 for_each_child_of_node_scoped()
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 Alexandre Mergnat <amergnat@baylibre.com>, CK Hu <ck.hu@mediatek.com>,
 "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20241011-mtk_drm_drv_memleak-v1-0-2b40c74c8d75@gmail.com>
 <20241011-mtk_drm_drv_memleak-v1-2-2b40c74c8d75@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241011-mtk_drm_drv_memleak-v1-2-2b40c74c8d75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/10/24 21:21, Javier Carrasco ha scritto:
> Introduce the scoped variant of the loop to automatically release the
> child node when it goes out of scope, which is more robust than the
> non-scoped variant, and accounts for new early exits that could be added
> in the future.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


