Return-Path: <linux-kernel+bounces-232146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2683C91A414
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57A091C21401
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4189E13E051;
	Thu, 27 Jun 2024 10:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cX98TkMG"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4971386BF;
	Thu, 27 Jun 2024 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484781; cv=none; b=STMVE++3gl38ZlXmtoVv2lNjI8mYiyKTIFHru8bF3x+iiFtahl0ShvHrs7vsBZYqLTEsx6dkyaMB4++I0X9/uumHHX+Sq9REhIrk8qNqMZKVQQnx50BZdkTzo3naZwxipz0ltgJVl7YCli/h4PtNwXsj4xLzD7PmPw98bVsaUD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484781; c=relaxed/simple;
	bh=AkpBiq6QZeCkJ2ClHXInJEXgeTHY7jWKyNdh3XWD5TA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3pCTa99R6etBm5Vc8QjmSXmaBa4rddVpvsn94z7KNIrW/GGcEvQhboYTeHfIuA4OoywayqrON32jkXeXG7k7x607HECCXYnz4rzXddyV/6r+fG8WgxLcv5zFUrMAUoSvlfeArMm+Ht79upspMQrIexTcv3ggAMpnB1bwktXDMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cX98TkMG; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719484778;
	bh=AkpBiq6QZeCkJ2ClHXInJEXgeTHY7jWKyNdh3XWD5TA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cX98TkMGmatIeQULfWhOZfq2FjpRtak7sKXJiJSqbf9dJHSdOAnuGdZM8zQI1noMV
	 tOGMq7ToTvFPMbbJAjPra82svkgAGTgM+/PZxJ5Svl303Ak4/LvURi8NAS5WLiEyOT
	 YKbI9CxpBzEQx+qACcnBs1xWFln19SbOM6r9JNi8mk7oIae3Twu1GIi6SsdVyF9pd2
	 CNLFBADqz0un4ihuzORpLjUHC7YIP7lrjvLZlnYGy/S8HzShuQhFVbXQ5W7kvO+VvT
	 7sqIbTAdIcNSskvyuS7zhZtd8+aM/Ro1R07OWKyQU30o8HwZm1v+x1/bQ81As8lACU
	 4bJPMia6C1Cgw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C3C4F3780029;
	Thu, 27 Jun 2024 10:39:36 +0000 (UTC)
Message-ID: <3d54c64b-e1cd-4034-b0dd-e5d6607c3ef1@collabora.com>
Date: Thu, 27 Jun 2024 12:39:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] dt-bindings: mfd: syscon: Split and enforce
 documenting MFD children
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>,
 Khuong Dinh <khuong@os.amperecomputing.com>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chuanhua Lei <lchuanhua@maxlinear.com>,
 Rahul Tanwar <rtanwar@maxlinear.com>,
 Lars Povlsen <lars.povlsen@microchip.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>,
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com,
 Nishanth Menon <nm@ti.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Conor Dooley
 <conor.dooley@microchip.com>, Maxime Ripard <mripard@kernel.org>
References: <20240627-dt-bindings-mfd-syscon-split-v4-0-dc6699a9f3e4@linaro.org>
 <20240627-dt-bindings-mfd-syscon-split-v4-6-dc6699a9f3e4@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240627-dt-bindings-mfd-syscon-split-v4-6-dc6699a9f3e4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 27/06/24 12:32, Krzysztof Kozlowski ha scritto:
> Simple syscon nodes can be documented in common syscon.yaml, however
> devices with simple-mfd compatible, thus with some children, should have
> their own schema listing these children.  Such listing makes the binding
> specific, allows better validation (so the incorrect child would not
> appear in the simple-mfd node) and actually enforces repeated rule for
> simple-mfd devices:
> 
>    "simple-mfd" is only for simple devices, where the children do not
>    depend on the parent.
> 
> Currently the syscon+simple-mfd binding is quite broad and allows
> any child or property, thus above rule cannot be enforced.
> 
> Split the syscon.yaml binding into:
> 1. Common syscon properties, used potentially by many bindings.
> 2. Simple syscon devices (NO simple-mfd!).
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



