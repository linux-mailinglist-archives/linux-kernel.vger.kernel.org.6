Return-Path: <linux-kernel+bounces-566318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0198CA67639
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D223A976D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AB320E004;
	Tue, 18 Mar 2025 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KhDI9DBX"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED52320468F;
	Tue, 18 Mar 2025 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307690; cv=none; b=gXUjbiKnsS1SQMDzbsNAxdkc6+wKjvoNJ8aubi91lLTVSWcC9MmfeUuumzfxlFjBjXzJwx903OoVJTkCn9M0Kwr4knx6eguiOD97HFaVJgCdprQjrfo8LVLAjrqG1awO8OOAR0vJYYb2Qje7cBBxEJU0iOr59A8C5xFfo61Rrf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307690; c=relaxed/simple;
	bh=DlTALxhnX1WzQznDtq8NeSAib+9haWmUV8E0yQEGDc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QndksKNt1+oF+5ddop2lJLbSxg9I7AwuFZ8aeQZUzIwSHE7YI7IaFpDh0lOeNKVGeg1P1989++1F57kVoezYl8UPxtkL/ekDYYgfRKz8zq0v7ToXaemY9wlvoJznVapwCnvW3AO+xqOC8/9CFpedMW7XVCB8TwzSdeeLlkx4hXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KhDI9DBX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742307683;
	bh=DlTALxhnX1WzQznDtq8NeSAib+9haWmUV8E0yQEGDc4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KhDI9DBXFlIC2GO3+W6xzD9tsjvysmhhYIc+vB+keu4md9fXlwTSNN4CksQ8fRMTl
	 zXwvLnNHqzHqdGDsuZ9fjcgD/0qrG7V+40I63YqSxeZpVkroSWG4j2tDva1KtU3mcN
	 E5toQgEr5RwPfvPfuFv/hteWGM0Hc2p4WpGsUVQIIDBoxs3sBCHbERCNtwecdrsLm0
	 ZSeo6csHIPCbHDRGzJW3ZXLejGyvelgQ9Eb+yz0K92U8T8Z3hu5ldPzf8enVT+dbRD
	 sgzuE/Vbz/iVoNUYTF1L1zXDbUz/eccgz3ikGnghE06aZAnh+iPV9Gfs1yXPXRPokt
	 7JXxZGlh3AMAQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 906DA17E0B25;
	Tue, 18 Mar 2025 15:21:22 +0100 (CET)
Message-ID: <2b666683-47f9-44b5-bae9-109764e60690@collabora.com>
Date: Tue, 18 Mar 2025 15:21:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] platform/chrome: Add support for Google Spherion in
 HW prober
To: Laura Nao <laura.nao@collabora.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, bleung@chromium.org,
 tzungbi@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 chrome-platform@lists.linux.dev, nfraprado@collabora.com,
 kernel@collabora.com
References: <20250318102259.189289-1-laura.nao@collabora.com>
 <20250318102259.189289-2-laura.nao@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250318102259.189289-2-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/03/25 11:22, Laura Nao ha scritto:
> Add a new compatible entry for "google,spherion" to the hardware prober
> platform list, using the same I2C component prober and trackpad data as
> "google,hana".
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



