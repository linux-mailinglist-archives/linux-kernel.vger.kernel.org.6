Return-Path: <linux-kernel+bounces-275842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAFB948AE3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B939B235DE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE811BC9FC;
	Tue,  6 Aug 2024 08:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=angelogioacchino.delregno@collabora.com header.b="krVhWrDw"
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3379A166F31;
	Tue,  6 Aug 2024 08:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722931652; cv=pass; b=jIuaE7X/b1Eqb7eStkKkzyeGJTFQMNXzRRAZNoXwNPmpquTQdjjDUL2d0xDbVEpi6nSpJSH7/4fbc4EogPHPDRz5W4/YP1IxOfu/jROoQxg/jU7tkept4vFyTpEUwlosFUC+TTLQL3HBgxZO6dVX9AUUmrAZ9vsQzZktBsfPovU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722931652; c=relaxed/simple;
	bh=sD9WEcsktwMCuhPTt/ntjvfTBsetdosDEqnhtFOTIfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PS7r++AsK1dxOBEb2yCaQ13SgG4mJzV6+/UF0q+9/wjqVYdJulwMiILWPIFkkgfNVoWEQzf5xPqfGNzHMGFobq0TUu8+ud6gCqpvQLB77vJLjqFEphA0yEx11LtVMPO8jRcAaYRHN3mUo/EKstZL6nCqxhn5jpqJ6s0epkmA0y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=angelogioacchino.delregno@collabora.com header.b=krVhWrDw; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1722931640; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FBX9vhR+G7lHl4FudhYRBRVNw8pYIGZEC0olIX9FOaF3Me/MzJsBduEcGktCSNnioXZJM1HqrjFucWego2skit1v+tvnBhqRrSzzeskg4u9fOTkgS5X15hTM4KtYb1n6b5/ZrQdMFLt0bnUMuABQfTG0lIdThV8OkzfJIpv7sY4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1722931640; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IrE670yx+9odykcx3pr94NIhef7s04HUgnr8F28Op48=; 
	b=EeP6szSJ4JNjbCW/4ES3dU6Us7gdD7U3UJDf+Pn2ifHP1Fd1/RaBUfVYH9B/s6UEKYfE7hgVbPE46Qwjwy+NubdMZ52zvWwcBjNmncxEMaGb1FbF1aF/xCiBRxeg65j3Fz3r3+iFbleyL9p4Hh5NPhR68/5+KFeZUyCakRwfOl8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=angelogioacchino.delregno@collabora.com;
	dmarc=pass header.from=<angelogioacchino.delregno@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1722931640;
	s=zohomail; d=collabora.com;
	i=angelogioacchino.delregno@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=IrE670yx+9odykcx3pr94NIhef7s04HUgnr8F28Op48=;
	b=krVhWrDwSdW8K00uqR4WQD8aZN6kPLEVS9s7/MWpwjcN7YCE+OMkxuisnz9RhBA3
	kq1yDFpfnnFSy1sED6o1+YqZH0dZ/tO5KY3wRRwHJfDM0l5HpHXkYD0Iatajp6fX6/S
	PyHa7MqXzRnhZceEyo85UcWU4yqr7a65SvQwXGyI=
Received: by mx.zohomail.com with SMTPS id 1722931637559700.0955006196194;
	Tue, 6 Aug 2024 01:07:17 -0700 (PDT)
Message-ID: <b887b799-cd9c-441d-8b1f-cda24ad131de@collabora.com>
Date: Tue, 6 Aug 2024 10:07:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Add kukui-jacuzzi-cerise and kukui-jacuzzi-stern
 DT and dt-binding
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240731-jacuzzi_dt-v3-0-1c4314e8962f@chromium.org>
 <172243932855.488108.1466847928167694223.b4-ty@collabora.com>
 <CAHc4DNLwUAzrE-1-7oH2DHR6fvz4x9ZVaKbjUo6rOy3-kjUadQ@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CAHc4DNLwUAzrE-1-7oH2DHR6fvz4x9ZVaKbjUo6rOy3-kjUadQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Il 06/08/24 07:05, Hsin-Te Yuan ha scritto:
> On Wed, Jul 31, 2024 at 11:22 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> On Wed, 31 Jul 2024 10:47:24 +0000, Hsin-Te Yuan wrote:
>>> Cerise is known as ASUS Chromebook CZ1.
>>> Stern is known as ASUS Chromebook Flip CZ1.
>>>
>>> They are almost identical. The only difference is that Cerise is a
>>> clamshell device without touchscreen and Stern is a convertible device.
>>>
>>>
>>> [...]
>>
>> Applied to v6.11-next/dts64, thanks!
>>
>> [1/2] arm64: dts: mt8183: Add kukui-jacuzzi-cerise series boards
>>        commit: 4ba6d1539fdd709ea8e8478c37b014e663cd6894
>> [2/2] dt-bindings: arm64: mediatek: Add kukui-jacuzzi-cerise board
>>        commit: ac90896833b52ff58c81727f57ed3cf9ffb9db86
>>
>> Cheers,
>> Angelo
>>
>>
> I'm sorry that I just found out these two devices will not be
> launched. I sincerely apologize for any inconvenience this may cause
> and for taking up your valuable time. I kindly request that you
> consider dropping this patch series.
> 
> Sincerely,
> Hsin-Te

It's okay, the commits weren't deep in the MediaTek trees, so I was able
to drop them in a jiffy.

Thank you!
Angelo


