Return-Path: <linux-kernel+bounces-183699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A1D8C9CBE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B251F22CC3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15485381D;
	Mon, 20 May 2024 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Pz57cOLc"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B818F1B960;
	Mon, 20 May 2024 11:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716206161; cv=none; b=LAyeTdUU9BW9MrClYMMziLJ+QLUN7vS4lrAbH/NK7wu5vhOLR7ypw/vo7P7u5g1lEOhX5SHLWksrywsBV+Ml7A5kGKAiwlKajVM/Jiyza/DLwrDZGBKRN2tDPYqLpmAi5TXP6c8c0lWwVaqARWQ2xmITTwt/IlQ9iIN0tufXACQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716206161; c=relaxed/simple;
	bh=HVdVs5WsRae2+1QNnkZk8b+8Vke7zSeq7GNWP4iLtE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=piKObkai6XTyBA7Vnv7l7w88Cv2FgpO5RRaWO6J6GvHTzHYWxu8Sx1tiB/Y8TM/Oa92v4BYvkMhdDezriMtUEwbN3Fs0HibA8iRpzcWBR1rS0uyObY7TNtCM5FgSs+681Izl3YySLA59VP7TnecEm4F09T0ZeEYtOuD9d9B97Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Pz57cOLc; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716206157;
	bh=HVdVs5WsRae2+1QNnkZk8b+8Vke7zSeq7GNWP4iLtE0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Pz57cOLcladhmdo5+/6Yy/Ks3GaYaTeKHcKTulsGnX7erKkpYOuVfk9HZAMKqnUy3
	 t5SxNsaK0MHnaYCs7Iofizh3vsfHicUMyp1YOWul5M/ED7vFcj8y4QSU0I5E4WLFpb
	 l/RqSzWiOq83+TlinnXWNfxJ7xVLRus4h5vUcgMU1HR8myXFmQYOmihk1hgLIbDbAc
	 otfrAnUpt8A0LM43u4m3Fbf0Vf0+FIoZtEGN1Xc5aEYoTHgj2YrDshVMA5bRORqpWk
	 Qq3s8hMeFveAo193c4XDBnxSuy1hSsZlehIycchb46jTXjThyfZ0QN6snIYwlGXveL
	 JdseYdQ8dOAmA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6141C3780BFE;
	Mon, 20 May 2024 11:55:56 +0000 (UTC)
Message-ID: <df152312-a8ab-40d8-a361-fe5100e11dd9@collabora.com>
Date: Mon, 20 May 2024 13:55:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph
 support for board path
To: Alexandre Mergnat <amergnat@baylibre.com>, chunkuang.hu@kernel.org
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 matthias.bgg@gmail.com, shawn.sung@mediatek.com, yu-chang.lee@mediatek.com,
 ck.hu@mediatek.com, jitao.shi@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 wenst@chromium.org, kernel@collabora.com
References: <20240516081104.83458-1-angelogioacchino.delregno@collabora.com>
 <20240516081104.83458-3-angelogioacchino.delregno@collabora.com>
 <ce1de395-3f60-4f7f-9424-bf036134de94@baylibre.com>
 <7dbe08cf-47a1-4da6-9035-6b0932cf8426@collabora.com>
 <67f13b3c-18b2-4042-9908-b4d41c24cdb0@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <67f13b3c-18b2-4042-9908-b4d41c24cdb0@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/05/24 13:49, Alexandre Mergnat ha scritto:
> 
> 
> On 20/05/2024 12:53, AngeloGioacchino Del Regno wrote:
>>> So, I don't know how you want to manage multiple display, but IMHO there are 2 
>>> ways:
>>> - removing the current "oneOf".
>>
>> ...eh I think this should be anyOf instead :-)
>>
>> I'll check later and send a v5.
> 
> "anyOf" behavior works as expected on my side, dt-validate pass ;)
> 

Hey, thanks for the test, buys me some important time.

Cheers!
Angelo

