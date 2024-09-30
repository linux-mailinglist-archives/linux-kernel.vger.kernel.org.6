Return-Path: <linux-kernel+bounces-343686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B70989E32
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDBDB287932
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFB41885B5;
	Mon, 30 Sep 2024 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DdvWzEcC"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BEC188007;
	Mon, 30 Sep 2024 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688565; cv=none; b=TVag7vX08uqK4jGTDBwAwYyEeZcht0Oe5FHLD7uEZ1U1+++wVAg3SmYitHBnlLwffIJ/VBvJUmsSTXWvKVckhGS02m0Q7418QBoevyJYjioC8SbrlFNZaEFHkNnRMSAqfP/sf+d2zPt2hyG18xoYk67vmjwYS9AKzNUlOAdbk0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688565; c=relaxed/simple;
	bh=VSv+BL7uOVtpOXmL+Sgph6olDDv+H2bs6l/TX9i1ebY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ip4Z9b6nHSp8/Uwe9XMPogVWzruUlj8VJrjF+3Fc8KM6+DTphA66eeVGsB2385GhmDfhRBs6BPqCc05FYAo8qu0J3GyrUWWz7lwtsFA4Yzubx2nAUD3Y7bHKa6Vz7CfYQbQg72LEf4s4mR1QCLjJxcQ5iVhz6zAkdZJAwBjvN4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DdvWzEcC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727688561;
	bh=VSv+BL7uOVtpOXmL+Sgph6olDDv+H2bs6l/TX9i1ebY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DdvWzEcC/f5lVkAF5i7dhMZZcUL4NVZxCRRPeVfZxyyg9HACYPQp4g3tKWvswYD7c
	 GoxD+POtGMREsd7mcil7qEtNINqkOX87IclwUNJLxwtLk9wt+z7QfUNzjhG6+1j3mq
	 FwEI9PEPnKyf9tR03De9b2vubmGdBWjf174bdWsNl9u5CXro67EDvoO0N2cbU0LTrF
	 1wwibw8BeNU34tsQXSMgXtqOEVbEbaKPjRb0usZKxv0AMlofbVLqIlS/2fri1QKgRt
	 WmpYynCjCuWzqniBPUQ2O1PCx/7upVMdKZVZ2XEHIkCpUe1uuLSmOZ7w262QkyrSjw
	 9222KbigmGOgQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 28E0D17E10AC;
	Mon, 30 Sep 2024 11:29:21 +0200 (CEST)
Message-ID: <d73ebca6-9254-42c6-958d-e45432de1b1d@collabora.com>
Date: Mon, 30 Sep 2024 11:29:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] soc: mediatek: mediatek-regulator-coupler: Support
 mt8188
To: Pablo Sun <pablo.sun@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-clk@vger.kernel.org
References: <20240927103005.17605-1-pablo.sun@mediatek.com>
 <20240927103005.17605-6-pablo.sun@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240927103005.17605-6-pablo.sun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 27/09/24 12:30, Pablo Sun ha scritto:
> The Mali GPU in mt8188 also requires coupled power supplies,
> that is, the "vsram" voltage should follow the "vgpu" voltage.
> Therefore add the compatible to enable this coupling behavior.
> 
> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



