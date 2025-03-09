Return-Path: <linux-kernel+bounces-553064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222F8A582F4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 11:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71DEE3AE594
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 10:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88BA1A8418;
	Sun,  9 Mar 2025 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jvwKJxkM"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98F1347B4
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741515463; cv=none; b=bIN65BbqEhdg5lTd1VIciDMalDbAYCwn6pNjOqLEizHMPl54OIRkTyJz7QnXPxIAzp+MB7Bn5dckpTvZpjushq5zEizUgBVQ1B93ye2ptf3D2hAbCxJ+YleT3ybUvqwg/82S976x9cSibukF4aH5WP3ytoQJNhPgQJ9o9Tll488=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741515463; c=relaxed/simple;
	bh=a9ZjEQJCPX7OdmrFZfTFLcOSWucp97wa0eLCzSNjgwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ref7KW43122o92YJxZiwVG9dhlb+MaIEygxMv2JzWpl8ReHDIn3WpiNE6KyzgcZYF9re/G0EHbYsnMCgR+aNg7VjbsFV99U/DLxhMegytFFPyh8ySyC+M1GkbTpiONgCSP+SkL9VNz3VFDjgLYYjsQKYGwPWenPwW5Ma0B2JLrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jvwKJxkM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741515459;
	bh=a9ZjEQJCPX7OdmrFZfTFLcOSWucp97wa0eLCzSNjgwg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jvwKJxkMx/ByKyXBNBK+i8lUNXRVXN2/9NOJ5FIU4+qitYuEAjgk9XHX4hTeUZMDd
	 dvW+OMApYkM5UlJJL8YZm9RPUrAS+JnhndtyZ9B1HV7Si1skqHRifyYpiLzwJUuDuH
	 SinPFa9jSA+4v6G9t7swwcDTPRzVpfPnFOkfKgkdTF1h0RpbQkAmEyXrmWvre/Lg3Z
	 ej4XQbzdS2B2mo7LL0BE4ywCPbIN52O9H1ZOFgr7G8sWIDSE48Lgdl7IjN2xtT53PY
	 gPODhO07J0ktW8WPeDqqLfl7H51yC45pQgRldMGav/QXr1r+76T83EPLkOXR/jznYF
	 GEVBOMTA4m8PQ==
Received: from [192.168.1.90] (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4B49D17E0343;
	Sun,  9 Mar 2025 11:17:39 +0100 (CET)
Message-ID: <f7fdf5de-90aa-4753-9500-c30339545adf@collabora.com>
Date: Sun, 9 Mar 2025 12:17:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/12] phy: rockchip: samsung-hdptx: Fix clock ratio
 setup
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>,
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250308-phy-sam-hdptx-bpc-v5-0-35087287f9d1@collabora.com>
 <20250308-phy-sam-hdptx-bpc-v5-3-35087287f9d1@collabora.com>
 <CAA8EJprBcGz0tZ5SDVC_WK2bzjXZAtOj+LfGnSxmwktvaQw=VQ@mail.gmail.com>
 <f1e33b02-5646-4219-98ac-c09e31d8215b@collabora.com>
 <CAA8EJprNTUuOwu__GcRhYmNi5rT0+3r16fs+n7Gdy3sjgTp+nw@mail.gmail.com>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <CAA8EJprNTUuOwu__GcRhYmNi5rT0+3r16fs+n7Gdy3sjgTp+nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/25 12:12 PM, Dmitry Baryshkov wrote:
> On Sun, 9 Mar 2025 at 12:11, Cristian Ciocaltea
> <cristian.ciocaltea@collabora.com> wrote:
>>
>> On 3/9/25 11:17 AM, Dmitry Baryshkov wrote:
>>> On Sat, 8 Mar 2025 at 14:21, Cristian Ciocaltea
>>> <cristian.ciocaltea@collabora.com> wrote:
>>>>
>>>> The switch from 1/10 to 1/40 clock ratio must happen when exceeding the
>>>> 340 MHz rate limit of HDMI 1.4, i.e. when entering the HDMI 2.0 domain,
>>>> and not before.
>>>
>>> Am I correct that the only functional change is a switch from
>>> greater-or-equal to simple greater?
>>
>> Yes.
> 
> If you were to repost the series for any reason, could you please
> spell that explicitly in the commit message. If not, it's fine.

Sure, I'll handle it in v6.

> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Thanks,
Cristian
 


