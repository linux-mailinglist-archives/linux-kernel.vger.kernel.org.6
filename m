Return-Path: <linux-kernel+bounces-359600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B42B998DD7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF611C243AA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F77319992D;
	Thu, 10 Oct 2024 16:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="rcftoLds"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1310A7462;
	Thu, 10 Oct 2024 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728579153; cv=none; b=RHTwSoxsAn+n2X41I9AZwYNqF48bwy/hXqQEHG+fW3N63RHqhFJCbmSmvHXOxv+jqOfA9QnQS0AVq+4nB/Zn/srWn/vLNH+ayTvXvlwZyNJpcf8+zUlPYZjnxkZAXVwfyo9rVt+mmgSSGfJb1nwN8OV3o3qAADVRqqpQQzlD1/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728579153; c=relaxed/simple;
	bh=00CIbkz6cBc4ZddU093Kq6zi4Y00R92whFpoF4a1pc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBn30yoPp+U9X58D1+wCY4a5sapyGUtPaXtQTiSk1lp2RXeHiOYlP2NQeGomI1EnBQD3UJgSDUL8Xfi5FiLW4JnGMNeQnnnoqeigvW7CeIMhR62exsorz26h9CgRmL1AQS3JobBQAXC6fLU7bF638lfEtCO2G4+i7SIDIe3Eb0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=rcftoLds; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1728579141; x=1729183941; i=wahrenst@gmx.net;
	bh=00CIbkz6cBc4ZddU093Kq6zi4Y00R92whFpoF4a1pc0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rcftoLdsFggRHQisW9PxoWWzHQMMwOfSaUG+KKuHU1b2EIY+LzHol8JAUkBky52v
	 gdgXRqvREPPpTf6I70z6VPxaiGsvMi26FvSFsK8vbR6SQ3IJ0fhsq30ZyUapyDwo8
	 OPpmXhfnFRx59Gklo+KSsWIKx026Qvdg74HO2YcF76B62Gfula7xdZ8n057WeBJYM
	 pUjhOM3+NTDAd4cYDnEiberxjYjPirodnIEV0PXL2Z//qUm+PHSS+4nusmWjj24NH
	 VlWutgaD76kxif6YqeN9iiWhFHHqh/lV1powfOIVd1+G2lqzzN6IifRZPG7MMj2oU
	 DrKN5jQuh7/lgmseig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.104] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5QJJ-1t0JRQ2sHV-006FBi; Thu, 10
 Oct 2024 18:52:21 +0200
Message-ID: <5ce21c8d-a195-44c8-a37d-5d6f441bf027@gmx.net>
Date: Thu, 10 Oct 2024 18:52:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] staging: vchiq_core: Locally cache cache_line_size
 information
To: Umang Jain <umang.jain@ideasonboard.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20241010102250.236545-1-umang.jain@ideasonboard.com>
 <20241010102250.236545-6-umang.jain@ideasonboard.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20241010102250.236545-6-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:fzjxMi9TTQ6XNeUmiqkCBS9300g4Xrj4asJu30NEHC9KVOH0nvc
 698W6V8p9hwEONUr5k9yFKlSpXnjsYOX349UVPLwumb7HEADF/CYrkUMJFmxfihRvn8qVSI
 +umVXn/VLQIqylfOU7OFACfjOwOLDr5vcWGjvLu8KlGAPIfMbjNZIxQu+cnhrbJM+J5dnn7
 pIgKLjxJCqZC62Bx8bShA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ri3y1IqgULY=;N8WQUvW+HTqzk92xVCMC4ndGZDZ
 M1H5MI/eMFYJ8hV4PHOxKN6OYZabg/3kGbWJX1hfpAe/uPiEJfFFejQc9fRXy0JU4FKwL8sRs
 GOe4emoTigCOTc+32widyrzHcsU3qvihgN7hIgrpFSrXFLZIiOQhjcwn4mO/kWD6vl3tfcwkF
 4yseEH3uDlutZG2BPeIE9Cs9DQZYaaqKLjXjLYDeLSmehQw0E7ROcufQXsMyptglVhMQ1dBhf
 1ibuWC5A2IOQXmwwJjFG3+A7F3XEh0PS+1K81BgeiL4+Xxc1sYg8//CHGSCVO9opITft2b4YC
 BYk/NnfR2cEq0Vdt+HjmFPCdc12WnSXoQOI2D8UiE1es6Zc2hQPCQ1/xygVeuWEbSayxWB3RU
 LUd7Uuv6cg1w5HQeol1/Iv7v4BY3XdrVgTJzYP7ApNvyeKnBoEVarGa/lA53+n+Otiq4tN4tF
 wtrNK/cP4ZMoKILJQjmMhSWCU1wt0xZKtfgSyoFy59YQeUB6pDwAlUw9zzzIrmApH4JPgNt/W
 HMxj7gBR176PYqgUM62GMdBh2TTouFywe+/RryrWzdr6dT9QHIMUu90idzuZrfrfBAVnbAMf7
 sv5tSwnUKMQ0N2rbdpKUk/Z+LcdjBoIKSg0v4S5b2zU97H9T6Eeo1ij1RYBtJJS2WY0BaaA9i
 4R66zBG78vpNpYc68Q3uaDxU+pwYGMWhihdQ27YWByZtW1P8FvTy6LrTLtjJIEmqF/E0HtHHv
 RiEnkVZ3b64xWqX5pAVC42SNAlIjPsVFasC/EFwKI4u5Do4cr7AxyZHyxJ0ModE8XdNpBJm/c
 P/dCKvE5VWwlTa2MfytE5QpA==

Am 10.10.24 um 12:22 schrieb Umang Jain:
> Locally cache 'cache_line_size' information in a variable instead of
> repeatedly accessing it from drv_mgmt->info. This helps to reflow lines
> under 80 columns.
>
> No functional change intended in this patch.
>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

