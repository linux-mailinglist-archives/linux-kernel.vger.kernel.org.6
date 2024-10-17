Return-Path: <linux-kernel+bounces-369870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F929A23DF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B62283497
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B86F1DDC38;
	Thu, 17 Oct 2024 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HIVYA2H+"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2511DD865
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172000; cv=none; b=oDoyEFFy+YnnFEzAxlw3CJ+lXPL3dHWqREbPT0nzH/xO1w6Ut5xdLLjS8fU2msfQlkKBItHIBT+vjrhtQeukeEpM1wFpIswNK7suRat2VcTMKBOrB9kj70b6ayJS/bpfJOMGltbFJtCz0aVelWFJkOGD8RPeQj+mPkeUS77EINI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172000; c=relaxed/simple;
	bh=gL7HIZDcngcg38f0O2Ne7G95R5rU2tPl/BIuc0Pcbdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJBDrlOrK05xrG0SRs7MGcgjdgGRHjTwgJq/nHuHx4c8NHsgTPnH8mIVeJIbD7HY7vyl8fxmaChi7RS0GlCjJK2gDclRq4TFTGNywhwRXKSJ3WAwQI5yn/7X73I8wcMSJJ/18FeqKWDXWitz7R8jKJRsZhI8LHdOkspD8dCeEnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HIVYA2H+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729171992;
	bh=gL7HIZDcngcg38f0O2Ne7G95R5rU2tPl/BIuc0Pcbdg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HIVYA2H+2rTlNkI3CBNX0Oz6XKMOTMy4YUDdvMANFeuRAuTlgX2JEH+DYXrgR+O58
	 +3qXEhNm6SX0//tfm1UygavvpxQ8uPmGjHeqzdmrlBttaXEKygadIbg4mufbfDHIrO
	 Bhg/WYSGh8TCrIMIWPF5ya6iHiKLTh8vkD7w4QQNNUuStKZ8NL0mlXk04DRkO2i3d5
	 VJJsHj+NC1IgmWjNe2URawoY2jCy+MzpGejDlFWJjhyshU9It0Z4O+BAv04cU1dmfD
	 bDQuCR+SrcXtrHSfHyz8X/ANEQZpyB6LvRXcCEupWFD4syPZhAAdOz+eFueT0LlWrl
	 xjFHeBsL1vQIg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 35DB317E3609;
	Thu, 17 Oct 2024 15:33:12 +0200 (CEST)
Message-ID: <ab80d339-8b7e-4cfa-a3fc-b9f1d295a79c@collabora.com>
Date: Thu, 17 Oct 2024 15:33:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/mediatek: Fix color format MACROs in OVL
To: Hsin-Te Yuan <yuanhsinte@chromium.org>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dianders@chromium.org
References: <20241016-color-v3-1-e0f5f44a72d8@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241016-color-v3-1-e0f5f44a72d8@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/10/24 16:17, Hsin-Te Yuan ha scritto:
> In commit 9f428b95ac89 ("drm/mediatek: Add new color format MACROs in
> OVL"), some new color formats are defined in the MACROs to make the
> switch statement more concise. That commit was intended to be a no-op
> cleanup. However, there are typos in these formats MACROs, which cause
> the return value to be incorrect. Fix the typos to ensure the return
> value remains unchanged.
> 
> Fixes: 9f428b95ac89 ("drm/mediatek: Add new color format MACROs in OVL")
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


