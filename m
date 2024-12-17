Return-Path: <linux-kernel+bounces-449928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD659F5829
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39ACA7A3ED4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691641F8EE4;
	Tue, 17 Dec 2024 20:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gGkDczDw"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934681EE7CB
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 20:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734468751; cv=none; b=jXE9CDvzQb8deJnku00u8pfERfKNNE7QOeIeW2q4VCUBRBikMLc2Y/gDUkYYTWuhmX2YKzhc471eY/SWlHLEw85AsPGepdOpixt/7ji7KeUV/64VlAtrQZ5Am83A5yteS1krbDKvqS6Np0q2tZev31HyONW8DWBcqyPrUIyPBzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734468751; c=relaxed/simple;
	bh=QTgTwjrLzq+Vh3vlJUekypbgmjzQ4zFJ9paCtPkW590=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cB7PXOytVuCK2u6OH0SIy6A3gwWaMqXIscqtEqwF46k+WOXiQfvtEPYfDNFTgAJ2SrW+Zs1qulxP3j2ut0ghoZRh4H7/d73XIH5bgNiuug1abIASpjVRVknI7Mep+Z7LLUZqYMWgt6g2Kub+IIZ3jd7WhM93L9qgBjxuVoI7PSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gGkDczDw; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734468746;
	bh=QTgTwjrLzq+Vh3vlJUekypbgmjzQ4zFJ9paCtPkW590=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gGkDczDweBrHtxydhN7MEf8Pgf0FmBXq6Z860ntzw+x4TerllQUvTIbx8BZLHLxwc
	 lQD8Qe3C01isMn2ZlHk4JGoDudQc2VyxV8dBoyiDMMBxfUp5qhCAQT+M5EkZAzV9iQ
	 7iPiioHO2joqDxWOYGzvItswwkXYqtvFjOy5R92OYOk7bfrHX2LCPKLTjIGmhUvFj4
	 fEYT11ZdPZo6NlFVDxf8+N+LJcTNw/DfdACT+D+/NLaq6yteMODWLiVpjVNRgGhQmA
	 p2p/DMGGMX0YpKIgohX9+dpGT9Xb9cHysiLSkh2Spui1zjeDquY+PbG6/NtT7JEsPK
	 IwNXHq1qS+L3w==
Received: from [192.168.1.90] (unknown [84.232.140.38])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DA7CC17E380A;
	Tue, 17 Dec 2024 21:52:25 +0100 (CET)
Message-ID: <2be9721e-62f3-41cc-83a8-5189b750a655@collabora.com>
Date: Tue, 17 Dec 2024 22:52:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/rockchip: Don't change hdmi reference clock rate
To: Derek Foreman <derek.foreman@collabora.com>,
 Algea Cao <algea.cao@rock-chips.com>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241217201708.3320673-1-derek.foreman@collabora.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20241217201708.3320673-1-derek.foreman@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/24 10:17 PM, Derek Foreman wrote:
> The code that changes hdmi->ref_clk was accidentally copied from
> downstream code that sets a different clock. We don't actually
> want to set any clock here at all.
> 
> Setting this clock incorrectly leads to incorrect timings for
> DDC, CEC, and HDCP signal generation.
> 
> No Fixes listed, as the theoretical timing error in DDC appears to
> still be within tolerances and harmless - and HDCP and CEC are not
> yet supported.
> 
> Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
> ---
>  drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 13 -------------
>  1 file changed, 13 deletions(-)

Reviewed-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

