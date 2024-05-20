Return-Path: <linux-kernel+bounces-183587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E29388C9AF9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 12:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F1E4282506
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D7F4D59E;
	Mon, 20 May 2024 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="38z8CCsu"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCE5C125;
	Mon, 20 May 2024 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716199616; cv=none; b=PAET2FxFM4191AkgvFuj5R0YDGf8Sdw1c9hDLgHnD27b0AmZnwJIALcYpvMZB5sU79dpYc5nkuzxA66u+V8UWm+/w5AI41UgVwoJqFzpp7XUszzL/FeZDCdXOP3ghDtG3BKnu3vzNNOcQZpY2CpsBKr5rklFM9b+UKpXFQLVX6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716199616; c=relaxed/simple;
	bh=vb+S3v0VFH+2kufPH8rXeEV4ZmE//CWYzZhNwvQ83wM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d/pKYZymsPhFQsj7ga9A/Ux3zQREucsytjUJtzQs3EWfGm+w+KI/CK7KrsGKTs3jkUfc+/dMfYb3RlfJpe1+jsAClj9B7+cqav9Nh4Zqwk4moVbOSSI6CUtApaKW8nJbt67ATfRNsOj0/n62FXmKA5j7V7EYvc3HPu97OwqJJSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=38z8CCsu; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716199613;
	bh=vb+S3v0VFH+2kufPH8rXeEV4ZmE//CWYzZhNwvQ83wM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=38z8CCsuKFNlEFOI8zKZiaIoR24d2xYKgwkiqCs0fEy6eEbUr0nwwXkrXcCfQmtbL
	 nUaoOacEpmeJb2ebeOQd7ubBmu+PHX3ChWO2IOnD9iqkfKPvyAdHb5YBDKBjnbDHCy
	 ozft6KKYyyMHEEesYZpKiDFPW5GhNQkf5NDk2FZJ1815WWY/UvHHlW2FyqzVWq8rKg
	 EwPxZE0TtgCda3YVcbM5mR07OouW9zwsREHiboOh8aQKjW3VkeIJhzwnb1CXX2rYJ+
	 hKObzyxCt9iQV9klOjOBQAHK+S/6I9T0zGihr7EITRtI6pjFwuDPqCAMbkGAQqtKj3
	 YU4dg37ZORrTQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1699D37809D1;
	Mon, 20 May 2024 10:06:53 +0000 (UTC)
Message-ID: <f7760293-ded2-4d89-928c-a73359a045d2@collabora.com>
Date: Mon, 20 May 2024 12:06:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: mediatek: mt8365: drop incorrect
 power-domain-cells
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240518211159.142920-1-krzysztof.kozlowski@linaro.org>
 <20240518211159.142920-3-krzysztof.kozlowski@linaro.org>
 <3b1be547-ac49-40fb-909f-96952c299545@collabora.com>
 <1540f43c-9859-49a8-9b20-1fb08d1c153f@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <1540f43c-9859-49a8-9b20-1fb08d1c153f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/05/24 12:03, Krzysztof Kozlowski ha scritto:
> On 20/05/2024 11:58, AngeloGioacchino Del Regno wrote:
>> Il 18/05/24 23:11, Krzysztof Kozlowski ha scritto:
>>> The top SCPSYS node is not a power domain provider.  It's child
>>> "power-controller" is instead.  Fix dtbs_check warnings like:
>>>
>>>     mt8365-evk.dtb: syscon@10006000: '#power-domain-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> Well if you're fixing that by migrating to scpsys compatible, you might as well
>> resolve all of the warnings in one commit, removing that power-domain-cells
>> property in patch [2/4], otherwise this one is technically a fix for that.
>>
>> Please squash [2/4] and [3/4], like that it just makes more sense.
>>
> 
> That's independent thing. Previous compatible - syscfg - also did not
> allow power domains. The difference is that bindings did not print a
> warning without my change. We can reverse the patches if this is more
> suitable.
> 

You're still introducing a warning with patch 2.

As for swapping the order, that could also be a solution, but I still don't see
that as an independent thing - in any case, swapping them is something I can do
while applying, eventually.




