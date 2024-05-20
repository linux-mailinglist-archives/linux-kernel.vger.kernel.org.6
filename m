Return-Path: <linux-kernel+bounces-183566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450A28C9AB7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759241C20385
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122984643B;
	Mon, 20 May 2024 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="T0evZWkN"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3B545949
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716198521; cv=none; b=snd2P/1os9REIDkFiw7RYYi4Et0AVmYW42I0zNAkWHJVZeY4Rm6Fzy+h488YInmLFmb/iw965nPduuj5dWBMtdkeDgZjy9jXdKOLO25+Cc1mZzTGc1iITgUoF67XiHu2fBYVwcSX0wJeLQxc4AhwwqSeMCQ5olKfKQvNibVhw84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716198521; c=relaxed/simple;
	bh=thi7surURGed3HD6kvRIjW8Ud8uvGfTlOLEu6z0HL5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PWN2k84uETzbCdksz8Ib9SsDT0sv1q9ruZE3par1Yx8Ka+5LafpI+YjFUOb7IBX6SNEYVNBSiEINRqLF2E12KSzGrtyjbeEWSzZ1BaPy97DS0uL2pXzExDOgcrn93dL0VXHhfxHoVgqU3eT5OtftTSIw84yQwYBbPmmwUDrHk7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=T0evZWkN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716198518;
	bh=thi7surURGed3HD6kvRIjW8Ud8uvGfTlOLEu6z0HL5s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T0evZWkNvuwzG7GkhUyvVpjzu/Tp912PHnbjefH66ew2QMMzjB9P/iT/4flVzku6y
	 2LKPBcWyk6wYtH6Sj+TdO2Kpa8ZNGRdbfgog1//5nrNv/wAfM4nuGOPQsbL80ybf4t
	 ZzlM7hPeY7X6BjUZogGHHpGluirIU7sp4kMreEu8AMQICt8JYnZ+8j9/Ic5oZFlHzl
	 tBv5s/jLEaJqWBC4YjgwChwAT00VpDfsfBrJztCnGW2RTsxHgD53TY06SMGquvnbv+
	 AMNklmv6wk/uTm7pZp/9gRv1P+kNNawvzCNlNzmJSHyxTNBRRtsDDLGLPUWQRyLsyu
	 1hS8bBAGKlPEg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 82FCA37820CD;
	Mon, 20 May 2024 09:48:37 +0000 (UTC)
Message-ID: <3efcc6c1-054c-444e-abd1-230124964307@collabora.com>
Date: Mon, 20 May 2024 11:48:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] drm/panel: boe-tv101wum-nl6: Check for errors on the
 NOP in prepare()
To: Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Shuijing Li <shuijing.li@mediatek.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Xinlei Lee
 <xinlei.lee@mediatek.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240517213712.3135166-1-dianders@chromium.org>
 <20240517143643.3.Ibffbaa5b4999ac0e55f43bf353144433b099d727@changeid>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240517143643.3.Ibffbaa5b4999ac0e55f43bf353144433b099d727@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/05/24 23:36, Douglas Anderson ha scritto:
> The mipi_dsi_dcs_nop() function returns an error but we weren't
> checking it in boe_panel_prepare(). Add a check. This is highly
> unlikely to matter in practice. If the NOP failed then likely later
> MIPI commands would fail too.
> 
> Found by code inspection.
> 
> Fixes: 812562b8d881 ("drm/panel: boe-tv101wum-nl6: Fine tune the panel power sequence")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



