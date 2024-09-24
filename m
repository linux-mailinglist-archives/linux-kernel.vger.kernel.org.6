Return-Path: <linux-kernel+bounces-337073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CCD9844F1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8CA1F26FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0571C1A4F29;
	Tue, 24 Sep 2024 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="W9b7sxjj"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4BE1A4E94;
	Tue, 24 Sep 2024 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727177877; cv=none; b=fhbEW9xo6SUwB3jtKveHaiaUpK090ysX/3vGccT0O9u9MLGAHSW1YRtkFFwzon4m58zE+eLqWnmRK3fyBkDxsZx8rKLV39bmLBfPoa/5uPHFdWmLGpn3coVFf9naQfmbc/NmrIYbXr2JooS1DLOyov0YCJgIsv3+bxNw9qGPkcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727177877; c=relaxed/simple;
	bh=HL+IJGvaPoYFWnbwstJlsZ+C2p9dZZSdwImP0j4Q+2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ggCqkdmHenhCiWYLSlt/6oWn5fspYqS2rrper4lyhgzo+tlZycvpy3SAVawTgEI29NjA2ByQ6oqmyQ75yEQ8j8NtgK71xAR1bhbUNEyErjf9teRuYOT5s1RbdnCuIexuKKSn6nT2bl+r9rujaiC4GZHQnxY2S5f43guhW/sQbps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=W9b7sxjj; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727177874;
	bh=HL+IJGvaPoYFWnbwstJlsZ+C2p9dZZSdwImP0j4Q+2k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W9b7sxjjLGQQX/tO6qWHLxOd6mGb3NzsoNvqpaV4Ve+SCj/ZHb7qw772sM3TRNNUJ
	 WklzCbkTRP32y+X8sND1JSnBfXce4jyeyh1R780DNuA2x5dO3vM1KI7g68u9huAJva
	 Sn3TPKTx41FgYSR+OZT1O6RuwYpMCj8tB+Uu3bXPRDVWursmJ4QGHDWaarhg9xbThc
	 /SXbadtQVTbvTe1o8SdPviC9wUsaACeIf66hvcoHsNIduFdnVQQ8N4SbOhQiu6NQlo
	 lJIAtvxoLAceu73B9vsbFdaA+Pn0nrgVdyJznELi0ZJDC6fL/uyS10wnNNnM3iKR63
	 QKYSiyNpEfa7Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A41EB17E1245;
	Tue, 24 Sep 2024 13:37:53 +0200 (CEST)
Message-ID: <2a74df47-c393-4a3c-bbc0-332c716c9a81@collabora.com>
Date: Tue, 24 Sep 2024 13:37:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: mediatek: mt8186: add FHCTL node
To: Max Weng <max_weng@compal.corp-partner.google.com>,
 linux-kernel@vger.kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240924101559.879167-1-max_weng@compal.corp-partner.google.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240924101559.879167-1-max_weng@compal.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/09/24 12:15, Max Weng ha scritto:
> From: max_weng <max_weng@compal.corp-partner.google.com>
> 
> add FHCTL device node for Frequency Hopping and Spread Spectrum clock function.
> 
> Signed-off-by: Max Weng <max_weng@compal.corp-partner.google.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



