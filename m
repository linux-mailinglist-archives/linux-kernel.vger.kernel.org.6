Return-Path: <linux-kernel+bounces-566182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47EAA67468
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ACD4189EB48
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4034520CCD6;
	Tue, 18 Mar 2025 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bcBn6h3x"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D311320897F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742302568; cv=none; b=CsIEVcR999bQxEgoIp9jHbnlO10Npq0JOKUqNcYBMVPEXO2RH9xR44UFpglmF71q3q1LY5a1NZaTPTRGGSEKwIM6A1b0WHQTzhaxOrQ6JdG74GbpmCAbbZ4vvi8Lgust7lkXy6/iywJT3oQ7b72gJ5JET4acePaA6De6fNex7J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742302568; c=relaxed/simple;
	bh=k1Jp1mQaKJe4wzy29NeaR9bYOOUp/GPWqEzK0Vc9Hyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rHHDoG4riwNZicoJQXuB2yX8MTqTWm0i1cSpMAPZz9lpYPyXxqWhwSn3ZOKeYmaKL8IreJ6Qwg/gFnWU3uRO9IPRO4coXb2Gb48nhyGnb7JIzfthl/MnVomWIyQLF67Ayvhnzo2b3qpsmh9fLE3vLXWsIHs+Fom3R6nFheBhbw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bcBn6h3x; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742302564;
	bh=k1Jp1mQaKJe4wzy29NeaR9bYOOUp/GPWqEzK0Vc9Hyo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bcBn6h3xCRIi5pCJkDWemJFu65FyuQJwyIh+MC77sWCpsO/D+OzzBM/oB72QFylVw
	 VMwmVFegCRy7z60JeRjtbBjwGHucX2qEYOHPeon2cIQXDwdw25mJOaR45jjMV3CkcB
	 NYDbhvazd64GN6tpV2A54et5pXRQ7fcMu38gWz21/8KvSIorZN5VoQEXHIIehoEAr6
	 2sKMrsDCfkmpjUDFk+eTqTvMzTWaKFegeaQcRETqu74pnOxhDKmT09kKl/iTAZFhgN
	 0FaOOhdJOZZknMIne1OKgxYXEKhrDtgQ1vJe9vZo9zneE8SxY6pWLofJsRkaoeq3yR
	 b30d/0a0klw3A==
Received: from [192.168.1.90] (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7A07617E0385;
	Tue, 18 Mar 2025 13:56:04 +0100 (CET)
Message-ID: <eafe83e6-c18a-4d1d-841d-8d2472a670e7@collabora.com>
Date: Tue, 18 Mar 2025 14:56:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/12] phy: rockchip: samsung-hdptx: Add high color
 depth management
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>,
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com>
 <20250308-phy-sam-hdptx-bpc-v5-12-35087287f9d1@collabora.com>
 <CAA8EJppo29p+8a5VUbr6dwaE9ywgS+-VcuUH_sF+NdA0xGU1Zw@mail.gmail.com>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <CAA8EJppo29p+8a5VUbr6dwaE9ywgS+-VcuUH_sF+NdA0xGU1Zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/25 12:18 PM, Dmitry Baryshkov wrote:
> On Sat, 8 Mar 2025 at 14:21, Cristian Ciocaltea
> <cristian.ciocaltea@collabora.com> wrote:
>>
>> Add support for 8-bit, 10-bit, 12-bit and 16-bit color depth setup.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 23 ++++++++++++++++++++++-
>>  1 file changed, 22 insertions(+), 1 deletion(-)
>>
> 
> Reviewed-by: Dmitry Baryshkov <dmtiry.baryshkov@linaro.org>

There's a typo in the email address, I've corrected it in v6.
 


