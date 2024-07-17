Return-Path: <linux-kernel+bounces-255249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA2F933DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA84284A45
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09101180A8C;
	Wed, 17 Jul 2024 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qDJtzF/E"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E082A1802D4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721224191; cv=none; b=c2sGWnPygQaW0aoADgzV+cW4p0ktFhLUOTHpuPkhze2/F9xMslUt55WM56aidIvcJhrytZH9DrjO/WDj2VLrsQm6JFyb5Td7l5v9KfV3p5CaNlVrwdw/CyUbWLuZ1eV4tzRXoGEB5CN9Rgmfcy/C0dzVuR/sX1Pj8nwMGqeUeXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721224191; c=relaxed/simple;
	bh=6ehNFxuXAzA5VSSUmxWhalLXcJ1zzSogzZ/g03PKf1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EOZQvbHkPP1/2dxDipdWoeXhk+gqpPdCE5sOIn4S/bvNY+YrGONZyJNkd2Lt7TuO8GGXoscUIARvL40ECVimrzyUc3slN3McOXQForZEcLsVWE4Ly77b7YO6BS57a04Faog7YzSU0ofaK38cWNIuml0+DJYXZIw0X+hmNdl4c3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qDJtzF/E; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721224188;
	bh=6ehNFxuXAzA5VSSUmxWhalLXcJ1zzSogzZ/g03PKf1o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qDJtzF/EjZbWVNU3Uxs/2vEF3NMK4vOZLgjK5km4+mzD7qLQBglJ/kI7Mm13n0A1d
	 QU9wXAuuY9CBEGJsEFAXbiPVF/TboMbQYIQoppTam2UrU9I0vR2ehmb5oLaJsld6Cc
	 laRaJcI9S2ZSYMdd4k42VWA6RLk8ub6D8W8eE8Wzm6uPo1F6jZfYtxWXt3uwJXeZU1
	 wE3tSyAVdbPs2RB6cbqNgMhFvZ85IBTfS7P8OREJUt8Ur8OHZxcEi+hkdrYvDAeNLT
	 SgFsV2ZPZbM5vwnKvbRkV08p5t6yohwwvmN1BYaE4RXvj/fTEPU6XbgHq2EE0wZx6r
	 S1r+quJMC86EA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A4DF33781144;
	Wed, 17 Jul 2024 13:49:46 +0000 (UTC)
Message-ID: <7d53e037-c4dd-4eb1-b79c-41f58f82beb6@collabora.com>
Date: Wed, 17 Jul 2024 15:49:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] drm/mediatek: Support "None" blending in OVL
To: shawn.sung@mediatek.com, Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Hsiao Chien Sung <shawn.sung@mediatek.corp-partner.google.com>,
 CK Hu <ck.hu@mediatek.com>
References: <20240717-alpha-blending-v4-0-4b1c806c0749@mediatek.com>
 <20240717-alpha-blending-v4-1-4b1c806c0749@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240717-alpha-blending-v4-1-4b1c806c0749@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/07/24 07:24, Hsiao Chien Sung via B4 Relay ha scritto:
> From: Hsiao Chien Sung <shawn.sung@mediatek.com>
> 
> Support "None" alpha blending mode on MediaTek's chips.
> 
> Reviewed-by: CK Hu <ck.hu@mediatek.com>
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


