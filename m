Return-Path: <linux-kernel+bounces-183569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 042A88C9ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84079B211E8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875FE481C0;
	Mon, 20 May 2024 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4gFFiyZp"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9D5219E0;
	Mon, 20 May 2024 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716198947; cv=none; b=UkquF3VXE5netdGLXUSrIcRuR+SruDJ0ZGZJKCu4b5mfiiTPJ/jG4IoiQ+ORt+P4F3BWyVxg/3TqR0KPDW2gHxk40Ue+h3wNIm3Dy5Bts7VVRgy+omJKDaJ1h2oK27cFkNXkfl3y+sGCWUReR/2GTnj+zFCtdDWAhf1ecC0+cBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716198947; c=relaxed/simple;
	bh=rzE7nnaPg+u62UlsV6bG5IQXkGCAxUqcoHM8hLYB1OU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ArBk3pD8Aa4nY3R7u6edUkm+sZa70sc+nB7wQ40dSuaVw1GxmOPROvr4npZ+yanURKgJYrTgEnpIJvoOu4/g/v+2jvsoOWsVUt0hiCGTf9wtN5YNXSe5G7AJfHbVT9d+JOAfGNRzavSXg8kpe2qBX5ca9Ch+GSV7soOmojxJJjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4gFFiyZp; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716198944;
	bh=rzE7nnaPg+u62UlsV6bG5IQXkGCAxUqcoHM8hLYB1OU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=4gFFiyZpSOvXFnhQYJ3KqTyRJEbDDkrgy1aZsXHaxvVvjado3VaUT0E0Bpvni3tMC
	 erGzuMR6kF2FJtwMH/YhlKMWPQLI6cFaizPwvFuaMaY5DFOmqFLKCpK6JEa6m5X6Qn
	 RZGGi7dVEAN4fSAVlWij5D8ub2gTdBfPWxgpRLbqhV5YIjXvE+vgBjnhKlieocvJJh
	 DdXvsXAcLke8ibqtcjUH2oOpg/RhcLOrIZIibrNXVj3v2E0aKsX1uWQpe/4dqQfRTt
	 r/CE3dFpFiloVdx3uAam+zxUpcHMHsHwvx+k3XBihTmf5gFDyMgYzHvShEYNGtZcrm
	 7loLBm5oWzr2A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1820B37820CD;
	Mon, 20 May 2024 09:55:44 +0000 (UTC)
Message-ID: <f42ef151-6eee-418f-91e1-5ac08d161119@collabora.com>
Date: Mon, 20 May 2024 11:55:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] arm64: dts: mediatek: mt8365: use a specific SCPSYS
 compatible
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240518211159.142920-1-krzysztof.kozlowski@linaro.org>
 <20240518211159.142920-2-krzysztof.kozlowski@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240518211159.142920-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/05/24 23:11, Krzysztof Kozlowski ha scritto:
> SoCs should use dedicated compatibles for each of their syscon nodes to
> precisely describe the block.  Using an incorrect compatible does not
> allow to properly match/validate children of the syscon device.  Replace
> SYSCFG compatible, which does not have children, with a new dedicated
> one for SCPSYS block.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Technically, that's not a SCPSYS block, but called SYSCFG in MT8365, but the
meaning and the functioning is the same, so it's fine for me.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


