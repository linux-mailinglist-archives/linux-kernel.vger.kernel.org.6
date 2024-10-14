Return-Path: <linux-kernel+bounces-363799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D1599C738
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D5A28405A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3631714A3;
	Mon, 14 Oct 2024 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MUNDtMkG"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF95E1684A0;
	Mon, 14 Oct 2024 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728902062; cv=none; b=t9FYzNl8zbt9UcuIJbZwY0NTA46KA1UDoy97BleU5afngXoETLSn51+KNMt1EDkSNMrFzJayYVotkJQsBkiMsaDXwVPeeCZEuLdsyafRAzfMNj+wV3sl+lIq7V8GPrIhN5iAZY2he81k6skBq2NM1LEqpqduDz7jM7ARJkxFBmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728902062; c=relaxed/simple;
	bh=hUsE9hl97X46HzaTn28zYZcdr8OeQ9jFpPk9E9c0/DU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HCM2OmXCqMIwFv9qSfQV03pitYuLkuDjY3PDixN4rYocfwuWboFtRoLiIXHoFuUmAbEA+s1k1p2LAxyoh8a+NT0Gj8mWQJ+5T/sl8Ge1fPBrwygr3B9wSQ17VE3crQVY+uIvsO+olghqgSVYnp024wElvdPoi/5fYY3tFsMB+G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MUNDtMkG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728902057;
	bh=hUsE9hl97X46HzaTn28zYZcdr8OeQ9jFpPk9E9c0/DU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MUNDtMkGtJlW+PgABff4bQy2NZEAHaXLlQh6LS1KSru0RYe7NsQPs/E9b8dpqGHWj
	 uQrOmcWSAzOgSNG9TdHPtD9bGLaM8l8cCTR8PIGI5zXnmvvFesvOLR6MW3RAe0k+DJ
	 +ND6qnDFgZzjki45mn2VJBnOoP5ukMrhSN/30I1D1BpmRAi4+ha4lf6Igrw54SnnVk
	 /B27T5T6K6b1+lN8zShcVT9zPiCJhOv8DnrsEIYzkVbN65D14uQsUR6Wd/2H317bcX
	 jDPF9MdXo4bNcb9qdzzGsU+PivSIpBF/MD4uaTLXAKvqON0YVtOB/4o5ppNHhoMQEx
	 fHIcFiN16MkFg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9740117E137F;
	Mon, 14 Oct 2024 12:34:17 +0200 (CEST)
Message-ID: <40ce7287-7fed-4670-b16b-695c36535661@collabora.com>
Date: Mon, 14 Oct 2024 12:34:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8188: Fix MERGE's alias IDs
To: Fei Shao <fshao@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20241014094622.1720289-1-fshao@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241014094622.1720289-1-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/10/24 11:45, Fei Shao ha scritto:
> MediaTek's ovl_adaptor driver requires the alias IDs of the MERGE
> components to be indexed from 1 to 5 to construct the MT8188 vdosys1
> routing path, since merge0 is particularly reserved for vdosys0
> according to the mmsys routing tables.
> 
> Update the alias IDs to ensure that ovl_adaptor can find the correct
> MERGE components, allowing DRM to initialize without issues.
> 
> Fixes: b13ecb7c6f67 ("arm64: dts: mediatek: mt8188: Add display nodes for vdosys1")
> Signed-off-by: Fei Shao <fshao@chromium.org>

I prefer that you resend the original series with this fix squashed into
the right commit instead, as I can still replace the series that I picked.

That makes things cleaner, so please do that.

Thanks,
Angelo



