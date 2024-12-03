Return-Path: <linux-kernel+bounces-429156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0709E1B1B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45D13B45106
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40151E0E1E;
	Tue,  3 Dec 2024 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Q+qUmzjW"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AA21E04B2;
	Tue,  3 Dec 2024 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218846; cv=none; b=SdNlT+Kk0K6j6rWcaptR3UJVGLCYNph15S37bDJPbgNxefb3mTjTT2K+NGXQbhcz4Szt1OTX15qDKdBelVv2srvFHvOonmgryoL3mYHNSZ+bAyt01K/v7rtMw+Uj5/JEk8Pl33C/stvs5Q8ZSf5fQhyC7sGe2GihWSJfje7OXGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218846; c=relaxed/simple;
	bh=mQrPvTHBU9kamXtdQ6gaZmlwNXNXUC4oOdkVd++NnNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VTGwmDv+tnoYIhxH7Hc75de3t487AH/+vOhM3TBDZpxVrMTnuEQPV771gI8ISctSotQrjqg9vpt3mqYwEpFUBQvm4OFaLvJzNGXQGB9kYutu/m2KJsmBFCbBDkOaoEyZCgl9+mZUWUlMXhYzThl+CpCXGSvuUHc6+WMLxXbf3F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Q+qUmzjW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733218836;
	bh=mQrPvTHBU9kamXtdQ6gaZmlwNXNXUC4oOdkVd++NnNc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q+qUmzjWXCMBbMFTKojflo1CpccRVjjhaNImCS2YlZXl1uo97+8kfot5/JszojIVu
	 B41gkX04CfuVMKdjbYE1v1ILvqCdasjQe9A2/HQibREFUk7pmbE1CYV7NN7pwYJGlk
	 +N2s8BJxbDIbMb+2qh8OUHfWFycRaR7rs1JuUMnMPHm4tCF3+Turbt/BoQGn8cIBJG
	 UQ0uNHkSOFHobz+kLDPCw7yAxtB24onwI7TXbXRka4zktY2shFhIBHvUJWEiAsnDRA
	 Exq0dTz8e6aoVsEDfkqarAABc3QWH81GNcYEpEwbbBAbgFX5Asz7KOBNUWvq1WFmmE
	 3YkrQyzdF8o/w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2EF2C17E35EA;
	Tue,  3 Dec 2024 10:40:36 +0100 (CET)
Message-ID: <b3672b3d-a336-433e-aa8a-6ddc6c8997d2@collabora.com>
Date: Tue, 3 Dec 2024 10:40:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/18] arm64: dts: mediatek: mt7988: add proc-supply
 for cpus on bpi-r4
To: Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241202122602.30734-1-linux@fw-web.de>
 <20241202122602.30734-16-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241202122602.30734-16-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/12/24 13:25, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add proc-supply property to cpus on Bananapi R4 board.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



