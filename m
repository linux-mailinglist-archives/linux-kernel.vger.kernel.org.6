Return-Path: <linux-kernel+bounces-412497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC1B9D09B2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 07:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80D35B21956
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8FE148FE6;
	Mon, 18 Nov 2024 06:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UaVJaDwn"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D92E1474AF
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 06:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731912270; cv=none; b=BxWN6Tr7auyQ7O1o3eLOldZ8jzCVrmDAyuo59PZ4arVcjGF4N8yCGja/ZDlgV2c8qNdF6wZAFHABnY63g56HTMVoOw+0YM2JXXOKQAhSvt917HJwfvYhG11QhfZg5+OQSt9zFT4SOHfVylQk25H8dzS+9+Pkor+G4alSdxMCPW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731912270; c=relaxed/simple;
	bh=v8sWRHTsKkaIXp7ryS23jcrKJ4KbPd8QHBLvwRGYRBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cq617SR4Eu19LbMtX9AxsuC0BzXkBFH+Aez0KhdTd50dJTsd/iIH50rb2ARfa1Fyy362rr3qfQqUzz2jRUHxjKqkhrXF6irLvXBOvqPYyxwAaAaGVyD4YC35+O+xSTaqJeU315WvZHRdfDarsONYREjj2DBjrJpmAb+BTQlkENI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UaVJaDwn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731912267;
	bh=v8sWRHTsKkaIXp7ryS23jcrKJ4KbPd8QHBLvwRGYRBs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UaVJaDwnAywiJoSPyNOgQwrN1wSc4pSz07TNlzDdluUFLwNqCDUVxCieKnG3omz/i
	 dM6elbVWs2gAcWK7ulZzLanAIDQr4b4SZ6UP0Wrph/MhhJNIo7nP+IQ8uhf5LMRyH2
	 pBUe8H58xtkpQmUyWSzFASNdoM3hkxg81Y6qDoGVjyX57BbnhhMbH89pluxnttIh7w
	 Ca7+g0ZvwRNHSqTPoJBp1ZrEHtleDhy1bHhJnQth48S291Aabyz9ioWYd+nKSFh+is
	 tNvu75YDOg4oejfcgQvnCeb+t/yxHPeEeEJo6unyzByw+9VyDuLaIRHNlZKUY7CpaX
	 xbSW3Bw4fq2Gw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0817A17E1227;
	Mon, 18 Nov 2024 07:44:27 +0100 (CET)
Message-ID: <fa0796d0-dbdf-46b3-aca8-20002e820360@collabora.com>
Date: Mon, 18 Nov 2024 07:44:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gnss: mtk: Simplify return variables in mtk_set_active
 and mtk_set_standby
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Johan Hovold
 <johan@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241117052501.1138926-1-iwamatsu@nigauri.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241117052501.1138926-1-iwamatsu@nigauri.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/11/24 06:25, Nobuhiro Iwamatsu ha scritto:
> Simply return directly instead of assign the return value.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



