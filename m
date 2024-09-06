Return-Path: <linux-kernel+bounces-318408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B34E296ED50
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A831F213E6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7018B3C463;
	Fri,  6 Sep 2024 08:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eFD/OAhU";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="fX/Jydk1"
Received: from a7-39.smtp-out.eu-west-1.amazonses.com (a7-39.smtp-out.eu-west-1.amazonses.com [54.240.7.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F6F15665C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 08:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725610446; cv=none; b=fAuAYvkXY3UNQ3LEXtQMTaI93+sPeHmAfeG9wEAi7T0kVDyxEmbdUVfECJBdT0Yrl0CMevuNfc10HeT6udFLXzo7fb+DznEwVxwQgqnb6XPLtZoSrtR9Ohb9k/G5wZijip6b4hefiZRCFeNv6oxlFjpNlx50NlGSI913RjMpWdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725610446; c=relaxed/simple;
	bh=VX7OlLnBt7jfAMupnrzu9AoSfcrke19/MgnbQULyPN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQL5VHb/xpc0FzL+I5FAYc8ZRK1mwQmiHkhRvhejwLvyC7X4ZIjNNOuEEygoAbQHk5F2wQJ97FxAbHIyg4X+cZTvMe7X/wYppBGoglIrK909EqEIgDDJZ1LAtC5D9Nv0T/ovhusGmsJfE7y+ko9P4fWV8TZ4RN0V2H2gwadJ9zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eFD/OAhU; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=fX/Jydk1; arc=none smtp.client-ip=54.240.7.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1725610443;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=VX7OlLnBt7jfAMupnrzu9AoSfcrke19/MgnbQULyPN0=;
	b=eFD/OAhUGa5sw9pLaicdiqtoY6wLOPI1biF5Wxi58nit79YB+YR36Rv6jMej/GEq
	IciE4Q6NLUxLH//4vNXgmxFlvx+yJ8LnQl/IwqDvNZpPb6VJKPfDbiOkPuffaaMpZHT
	t4trHzi8nnYw3YQETnln1kIJ0NhBRZG53rrMX+vozzla1B6GL2rvIEz9D6uKpTnaaar
	DU/y8yuvLlMoKID0KJsl9CE5oTRgQ5iaQe9gfHVzJncnTUnS/1s9xEHjg58cUJ2g4lj
	WnHFOeHtmg+XcZQL6hRM1EuUK/ZhzT+zRI2LFqeHHOgD8e1RcJEuSNEmjieO36naPuE
	CTz9DvUBnA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1725610443;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=VX7OlLnBt7jfAMupnrzu9AoSfcrke19/MgnbQULyPN0=;
	b=fX/Jydk1y6+dVBlfSvKcrqhkAlAVAqdnPwf7EzAfbEiZtIQjuMfTKcUauJp/j99e
	vYsA8VTOqrT93Ll54NNjVHeOYlqwER/vyYQ4YWuKgMdmOZCCEvqDyAP+CS6SxPl3jsJ
	s65MA5jq66MD715cIMZDdIrJFo5oA+JWsgDSPcz8=
Message-ID: <01020191c665c261-8b839b39-d297-441f-8b83-49edd60ba752-000000@eu-west-1.amazonses.com>
Date: Fri, 6 Sep 2024 08:14:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] drm/mediatek: Fix get efuse issue for MT8188 DPTX
To: Liankun Yang <liankun.yang@mediatek.com>, chunkuang.hu@kernel.org, 
	p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch, 
	matthias.bgg@gmail.com, ck.hu@mediatek.com, shuijing.li@mediatek.com, 
	jitao.shi@mediatek.com, mac.shen@mediatek.com
Cc: Project_Global_Chrome_Upstream_Group@mediatek.com, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240902133736.16461-1-liankun.yang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240902133736.16461-1-liankun.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.06-54.240.7.39

Il 02/09/24 15:36, Liankun Yang ha scritto:
> Update efuse data for MT8188 displayport.
> 
> The DP monitor can not display when DUT connected to USB-c to DP dongle.
> Analysis view is invalid DP efuse data.
> 
> Fixes: 350c3fe907fb ("drm/mediatek: dp: Add support MT8188 dp/edp function")
> 
> Changes in V2:
> - Add Fixes tag.
> - Update the commit title.
> - Update the commit description.
> Per suggestion from the previous thread:
> https://patchwork.kernel.org/project/linux-mediatek/patch/
> 20240510061716.31103-1-liankun.yang@mediatek.com/
> 
> Signed-off-by: Liankun Yang <liankun.yang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


