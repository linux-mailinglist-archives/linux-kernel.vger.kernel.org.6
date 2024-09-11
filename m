Return-Path: <linux-kernel+bounces-324377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2B4974BCE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA87B1F252E2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CB213D24C;
	Wed, 11 Sep 2024 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gfcRmcKY";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="RDLkUYag"
Received: from a7-50.smtp-out.eu-west-1.amazonses.com (a7-50.smtp-out.eu-west-1.amazonses.com [54.240.7.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E643CF6A;
	Wed, 11 Sep 2024 07:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726040926; cv=none; b=ojldZwouTfU6+Ett5POlw2sYYM43cY7QSF0W4DVqC1dxE85KtkgSlfB7J/s0lHJYGePvON27KN0cnE3S+cUHhavKe/E3VS6JQtHvtaUBKfFLO39Pzmgjp8XHP1FP6EmQGf/grEnYvBU2qPIkIi2mXhHolzkP9QGak/HTEwY4aqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726040926; c=relaxed/simple;
	bh=QZzlqQNzP6BYEm08sf/8gxgY9/9MBXoce+m3v5e46j0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWFKySraObtjrWc6Tq/Dw5/eN/Ag+n0etn3A/mwhMCb2bUJYkWEaLVD7kPPLzQ12HdHps8Cuvy+cgq0XgsxB10kAjCEkiQquqGpfYI6/LIl9jcNuchaRVJ4Yr7RUnz4eThM+7fGUXg9wWR1dZthafuaKroBJIg5V7JPECr1RKe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gfcRmcKY; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=RDLkUYag; arc=none smtp.client-ip=54.240.7.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726040923;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=QZzlqQNzP6BYEm08sf/8gxgY9/9MBXoce+m3v5e46j0=;
	b=gfcRmcKYk3aOU2YHCJ25TmGLGGPFcwTda8Ww0AO37TqNNVawzTrs0xAmsfUVXhJA
	ZBGKK32ivqrfeEIE8+yR+diNDPh/hJjaxCU+91M3J/Pzd1eoG9gGSzMXbCqyMq31lcU
	KSdCkCY/9wcICn9NETKdxlU+Xv2i06lK7Bu771Rf0e5E1oKFuyxdRAGTDYnlZ3e5gVr
	na2OSSW2KnodJ+770FZuDL06QQnaBNl2ymFaQvwZ8eJnGi9SxDp26Zy+WKssiuYPZsb
	s3a0X/5JjZKFgZKpPegRRwafPGb9p2TGpSfmBqWr54x918d87c/Z0p8agfhcCea4p8Z
	qfcNXzPhwA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726040923;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=QZzlqQNzP6BYEm08sf/8gxgY9/9MBXoce+m3v5e46j0=;
	b=RDLkUYag4BqylbV6bGcG3ja+A8yMKbhNBKS+SeADKME7joIpnFLoWZoKqX43xc9+
	jKw7uq7tuAVEHI1k2WiH48RiICmWhGH7MQE67Hjx783UKE+3Ds3OAq5WDCPnG9xNYA5
	XdqvToUObEA9msA3hnnqkCyCLaP1/yul5R4K+xGE=
Message-ID: <01020191e00e5b01-2762c208-54d4-459f-b81f-b9cfbf9bd569-000000@eu-west-1.amazonses.com>
Date: Wed, 11 Sep 2024 07:48:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2] usb: musb: mediatek: Simplify code with
 dev_err_probe()
To: Lin Ruifeng <linruifeng4@huawei.com>, b-liu@ti.com, 
	gregkh@linuxfoundation.org, matthias.bgg@gmail.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
References: <20240907081351.19879-1-linruifeng4@huawei.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240907081351.19879-1-linruifeng4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.11-54.240.7.50

Il 07/09/24 10:13, Lin Ruifeng ha scritto:
> The combination of dev_err() and the returned error code could be
> replaced by dev_err_probe() in driver's probe function.
 >

> Let's,
> converting to dev_err_probe() to make code more simple.

Convert to dev_err_probe() to simplify the code.

> 
> Signed-off-by: Lin Ruifeng <linruifeng4@huawei.com>

After which,
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



