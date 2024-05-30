Return-Path: <linux-kernel+bounces-195976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6018D5593
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 00:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF231F23D88
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 22:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF826182D37;
	Thu, 30 May 2024 22:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=placeviolette.net header.i=dev@placeviolette.net header.b="YIwc5F/P"
Received: from sender21-op-o11.zoho.eu (sender21-op-o11.zoho.eu [185.172.199.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBE2176ABE
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 22:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.172.199.225
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717108836; cv=pass; b=jSRSYTTpMdPVLQLqNC65nCaMsl0I13t5/aF1bKDNrVPSxhJVxGocr6ra6h3SX51td6pfoe6uza1ERifrv3v7IkuyBCmyxv8stxZ9aDbVS1XHh+BkRh1II+chDZq28hjzZ4eykyOxJ0DoWU+T3j51Cqu5/r/JqGbPvh11YugOu8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717108836; c=relaxed/simple;
	bh=+GyyG9eSMyx7lzvqxYNeYPbo17yQoZT5qcASYjdHtAY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=aELYe+7bWchc5XMqOkVgMTnlP8MWxYahf1mPtBzQ6mFsV00akZCi7w5ZfmQ3YKeGiYLVKV3/kGejOH1RXNhdcF0xmNJlfgakMcWo4T1J4Af5RllLzYIoXn/4rdZqtGr+/KZa+pzIVOx8qCE2goHgJLc6uChUFJeOwuwuRdGLIy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=placeviolette.net; spf=pass smtp.mailfrom=placeviolette.net; dkim=pass (1024-bit key) header.d=placeviolette.net header.i=dev@placeviolette.net header.b=YIwc5F/P; arc=pass smtp.client-ip=185.172.199.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=placeviolette.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=placeviolette.net
ARC-Seal: i=1; a=rsa-sha256; t=1717108792; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=hS9F3rbVAme1LpkfbhORfvRtfQHYO3fXt38IN31pf2WBpbWh46kOXF6iZ51i41rKtv5+kJvZc3oDHYYQzycLdOIu3/xPD2pSR4jvO+m2/m2s5gWgWp0xtrQAxZIcq6thWbvg+VzOBurLldAdyod+Iiie4aXWSxPuiVYDcrcQvMk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1717108792; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mDStETwQo/9R9lk52eoeFLqdRJv18IPwNR5FM5Leuqw=; 
	b=kSH8DheaJ5PBj/37RT569i7xZOPaKe03hDeAK6lzae620O/9G56qkgV/Qph867BTi2CG8C68LrJtXDEkd8wtwR8dl8czadGT8iG3a0hkn2XOXiyLPiexPbBfRlRbW6j4E1p3I0346XmCNxrDAGkd6W1IhqbpaKvnsAR4j3VwiE4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=placeviolette.net;
	spf=pass  smtp.mailfrom=dev@placeviolette.net;
	dmarc=pass header.from=<dev@placeviolette.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1717108792;
	s=zmail; d=placeviolette.net; i=dev@placeviolette.net;
	h=Message-ID:Date:Date:MIME-Version:To:To:Cc:Cc:References:Subject:Subject:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=mDStETwQo/9R9lk52eoeFLqdRJv18IPwNR5FM5Leuqw=;
	b=YIwc5F/PWW+4gTLrgSkmGcAQD1QptBy+0XPIP2H+6KmgyfERzCgNk0aJU8jhf2JH
	M3JFhfJzTTruhO72Ag/eA2wvp96Q+jj81Gc52YV0zsK5FUKRFB1PlzUMhKvrSXY4JZc
	sYC18NR3/USCnI3Nh4P4UBqpGI3/EUuiTi1gaVhw=
Received: by mx.zoho.eu with SMTPS id 1717108790902816.4816233199875;
	Fri, 31 May 2024 00:39:50 +0200 (CEST)
Message-ID: <00a76167-6d25-4c5a-b5a5-e61104b74147@placeviolette.net>
Date: Thu, 30 May 2024 18:39:47 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dmitry.baryshkov@linaro.org
Cc: alexeymin@postmarketos.org, andersson@kernel.org,
 bryan.odonoghue@linaro.org, johan+linaro@kernel.org,
 konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 mathieu.poirier@linaro.org, neil.armstrong@linaro.org,
 quic_sibis@quicinc.com, steev@kali.org, wuxilin123@gmail.com
References: <20240512-qcom-pd-mapper-v8-0-5ecbb276fcc0@linaro.org>
Subject: Re: [PATCH v8 0/5] soc: qcom: add in-kernel pd-mapper implementation
Content-Language: en-US
From: classabbyamp <dev@placeviolette.net>
In-Reply-To: <20240512-qcom-pd-mapper-v8-0-5ecbb276fcc0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

I've tested this applied on top of kernel 6.8.11 on an X13s over the 
past week and it's been working well.

-- 
classabbyamp

