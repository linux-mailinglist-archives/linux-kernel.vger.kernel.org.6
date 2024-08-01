Return-Path: <linux-kernel+bounces-270874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E532944683
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4578D1F2525F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A83D16DC3A;
	Thu,  1 Aug 2024 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4cpvwBuX"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A3B13D891
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500639; cv=none; b=EEScUHV3P7cZS20Pp4h68hSeJheWeJ1vduC0ELG37te8hGiFM0eJgtASCT9NkAGNaSqJrRoiEsg2X7sS2dc0MfkukU8mcmAFBAjiOF4FPENHnr5AhoWRupOs4GEmoFB0sQOm98oLwu2Ai0TK9IXw/QwyV/yGDhMAskHsqIfbWNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500639; c=relaxed/simple;
	bh=suyOYv7hGoiKkqAOfnYjT40wA9uY4wMwWjlg+hdAcxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ry6dbvyErc6g6XxFDMctssAtxujQ16/fgW8hvmEnAB+mWJwuz4KX8wFhkLEJO+eqONZlOjlXg65L9Jn2CpUyoEdNLUc7SkhKgMESyz6nBshlMFDtNAv1KSbAbSB+Vf5tuTYmTFYZzUpMsbSNLqGUSNes7NwtTM6yBXKzG4HMk/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4cpvwBuX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722500635;
	bh=suyOYv7hGoiKkqAOfnYjT40wA9uY4wMwWjlg+hdAcxE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=4cpvwBuXeiF1IJKFI61G5oN7nxTdHUhz/ATQiukTCYP7ygTEAJEViNVhCBO8d/I4B
	 QpDNmQU6A8v5JCUALTlaeg7a/JIQZPxpkPfKTfWltlQWWGhd8kJgEtBXHYAVQbLJuw
	 vgZjJsdn6wfXzGYwM0nwbPlvwo6LYk4pft6wc4xpGB1Q+sm6V/a38TjGWfLQLhiLyp
	 pkw8tHVzQLMaO1f/IryRxW+S9Le7pBxrISaruD+P9bGK2VB4W9lyMOT5kmMBjPf/Fc
	 hJkrduG+PbIKam7blYf+oMx4L7HCyPmfGPTXNroZT7rHu9I3RtvtVTAXLP+HpEqdvk
	 HsjxrUu0ONiag==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 46888378220A;
	Thu,  1 Aug 2024 08:23:55 +0000 (UTC)
Message-ID: <9b983add-45a4-497d-ab95-188f8ca1c0d1@collabora.com>
Date: Thu, 1 Aug 2024 10:23:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: mediatek: Drop unnecessary check for property
 presence
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240731201407.1838385-1-robh@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240731201407.1838385-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 31/07/24 22:13, Rob Herring (Arm) ha scritto:
> of_property_read_u32() returns -EINVAL if a property is not present, so
> the preceeding check for presence with of_find_property() can be
> dropped. Really, what the errno is shouldn't matter. Either the property
> can be read and used or it can't and is ignored.
> 
> This is part of a larger effort to remove callers of of_find_property()
> and similar functions. of_find_property() leaks the DT struct property
> and data pointers which is a problem for dynamically allocated nodes
> which may be freed.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



